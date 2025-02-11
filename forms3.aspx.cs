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

public class Searchdtdd
{
    public string ServiceName { get; set; }
    public string Id { get; set; }
    public string CategoryId { get; set; }
    public string SubCategoryId { get; set; }
}

public class seizrureplace
{
    public string seizure { get; set; }
   
}
public class properyszed
{
    public string property { get; set; }

}
public class acsedtl
{
    public string accused { get; set; }

}

public class accusedsign
{
    public string acsdsign { get; set; }

}

public class witnessign
{
    public string wtnsign { get; set; }

}

public class seizuremark
{
    public string szuremark { get; set; }

}
public class wtnsdtl
{
    public string witness { get; set; }

}

public class reasoncstdy
{
    public string propseized { get; set; }

}


public class idcopies
{
    public string copies { get; set; }

}


public class indenticopies
{
    public string copiesx { get; set; }

}


public class cstodianseized
{
    public string cstdnproperty { get; set; }

}

public class cstodianfile
{
    public string copies { get; set; }

}


public class possessor
{
    public string namepssr { get; set; }
    public string bodymarkpssr { get; set; }
    public string mobilepssr { get; set; }
    public string idcardnopssr { get; set; }
    public string signwithdtpssr { get; set; }
}
public class indewitness
{
    public string namein { get; set; }
    public string bodymarkin { get; set; }
    public string mobilein { get; set; }
    public string idcardnoin { get; set; }

    public string signwithdtin { get; set; }
}

public class officialwtns
{
    public string nameofi { get; set; }
    public string bodymarkofi { get; set; }
    public string mobileofi { get; set; }
    public string idcardnoofi { get; set; }
    public string signwithdtofi { get; set; }
}
public class Seizure
{
    public string caseno { get; set; }
    public string dtofszure { get; set; }
    public string szuretime { get; set; }
    public string circumst { get; set; }
    public string signoficer { get; set; }
    public string division { get; set; }
    public string szrelndmark { get; set;}
    public string rangeofc { get; set; }
    public string gpscordintes { get; set;}
    public string date { get; set; }
    public string time { get; set; }
    public string reasonsz{ get; set; }
    public string bfrespno { get; set; }
    public string dated { get; set; }
    public string timed { get; set; }
    public string aftrsprtcl { get; set; }
    public string datex { get; set; }
    public string timex { get; set; }
    public string formnoi { get; set; }
    public string dte { get; set; }
    public string tme { get; set; }
   
    public string anyremark { get; set; }
 
    public string ofcrname { get; set; }
    public string ofcrdesig { get; set; }
    public string ofidno { get; set; }
    public string ofcrcontct { get; set; }
}

public partial class forms3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Seizure> seizurelist, string pic, string path, List<seizrureplace> seizrureplace, List<properyszed> properyszed, List<acsedtl> acsedtl, List<accusedsign> accusedsign, List<witnessign> witnessign, List<seizuremark> seizuremark, List<wtnsdtl> wtnsdtl, List<reasoncstdy> reasoncstdy, List<idcopies> idcopies, List<indenticopies> indenticopies,List<cstodianseized> cstodianseized, List<cstodianfile> cstodianfile, List<possessor> possessor, List<indewitness> indewitness, List<officialwtns> officialwtns)
    {

        string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        //string ftpFolder = "ftp://iicaapp.co.in/httpdocs/cmndcrt/";
        if (path != null && path != string.Empty)
        {

            HttpContext.Current.Session["kl"] = "";
            //tp = "image/jpg";
            byte[] bytes = Convert.FromBase64String(pic.ToString().Split(',')[1]);

            string ftp = "ftp://iicaapp.co.in/";
            //HttpPostedFile file = fs.;
            //FTP Folder name. Leave blank if you want to upload to root folder.

            string sst = string.Empty;


            //System.Drawing.Image image;
            //using (MemoryStream ms = new MemoryStream(bytes))
            //{
            //    image = System.Drawing.Image.FromStream(ms)
            ;
            //}


            try
            {
                //Create FTP Request.
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "seizurelist" + "." + path.ToString().Split('.')[1].ToString());
                request.Method = WebRequestMethods.Ftp.UploadFile;

                //Enter FTP Server credentials.
                request.Credentials = new NetworkCredential("iicaftpnew", "B~aae3632");
                request.ContentLength = bytes.Length;
                request.UsePassive = true;
                request.UseBinary = true;
                request.ServicePoint.ConnectionLimit = bytes.Length;
                request.EnableSsl = false;

                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(bytes, 0, bytes.Length);
                    requestStream.Close();
                }

                FtpWebResponse response = (FtpWebResponse)request.GetResponse();

                //Page page = HttpContext.Current.Handler as Page;
                //if (page != null)
                //{
                //    string error = "Payments made Successfully !!!"; error.Replace("'", "\'");
                //    ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error + "');", true);

                //}
                response.Close();
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
        }

        DATABASE DB = new DATABASE();

        SqlConnection con1 = new SqlConnection();




        string pthh = "https://iicaapp.co.in/httpdocs/cmndcrt" + path.ToString().Split('.')[0] + "seizurelist" + "." + path.ToString().Split('.')[1].ToString();

        // Insert data from caselist
        //foreach (var beforesearch in beforelist)
        //{
        //    string sql = "INSERT INTO [forestdata].[dbo].[tbl_beforesrch] (caseno,no, division,date, time, formiino,datex,timex,prsnfldtl,spinvldtl,Posesnfnd,remark,name,adrs,mob,paths) values ('" + beforesearch.caseno + "','" + beforesearch.prtno + "','" + beforesearch.divsn + "','" + beforesearch.rangeofc + "','" + beforesearch.datc + "','" + beforesearch.ptime + "','" + beforesearch.rformiino + "','" + beforesearch.dtx + "','" + beforesearch.tmex + "','" + beforesearch.gpscdtnts + "','" + beforesearch.srchprtydtl + "','" + beforesearch.pssnfnd + "','" + beforesearch.rmrk + "','" + beforesearch.name + "','" + beforesearch.adress + "','" + beforesearch.mobile + "','" + pthh + "')";
        //    con1 = DB.getCon();
        //    SqlCommand cmmds = new SqlCommand(sql, con1);
        //    DB.ExecQry(cmmds);

        //}

        return "";

    
    //try
    //{
    //    string connectionString = ConfigurationManager.ConnectionStrings["forestdata"].ConnectionString;

    //    using (SqlConnection connection = new SqlConnection(connectionString))
    //    {
    //        connection.Open();

    //        foreach (var seizure in seizurelist)
    //        {
    //            string query = "INSERT INTO [forestdata].[dbo].[tbl_seizure_list] " +
    //                           "(dtszre,timeszre, plceszre, prtclrpszed, nmacsed, nmofwtns,szremrk, division,lndmrkszre,rangeofc, gpscodint,dtx,timex,rsonszre,bfresprtcl,dte,tme,aftresprtcl,dtex,tmex,frmino,datexx,timesxx,prtpszed,cstdnpszed,pssrnm,pssrbdyiden,pssrmob,pssridno,nmw,bdyidenw,mobw,idno,ofwnm,ofwbdyiden,ofwmob,ofwidno,name,desig,idnoo,mob) " +
    //                           "VALUES (@dtszre,@timeszre,@plceszre,@prtclrpszed,@nmacsed,@nmofwtns,@szremrk, @division,@lndmrkszre,@rangeofc,@gpscodint,@dtx,@timex,@rsonszre,@bfresprtcl,@dte,@tme,@aftresprtcl,@dtex,@tmex,@frmino,@datexx,@timesxx,@prtpszed,@cstdnpszed,@pssrnm,@pssrbdyiden,@pssrmob,@pssridno,@nmw,@bdyidenw,@mobw,@idno,@ofwnm,@ofwbdyiden,@ofwmob,@ofwidno,@name,@desig,@idnoo,@mob)";

    //            using (SqlCommand cmd = new SqlCommand(query, connection))
    //            {
    //                cmd.Parameters.AddWithValue("@dtszre", seizure.datesz);
    //                cmd.Parameters.AddWithValue("@timeszre", seizure.timeszr);
    //                cmd.Parameters.AddWithValue("@plceszre", seizure.plcsz);
    //                cmd.Parameters.AddWithValue("@prtclrpszed", seizure.prticltpsz);
    //                cmd.Parameters.AddWithValue("@nmacsed", seizure.nmofacsed);
    //                cmd.Parameters.AddWithValue("@nmofwtns", seizure.nmwtns);
    //                cmd.Parameters.AddWithValue("@szremrk", seizure.szremrk);
    //                cmd.Parameters.AddWithValue("@division", seizure.division);
    //                cmd.Parameters.AddWithValue("@lndmrkszre", seizure.lndmrksz);
    //                cmd.Parameters.AddWithValue("@rangeofc", seizure.rangeofc);
    //                cmd.Parameters.AddWithValue("@gpscodint", seizure.gpscodi);
    //                cmd.Parameters.AddWithValue("@dtx", seizure.datel);
    //                cmd.Parameters.AddWithValue("@timex", seizure.timel);
    //                cmd.Parameters.AddWithValue("@rsonszre", seizure.reasonsz);
    //                cmd.Parameters.AddWithValue("@bfresprtcl", seizure.bfrespno);
    //                cmd.Parameters.AddWithValue("@dte", seizure.date);
    //                cmd.Parameters.AddWithValue("@tme", seizure.time);
    //                cmd.Parameters.AddWithValue("@aftresprtcl", seizure.aftrsprtcl);
    //                cmd.Parameters.AddWithValue("@dtex", seizure.datex);
    //                cmd.Parameters.AddWithValue("@tmex", seizure.timex);
    //                cmd.Parameters.AddWithValue("@frmino", seizure.formnoi);
    //                cmd.Parameters.AddWithValue("@datexx", seizure.dte);
    //                cmd.Parameters.AddWithValue("@timesxx", seizure.tme);
    //                cmd.Parameters.AddWithValue("@prtpszed", seizure.prtpszed);
    //                cmd.Parameters.AddWithValue("@cstdnpszed", seizure.prtpszedx);
    //                cmd.Parameters.AddWithValue("@pssrnm", seizure.name);
    //                cmd.Parameters.AddWithValue("@pssrbdyiden", seizure.bodyidn);
    //                cmd.Parameters.AddWithValue("@pssrmob", seizure.mobile);
    //                cmd.Parameters.AddWithValue("@pssridno", seizure.idno);
    //                cmd.Parameters.AddWithValue("@nmw", seizure.wname);
    //                cmd.Parameters.AddWithValue("@bdyidenw", seizure.wbodyidn);
    //                cmd.Parameters.AddWithValue("@mobw", seizure.wmobil);
    //                cmd.Parameters.AddWithValue("@idno", seizure.widno);
    //                cmd.Parameters.AddWithValue("@ofwnm", seizure.ofname);
    //                cmd.Parameters.AddWithValue("@ofwbdyiden", seizure.ofbodyidn);
    //                cmd.Parameters.AddWithValue("@ofwmob", seizure.ofmobil);
    //                cmd.Parameters.AddWithValue("@ofwidno", seizure.ofidno);
    //                cmd.Parameters.AddWithValue("@name", seizure.ofcrname);
    //                cmd.Parameters.AddWithValue("@desig", seizure.ofcrdesig);
    //                cmd.Parameters.AddWithValue("@idnoo", seizure.ofcridno);
    //                cmd.Parameters.AddWithValue("@mob", seizure.ofcrcontct);
    //                cmd.ExecuteNonQuery();
    //            }
    //        }



    //        connection.Close();
    //    }

    //    return "Data inserted successfully.";
    //}
    //catch (Exception ex)
    //{
    //    return "Error inserting data: " + ex.Message;
    //}
}

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Searchdtdd> GetAutoCompleteData(string prefix)
    {
        List<Searchdtdd> services = new List<Searchdtdd>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["Byvdata"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT * FROM tbl_newcaseform WHERE casno LIKE @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;

                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        services.Add(new Searchdtdd
                        {
                            ServiceName = sdr["casno"].ToString(),
                            Id = sdr["id"].ToString(),
                            CategoryId = sdr["dist"].ToString(),
                            SubCategoryId = sdr["city"].ToString()
                        });
                    }
                }
            }
        }

        return services;
    }
}

