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
public class Addinfo
{
    public string incrtof { get; set; }
    public string reformi { get; set; }
    public string dvsn { get; set; }
    public string year { get; set; }
    public string rangeofc { get; set; }
    public string caseno { get; set; }
    public string date { get; set; }
    public string fprprtno { get; set; }
    public string datec { get; set; }
    public string sec { get; set; }
    public string undact { get; set; }
    public string typfrepo { get; set; }
    public string mncntocr { get; set; }
    public string nmofinvofcr { get; set; }
    public string mdtctnofnc { get; set; }
    public string rank { get; set; }
    public string cmplnorinf { get; set; }
    public string withszslno { get; set; }
    public string resultofany { get; set; }
    public string anm { get; set; }
    public string fandhnm { get; set; }
    public string whetherverified { get; set; }
    public string dob { get; set; }
    public string gndr { get; set; }
    public string aadhar { get; set; }
    public string ntonlty { get; set; }
    public string dateofissue { get; set; }
    public string plceofisu { get; set; }
    public string whterscst { get; set; }
    public string rlgn { get; set; }
    public string ocptn { get; set; }
    public string adrs { get; set; }
    public string bdyidnmrk { get; set; }
    public string whetherverifiedd { get; set; }
    public string validid { get; set; }
    public string stsacsd { get; set; }
    public string arstmemorefno { get; set; }
    public string dtofarst { get; set; }
    public string dtofrlse { get; set; }
    public string dtonwhftocrt { get; set; }
    public string nmadrsofsrtes { get; set; }
    public string bkedvlnsecact { get; set; }
    public string pvscnvctnwithcase { get; set; }
    public string anmx { get; set; }
    public string fandhnmx { get; set; }
    public string whetherverifiedxd { get; set; }
    public string dobx { get; set; }
    public string gndrx { get; set; }
    public string aadharx { get; set; }
    public string ntonltyx { get; set; }
    public string dateofissuex { get; set; }
    public string plceofisux { get; set; }
    public string whterscstx { get; set; }
    public string rlgnx { get; set; }
    public string ocptnx { get; set; }
    public string adrsx { get; set; }
    public string bdyidnmrkx { get; set; }
    public string whetherverifieddx { get; set; }
    public string valididx { get; set; }
    public string stsacsdx { get; set; }
    public string bkedvlnsecactx { get; set; }
    public string ntbngchrofnc { get; set; }
    public string prtclrwtnsdtl { get; set; }
    public string brfctofcase { get; set; }
    public string casedryrefno { get; set; }
    public string amemorefno { get; set; }
    public string forthrmrefno { get; set; }
    public string formsvnrefno { get; set; }
    public string nmofcr { get; set; }
    public string rnkofcr { get; set; }
    public string ofcridno { get; set; }
    public string nmofcrx { get; set; }
    public string rnkofcrx { get; set; }
    public string ofcridnox { get; set; }

}

public partial class forms8 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Addinfo> adinfolist)
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (var addinfo in adinfolist)
                {
                    string query = "INSERT INTO [forestdata].[dbo].[tbl_additional_info]" +
                 "(incourt, reformi, division, year, rangeofc, caseno, date, fprcectno, datex, sec, act, typrfrepo, mistakeoflaw, modeOffence,invofcrnm, rank, complainant, szlistno,resultofany, name, fhnm, whetherverified, dob, gndr, adhr, nationality,dateofissue,placeofissue,whscst,relegion,ocptn,adrs,bdymrks,whetherverifiedx,valididtls,acsedsts,arstmemoref,dateofarst,dateofbail,datewfcrt,nmadrsrtes,bkvlnact,pvsref,namex,fhnmx,whetherverifiedy,dobx,gndry,adhry,nationalityy,dateofissuey,placeofissuey,whscstx,relegiony,ocptny,adrsy,bdymrksy,whetherverifiedxx,valididtlsy,acsedstsy,bkvlnacty,notchofnc,pwtnsdtl,bfactcase,cdryrno,amemorefn,formiiirefn,formviirefn,rofname,rofranks,roidno,invoname,invofranks,invoidno) " +
                 "VALUES (@incourt, @reformi, @division, @year, @rangeofc, @caseno, @date, @fprcectno, @datex, @sec, @act, @typrfrepo, @mistakeoflaw,@invofcrnm, @modeOffence, @rank, @complainant, @szlistno,@resultofany, @name, @fhnm, @whetherverified, @dob, @gndr, @adhr, @nationality,@dateofissue,@placeofissue,@whscst,@relegion,@ocptn,@adrs,@bdymrks,@whetherverifiedx,@valididtls,@acsedsts,@arstmemoref,@dateofarst,@dateofbail,@datewfcrt,@nmadrsrtes,@bkvlnact,@pvsref,@namex,@fhnmx,@whetherverifiedy,@dobx,@gndry,@adhry,@nationalityy,@dateofissuey,@placeofissuey,@whscstx,@relegiony,@ocptny,@adrsy,@bdymrksy,@whetherverifiedxx,@valididtlsy,@acsedstsy,@bkvlnacty,@notchofnc,@pwtnsdtl,@bfactcase,@cdryrno,@amemorefn,@formiiirefn,@formviirefn,@rofname,@rofranks,@roidno,@invoname,@invofranks,@invoidno)";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@incourt", addinfo.incrtof);
                        cmd.Parameters.AddWithValue("@reformi", addinfo.reformi);
                        cmd.Parameters.AddWithValue("@division", addinfo.dvsn);
                        cmd.Parameters.AddWithValue("@year", addinfo.year);
                        cmd.Parameters.AddWithValue("@rangeofc", addinfo.rangeofc);
                        cmd.Parameters.AddWithValue("@caseno", addinfo.caseno);
                        cmd.Parameters.AddWithValue("@date", addinfo.date);
                        cmd.Parameters.AddWithValue("@fprcectno", addinfo.fprprtno);
                        cmd.Parameters.AddWithValue("@datex", addinfo.date);
                        cmd.Parameters.AddWithValue("@sec", addinfo.sec);
                        cmd.Parameters.AddWithValue("@act", addinfo.undact);
                        cmd.Parameters.AddWithValue("@typrfrepo", addinfo.typfrepo);
                        cmd.Parameters.AddWithValue("@mistakeoflaw", addinfo.mncntocr);
                        cmd.Parameters.AddWithValue("@invofcrnm", addinfo.nmofinvofcr);
                        cmd.Parameters.AddWithValue("@modeOffence", addinfo.mdtctnofnc);
                        cmd.Parameters.AddWithValue("@rank", addinfo.rank);
                        cmd.Parameters.AddWithValue("@complainant", addinfo.cmplnorinf);
                        cmd.Parameters.AddWithValue("@szlistno", addinfo.withszslno);
                        cmd.Parameters.AddWithValue("@resultofany", addinfo.resultofany);
                        cmd.Parameters.AddWithValue("@name", addinfo.anm);
                        cmd.Parameters.AddWithValue("@fhnm", addinfo.fandhnm);
                        cmd.Parameters.AddWithValue("@whetherverified", addinfo.whetherverified);
                        cmd.Parameters.AddWithValue("@dob", addinfo.dob);
                        cmd.Parameters.AddWithValue("@gndr", addinfo.gndr);
                        cmd.Parameters.AddWithValue("@adhr", addinfo.aadhar);
                        cmd.Parameters.AddWithValue("@nationality", addinfo.ntonlty);
                        cmd.Parameters.AddWithValue("@dateofissue", addinfo.dateofissue);
                        cmd.Parameters.AddWithValue("@placeofissue", addinfo.plceofisu);
                        cmd.Parameters.AddWithValue("@whscst", addinfo.whterscst);
                        cmd.Parameters.AddWithValue("@relegion", addinfo.rlgn);
                        cmd.Parameters.AddWithValue("@ocptn", addinfo.ocptn);
                        cmd.Parameters.AddWithValue("@adrs", addinfo.adrs);
                        cmd.Parameters.AddWithValue("@bdymrks", addinfo.bdyidnmrk);
                        cmd.Parameters.AddWithValue("@whetherverifiedx", addinfo.whetherverifiedd);
                        cmd.Parameters.AddWithValue("@valididtls", addinfo.validid);
                        cmd.Parameters.AddWithValue("@acsedsts", addinfo.stsacsd);
                        cmd.Parameters.AddWithValue("@arstmemoref", addinfo.arstmemorefno);
                        cmd.Parameters.AddWithValue("@dateofarst", addinfo.dtofarst);
                        cmd.Parameters.AddWithValue("@dateofbail", addinfo.dtofrlse);
                        cmd.Parameters.AddWithValue("@datewfcrt", addinfo.dtonwhftocrt);
                        cmd.Parameters.AddWithValue("@nmadrsrtes", addinfo.nmadrsofsrtes);
                        cmd.Parameters.AddWithValue("@bkvlnact", addinfo.bkedvlnsecact);
                        cmd.Parameters.AddWithValue("@pvsref", addinfo.pvscnvctnwithcase);
                        cmd.Parameters.AddWithValue("@namex", addinfo.anmx);
                        cmd.Parameters.AddWithValue("@fhnmx", addinfo.fandhnmx);
                        cmd.Parameters.AddWithValue("@whetherverifiedy", addinfo.whetherverifiedxd);
                        cmd.Parameters.AddWithValue("@dobx", addinfo.dobx);
                        cmd.Parameters.AddWithValue("@gndry", addinfo.gndrx);
                        cmd.Parameters.AddWithValue("@adhry", addinfo.aadharx);
                        cmd.Parameters.AddWithValue("@nationalityy", addinfo.ntonltyx);
                        cmd.Parameters.AddWithValue("@dateofissuey", addinfo.dateofissuex);
                        cmd.Parameters.AddWithValue("@placeofissuey", addinfo.plceofisux);
                        cmd.Parameters.AddWithValue("@whscstx", addinfo.whterscstx);
                        cmd.Parameters.AddWithValue("@relegiony", addinfo.rlgnx);
                        cmd.Parameters.AddWithValue("@ocptny", addinfo.ocptnx);
                        cmd.Parameters.AddWithValue("@adrsy", addinfo.adrsx);
                        cmd.Parameters.AddWithValue("@bdymrksy", addinfo.bdyidnmrkx);
                        cmd.Parameters.AddWithValue("@whetherverifiedxx", addinfo.whetherverifieddx);
                        cmd.Parameters.AddWithValue("@valididtlsy", addinfo.valididx);
                        cmd.Parameters.AddWithValue("@acsedstsy", addinfo.stsacsdx);
                        cmd.Parameters.AddWithValue("@bkvlnacty", addinfo.bkedvlnsecactx);
                        cmd.Parameters.AddWithValue("@notchofnc", addinfo.ntbngchrofnc);
                        cmd.Parameters.AddWithValue("@pwtnsdtl", addinfo.prtclrwtnsdtl);
                        cmd.Parameters.AddWithValue("@bfactcase", addinfo.brfctofcase);
                        cmd.Parameters.AddWithValue("@cdryrno", addinfo.casedryrefno);
                        cmd.Parameters.AddWithValue("@amemorefn", addinfo.amemorefno);
                        cmd.Parameters.AddWithValue("@formiiirefn", addinfo.forthrmrefno);
                        cmd.Parameters.AddWithValue("@formviirefn", addinfo.formsvnrefno);
                        cmd.Parameters.AddWithValue("@rofname", addinfo.nmofcr);
                        cmd.Parameters.AddWithValue("@rofranks", addinfo.rnkofcr);
                        cmd.Parameters.AddWithValue("@roidno", addinfo.ofcridno);
                        cmd.Parameters.AddWithValue("@invoname", addinfo.nmofcrx);
                        cmd.Parameters.AddWithValue("@invofranks", addinfo.rnkofcrx);
                        cmd.Parameters.AddWithValue("@invoidno", addinfo.ofcridnox);
                       
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