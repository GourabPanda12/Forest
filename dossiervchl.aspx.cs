using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Services;
using System.Net;
using System.IO;
using System.Web.Script.Services;
using Newtonsoft.Json;

public partial class dossiervchl : System.Web.UI.Page
{
    private const string FtpFolder = "ftp://msksoftware.co.in/httpdocs/forestdoc/";
    private const string FtpUsername = "mskuser";
    private const string FtpPassword = "Swadhin@#12";

    // Add new class to handle image data
    public class ImageData
    {
        public string Base64 { get; set; }
        public string FileName { get; set; }
    }

    // Modified FormData class to include image array
    public class FormData
    {
        // ... (existing properties remain the same)
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
        public DateTime? DateSeizure { get; set; }
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
        public string SignatureBase64 { get; set; }
        public string SignatureFileName { get; set; }
        public List<ImageData> Images { get; set; }
    }

    [WebMethod]
    public static string SaveFormData(FormData formData)
    {
        try
        {
            // Handle signature upload
            string signaturePath = string.Empty;
            if (!string.IsNullOrEmpty(formData.SignatureBase64) && !string.IsNullOrEmpty(formData.SignatureFileName))
            {
                bool signatureUploaded = UploadFileToFtp(formData.SignatureBase64, formData.SignatureFileName);
                if (signatureUploaded)
                {
                    signaturePath = "https://msksoftware.co.in/forestdoc/" + formData.SignatureFileName;
                }
                else
                {
                    return "Error: Signature upload failed.";
                }
            }

            // Handle multiple image uploads
            List<string> imagePaths = new List<string>();
            if (formData.Images != null && formData.Images.Count > 0)
            {
                foreach (var image in formData.Images)
                {
                    if (!string.IsNullOrEmpty(image.Base64) && !string.IsNullOrEmpty(image.FileName))
                    {
                        bool imageUploaded = UploadFileToFtp(image.Base64, image.FileName);
                        if (imageUploaded)
                        {
                            imagePaths.Add("https://msksoftware.co.in/forestdoc/" + image.FileName);
                        }
                        else
                        {
                            return "Error: Image upload failed for " + image.FileName;
                        }
                    }
                }
            }

            // Combine image paths into a single string with delimiter
            string combinedImagePaths = string.Join("|", imagePaths);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO [forestdata].[forestadmin].[SeizureDetails]
                    (
                        MakeModel, VIN, RegistrationNumber, Color, YearManufacture, OdometerReading, OwnerName, 
                        OwnerFatherName, OwnerAddress, OwnerContact, OwnerEmail, OwnerId, DateSeizure, 
                        LocationSeizure, ReasonSeizure, AuthoritySeized, CurrentLocation, VehicleType, EngineNumber, 
                        ChassisNumber, ConditionVehicle, AdditionalFeatures, RC, Insurance, PUC, OtherDocuments, 
                        PreviousOffenses, CaseNumber, Court, InvestigatingOfficer, BriefCase, VehicleUsage, 
                        RegionsOperated, AcquittalsConvictions, AdditionalNotes, SignaturePath, ImagePaths
                    ) 
                    VALUES 
                    (
                        @MakeModel, @VIN, @RegistrationNumber, @Color, @YearManufacture, @OdometerReading, @OwnerName, 
                        @OwnerFatherName, @OwnerAddress, @OwnerContact, @OwnerEmail, @OwnerId, @DateSeizure, 
                        @LocationSeizure, @ReasonSeizure, @AuthoritySeized, @CurrentLocation, @VehicleType, @EngineNumber, 
                        @ChassisNumber, @ConditionVehicle, @AdditionalFeatures, @RC, @Insurance, @PUC, @OtherDocuments, 
                        @PreviousOffenses, @CaseNumber, @Court, @InvestigatingOfficer, @BriefCase, @VehicleUsage, 
                        @RegionsOperated, @AcquittalsConvictions, @AdditionalNotes, @SignaturePath, @ImagePaths
                    )";

                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@MakeModel", formData.MakeModel);
                cmd.Parameters.AddWithValue("@VIN", formData.VIN);
                cmd.Parameters.AddWithValue("@RegistrationNumber", formData.RegistrationNumber);
                cmd.Parameters.AddWithValue("@Color", formData.Color);
                cmd.Parameters.AddWithValue("@YearManufacture", formData.YearManufacture);
                cmd.Parameters.AddWithValue("@OdometerReading", formData.OdometerReading);
                cmd.Parameters.AddWithValue("@OwnerName", formData.OwnerName);
                cmd.Parameters.AddWithValue("@OwnerFatherName", formData.OwnerFatherName);
                cmd.Parameters.AddWithValue("@OwnerAddress", formData.OwnerAddress);
                cmd.Parameters.AddWithValue("@OwnerContact", formData.OwnerContact);
                cmd.Parameters.AddWithValue("@OwnerEmail", formData.OwnerEmail);
                cmd.Parameters.AddWithValue("@OwnerId", formData.OwnerId);
                cmd.Parameters.AddWithValue("@DateSeizure", (object)formData.DateSeizure ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@LocationSeizure", formData.LocationSeizure);
                cmd.Parameters.AddWithValue("@ReasonSeizure", formData.ReasonSeizure);
                cmd.Parameters.AddWithValue("@AuthoritySeized", formData.AuthoritySeized);
                cmd.Parameters.AddWithValue("@CurrentLocation", formData.CurrentLocation);
                cmd.Parameters.AddWithValue("@VehicleType", formData.VehicleType);
                cmd.Parameters.AddWithValue("@EngineNumber", formData.EngineNumber);
                cmd.Parameters.AddWithValue("@ChassisNumber", formData.ChassisNumber);
                cmd.Parameters.AddWithValue("@ConditionVehicle", formData.ConditionVehicle);
                cmd.Parameters.AddWithValue("@AdditionalFeatures", formData.AdditionalFeatures);
                cmd.Parameters.AddWithValue("@RC", formData.RC);
                cmd.Parameters.AddWithValue("@Insurance", formData.Insurance);
                cmd.Parameters.AddWithValue("@PUC", formData.PUC);
                cmd.Parameters.AddWithValue("@OtherDocuments", formData.OtherDocuments);
                cmd.Parameters.AddWithValue("@PreviousOffenses", formData.PreviousOffenses);
                cmd.Parameters.AddWithValue("@CaseNumber", formData.CaseNumber);
                cmd.Parameters.AddWithValue("@Court", formData.Court);
                cmd.Parameters.AddWithValue("@InvestigatingOfficer", formData.InvestigatingOfficer);
                cmd.Parameters.AddWithValue("@BriefCase", formData.BriefCase);
                cmd.Parameters.AddWithValue("@VehicleUsage", formData.VehicleUsage);
                cmd.Parameters.AddWithValue("@RegionsOperated", formData.RegionsOperated);
                cmd.Parameters.AddWithValue("@AcquittalsConvictions", formData.AcquittalsConvictions);
                cmd.Parameters.AddWithValue("@AdditionalNotes", formData.AdditionalNotes);
                cmd.Parameters.AddWithValue("@SignaturePath", string.IsNullOrEmpty(signaturePath) ? DBNull.Value : (object)signaturePath);
                cmd.Parameters.AddWithValue("@ImagePaths", string.IsNullOrEmpty(combinedImagePaths) ? DBNull.Value : (object)combinedImagePaths);

                conn.Open();
                cmd.ExecuteNonQuery();

                return "Success: Form data saved successfully.";
            }
        }
        catch (Exception ex)
        {
                return "Error: " + ex.Message;
        }
    }

    private static bool UploadFileToFtp(string base64Data, string fileName)
    {
        // Existing FTP upload logic remains the same
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
}