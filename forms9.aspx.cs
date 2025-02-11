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

public class Casediary
{
    public string bookno { get; set;}
    public string slno { get; set; }
    public string caseno { get; set; }
    public string date { get; set; }
    public string reformino { get; set; }

}
public partial class forms9 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Casediary> casediarylist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from departmentlist
                foreach (var casediary in casediarylist)
                {
                    // SQL query to insert data from departmentlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_casediary]" +
                                   "(bookno, slno, caseno, date, reformi) " +
                                   "VALUES (@bookno, @slno, @caseno, @date, @reformi)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@bookno", casediary.bookno);
                        cmd.Parameters.AddWithValue("@slno", casediary.slno);
                        cmd.Parameters.AddWithValue("@caseno", casediary.caseno);
                        cmd.Parameters.AddWithValue("@date", casediary.date);
                        cmd.Parameters.AddWithValue("@reformi", casediary.reformino);
                       
                       
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