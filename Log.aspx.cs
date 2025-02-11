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

using System.Web.Script.Serialization;

public partial class Log : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<LogReportDTO> GetLogReports(string caseNo)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        List<LogReportDTO> reports = new List<LogReportDTO>();

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            string query = "SELECT [FormName], [Name], [Dates], [Status] FROM [forestdata].[dbo].[LogReport] WHERE [CaseNo] = @CaseNo";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@CaseNo", caseNo);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        reports.Add(new LogReportDTO
                        {
                            FormName = reader.IsDBNull(0) ? string.Empty : reader.GetString(0),
                            Name = reader.IsDBNull(1) ? string.Empty : reader.GetString(1),
                            Dates = reader.IsDBNull(2) ? null : reader.GetDateTime(2).ToString("yyyy-MM-dd"),
                            Status = reader.IsDBNull(3) ? string.Empty : reader.GetString(3)
                        });
                    }
                }
            }
        }

        return reports;
    }

    [Serializable]
    public class LogReportDTO
    {
        public string FormName { get; set; }
        public string Name { get; set; }
        public string Dates { get; set; } // This remains a string to ensure proper formatting as "yyyy-MM-dd".
        public string Status { get; set; }
    }

    [WebMethod]
    public static int GetCompletedForms(string caseNo)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        int completedForms = 0;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM [forestdata].[dbo].[LogReport] WHERE CaseNo = @CaseNo AND Status = 'active'";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@CaseNo", caseNo);
            conn.Open();
            completedForms = Convert.ToInt32(cmd.ExecuteScalar());
        }

        return completedForms;
    }

}