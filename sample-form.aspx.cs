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

public partial class sample_form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static string Insert(string description, string pic, string path)
    {
        if (!string.IsNullOrEmpty(path))
        {
            // Construct the file path
            string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
            string fileName = path.Split('.')[0] + "dfojto." + path.Split('.')[1];

            // Convert the image string to bytes
            byte[] bytes = Convert.FromBase64String(pic.Split(',')[1]);

            try
            {
                // Create FTP Request
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + fileName);
                request.Method = WebRequestMethods.Ftp.UploadFile;

                // Enter FTP Server credentials
                request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
                request.ContentLength = bytes.Length;
                request.UsePassive = true;
                request.UseBinary = true;
                request.ServicePoint.ConnectionLimit = bytes.Length;
                request.EnableSsl = false;

                // Upload the file
                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(bytes, 0, bytes.Length);
                }

                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                response.Close();
            }
            catch (WebException ex)
            {
                return "FTP Error: " + (ex.Response as FtpWebResponse).StatusDescription;
            }
        }

        // Insert the data into the database
        string constr = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_samplefrm] (descp, upldfile) VALUES (@descp, @upldfile)"))
            {
                cmd.Parameters.AddWithValue("@descp", description);
                cmd.Parameters.AddWithValue("@upldfile", "https://iicaapp.co.in/httpdocs/cmndcrt" + path.ToString().Split('.')[0] + "dfojto" + "." + path.ToString().Split('.')[1].ToString());
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        return "Success";
    }

}