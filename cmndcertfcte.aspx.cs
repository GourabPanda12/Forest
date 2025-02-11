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

public partial class cmndcertfcte : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static string Insert( string pic, string path, string caseno)
    {
        string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        if (path != null && path != string.Empty)
        {

            HttpContext.Current.Session["kl"] = "";
            //tp = "image/jpg";
            byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

            string ftp = "ftp://iicaapp.co.in/";
            //HttpPostedFile file = fs.;
            //FTP Folder name. Leave blank if you want to upload to root folder.

            string sst = string.Empty;


            //System.Drawing.Image image;
            //using (MemoryStream ms = new MemoryStream(bytes))
            //{
            //    image = System.Drawing.Image.FromStream(ms)
            ;
            //}


            try
            {
                //Create FTP Request.
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "commandctf" + "." + path.ToString().Split('.')[1].ToString());
                request.Method = WebRequestMethods.Ftp.UploadFile;

                //Enter FTP Server credentials.
                request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
                request.ContentLength = bytes.Length;
                request.UsePassive = true;
                request.UseBinary = true;
                request.ServicePoint.ConnectionLimit = bytes.Length;
                request.EnableSsl = false;

                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(bytes, 0, bytes.Length);
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
        }

        string constr = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_cmndcrtfct] (caseno,upldfile) VALUES (@caseno,@upldfile)"))
            {
                
                cmd.Parameters.AddWithValue("@caseno", caseno);
                cmd.Parameters.AddWithValue("@upldfile", "https://iicaapp.co.in/cmndcrt/" + path.ToString().Split('.')[0] + "commandctf" + "." + path.ToString().Split('.')[1].ToString());
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        return "Success";
    }

}