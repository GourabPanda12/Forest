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
public partial class index : System.Web.UI.Page
{
    DATABASE DB = new DATABASE();
    protected void Page_Load(object sender, EventArgs e)
    {
 if (!IsPostBack)
        {
	  //Response.StatusCode = 503;
   // Response.StatusDescription = "Service Unavailable";
  //  Response.End();
	  //  Response.StatusCode = 503;
    //Response.StatusDescription = "Service Unavailable";
   // Response.End();
	// Response.Redirect("index.aspx");
            // Additional logic if needed
        }
    }

    protected void login_ServerClick(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        SqlCommand cmd = new SqlCommand("select * from [forestdata].[dbo].[tbl_userlogin] where usernm=@username and pwd=@password", con);
        cmd.Parameters.AddWithValue("@username", txtusrnm.Value.ToString());
        cmd.Parameters.AddWithValue("@password", txtpwd.Value.ToString());
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        con.Open();
        int i = cmd.ExecuteNonQuery();
        con.Close();
        if (dt.Rows.Count > 0)
        {
            Session["LOGID"] = dt.Rows[0]["id"].ToString();
            Response.Redirect("dashboard.aspx");

        }
        else
        {
            Page page = HttpContext.Current.Handler as Page;
            if (page != null)
            {
                string error = "OOps some error in Username or Password !!!"; error.Replace("'", "\'");
                ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

            }
        }
    }
}