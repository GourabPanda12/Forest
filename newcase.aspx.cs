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
public class Newcase
{
    public string caseno { get; set; }
    public string date { get; set; }
    public string div { get; set; }
    public string dist { get; set; }
    public string city { get; set; }
    public string rangeofcr { get; set; }
    public string remark { get; set; }
}
public partial class newcase : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public static string autofillid()
    //{
    //    string x = string.Empty;
    //    DATABASE DB = new DATABASE();
    //    DataTable DF = DB.returnDt("  select isnull(MAX(id),1) as id from tbl_newcaseform ");
    //    return DF.Rows[0]["id"].ToString();
    //}
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Newcase> caselist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Begin a transaction
                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Insert data from caselist
                        foreach (var newcase in caselist)
                        {
                            // SQL query to insert data
                            string query = "INSERT INTO [forestdata].[dbo].[tbl_newcaseform] " +
                                           "(casno, date, division, dist, city, rangeofcr, remark) " +
                                           "VALUES (@casno, @date, @division, @dist, @city, @rangeofcr, @remark)";

                            // Execute the SQL query
                            using (SqlCommand cmd = new SqlCommand(query, connection, transaction))
                            {
                                // Set parameters
                                cmd.Parameters.AddWithValue("@casno", newcase.caseno);
                                cmd.Parameters.AddWithValue("@date", newcase.date);
                                cmd.Parameters.AddWithValue("@division", newcase.div);
                                cmd.Parameters.AddWithValue("@dist", newcase.dist);
                                cmd.Parameters.AddWithValue("@city", newcase.city);
                                cmd.Parameters.AddWithValue("@rangeofcr", newcase.rangeofcr);
                                cmd.Parameters.AddWithValue("@remark", newcase.remark);

                                // Execute the query
                                cmd.ExecuteNonQuery();
                            }
                        }

                        // Commit the transaction
                        transaction.Commit();

                        // Close the database connection
                        connection.Close();

                        // Return success message
                        return "Data inserted successfully.";
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction in case of error
                        transaction.Rollback();

                        // Return error message
                        return "Error inserting data: " + ex.Message;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Return error message
            return "Error inserting data: " + ex.Message;
        }
    }
	
	
	
	
	  [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp()
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; Getdespp3
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select divs,id from tbl_dist order by divs asc";
            
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
						
							 countries.Add(string.Format("{0}*{1}", sdr["id"], sdr["divs"]));
						
                       
                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }
	

	  [System.Web.Services.WebMethod(EnableSession = true)]
    public static string[] Getdesp1(string name)
    {

        SqlConnection con1 = new SqlConnection();

        DATABASE DB = new DATABASE();

        //string sql = "insert into tbl_subcat (subname,catid) values ('" + name + "','" + catid + "')"; Getdespp3
        //con1 = DB.getCon();
        //SqlCommand cmmds = new SqlCommand(sql, con1);
        //DB.ExecQry(cmmds);

        List<string> countries = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select divs,id from tbl_divs where did ="+name+"";
            
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
						
							 countries.Add(string.Format("{0}*{1}", sdr["id"], sdr["divs"]));
						
                       
                    }
                }
                conn.Close();
            }
        }

        return countries.ToArray();

    }

}