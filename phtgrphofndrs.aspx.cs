using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;
using System.Web.Services;
using System.Net;
using System.Text.RegularExpressions;
using AjaxControlToolkit;
using System.Drawing;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Reflection;
using Razorpay.Api;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using ClosedXML.Excel;
using System.Web.Script.Services;

public partial class phtgrphofndrs : System.Web.UI.Page
{

        private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp()
    {
        List<string> cases = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT casno, id FROM tbl_newcaseform";
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        cases.Add(string.Format("{0}*{1}", sdr["id"], sdr["casno"]));
                    }
                }
                conn.Close();
            }
        }

        return cases.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdespx()
    {
        List<string> cases = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT casno, id FROM tbl_newcaseformfr";
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        cases.Add(string.Format("{0}*{1}", sdr["id"], sdr["casno"]));
                    }
                }
                conn.Close();
            }
        }

        return cases.ToArray();
    }


    private static bool UploadFileToFtp(string base64Data, string fileName)
    {
        if (string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
        {
            return false;
        }

        try
        {
            string[] dataParts = base64Data.Split(',');
            if (dataParts.Length < 2)
            {
                return false;
            }

            byte[] fileBytes = Convert.FromBase64String(dataParts[1]);

            string fullPath = FtpFolder + fileName;
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(fullPath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.ContentLength = fileBytes.Length;
            request.UsePassive = true;
            request.UseBinary = true;
            request.ServicePoint.ConnectionLimit = fileBytes.Length;
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileBytes, 0, fileBytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                return response.StatusCode == FtpStatusCode.ClosingData;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("FTP upload failed: " + ex.Message);
            return false;
        }
    }

    [WebMethod]
    public static string SaveFormData(FormData formData)
    {
        try
        {
            // Upload files to FTP
            string signaturePath = string.Empty;
            string imagePath = string.Empty;

            if (!string.IsNullOrEmpty(formData.SignatureBase64) && !string.IsNullOrEmpty(formData.SignatureFileName))
            {
                bool signatureUploaded = UploadFileToFtp(formData.SignatureBase64, formData.SignatureFileName);
                if (signatureUploaded)
                {
                    signaturePath =  "https://msksoftware.co.in/forestdoc/"  + formData.SignatureFileName;
                }
                else
                {
                    return "Error: Signature upload failed.";
                }
            }

            if (!string.IsNullOrEmpty(formData.ImageBase64) && !string.IsNullOrEmpty(formData.ImageFileName))
            {
                bool imageUploaded = UploadFileToFtp(formData.ImageBase64, formData.ImageFileName);
                if (imageUploaded)
                {
                    imagePath = "https://msksoftware.co.in/forestdoc/"  + formData.ImageFileName;
                }
                else
                {
                    return "Error: Image upload failed.";
                }
            }

            // Save form data in the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            INSERT INTO [dbo].[offenderx]
            (
                ChooseOne, CaseNo, Name, Aliases, DOB, PlaceOfBirth, Sex, Hair, EyeColor, Complexion, Height, Weight, Build,
                Citizenship, Language, IdentificationMarks, PhoneNumber, Email, Passport, BankAccount, Adhaar, Occupation, Associates,
                CrimeHistory, ModusOperandi, AreaActivities, Acquittals, ProclaimedOffenderDetails, OtherRemarks, SignaturePath, ImagePath,
                SubmissionDate
            )
            VALUES
            (
                @ChooseOne, @CaseNo, @Name, @Aliases, @DOB, @PlaceOfBirth, @Sex, @Hair, @EyeColor, @Complexion, @Height, @Weight, @Build,
                @Citizenship, @Language, @IdentificationMarks, @PhoneNumber, @Email, @Passport, @BankAccount, @Adhaar, @Occupation, @Associates,
                @CrimeHistory, @ModusOperandi, @AreaActivities, @Acquittals, @ProclaimedOffenderDetails, @OtherRemarks, @SignaturePath, @ImagePath,
                @SubmissionDate
            )";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ChooseOne", string.IsNullOrEmpty(formData.ChooseOne) ? DBNull.Value : (object)formData.ChooseOne);
                    command.Parameters.AddWithValue("@CaseNo", string.IsNullOrEmpty(formData.CaseNo) ? DBNull.Value : (object)formData.CaseNo);
                    command.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(formData.Name) ? DBNull.Value : (object)formData.Name);
                    command.Parameters.AddWithValue("@Aliases", string.IsNullOrEmpty(formData.Aliases) ? DBNull.Value : (object)formData.Aliases);
                    command.Parameters.AddWithValue("@DOB", string.IsNullOrEmpty(formData.DOB) ? DBNull.Value : (object)formData.DOB);
                    command.Parameters.AddWithValue("@PlaceOfBirth", string.IsNullOrEmpty(formData.PlaceOfBirth) ? DBNull.Value : (object)formData.PlaceOfBirth);
                    command.Parameters.AddWithValue("@Sex", string.IsNullOrEmpty(formData.Sex) ? DBNull.Value : (object)formData.Sex);
                    command.Parameters.AddWithValue("@Hair", string.IsNullOrEmpty(formData.Hair) ? DBNull.Value : (object)formData.Hair);
                    command.Parameters.AddWithValue("@EyeColor", string.IsNullOrEmpty(formData.EyeColor) ? DBNull.Value : (object)formData.EyeColor);
                    command.Parameters.AddWithValue("@Complexion", string.IsNullOrEmpty(formData.Complexion) ? DBNull.Value : (object)formData.Complexion);
                    command.Parameters.AddWithValue("@Height", string.IsNullOrEmpty(formData.Height) ? DBNull.Value : (object)formData.Height);
                    command.Parameters.AddWithValue("@Weight", string.IsNullOrEmpty(formData.Weight) ? DBNull.Value : (object)formData.Weight);
                    command.Parameters.AddWithValue("@Build", string.IsNullOrEmpty(formData.Build) ? DBNull.Value : (object)formData.Build);
                    command.Parameters.AddWithValue("@Citizenship", string.IsNullOrEmpty(formData.Citizenship) ? DBNull.Value : (object)formData.Citizenship);
                    command.Parameters.AddWithValue("@Language", string.IsNullOrEmpty(formData.Language) ? DBNull.Value : (object)formData.Language);
                    command.Parameters.AddWithValue("@IdentificationMarks", string.IsNullOrEmpty(formData.IdentificationMarks) ? DBNull.Value : (object)formData.IdentificationMarks);
                    command.Parameters.AddWithValue("@PhoneNumber", string.IsNullOrEmpty(formData.PhoneNumber) ? DBNull.Value : (object)formData.PhoneNumber);
                    command.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(formData.Email) ? DBNull.Value : (object)formData.Email);
                    command.Parameters.AddWithValue("@Passport", string.IsNullOrEmpty(formData.Passport) ? DBNull.Value : (object)formData.Passport);
                    command.Parameters.AddWithValue("@BankAccount", string.IsNullOrEmpty(formData.BankAccount) ? DBNull.Value : (object)formData.BankAccount);
                    command.Parameters.AddWithValue("@Adhaar", string.IsNullOrEmpty(formData.Adhaar) ? DBNull.Value : (object)formData.Adhaar);
                    command.Parameters.AddWithValue("@Occupation", string.IsNullOrEmpty(formData.Occupation) ? DBNull.Value : (object)formData.Occupation);
                    command.Parameters.AddWithValue("@Associates", string.IsNullOrEmpty(formData.Associates) ? DBNull.Value : (object)formData.Associates);
                    command.Parameters.AddWithValue("@CrimeHistory", string.IsNullOrEmpty(formData.CrimeHistory) ? DBNull.Value : (object)formData.CrimeHistory);
                    command.Parameters.AddWithValue("@ModusOperandi", string.IsNullOrEmpty(formData.ModusOperandi) ? DBNull.Value : (object)formData.ModusOperandi);
                    command.Parameters.AddWithValue("@AreaActivities", string.IsNullOrEmpty(formData.AreaActivities) ? DBNull.Value : (object)formData.AreaActivities);
                    command.Parameters.AddWithValue("@Acquittals", string.IsNullOrEmpty(formData.Acquittals) ? DBNull.Value : (object)formData.Acquittals);
                    command.Parameters.AddWithValue("@ProclaimedOffenderDetails", string.IsNullOrEmpty(formData.ProclaimedOffenderDetails) ? DBNull.Value : (object)formData.ProclaimedOffenderDetails);
                    command.Parameters.AddWithValue("@OtherRemarks", string.IsNullOrEmpty(formData.OtherRemarks) ? DBNull.Value : (object)formData.OtherRemarks);
                    command.Parameters.AddWithValue("@SignaturePath", string.IsNullOrEmpty(signaturePath) ? DBNull.Value : (object)signaturePath);
                    command.Parameters.AddWithValue("@ImagePath", string.IsNullOrEmpty(imagePath) ? DBNull.Value : (object)imagePath);
                    command.Parameters.AddWithValue("@SubmissionDate", DateTime.Now);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error saving form data: " + ex.Message);
            return "Error: " + ex.Message;
        }
    }


    public class FormData
    {
        public string ChooseOne { get; set; }
        public string CaseNo { get; set; }
        public string Name { get; set; }
        public string Aliases { get; set; }
        public string DOB { get; set; }
        public string PlaceOfBirth { get; set; }
        public string Sex { get; set; }
        public string Hair { get; set; }
        public string EyeColor { get; set; }
        public string Complexion { get; set; }
        public string Height { get; set; }
        public string Weight { get; set; }
        public string Build { get; set; }
        public string Citizenship { get; set; }
        public string Language { get; set; }
        public string IdentificationMarks { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Passport { get; set; }
        public string BankAccount { get; set; }
        public string Adhaar { get; set; }
        public string Occupation { get; set; }
        public string Associates { get; set; }
        public string CrimeHistory { get; set; }
        public string ModusOperandi { get; set; }
        public string AreaActivities { get; set; }
        public string Acquittals { get; set; }
        public string ProclaimedOffenderDetails { get; set; }
        public string OtherRemarks { get; set; }
        public string SignatureBase64 { get; set; }
        public string SignatureFileName { get; set; }
        public string ImageBase64 { get; set; }
        public string ImageFileName { get; set; }
    }

}