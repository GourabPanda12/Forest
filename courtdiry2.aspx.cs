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
using System.Web.Script.Serialization;
using System.Globalization;

public partial class courtdiry2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class CaseDetail
    {
        public int Id { get; set; }
        public string CourtName { get; set; }
        public string At { get; set; }
        public string ForestRangeDivision { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string CourtCaseNo { get; set; }
        public string DateOfFiling { get; set; }
        public string CourtDiaryNo { get; set; }
        public string SectionsInvoked { get; set; }
        public string PreviousDate { get; set; }
        public string AccusedDetails { get; set; }
        public string RelativeDetails { get; set; }
        public string AccusedAddress { get; set; }
        public string PinCode { get; set; }
        public string SummonStage { get; set; }
        public string BailStage { get; set; }
        public string PreCharge { get; set; }
        public string PleadGuilty { get; set; }
        public string PostCharge { get; set; }
        public string ProsEvidence { get; set; }
        public string DefenceWitness { get; set; }
        public string Statement { get; set; }
        public string Argument { get; set; }
        public string WitnessType { get; set; }
        public string NameOfWitness { get; set; }
        public string SummonedOrAppeared { get; set; }
        public string FullySupported { get; set; }
        public string PartlySupported { get; set; }
        public string BecameHostile { get; set; }
        public string ReasonsNotExamined { get; set; }
        public string ProceedingsBrief { get; set; }
        public string RemediesSuggested { get; set; }
        public string OfficerNameRank { get; set; }
        public string RangeDivision { get; set; }
        public string DcfDfoComments { get; set; }
        public string SubmissionDate { get; set; }
        public string SignaturePath { get; set; }
     
        public string ImagePath { get; set; }
    }

    [WebMethod]
    public static List<CaseDetail> GetCaseDetails()
    {
        List<CaseDetail> caseDetailsList = new List<CaseDetail>();

        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        string query = @"SELECT TOP (1000) 
                            [Id], [CourtName], [At], [ForestRangeDivision], [District], [State], 
                            [CourtCaseNo], [DateOfFiling], [CourtDiaryNo], [SectionsInvoked], 
                            [PreviousDate], [AccusedDetails], [RelativeDetails], [AccusedAddress], 
                            [PinCode], [SummonStage], [BailStage], [PreCharge], [PleadGuilty], 
                            [PostCharge], [ProsEvidence], [DefenceWitness], [Statement], 
                            [Argument], [WitnessType], [NameOfWitness], [SummonedOrAppeared], 
                            [FullySupported], [PartlySupported], [BecameHostile], 
                            [ReasonsNotExamined], [ProceedingsBrief], [RemediesSuggested], 
                            [OfficerNameRank], [RangeDivision], [DcfDfoComments],  [SubmissionDate],
                            [SignaturePath],[ImagePath]
                        FROM [forestdata].[dbo].[CaseDetailsx]";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        caseDetailsList.Add(new CaseDetail
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            CourtName = reader["CourtName"].ToString(),
                            At = reader["At"].ToString(),
                            ForestRangeDivision = reader["ForestRangeDivision"].ToString(),
                            District = reader["District"].ToString(),
                            State = reader["State"].ToString(),
                            CourtCaseNo = reader["CourtCaseNo"].ToString(),
                            DateOfFiling = reader["DateOfFiling"].ToString(),
                            CourtDiaryNo = reader["CourtDiaryNo"].ToString(),
                            SectionsInvoked = reader["SectionsInvoked"].ToString(),
                            PreviousDate = reader["PreviousDate"].ToString(),
                            AccusedDetails = reader["AccusedDetails"].ToString(),
                            RelativeDetails = reader["RelativeDetails"].ToString(),
                            AccusedAddress = reader["AccusedAddress"].ToString(),
                            PinCode = reader["PinCode"].ToString(),
                            SummonStage = reader["SummonStage"].ToString(),
                            BailStage = reader["BailStage"].ToString(),
                            PreCharge = reader["PreCharge"].ToString(),
                            PleadGuilty = reader["PleadGuilty"].ToString(),
                            PostCharge = reader["PostCharge"].ToString(),
                            ProsEvidence = reader["ProsEvidence"].ToString(),
                            DefenceWitness = reader["DefenceWitness"].ToString(),
                            Statement = reader["Statement"].ToString(),
                            Argument = reader["Argument"].ToString(),
                            WitnessType = reader["WitnessType"].ToString(),
                            NameOfWitness = reader["NameOfWitness"].ToString(),
                            SummonedOrAppeared = reader["SummonedOrAppeared"].ToString(),
                            FullySupported = reader["FullySupported"].ToString(),
                            PartlySupported = reader["PartlySupported"].ToString(),
                            BecameHostile = reader["BecameHostile"].ToString(),
                            ReasonsNotExamined = reader["ReasonsNotExamined"].ToString(),
                            ProceedingsBrief = reader["ProceedingsBrief"].ToString(),
                            RemediesSuggested = reader["RemediesSuggested"].ToString(),
                            OfficerNameRank = reader["OfficerNameRank"].ToString(),
                            RangeDivision = reader["RangeDivision"].ToString(),
                            DcfDfoComments = reader["DcfDfoComments"].ToString(),
                            SubmissionDate = reader["SubmissionDate"].ToString(),
                            SignaturePath = reader["SignaturePath"].ToString(),
                           
                            ImagePath = reader["ImagePath"].ToString()
                        });
                    }
                }
            }
        }

        return caseDetailsList;
    }
}