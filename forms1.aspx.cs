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


   public class Report
   {
    public string ofrptno { get; set; }
    public string dt { get; set; }
    public string poc { get; set; }
    public string dth { get; set; }
    public string hour { get; set; }
    public string nm { get; set; }
    public string parntge { get; set; }
    public string resd { get; set; }
    public string prptysz { get; set; }
    public string cstdyszp { get; set; }
    public string ntrofence { get; set; }
    public string refofrepon { get; set; }
    public string divn { get; set; }
    public string rangeof { get; set; }
    public string time { get; set; }
    public string date { get; set; }
    public string sec { get; set; }
    public string act { get; set; }
    public string gpsco { get; set; }
    public string ladmrk { get; set; }
    public string pht { get; set; }
    public string informdtl { get; set; }
    public string mode { get; set; }
    public string party { get; set; }
    public string dno { get; set; }
    public string dtx { get; set; }
    public string timex { get; set; }
    public string adlt { get; set; }
    public string minr { get; set; }
    public string snm { get; set; }
    public string bdenti { get; set; }
    public string mob { get; set; }
    public string idno { get; set; }
    public string sznmp { get; set; }
    public string szidn { get; set; }
    public string nmofcstd { get; set; }
    public string adrscstd { get; set; }
    public string contctdtl { get; set; }
    public string rsn { get; set; }
    public string wtnsdtl { get; set; }
    public string nmidno { get; set; }
    public string contct { get; set; }

   }

public partial class forms1 : System.Web.UI.Page
{
    DATABASE DB = new DATABASE();
    private static TimeZoneInfo India_Standard_Time = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Report> reportlist)
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (var report in reportlist)
                {
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_coplntform] " +
                                   "(ofcreptno, dated, plceocrnce, date, timee, ofnm, ofprtge, ofresd, prprtyszd, cstdyszpr, factcse, rferofrpt, division, raneofc, timex, datex, section, underact, gpsextplce, lndmrk, informdtl, mode, cntrcvr, rangedno, datec, tme, sadlt, sminor, snm, sidfcn, smble, idother, nmprprty, idfctnmrk, nmcstdn, cstadrs, ctdncnt, rsninwtns, ofclwtnsdtl, nmdesigidno, nmdesgcnt) " +
                                   "VALUES (@ofcreptno, @dated, @plceocrnce, @date, @timee, @ofnm, @ofprtge, @ofresd, @prprtyszd, @cstdyszpr, @factcse, @rferofrpt, @division, @raneofc, @timex, @datex, @section, @underact,  @gpsextplce, @lndmrk, @informdtl, @mode,  @cntrcvr, @rangedno, @datec, @tme, @sadlt, @sminor, @snm, @sidfcn, @smble, @idother, @nmprprty, @idfctnmrk, @nmcstdn, @cstadrs, @ctdncnt, @rsninwtns, @ofclwtnsdtl, @nmdesigidno, @nmdesgcnt)";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@ofcreptno", report.ofrptno);
                        cmd.Parameters.AddWithValue("@dated", report.dt);
                        cmd.Parameters.AddWithValue("@plceocrnce", report.poc);
                        cmd.Parameters.AddWithValue("@date", report.dth);
                        cmd.Parameters.AddWithValue("@timee", report.hour);
                        cmd.Parameters.AddWithValue("@ofnm", report.nm);
                        cmd.Parameters.AddWithValue("@ofprtge", report.parntge);
                        cmd.Parameters.AddWithValue("@ofresd", report.resd);
                        cmd.Parameters.AddWithValue("@prprtyszd", report.prptysz);
                        cmd.Parameters.AddWithValue("@cstdyszpr", report.cstdyszp);
                        cmd.Parameters.AddWithValue("@factcse", report.ntrofence);
                        cmd.Parameters.AddWithValue("@rferofrpt", report.refofrepon);
                        cmd.Parameters.AddWithValue("@division", report.divn);
                        cmd.Parameters.AddWithValue("@raneofc", report.rangeof);
                        cmd.Parameters.AddWithValue("@timex", report.time);
                        cmd.Parameters.AddWithValue("@datex", report.date);
                        cmd.Parameters.AddWithValue("@section", report.sec);
                        cmd.Parameters.AddWithValue("@underact", report.act);
                        cmd.Parameters.AddWithValue("@gpsextplce", report.gpsco);
                        cmd.Parameters.AddWithValue("@lndmrk", report.ladmrk);
                        cmd.Parameters.AddWithValue("@informdtl", report.informdtl);
                        cmd.Parameters.AddWithValue("@mode", report.mode);
                        cmd.Parameters.AddWithValue("@cntrcvr", report.party);
                        cmd.Parameters.AddWithValue("@rangedno", report.dno);
                        cmd.Parameters.AddWithValue("@datec", report.dtx);
                        cmd.Parameters.AddWithValue("@tme", report.timex);
                        cmd.Parameters.AddWithValue("@sadlt", report.adlt);
                        cmd.Parameters.AddWithValue("@sminor", report.minr);
                        cmd.Parameters.AddWithValue("@snm", report.snm);
                        cmd.Parameters.AddWithValue("@sidfcn", report.bdenti);
                        cmd.Parameters.AddWithValue("@smble", report.mob);
                        cmd.Parameters.AddWithValue("@idother", report.idno);
                        cmd.Parameters.AddWithValue("@nmprprty", report.sznmp);
                        cmd.Parameters.AddWithValue("@idfctnmrk", report.szidn);
                        cmd.Parameters.AddWithValue("@nmcstdn", report.nmofcstd);
                        cmd.Parameters.AddWithValue("@cstadrs", report.adrscstd);
                        cmd.Parameters.AddWithValue("@ctdncnt", report.contctdtl);
                        cmd.Parameters.AddWithValue("@rsninwtns", report.rsn);
                        cmd.Parameters.AddWithValue("@ofclwtnsdtl", report.wtnsdtl);
                        cmd.Parameters.AddWithValue("@nmdesigidno", report.nmidno);
                        cmd.Parameters.AddWithValue("@nmdesgcnt", report.contct);

                        cmd.ExecuteNonQuery();
                    }
                }

               

                

                connection.Close();
            }

            return "Data inserted successfully.";
        }
        catch (Exception ex)
        {
            return "Error inserting data: " + ex.Message;
        }
    }
}






