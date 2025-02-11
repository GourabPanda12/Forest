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
public class ReqData
{
    public string caseno { get; set; }
    public string pic { get; set; }
    public string paths { get; set; }

}
public partial class sec_77 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    //  public static string Insert(string caseno, string pic, string path)
    public static string Insert(List<ReqData> jsonDynmxcxx)
    {
        string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //   string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //if (path != null && path != string.Empty)
        //{

        //    HttpContext.Current.Session["kl"] = "";
        //    //tp = "image/jpg";
        //    byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

        //    string ftp = "ftp://iicaapp.co.in/";
        //    //HttpPostedFile file = fs.;
        //    //FTP Folder name. Leave blank if you want to upload to root folder.

        //    string sst = string.Empty;


        //    //System.Drawing.Image image;
        //    //using (MemoryStream ms = new MemoryStream(bytes))
        //    //{
        //    //    image = System.Drawing.Image.FromStream(ms)
        //    ;
        //    //}


        //    try
        //    {
        //        //Create FTP Request.
        //        FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "requistn" + "." + path.ToString().Split('.')[1].ToString());
        //        request.Method = WebRequestMethods.Ftp.UploadFile;

        //        //Enter FTP Server credentials.
        //        request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
        //        request.ContentLength = bytes.Length;
        //        request.UsePassive = true;
        //        request.UseBinary = true;
        //        request.ServicePoint.ConnectionLimit = bytes.Length;
        //        request.EnableSsl = false;

        //        using (Stream requestStream = request.GetRequestStream())
        //        {
        //            requestStream.Write(bytes, 0, bytes.Length);
        //            requestStream.Close();
        //        }

        //        FtpWebResponse response = (FtpWebResponse)request.GetResponse();

        //        //Page page = HttpContext.Current.Handler as Page;
        //        //if (page != null)
        //        //{
        //        //    string error = "Payments made Successfully !!!"; error.Replace("'", "\'");
        //        //    ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

        //        //}
        //        response.Close();
        //    }
        //    catch (WebException ex)
        //    {
        //        throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
        //    }
        //}




        //string constr = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        //using (SqlConnection con = new SqlConnection(constr))
        //{
        //    using (SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_rqtnofwtns] (cmdno,upldfile) VALUES (@cmdno,@upldfile)"))
        //    {
        //        cmd.Parameters.AddWithValue("@cmdno", caseno);
        //        cmd.Parameters.AddWithValue("@upldfile", "https://iicaapp.co.in/cmndcrt" + path.ToString().Split('.')[0] + "requistn" + "." + path.ToString().Split('.')[1].ToString());
        //        cmd.Connection = con;
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //    }
        //}
        return "Success";
    }

    [WebMethod]
    public static string SavePdf(string pdfData, string caseNo, string pageName)
    {
        try
        {
            // Define the path to save the PDF
            //  string filePath = Server.MapPath("~/SavedFiles/GeneratedPDF.pdf");

            // Convert the base64 string to a byte array
            byte[] pdfBytes = Convert.FromBase64String(pdfData);
            string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
            //   string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
            //if (path != null && path != string.Empty)
            //{

            //    HttpContext.Current.Session["kl"] = "";
            //    //tp = "image/jpg";
            //    byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

            //    string ftp = "ftp://iicaapp.co.in/";
            //    //HttpPostedFile file = fs.;
            //    //FTP Folder name. Leave blank if you want to upload to root folder.

            //    string sst = string.Empty;


            //    //System.Drawing.Image image;
            //    //using (MemoryStream ms = new MemoryStream(bytes))
            //    //{
            //    //    image = System.Drawing.Image.FromStream(ms)
            //    ;
            //    //}

            // string fullPath = Request.Url.AbsolutePath;

            // Extract the page name from the full path
            //string pageName = System.IO.Path.GetFileName(fullPath);
            try
            {
                //Create FTP Request.
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + "case-forest-" + pageName.Split('.')[0] + ".pdf");
                request.Method = WebRequestMethods.Ftp.UploadFile;

                //Enter FTP Server credentials.
                request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
                request.ContentLength = pdfBytes.Length;
                request.UsePassive = true;
                request.UseBinary = true;
                request.ServicePoint.ConnectionLimit = pdfBytes.Length;
                request.EnableSsl = false;

                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(pdfBytes, 0, pdfBytes.Length);
                    requestStream.Close();
                }

                FtpWebResponse response = (FtpWebResponse)request.GetResponse();

                //Page page = HttpContext.Current.Handler as Page;
                //if (page != null)
                //{
                //    string error = "Payments made Successfully !!!"; error.Replace("'", "\'");
                //    ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

                //}
                response.Close();
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
            //}




            //string constr = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            //using (SqlConnection con = new SqlConnection(constr))
            //{
            //    using (SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_rqtnofwtns] (cmdno,upldfile,fltyp) VALUES (@cmdno,@upldfile)"))
            //    {
            //        cmd.Parameters.AddWithValue("@cmdno", caseNo);
            //        cmd.Parameters.AddWithValue("@upldfile", "https://iicaapp.co.in/cmndcrt" + path.ToString().Split('.')[0] + "requistn" + "." + path.ToString().Split('.')[1].ToString());
            //        cmd.Connection = con;
            //        con.Open();
            //        cmd.ExecuteNonQuery();
            //        con.Close();
            //    }
            //}
            // Write the byte array to a file
            //   File.WriteAllBytes(filePath, pdfBytes);

            return "PDF saved successfully!";
        }
        catch (Exception ex)
        {
            return "Error saving PDF: " + ex.Message;
        }
    }
}