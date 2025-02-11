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
public class Department
{
    public string no { get; set; }
    public string fdept { get; set; }
    public string divsn { get; set; }
    public string depot { get; set; }
    public string rcvfrm { get; set; }
    public string sumrs { get; set; }
    public string prtclrpszd { get; set; }
    public string szrplace { get; set; }
    public string date { get; set; }
    public string time { get; set; }
    public string theara { get; set; }
    public string yrdd { get; set; }
    public string nummber { get; set; }
    public string fdeptmt { get; set; }
    public string divisnd { get; set; }
    public string formi { get; set; }
    public string formii { get; set; }
    public string rcvdfrm { get; set; }
    public string sumrswrd { get; set; }
    public string thrgh { get; set; }
    public string day { get; set; }
    public string twrdsd { get; set; }
    public string violtnof { get; set; }
    public string byff { get; set; }
    public string cmpndngamnt { get; set; }
    public string prtcltpszed { get; set; }
    public string plceszre { get; set; }
    public string dte { get; set; }
    public string tme { get; set; }
    public string mnth { get; set; }
    public string year { get; set; }
}

public partial class Offence : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Department> departmentlist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from departmentlist
                foreach (var department in departmentlist)
                {
                    // SQL query to insert data from departmentlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_compouding_rcpt]" +
                                   "(no, fdepatmnt, division, depot, rcvfrm, rupees, prtclepszd, szrplce, date, time, ara, year, numb, fdept, divsn, rferfi, rferfii, recvfm, smrupwrd, thrgh, ondd, twrd, vlnof, byff, rsncamnt, prpszed, plceszre, dted, tmed, thfo, yeard) " +
                                   "VALUES (@no, @fdepatmnt, @division, @depot, @rcvfrm, @rupees, @prtclepszd, @szrplce, @date, @time, @ara, @year, @numb, @fdept, @divsn, @rferfi, @rferii, @recvfm, @smrupwrd, @thrgh, @ondd, @twrd,  @vlnof, @byff, @rsncamnt, @prpszed, @plceszre, @dted, @tmed, @thfo, @yeard)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@no", department.no);
                        cmd.Parameters.AddWithValue("@fdepatmnt", department.fdept);
                        cmd.Parameters.AddWithValue("@division", department.divsn);
                        cmd.Parameters.AddWithValue("@depot", department.depot);
                        cmd.Parameters.AddWithValue("@rcvfrm", department.rcvfrm);
                        cmd.Parameters.AddWithValue("@rupees", department.sumrs);
                        cmd.Parameters.AddWithValue("@prtclepszd", department.prtclrpszd);
                        cmd.Parameters.AddWithValue("@szrplce", department.szrplace);
                        cmd.Parameters.AddWithValue("@date", department.date);
                        cmd.Parameters.AddWithValue("@time", department.time);
                        cmd.Parameters.AddWithValue("@ara", department.theara);
                        cmd.Parameters.AddWithValue("@year", department.yrdd);
                        cmd.Parameters.AddWithValue("@numb", department.nummber);
                        cmd.Parameters.AddWithValue("@fdept", department.fdeptmt);
                        cmd.Parameters.AddWithValue("@divsn", department.divisnd);
                        cmd.Parameters.AddWithValue("@rferfi", department.formi);
                        cmd.Parameters.AddWithValue("@rferii", department.formii);
                        cmd.Parameters.AddWithValue("@recvfm", department.rcvdfrm);
                        cmd.Parameters.AddWithValue("@smrupwrd", department.sumrswrd);
                        cmd.Parameters.AddWithValue("@thrgh", department.thrgh);
                        cmd.Parameters.AddWithValue("@ondd", department.day);
                        cmd.Parameters.AddWithValue("@twrd", department.twrdsd);
                        cmd.Parameters.AddWithValue("@vlnof", department.violtnof);
                        cmd.Parameters.AddWithValue("@byff", department.byff);
                        cmd.Parameters.AddWithValue("@rsncamnt", department.cmpndngamnt);
                        cmd.Parameters.AddWithValue("@prpszed", department.prtcltpszed);
                        cmd.Parameters.AddWithValue("@plceszre", department.plceszre);
                        cmd.Parameters.AddWithValue("@dted", department.dte);
                        cmd.Parameters.AddWithValue("@tmed", department.tme);
                        cmd.Parameters.AddWithValue("@thfo", department.mnth);
                        cmd.Parameters.AddWithValue("@yeard", department.year);

                        // Execute the query
                        cmd.ExecuteNonQuery();
                    }
                }

                // Close the database connection
                connection.Close();
            }

            // Return success message
            return "Data inserted successfully.";
        }
        catch (Exception ex)
        {
            // Return error message
            return "Error inserting data: " + ex.Message;
        }
    }

}