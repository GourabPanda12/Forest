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
using System.Net.Http;


public partial class phtgrphofndrs2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    public class Offender
    {
        public string SubmissionDate { get; set; }
        public string ChooseOne { get; set; }
        public string CaseNo { get; set; }
        public string Name { get; set; }
        public string Aliases { get; set; }
        public string DOB { get; set; }
        public string PlaceOfBirth { get; set; }
        public string Sex { get; set; }
        public string Hair { get; set; }
        public string EyeColor { get; set; }
        public string Complexion { get; set; }
        public string Height { get; set; }
        public string Weight { get; set; }
        public string Citizenship { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Passport { get; set; }
        public string BankAccount { get; set; }
        public string Adhaar { get; set; }
        public string Occupation { get; set; }
        public string Associates { get; set; }
        public string CrimeHistory { get; set; }
        public string ModusOperandi { get; set; }
        public string AreaActivities { get; set; }
        public string Acquittals { get; set; }
        public string ProclaimedOffenderDetails { get; set; }
        public string OtherRemarks { get; set; }
        public string SignaturePath { get; set; }
        public string ImagePath { get; set; }
        public string SignaturePath64 { get; set; }
        public string ImagePath64 { get; set; }

    }
    public static class ImageToBase64
    {
        public static string ConvertImageUrlToBase64(string imageUrl)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");
                    // Download image data as byte array synchronously
                    byte[] imageBytes = client.GetByteArrayAsync(imageUrl).GetAwaiter().GetResult();

                    // Convert byte array to Base64 string
                    string base64String = Convert.ToBase64String(imageBytes);

                    return base64String;
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                return ex.Message.ToString();
            }
        }
    }

    [WebMethod]
    public static List<Offender> GetOffenderData()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;
        List<Offender> offenders = new List<Offender>();

        string query = @"SELECT [ChooseOne], [CaseNo], [Name], [Aliases], [DOB], [PlaceOfBirth], [Sex], [Hair], 
                            [EyeColor], [Complexion], [Height], [Weight], [Citizenship], [PhoneNumber], 
                            [Email], [Passport], [BankAccount], [Adhaar], [Occupation], [Associates], 
                            [CrimeHistory], [ModusOperandi], [AreaActivities], [Acquittals], 
                            [ProclaimedOffenderDetails], [OtherRemarks], [SignaturePath], [ImagePath], 
                            [SubmissionDate]
                     FROM [forestdata].[dbo].[offenderx]";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        offenders.Add(new Offender
                        {

                            SubmissionDate = reader["SubmissionDate"] != DBNull.Value ? Convert.ToDateTime(reader["SubmissionDate"]).ToString("yyyy-MM-dd") : string.Empty,
                            ChooseOne = reader["ChooseOne"] != DBNull.Value ? reader["ChooseOne"].ToString() : string.Empty,
                            CaseNo = reader["CaseNo"] != DBNull.Value ? reader["CaseNo"].ToString() : string.Empty,
                            Name = reader["Name"] != DBNull.Value ? reader["Name"].ToString() : string.Empty,
                            Aliases = reader["Aliases"] != DBNull.Value ? reader["Aliases"].ToString() : string.Empty,
                            DOB = reader["DOB"] != DBNull.Value ? Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd") : string.Empty,
                            PlaceOfBirth = reader["PlaceOfBirth"] != DBNull.Value ? reader["PlaceOfBirth"].ToString() : string.Empty,
                            Sex = reader["Sex"] != DBNull.Value ? reader["Sex"].ToString() : string.Empty,
                            Hair = reader["Hair"] != DBNull.Value ? reader["Hair"].ToString() : string.Empty,
                            EyeColor = reader["EyeColor"] != DBNull.Value ? reader["EyeColor"].ToString() : string.Empty,
                            Complexion = reader["Complexion"] != DBNull.Value ? reader["Complexion"].ToString() : string.Empty,
                            Height = reader["Height"] != DBNull.Value ? reader["Height"].ToString() : string.Empty,
                            Weight = reader["Weight"] != DBNull.Value ? reader["Weight"].ToString() : string.Empty,
                            Citizenship = reader["Citizenship"] != DBNull.Value ? reader["Citizenship"].ToString() : string.Empty,
                            PhoneNumber = reader["PhoneNumber"] != DBNull.Value ? reader["PhoneNumber"].ToString() : string.Empty,
                            Email = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : string.Empty,
                            Passport = reader["Passport"] != DBNull.Value ? reader["Passport"].ToString() : string.Empty,
                            BankAccount = reader["BankAccount"] != DBNull.Value ? reader["BankAccount"].ToString() : string.Empty,
                            Adhaar = reader["Adhaar"] != DBNull.Value ? reader["Adhaar"].ToString() : string.Empty,
                            Occupation = reader["Occupation"] != DBNull.Value ? reader["Occupation"].ToString() : string.Empty,
                            Associates = reader["Associates"] != DBNull.Value ? reader["Associates"].ToString() : string.Empty,
                            CrimeHistory = reader["CrimeHistory"] != DBNull.Value ? reader["CrimeHistory"].ToString() : string.Empty,
                            ModusOperandi = reader["ModusOperandi"] != DBNull.Value ? reader["ModusOperandi"].ToString() : string.Empty,
                            AreaActivities = reader["AreaActivities"] != DBNull.Value ? reader["AreaActivities"].ToString() : string.Empty,
                            Acquittals = reader["Acquittals"] != DBNull.Value ? reader["Acquittals"].ToString() : string.Empty,
                            ProclaimedOffenderDetails = reader["ProclaimedOffenderDetails"] != DBNull.Value ? reader["ProclaimedOffenderDetails"].ToString() : string.Empty,
                            OtherRemarks = reader["OtherRemarks"] != DBNull.Value ? reader["OtherRemarks"].ToString() : string.Empty,
                            SignaturePath = reader["SignaturePath"] != DBNull.Value ? reader["SignaturePath"].ToString() : null,
                            ImagePath = reader["ImagePath"] != DBNull.Value ? reader["ImagePath"].ToString() : null,
                            SignaturePath64 = reader["SignaturePath"] != DBNull.Value
    ? "data:image/jpeg;base64," + ImageToBase64.ConvertImageUrlToBase64(reader["SignaturePath"].ToString())
    : null,
                            ImagePath64 = reader["ImagePath"] != DBNull.Value
    ? "data:image/jpeg;base64," + ImageToBase64.ConvertImageUrlToBase64(reader["ImagePath"].ToString())
    : null,


                        });
                    }
                }
            }
        }

        return offenders;
    }
}