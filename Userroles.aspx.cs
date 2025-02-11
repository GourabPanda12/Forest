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
public class CheckboxStatez
{
    public string Label { get; set; }
    public bool state { get; set; }


}

public partial class Userroles : System.Web.UI.Page
{
    DATABASE DB = new DATABASE();
    INS IN = new INS();
    private static TimeZoneInfo India_Standard_Time = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string ProcessData(string adminName, string phone, string typx, List<CheckboxStatez> dataknw)
    {

        string labelsString = "";

        // Loop through each CheckboxStatez object in the list
        foreach (CheckboxStatez item in dataknw)
        {
            // Check if the state is true
            if (item.state)
            {
                // Concatenate the label with a comma to the labelsString
                labelsString += item.Label + ",";
            }
        }

        // Remove the trailing comma, if any
        if (labelsString.EndsWith(","))
        {
             labelsString.Substring(0, labelsString.Length - 1);
        }

        DATABASE DB = new DATABASE();
        SqlConnection con1 = new SqlConnection();
        string sql = "insert into tbl_user (usernm,pwd,usrtype,rolls) values ('" + adminName + "','" + phone + "','" + typx + "','" + labelsString + "')";
        con1 = DB.getCon();
        SqlCommand cmmds = new SqlCommand(sql, con1);
        DB.ExecQry(cmmds);
        // Deserialize JSON string to objects
        // Perform any processing here
        // For demonstration purposes, just returning received data

        //string checkboxes = "";
        //for (int i = 0; i < checkboxLabels.Length; i++)
        //{
        //    checkboxes += $"{checkboxLabels[i]}: {checkboxStates[i]}, ";
        //}
        return "";
    }
}