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
public class Witnesses
{
    public string slno { get; set; }
    public string divsn { get; set; }
    public string rangeofc { get; set; }
    public string dat { get; set; }
    public string tofcr { get; set; }
    public string cntct { get; set; }
    public string email { get; set; }
    public string caseno { get; set; }
    public string dted { get; set; }
    public string vltn { get; set; }
    public string unkn { get; set; }
    public string regatp { get; set; }
    public string aprtme { get; set; }
    public string aprdt { get; set; }
    public string aprdy { get; set; }
    public string aprplc { get; set; }
    public string ofcrnm { get; set; }
    public string ofcrdsg { get; set; }
    public string noticn { get; set; }
    public string ntdate { get; set; }
    public string waprdte { get; set; }
    public string waprdy { get; set; }
    public string fromdt { get; set; }
    public string todt { get; set; }
    public string szrelist { get; set; }
    public string rupees { get; set; }
    public string atndcedtl { get; set; }
    public string ofnceof { get; set; }
    public string wtnsdtl { get; set; }
    public string wtnsnm { get; set; }
    public string acsnm { get; set; }
    public string place { get; set; }
    public string court { get; set; }
    public string courtdt { get; set; }
    public string crtday { get; set; }
    public string crtime { get; set; }
    public string touch { get; set; }
    public string complndt { get; set; }
    public string compday { get; set; }
    public string comyr { get; set; }
}
public partial class witness : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Witnesses> witnesseslist)
    {
        try
        {
            // Connection to the database
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert data from departmentlist
                foreach (var witnesses in witnesseslist)
                {
                    // SQL query to insert data from departmentlist
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_attndncewtness] " +
                                   "(slno, divsn, rangeofc, dt, atdto, contact, eml, caseno, cdt, vlnof, unk, regat, apprtme, apprdt, aprday, aprplce, rqstonm, rqstdesig, ntceno,ntcedt, wtaprdt, wtaprdy, wtapfrm, wtapto, szrlist, paidwith,spctdtl, offnceof, attndcedtl, wtnsnm, wrntnm, apprplc, court, crtdt, crtday, crtme, tching ,comppdt ,compday, compyr) " +
                                   "VALUES (@slno, @divsn, @rangeofc, @dt, @atdto, @contact, @eml, @caseno, @cdt, @vlnof, @unk, @regat, @apprtme, @apprdt, @aprday, @aprplce, @rqstonm, @rqstdesig, @ntceno, @ntcedt, @wtaprdt, @wtaprdy, @wtapfrm, @wtapto, @szrlist, @paidwith, @spctdtl, @offnceof, @attndcedtl, @wtnsnm, @wrntnm, @apprplc, @court, @crtdt, @crtday, @crtme, @tching, @comppdt, @compday, @compyr)";

                    // Execute the SQL query
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@slno", witnesses.slno);
                        cmd.Parameters.AddWithValue("@divsn", witnesses.divsn);
                        cmd.Parameters.AddWithValue("@rangeofc", witnesses.rangeofc);
                        cmd.Parameters.AddWithValue("@dt", witnesses.dat);
                        cmd.Parameters.AddWithValue("@atdto", witnesses.tofcr);
                        cmd.Parameters.AddWithValue("@contact", witnesses.cntct);
                        cmd.Parameters.AddWithValue("@eml", witnesses.email);
                        cmd.Parameters.AddWithValue("@caseno", witnesses.caseno);
                        cmd.Parameters.AddWithValue("@cdt", witnesses.dted);
                        cmd.Parameters.AddWithValue("@vlnof", witnesses.vltn);
                        cmd.Parameters.AddWithValue("@unk", witnesses.unkn);
                        cmd.Parameters.AddWithValue("@regat", witnesses.regatp);
                        cmd.Parameters.AddWithValue("@apprtme", witnesses.aprtme);
                        cmd.Parameters.AddWithValue("@apprdt", witnesses.aprdt);
                        cmd.Parameters.AddWithValue("@aprday", witnesses.aprdy);
                        cmd.Parameters.AddWithValue("@aprplce", witnesses.aprplc);
                        cmd.Parameters.AddWithValue("@rqstonm", witnesses.ofcrnm);
                        cmd.Parameters.AddWithValue("@rqstdesig", witnesses.ofcrdsg);
                        cmd.Parameters.AddWithValue("@ntceno", witnesses.noticn);
                        cmd.Parameters.AddWithValue("@ntcedt", witnesses.ntdate);
                        cmd.Parameters.AddWithValue("@wtaprdt", witnesses.waprdte);
                        cmd.Parameters.AddWithValue("@wtaprdy", witnesses.waprdy);
                        cmd.Parameters.AddWithValue("@wtapfrm", witnesses.fromdt);
                        cmd.Parameters.AddWithValue("@wtapto", witnesses.todt);
                        cmd.Parameters.AddWithValue("@szrlist", witnesses.szrelist);
                        cmd.Parameters.AddWithValue("@paidwith", witnesses.rupees);
                        cmd.Parameters.AddWithValue("@spctdtl", witnesses.atndcedtl);
                        cmd.Parameters.AddWithValue("@offnceof", witnesses.ofnceof);
                        cmd.Parameters.AddWithValue("@attndcedtl", witnesses.wtnsdtl);
                        cmd.Parameters.AddWithValue("@wtnsnm", witnesses.wtnsnm);
                        cmd.Parameters.AddWithValue("@wrntnm", witnesses.acsnm);
                        cmd.Parameters.AddWithValue("@apprplc", witnesses.place);
                        cmd.Parameters.AddWithValue("@court", witnesses.court);
                        cmd.Parameters.AddWithValue("@crtdt", witnesses.courtdt);
                        cmd.Parameters.AddWithValue("@crtday", witnesses.crtday);
                        cmd.Parameters.AddWithValue("@crtme", witnesses.crtime);
                        cmd.Parameters.AddWithValue("@tching", witnesses.touch);
                        cmd.Parameters.AddWithValue("@comppdt", witnesses.complndt);
                        cmd.Parameters.AddWithValue("@compday", witnesses.compday);
                        cmd.Parameters.AddWithValue("@compyr", witnesses.comyr);
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