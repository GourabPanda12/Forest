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

public class Fdepartment
{

    public string offncfno { get; set; }
    public string shri { get; set; }
    public string ttlsum { get; set; }
    public string sumwrds { get; set; }
    public string sectn { get; set; }
    public string szrdtl { get; set; }
    public string athrfo { get; set; }
    public string designation { get; set; }
    public string place { get; set; }
    public string dated { get; set; }
    public string mrdd { get; set; }
    public string offclrmge { get; set; }
    public string formino { get; set; }
    public string fdeptmt { get; set; }
    public string divisn { get; set; }
    public string formi { get; set; }
    public string formii { get; set; }
    public string under { get; set; }
    public string acsnm { get; set; }
    public string rsum { get; set; }
    public string suminwords { get; set; }
    public string rsncamnt { get; set; }
    public string formiino { get; set; }
    public string places { get; set; }
    public string dte { get; set; }
    public string tme { get; set; }
    public string ofcr { get; set; }
    public string rngofcrnm { get; set; }

}

public partial class compoundorder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Fdepartment> fdepartmentlist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from informlist
                foreach (var fdepartment in fdepartmentlist)
                {
                    // SQL query to insert data from informlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_compouding_order]" +
                                   "(fileno, acsednm, amnt, amntw, section, szuredtl, athrzefo, desig, place, dt, rfo, officernge, formino, forestdept, division, rferfi, rferfii, ofncunder, acsed, ttlamnt, ttlamntwods, reason, formiino, plce, dte, tme, ofcr, rofcerof) " +
                                   "VALUES (@fileno, @acsednm, @amnt, @amntw, @section, @szuredtl, @athrzefo, @desig,  @place, @dt, @rfo, @officernge, @formino, @forestdept, @division, @rferfi, @rferfii, @ofncunder, @acsed, @ttlamnt, @ttlamntwods, @reason, @formiino, @plce,@dte, @tme, @ofcr, @rofcerof)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@fileno", fdepartment.offncfno);
                        cmd.Parameters.AddWithValue("@acsednm", fdepartment.shri);
                        cmd.Parameters.AddWithValue("@amnt", fdepartment.ttlsum);
                        cmd.Parameters.AddWithValue("@amntw", fdepartment.sumwrds);
                        cmd.Parameters.AddWithValue("@section", fdepartment.sectn);
                        cmd.Parameters.AddWithValue("@szuredtl", fdepartment.szrdtl);
                        cmd.Parameters.AddWithValue("@athrzefo", fdepartment.athrfo);
                        cmd.Parameters.AddWithValue("@desig", fdepartment.designation);
                        cmd.Parameters.AddWithValue("@place", fdepartment.place);
                        cmd.Parameters.AddWithValue("@dt", fdepartment.dated);
                        cmd.Parameters.AddWithValue("@rfo", fdepartment.mrdd);
                        cmd.Parameters.AddWithValue("@officernge", fdepartment.offclrmge);
                        cmd.Parameters.AddWithValue("@formino", fdepartment.formino);
                        cmd.Parameters.AddWithValue("@forestdept", fdepartment.fdeptmt);
                        cmd.Parameters.AddWithValue("@division", fdepartment.divisn);
                        cmd.Parameters.AddWithValue("@rferfi", fdepartment.formi);
                        cmd.Parameters.AddWithValue("@rferfii", fdepartment.formii);
                        cmd.Parameters.AddWithValue("@ofncunder", fdepartment.under);
                        cmd.Parameters.AddWithValue("@acsed", fdepartment.acsnm);
                        cmd.Parameters.AddWithValue("@ttlamnt", fdepartment.rsum);
                        cmd.Parameters.AddWithValue("@ttlamntwods", fdepartment.suminwords);
                        cmd.Parameters.AddWithValue("@reason", fdepartment.rsncamnt);
                        cmd.Parameters.AddWithValue("@formiino", fdepartment.formiino);
                        cmd.Parameters.AddWithValue("@plce", fdepartment.places);
                        cmd.Parameters.AddWithValue("@dte", fdepartment.dte);
                        cmd.Parameters.AddWithValue("@tme", fdepartment.tme);
                        cmd.Parameters.AddWithValue("@ofcr", fdepartment.ofcr);
                        cmd.Parameters.AddWithValue("@rofcerof", fdepartment.rngofcrnm);
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