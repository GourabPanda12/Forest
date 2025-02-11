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

public partial class courtdiry : System.Web.UI.Page
{
     private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";
	
    protected void Page_Load(object sender, EventArgs e)
    {
        // Page load logic if needed
    }

    [WebMethod]
    public static string SaveCaseDetails(CaseDetails caseDetails)
    {
        try
        {
            // Upload signature to FTP
            string signaturePath = string.Empty;
            string imagePath = string.Empty;
            if (!string.IsNullOrEmpty(caseDetails.SignatureBase64) && !string.IsNullOrEmpty(caseDetails.SignatureFileName))
            {
                bool signatureUploaded = UploadFileToFtp(caseDetails.SignatureBase64, caseDetails.SignatureFileName);
                if (signatureUploaded)
                {
                    signaturePath = "https://iicaapp.co.in/cmndcrt/" + caseDetails.SignatureFileName;
                }
                else
                {
                    return "Error: Signature upload failed.";
                }
            }

            if (!string.IsNullOrEmpty(caseDetails.ImageBase64) && !string.IsNullOrEmpty(caseDetails.ImageFileName))
            {
                bool imageUploaded = UploadFileToFtp(caseDetails.ImageBase64, caseDetails.ImageFileName);
                if (imageUploaded)
                {
                                       imagePath = "https://msksoftware.co.in/httpdocs/forestdoc/" + caseDetails.ImageFileName;

                }
                else
                {
                    return "Error: Image upload failed.";
                }
            }

            // Save case details in the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO [forestdata].[dbo].[CaseDetailsx]
                    (
                        CourtName, At, ForestRangeDivision, District, State, CourtCaseNo, DateOfFiling, CourtDiaryNo, SectionsInvoked, PreviousDate,
                        AccusedDetails, RelativeDetails, AccusedAddress, PinCode, SummonStage, BailStage, PreCharge, PleadGuilty, PostCharge, ProsEvidence,
                        DefenceWitness, Statement, Argument, WitnessType, NameOfWitness, SummonedOrAppeared, FullySupported, PartlySupported, BecameHostile,
                        ReasonsNotExamined, ProceedingsBrief, RemediesSuggested, OfficerNameRank, RangeDivision, DcfDfoComments, SignaturePath,ImagePath, SubmissionDate
                    )
                    VALUES
                    (
                        @CourtName, @At, @ForestRangeDivision, @District, @State, @CourtCaseNo, @DateOfFiling, @CourtDiaryNo, @SectionsInvoked, @PreviousDate,
                        @AccusedDetails, @RelativeDetails, @AccusedAddress, @PinCode, @SummonStage, @BailStage, @PreCharge, @PleadGuilty, @PostCharge, @ProsEvidence,
                        @DefenceWitness, @Statement, @Argument, @WitnessType, @NameOfWitness, @SummonedOrAppeared, @FullySupported, @PartlySupported, @BecameHostile,
                        @ReasonsNotExamined, @ProceedingsBrief, @RemediesSuggested, @OfficerNameRank, @RangeDivision, @DcfDfoComments, @SignaturePath,@ImagePath, @SubmissionDate
                    )";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters
                    command.Parameters.AddWithValue("@CourtName", caseDetails.CourtName ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@At", caseDetails.At ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ForestRangeDivision", caseDetails.ForestRangeDivision ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@District", caseDetails.District ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@State", caseDetails.State ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@CourtCaseNo", caseDetails.CourtCaseNo ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@DateOfFiling", caseDetails.DateOfFiling ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@CourtDiaryNo", caseDetails.CourtDiaryNo ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@SectionsInvoked", caseDetails.SectionsInvoked ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@PreviousDate", caseDetails.PreviousDate ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@AccusedDetails", caseDetails.AccusedDetails ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@RelativeDetails", caseDetails.RelativeDetails ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@AccusedAddress", caseDetails.AccusedAddress ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@PinCode", caseDetails.PinCode ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@SummonStage", caseDetails.SummonStage);
                    command.Parameters.AddWithValue("@BailStage", caseDetails.BailStage);
                    command.Parameters.AddWithValue("@PreCharge", caseDetails.PreCharge);
                    command.Parameters.AddWithValue("@PleadGuilty", caseDetails.PleadGuilty);
                    command.Parameters.AddWithValue("@PostCharge", caseDetails.PostCharge);
                    command.Parameters.AddWithValue("@ProsEvidence", caseDetails.ProsEvidence);
                    command.Parameters.AddWithValue("@DefenceWitness", caseDetails.DefenceWitness);
                    command.Parameters.AddWithValue("@Statement", caseDetails.Statement);
                    command.Parameters.AddWithValue("@Argument", caseDetails.Argument);
                    command.Parameters.AddWithValue("@WitnessType", caseDetails.WitnessType ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@NameOfWitness", caseDetails.NameOfWitness ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@SummonedOrAppeared", caseDetails.SummonedOrAppeared ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@FullySupported", caseDetails.FullySupported ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@PartlySupported", caseDetails.PartlySupported ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@BecameHostile", caseDetails.BecameHostile ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ReasonsNotExamined", caseDetails.ReasonsNotExamined ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ProceedingsBrief", caseDetails.ProceedingsBrief ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@RemediesSuggested", caseDetails.RemediesSuggested ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@OfficerNameRank", caseDetails.OfficerNameRank ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@RangeDivision", caseDetails.RangeDivision ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@DcfDfoComments", caseDetails.DcfDfoComments ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@SignaturePath", signaturePath ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ImagePath", string.IsNullOrEmpty(imagePath) ? DBNull.Value : (object)imagePath);
                    command.Parameters.AddWithValue("@SubmissionDate", DateTime.Now);

                    // Execute query
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            return "Success";
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error saving case details: " + ex.Message);
            return "Error: " + ex.Message;
        }
    }

    private static bool UploadFileToFtp(string base64Data, string fileName)
    {
        if (string.IsNullOrEmpty(base64Data) || string.IsNullOrEmpty(fileName))
        {
            return false;
        }

        try
        {
            string[] dataParts = base64Data.Split(',');
            if (dataParts.Length < 2)
            {
                return false;
            }

            byte[] fileBytes = Convert.FromBase64String(dataParts[1]);

            string fullPath = FtpFolder + fileName;
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(fullPath);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(FtpUsername, FtpPassword);
            request.ContentLength = fileBytes.Length;
            request.UsePassive = true;
            request.UseBinary = true;
            request.ServicePoint.ConnectionLimit = fileBytes.Length;
            request.EnableSsl = false;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileBytes, 0, fileBytes.Length);
            }

            using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
            {
                return response.StatusCode == FtpStatusCode.ClosingData;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("FTP upload failed: " + ex.Message);
            return false;
        }
    }

    public class CaseDetails
    {
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
        public bool SummonStage { get; set; }
        public bool BailStage { get; set; }
        public bool PreCharge { get; set; }
        public bool PleadGuilty { get; set; }
        public bool PostCharge { get; set; }
        public bool ProsEvidence { get; set; }
        public bool DefenceWitness { get; set; }
        public bool Statement { get; set; }
        public bool Argument { get; set; }
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
        public string SignatureBase64 { get; set; }
        public string SignatureFileName { get; set; }
        public string ImageBase64 { get; set; }
        public string ImageFileName { get; set; }
    }
}