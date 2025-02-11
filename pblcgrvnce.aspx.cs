using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Web.Services;

public partial class pblcgrvnce : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Initialize the page or load any required data
        }
    }

    private static bool UploadFileToFtp(string picData, string fileName)
    {
        if (string.IsNullOrEmpty(fileName) || string.IsNullOrEmpty(picData))
        {
            return false;
        }

        try
        {
            string[] picParts = picData.Split(',');
            if (picParts.Length < 2)
            {
                return false;
            }

            byte[] bytes = Convert.FromBase64String(picParts[1]);

            // Use string concatenation or String.Format for C# 5 compatibility
            string fullPath = FtpFolder + fileName;  // Option 1: String concatenation

            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(fullPath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.ContentLength = bytes.Length;
            request.UsePassive = true;
            request.UseBinary = true;
            request.ServicePoint.ConnectionLimit = bytes.Length;
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(bytes, 0, bytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                return response.StatusCode == FtpStatusCode.ClosingData;
            }
        }
        catch (WebException ex)
        {
            FtpWebResponse response = ex.Response as FtpWebResponse;
            string errorMessage = response != null ? response.StatusDescription : ex.Message;
            System.Diagnostics.Debug.WriteLine("FTP Upload failed: " + errorMessage);
            return false;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Upload failed: " + ex.Message);
            return false;
        }
    }

    [WebMethod(EnableSession = true)]
    public static string Insert(string clientName, string mobileNo, string district, string division, string description, string picz, string pathz)
    {
        try
        {
            // Upload file if provided
            string filePath = string.Empty;
            if (!string.IsNullOrEmpty(picz) && !string.IsNullOrEmpty(pathz))
            {
                bool uploadSuccess = UploadFileToFtp(picz, pathz);
                if (!uploadSuccess)
                {
                    return "Error: File upload failed.";
                }
                 filePath = "https://msksoftware.co.in/httpdocs/forestdoc/" + pathz;   // Option 1: String concatenation
            }

            // Save grievance details in the database
            string constr = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = @"
                INSERT INTO [dbo].[submissions]
                (Name, Mobile, District, Division, Description, FilePath, SubmissionDate) 
                VALUES 
                (@Name, @Mobile, @District, @Division, @Description, @FilePath, @SubmissionDate)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(clientName) ? DBNull.Value : (object)clientName);
                    cmd.Parameters.AddWithValue("@Mobile", string.IsNullOrEmpty(mobileNo) ? DBNull.Value : (object)mobileNo);
                    cmd.Parameters.AddWithValue("@District", string.IsNullOrEmpty(district) ? DBNull.Value : (object)district);
                    cmd.Parameters.AddWithValue("@Division", string.IsNullOrEmpty(division) ? DBNull.Value : (object)division);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                    cmd.Parameters.AddWithValue("@FilePath", string.IsNullOrEmpty(filePath) ? DBNull.Value : (object)filePath);
                    cmd.Parameters.AddWithValue("@SubmissionDate", DateTime.Now);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return "Success: Grievance submitted successfully.";
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Grievance submission failed: " + ex.Message);
            return "Error: " + ex.Message;
        }
    }
}
