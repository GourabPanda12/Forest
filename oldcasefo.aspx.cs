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
public class CaseData
{
    public string caseno { get; set; }
    public string date { get; set; }
    public string div { get; set; }
    public string dist { get; set; }
    public string city { get; set; }
}
public partial class oldcasefo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<CaseData> GetAutoCompleteData(string prefix)
    {
        List<CaseData> services = new List<CaseData>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT * FROM [tbl_newcaseformfr] WHERE casno LIKE @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new CaseData
                        {
                            caseno = sdr["casno"].ToString(),
                            date = sdr["date"].ToString(),
                            div = sdr["division"].ToString(),
                            dist = sdr["dist"].ToString(),
                            city = sdr["city"].ToString()
                        });
                    }
                }
            }
        }

        return services;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp(string name)
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; Getdespp3
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select casno,id from tbl_newcaseformfr";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}", sdr["id"], sdr["casno"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdespp3(string name)
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; 
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select division,dist,city,rangeofcr,remark,date from tbl_newcaseformfr where casno='" + name + "'";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}*{2}*{3}*{4}*{5}", sdr["division"], sdr["dist"], sdr["city"], sdr["rangeofcr"], sdr["remark"], sdr["date"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp2()
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; Getdespp3
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select divs,id from tbl_dist";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}", sdr["id"], sdr["divs"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp3(string name)
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; Getdespp3
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select divs,id from tbl_divs where did =" + name + "";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}", sdr["id"], sdr["divs"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string getdwn(string name)
    {
        string lfrt = string.Empty;
        //   DateTime dateTime_Indian = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, India_Standard_Time);
        string username = "";
        string lastVisit = "";
        HttpContext context = HttpContext.Current;

        // Checking if the cookie exists in the request
        if (context.Request.Cookies["MyCookie"] != null)
        {
            // Retrieving the cookie values
            username = context.Request.Cookies["MyCookie"]["LOGID"];
            lastVisit = context.Request.Cookies["MyCookie"]["MNM"];

            // Accessing the HttpResponse
            HttpResponse response = context.Response;

            // Writing the retrieved values to the response
            // response.Write("Username: " + username + "<br/>");
            // response.Write("Last Visit: " + lastVisit);
        }

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        DataTable gh = DB.returnDt("select count(*) as cnt from tbl_newcaseform");
        // DataTable gh55 = DB.returnDt("select kyc_sts from tbl_regsx where memid=" + username + "");
        return gh.Rows[0]["cnt"].ToString() + "*" + "ok";


    }
}