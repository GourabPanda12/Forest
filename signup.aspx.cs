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

public class Users
{
    public string firstnm { get; set; }
    public string lastnm { get; set; }
    public string phone { get; set; }
    public string email { get; set; }
}
public partial class signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Users> userslist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from departmentlist
                foreach (var users in userslist)
                {
                    // SQL query to insert data from departmentlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_newuser]" +
                                   "(fnm, lnm, phn, eml) " +
                                   "VALUES (@fnm, @lnm, @phn, @eml)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@fnm", users.firstnm);
                        cmd.Parameters.AddWithValue("@lnm", users.lastnm);
                        cmd.Parameters.AddWithValue("@phn", users.phone);
                        cmd.Parameters.AddWithValue("@eml", users.email);

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