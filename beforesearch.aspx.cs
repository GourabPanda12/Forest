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
public class Searchdatayy
{
    public string ServiceName { get; set; }
    public string Id { get; set; }
    public string CategoryId { get; set; }
    public string SubCategoryId { get; set; }
}
public class undertaken
{
    public string name { get; set; }
    public string address { get; set; }
    public string mobile { get; set; }

}
public class posses
{
    public string possession { get; set; }
}
public class partys
{
    public string party { get; set; }
}
public class places
{
    public string place { get; set; }
}
public class Beforesearch
{
    public string caseno { get; set; }
    public string prtno { get; set; }
    public string divsn { get; set; }
    public string rangeofc { get; set; }
    public string datc { get; set; }
    public string ptime { get; set; }
    public string rformiino { get; set; }
    public string dtx { get; set; }
    public string tmex { get; set; }

    public string rmrk { get; set; }

}

public partial class beforesearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public static string Insert(List<Beforesearch> beforelist, string pic, string path, List<undertaken> undertaken, List<posses> posses, List<partys> partys, List<places> places)
    //{

    //    string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
    //    //string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
    //    if (path != null && path != string.Empty)
    //    {

    //        HttpContext.Current.Session["kl"] = "";
    //        //tp = "image/jpg";
    //        byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

    //        string ftp = "ftp://iicaapp.co.in/";
    //        //HttpPostedFile file = fs.;
    //        //FTP Folder name. Leave blank if you want to upload to root folder.

    //        string sst = string.Empty;


    //        //System.Drawing.Image image;
    //        //using (MemoryStream ms = new MemoryStream(bytes))
    //        //{
    //        //    image = System.Drawing.Image.FromStream(ms)
    //        ;
    //        //}


    //        try
    //        {
    //            //Create FTP Request.
    //            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "beforesearch" + "." + path.ToString().Split('.')[1].ToString());
    //            request.Method = WebRequestMethods.Ftp.UploadFile;

    //            //Enter FTP Server credentials.
    //            request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
    //            request.ContentLength = bytes.Length;
    //            request.UsePassive = true;
    //            request.UseBinary = true;
    //            request.ServicePoint.ConnectionLimit = bytes.Length;
    //            request.EnableSsl = false;

    //            using (Stream requestStream = request.GetRequestStream())
    //            {
    //                requestStream.Write(bytes, 0, bytes.Length);
    //                requestStream.Close();
    //            }

    //            FtpWebResponse response = (FtpWebResponse)request.GetResponse();

    //            //Page page = HttpContext.Current.Handler as Page;
    //            //if (page != null)
    //            //{
    //            //    string error = "Payments made Successfully !!!"; error.Replace("'", "\'");
    //            //    ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

    //            //}
    //            response.Close();
    //        }
    //        catch (WebException ex)
    //        {
    //            throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
    //        }
    //    }

    //    DATABASE DB = new DATABASE();

    //    SqlConnection con1 = new SqlConnection();




    //    string pthh = "https://iicaapp.co.in/httpdocs/cmndcrt" + path.ToString().Split('.')[0] + "beforesearch" + "." + path.ToString().Split('.')[1].ToString();

    //    // Insert data from caselist
    //    //foreach (var beforesearch in beforelist)
    //    //{
    //    //    string sql = "INSERT INTO [forestdata].[dbo].[tbl_beforesrch] (caseno,no, division,date, time, formiino,datex,timex,prsnfldtl,spinvldtl,Posesnfnd,remark,name,adrs,mob,paths) values ('" + beforesearch.caseno + "','" + beforesearch.prtno + "','" + beforesearch.divsn + "','" + beforesearch.rangeofc + "','" + beforesearch.datc + "','" + beforesearch.ptime + "','" + beforesearch.rformiino + "','" + beforesearch.dtx + "','" + beforesearch.tmex + "','" + beforesearch.gpscdtnts + "','" + beforesearch.srchprtydtl + "','" + beforesearch.pssnfnd + "','" + beforesearch.rmrk + "','" + beforesearch.name + "','" + beforesearch.adress + "','" + beforesearch.mobile + "','" + pthh + "')";
    //    //    con1 = DB.getCon();
    //    //    SqlCommand cmmds = new SqlCommand(sql, con1);
    //    //    DB.ExecQry(cmmds);

    //    //}

    //    return "";

    //}


    [WebMethod(EnableSession = true)]
    public static string Insert(string caseno,string pic, string path)
    {
        //string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //if (path != null && path != string.Empty)
        //{

        //    HttpContext.Current.Session["kl"] = "";
        //    tp = "image/jpg";
        //    byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

        //    string ftp = "ftp://iicaapp.co.in/";
        //    HttpPostedFile file = fs.;
        //    FTP Folder name.Leave blank if you want to upload to root folder.

        //    string sst = string.Empty;


        //    System.Drawing.Image image;
        //    using (MemoryStream ms = new MemoryStream(bytes))
        //    {
        //        image = System.Drawing.Image.FromStream(ms)
        //    ;
        //    }


        //    try
        //    {
        //        Create FTP Request.
        //        FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "beforesearch" + "." + path.ToString().Split('.')[1].ToString());
        //        request.Method = WebRequestMethods.Ftp.UploadFile;

        //        Enter FTP Server credentials.
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

        //        Page page = HttpContext.Current.Handler as Page;
        //        if (page != null)
        //        {
        //            string error = "Payments made Successfully !!!"; error.Replace("'", "\'");
        //            ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

        //        }
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
        //    using (SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_befresrch] (cmdno,upldfile) VALUES (@cmdno,@upldfile)"))
        //    {
        //        cmd.Parameters.AddWithValue("@cmdno", caseno);

        //        cmd.Parameters.AddWithValue("@upldfile", "https://iicaapp.co.in/cmndcrt/" + path.ToString().Split('.')[0] + "beforesearch" + "." + path.ToString().Split('.')[1].ToString());
        //        cmd.Connection = con;
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //    }
        //}
        return "Success";
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Searchdatayy> GetAutoCompleteData(string prefix)
    {
        List<Searchdatayy> services = new List<Searchdatayy>();

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
                        services.Add(new Searchdatayy
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