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
public class Final
{
    public string divisn { get; set; }
    public string dt { get; set; }
    public string offncrpt { get; set; }
    public string range { get; set; }
    public string dtofdtctn { get; set; }
    public string pocrnce { get; set; }
    public string hrdtctn { get; set; }
    public string whmdtct { get; set; }
    public string anm { get; set; }
    public string ftnm { get; set; }
    public string village { get; set; }
    public string thana { get; set; }
    public string dist { get; set; }
    public string divson { get; set; }
    public string offcrptno { get; set; }
    public string dated { get; set; }
    public string rvnestrnge { get; set; }
    public string memono { get; set; }
    public string dtd { get; set; }
    public string dfoinchrge { get; set; }
    public string divisnx { get; set; }
    public string memonumber { get; set; }
    public string dat { get; set; }
    public string dfochrg { get; set; }
    public string divisnd { get; set; }
}
public partial class final : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Final> finalist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from departmentlist
                foreach (var final in finalist)
                {
                    // SQL query to insert data from departmentlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_finalrepo] " +
                                   "(division, dated, ofncrno, range, dodt, plceoccr, timedt, bywhmdtct, acsdnm, fnm, vlge, thana, dist, dvsn, ofnrepon, date, rvnestrng, memono, dte, dfoinc, divsn, memonumb, dtde, dfoch, divisn) " +
                                   "VALUES (@division, @dated, @ofncrno, @range, @dodt, @plceoccr, @timedt, @bywhmdtct, @acsdnm, @fnm, @vlge, @thana, @dist, @dvsn, @ofnrepon, @date, @rvnestrng, @memono, @dte, @dfoinc, @divsn, @memonumb, @dtde, @dfoch, @divisn)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@division", final.divisn);
                        cmd.Parameters.AddWithValue("@dated", final.dt);
                        cmd.Parameters.AddWithValue("@ofncrno", final.offncrpt);
                        cmd.Parameters.AddWithValue("@range", final.range);
                        cmd.Parameters.AddWithValue("@dodt", final.dtofdtctn);
                        cmd.Parameters.AddWithValue("@plceoccr", final.pocrnce);
                        cmd.Parameters.AddWithValue("@timedt", final.hrdtctn);
                        cmd.Parameters.AddWithValue("@bywhmdtct", final.whmdtct);
                        cmd.Parameters.AddWithValue("@acsdnm", final.anm);
                        cmd.Parameters.AddWithValue("@fnm", final.ftnm);
                        cmd.Parameters.AddWithValue("@vlge", final.village);
                        cmd.Parameters.AddWithValue("@thana", final.thana);
                        cmd.Parameters.AddWithValue("@dist", final.dist);
                        cmd.Parameters.AddWithValue("@dvsn", final.divson);
                        cmd.Parameters.AddWithValue("@ofnrepon", final.offcrptno);
                        cmd.Parameters.AddWithValue("@date", final.dated);
                        cmd.Parameters.AddWithValue("@rvnestrng", final.rvnestrnge);
                        cmd.Parameters.AddWithValue("@memono", final.memono);
                        cmd.Parameters.AddWithValue("@dte", final.dtd);
                        cmd.Parameters.AddWithValue("@dfoinc", final.dfoinchrge);
                        cmd.Parameters.AddWithValue("@divsn", final.divisnx);
                        cmd.Parameters.AddWithValue("@memonumb", final.memonumber);
                        cmd.Parameters.AddWithValue("@dtde", final.dat);
                        cmd.Parameters.AddWithValue("@dfoch", final.dfochrg);
                        cmd.Parameters.AddWithValue("@divisn", final.divisnd);
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