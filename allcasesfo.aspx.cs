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

public partial class allcasesfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    public static string[] Getdesp4(string name)
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
                cmd.CommandText = "select divs,did from tbl_divs";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}", sdr["did"], sdr["divs"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp1(string name)
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
                cmd.CommandText = "select [casno] ,[date] ,[division] ,[dist] ,[city] ,[rangeofcr] ,[remark] from tbl_newcaseformfr";

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {

                        countries.Add(string.Format("{0}*{1}*{2}*{3}*{4}", sdr["casno"], sdr["date"], sdr["dist"], sdr["division"], sdr["rangeofcr"]));


                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }
}