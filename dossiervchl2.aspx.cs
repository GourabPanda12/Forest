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

public partial class dossiervchl2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<SeizureDetails> GetSeizureDetails()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        List<SeizureDetails> seizureDetailsList = new List<SeizureDetails>();

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM [forestdata].[forestadmin].[SeizureDetails]";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            SeizureDetails details = new SeizureDetails
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                MakeModel = reader["MakeModel"].ToString(),
                                VIN = reader["VIN"].ToString(),
                                RegistrationNumber = reader["RegistrationNumber"].ToString(),
                                Color = reader["Color"].ToString(),
                                YearManufacture = reader["YearManufacture"].ToString(),
                                OdometerReading = reader["OdometerReading"].ToString(),
                                OwnerName = reader["OwnerName"].ToString(),
                                OwnerFatherName = reader["OwnerFatherName"].ToString(),
                                OwnerAddress = reader["OwnerAddress"].ToString(),
                                OwnerContact = reader["OwnerContact"].ToString(),
                                OwnerEmail = reader["OwnerEmail"].ToString(),
                                OwnerId = reader["OwnerId"].ToString(),
                                DateSeizure = reader["DateSeizure"] != DBNull.Value ?  Convert.ToDateTime(reader["DateSeizure"]).ToString("yyyy-MM-dd") : string.Empty,
                                LocationSeizure = reader["LocationSeizure"].ToString(),
                                ReasonSeizure = reader["ReasonSeizure"].ToString(),
                                AuthoritySeized = reader["AuthoritySeized"].ToString(),
                                CurrentLocation = reader["CurrentLocation"].ToString(),
                                VehicleType = reader["VehicleType"].ToString(),
                                EngineNumber = reader["EngineNumber"].ToString(),
                                ChassisNumber = reader["ChassisNumber"].ToString(),
                                ConditionVehicle = reader["ConditionVehicle"].ToString(),
                                AdditionalFeatures = reader["AdditionalFeatures"].ToString(),
                                RC = reader["RC"].ToString(),
                                Insurance = reader["Insurance"].ToString(),
                                PUC = reader["PUC"].ToString(),
                                OtherDocuments = reader["OtherDocuments"].ToString(),
                                PreviousOffenses = reader["PreviousOffenses"].ToString(),
                                CaseNumber = reader["CaseNumber"].ToString(),
                                Court = reader["Court"].ToString(),
                                InvestigatingOfficer = reader["InvestigatingOfficer"].ToString(),
                                BriefCase = reader["BriefCase"].ToString(),
                                VehicleUsage = reader["VehicleUsage"].ToString(),
                                RegionsOperated = reader["RegionsOperated"].ToString(),
                                AcquittalsConvictions = reader["AcquittalsConvictions"].ToString(),
                                AdditionalNotes = reader["AdditionalNotes"].ToString(),
                                SignaturePath = reader["SignaturePath"].ToString(),
                                ImagePaths = reader["ImagePaths"].ToString()
                            };

                            seizureDetailsList.Add(details);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Handle errors (log, rethrow, etc.)
            throw new Exception("Error retrieving seizure details: " + ex.Message);
        }

        return seizureDetailsList;
    }
}

// Model class for SeizureDetails
public class SeizureDetails
{
    public int Id { get; set; }
    public string MakeModel { get; set; }
    public string VIN { get; set; }
    public string RegistrationNumber { get; set; }
    public string Color { get; set; }
    public string YearManufacture { get; set; }
    public string OdometerReading { get; set; }
    public string OwnerName { get; set; }
    public string OwnerFatherName { get; set; }
    public string OwnerAddress { get; set; }
    public string OwnerContact { get; set; }
    public string OwnerEmail { get; set; }
    public string OwnerId { get; set; }
    public string DateSeizure { get; set; }
    public string LocationSeizure { get; set; }
    public string ReasonSeizure { get; set; }
    public string AuthoritySeized { get; set; }
    public string CurrentLocation { get; set; }
    public string VehicleType { get; set; }
    public string EngineNumber { get; set; }
    public string ChassisNumber { get; set; }
    public string ConditionVehicle { get; set; }
    public string AdditionalFeatures { get; set; }
    public string RC { get; set; }
    public string Insurance { get; set; }
    public string PUC { get; set; }
    public string OtherDocuments { get; set; }
    public string PreviousOffenses { get; set; }
    public string CaseNumber { get; set; }
    public string Court { get; set; }
    public string InvestigatingOfficer { get; set; }
    public string BriefCase { get; set; }
    public string VehicleUsage { get; set; }
    public string RegionsOperated { get; set; }
    public string AcquittalsConvictions { get; set; }
    public string AdditionalNotes { get; set; }
    public string SignaturePath { get; set; }
    public string ImagePaths { get; set; }
}
