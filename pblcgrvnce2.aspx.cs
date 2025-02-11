using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration; 

public partial class pblcgrvnce2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { }

    [WebMethod]
    public static List<Submission> GetSubmissions()
    {
        List<Submission> submissions = new List<Submission>();

        // Fetch connection string from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Correct SQL query without SubmissionID
            string query = @"SELECT [Name], [Mobile], [District], [Description], 
                                    [FilePath], [SubmissionDate], [Division] 
                             FROM [forestdata].[dbo].[submissions]";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    submissions.Add(new Submission
                    {
                        Name = reader["Name"].ToString(),
                        Mobile = reader["Mobile"].ToString(),
                        District = reader["District"].ToString(),
                        Division = reader["Division"].ToString(),
                        Description = reader["Description"].ToString(),
                        FilePath = reader["FilePath"] != DBNull.Value ? reader["FilePath"].ToString().Split('/')[4] : null,
                        SubmissionDate = reader["SubmissionDate"] != DBNull.Value
                            ? Convert.ToDateTime(reader["SubmissionDate"]).ToString("yyyy-MM-ddTHH:mm:ss")
                            : null // Use ISO format for JavaScript
                    });
                }
            }
        }

        return submissions;
    }

    public class Submission
    {
        public string Name { get; set; }
        public string Mobile { get; set; }
        public string District { get; set; }
        public string Division { get; set; }
        public string Description { get; set; }
        public string FilePath { get; set; }
        public string SubmissionDate { get; set; }
    }
}
