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
public class Information
{
    public string date { get; set; }
    public string nmfo { get; set; }
    public string property { get; set; }
    public string section { get; set; }
    public string act { get; set; }
	 public string rngrof { get; set; }
	 public string frstrof { get; set; }
    public string repono { get; set; }
    public string dated { get; set; }
    public string szreno { get; set; }
    public string formno { get; set; }
}


  

public partial class forms4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Information> informlist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from informlist
                foreach (var information in informlist)
                {
                    // SQL query to insert data from informlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_seizure_info] " +
                                   "(sdt, nmfo, prprtyof, section,act,rangerof,frstrof,repono, date, szrelistn, formno) " +
                                   "VALUES (@sdt, @nmfo, @prprtyof, @section, @act, @rangerof, @frstrof, @repono, @date, @szrelistn, @formno)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@sdt", information.date);
                        cmd.Parameters.AddWithValue("@nmfo", information.nmfo);
                        cmd.Parameters.AddWithValue("@prprtyof", information.property);
                        cmd.Parameters.AddWithValue("@section", information.section);
                        cmd.Parameters.AddWithValue("@act", information.act);
						cmd.Parameters.AddWithValue("@rangerof", information.rngrof);
						cmd.Parameters.AddWithValue("@frstrof", information.frstrof);
                        cmd.Parameters.AddWithValue("@repono", information.repono);
                        cmd.Parameters.AddWithValue("@date", information.dated);
                        cmd.Parameters.AddWithValue("@szrelistn", information.szreno);
                        cmd.Parameters.AddWithValue("@formno", information.formno);


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