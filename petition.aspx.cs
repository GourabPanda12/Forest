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
public class Officer
{
    public string division { get; set; }
    public string nmof { get; set; }
    public string sonof { get; set; }
    public string resdof { get; set; }
    public string po { get; set; }
    public string dist { get; set; }
    public string acsdnm { get; set; }
    public string fnm { get; set; }
    public string pmntadr { get; set; }
    public string tempadr { get; set; }
    public string prtclrofnc { get; set; }
    public string iprpty { get; set; }
    public string adrsac { get; set; }
    public string dateac { get; set; }
    public string adrsw { get; set; }
    public string datew { get; set; }
	 public string ofcrnm { get; set; }
    public string ofcrdsg { get; set; }
   

}

public partial class petition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Officer> officerlist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from informlist
                foreach (var officer in officerlist)
                {
                    // SQL query to insert data from informlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_compondingptn] " +
                                   "(division,rfo,sof,resid,po,dist,acsnm,fnm,padrs,tadrs,prtclrofns,prprty,adrs,date,adrsi,dateii,ofcrnm,ofcrdesig) " +
                                   "VALUES (@division,@rfo,@sof,@resid,@po,@dist,@acsnm,@fnm,@padrs,@tadrs,@prtclrofns,@prprty,@adrs,@date,@adrsi,@dateii, @ofcrnm, @ofcrdesig)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@division", officer.division);
                        cmd.Parameters.AddWithValue("@rfo", officer.nmof);
                        cmd.Parameters.AddWithValue("@sof", officer.sonof);
                        cmd.Parameters.AddWithValue("@resid", officer.resdof);
                        cmd.Parameters.AddWithValue("@po", officer.po);
                        cmd.Parameters.AddWithValue("@dist", officer.dist);
                        cmd.Parameters.AddWithValue("@acsnm", officer.acsdnm);
                        cmd.Parameters.AddWithValue("@fnm", officer.fnm);
                        cmd.Parameters.AddWithValue("@padrs", officer.pmntadr);
                        cmd.Parameters.AddWithValue("@tadrs", officer.tempadr);
                        cmd.Parameters.AddWithValue("@prtclrofns", officer.prtclrofnc);
                        cmd.Parameters.AddWithValue("@prprty", officer.iprpty);
                        cmd.Parameters.AddWithValue("@adrs", officer.adrsac);
                        cmd.Parameters.AddWithValue("@date", officer.dateac);
                        cmd.Parameters.AddWithValue("@adrsi", officer.adrsw);
                        cmd.Parameters.AddWithValue("@dateii", officer.datew);
                        cmd.Parameters.AddWithValue("@ofcrnm", officer.ofcrnm);
                        cmd.Parameters.AddWithValue("@ofcrdesig", officer.ofcrdsg);

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