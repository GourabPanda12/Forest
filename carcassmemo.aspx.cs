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
public class Searchdtt
{
    public string ServiceName { get; set; }
    public string Id { get; set; }
    public string CategoryId { get; set; }
    public string SubCategoryId { get; set; }
}

public class Carcassins
{
    public string caseno { get; set; }
    public string odudcaseno { get; set; }
    public string rangediv { get; set; }
    public string dateinsp { get; set; }
    public string timeins { get; set; }
    public string specnm { get; set; }
    public string place { get; set; }
    public string descpcarcs { get; set; }
    public string apainj { get; set; }
    public string mannerwh { get; set; }
    public string circumif { get; set; }
    public string acculist { get; set; }
    public string opnwtns { get; set; }
    public string opnfrstr { get; set; }

}

public partial class carcassmemo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Carcassins> carcassinslist, string pic, string path)
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
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "carcass" + "." + path.ToString().Split('.')[1].ToString());
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
        DATABASE DB = new DATABASE();

        SqlConnection con1 = new SqlConnection();




        string pthh = "https://iicaapp.co.in/httpdocs/cmndcrt" + path.ToString().Split('.')[0] + "carcass" + "." + path.ToString().Split('.')[1].ToString();

        // Insert data from caselist
        foreach (var carcassins in carcassinslist)
        {
            string sql = "INSERT INTO [forestdata].[dbo].[tbl_carcsmemo] (" +
                "[caseno], [odudcsno], [rngdiv], [dtinsp], [hrtm], [speciesdtl], [carcassfnd], [descpcar], [injcr], [manner], [circum], [acculist], [opinion], [opinionfo], [paths]) " +
                "VALUES ('" + carcassins.caseno + "', '" + carcassins.odudcaseno + "', '" + carcassins.rangediv + "', '" + carcassins.dateinsp + "', '" + carcassins.timeins + "', '" + carcassins.specnm + "', '" + carcassins.place + "', '" + carcassins.descpcarcs + "', '" + carcassins.apainj + "', '" + carcassins.mannerwh + "', '" + carcassins.circumif + "', '" + carcassins.acculist + "', '" + carcassins.opnwtns + "', '" + carcassins.opnfrstr + "', '" + pthh + "');";
            con1 = DB.getCon();

            SqlCommand cmmds = new SqlCommand(sql, con1);
            DB.ExecQry(cmmds);

        }


        return "";
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Searchdtt> GetAutoCompleteData(string prefix)
    {
        List<Searchdtt> services = new List<Searchdtt>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["Byvdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT * FROM tbl_newcaseform WHERE casno LIKE @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new Searchdtt
                        {
                            ServiceName = sdr["casno"].ToString(),
                            Id = sdr["id"].ToString(),
                            CategoryId = sdr["dist"].ToString(),
                            SubCategoryId = sdr["city"].ToString()
                        });
                    }
                }
            }
        }

        return services;
    }
}