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

public class Searchdttx
{
    public string ServiceName { get; set; }
    public string Id { get; set; }
    public string CategoryId { get; set; }
    public string SubCategoryId { get; set; }
}

public class Checkl
{
    public string caseno { get; set; }
    public string spotelct { get; set; }
    public string electinsp { get; set; }
    public string wildani { get; set;}
    public string othrdisco { get; set; }
    public string postmrtrep { get; set; }
    public string chrdtissue { get; set; }
    public string spcsex { get; set; }
    public string factsconfe { get; set; }
    public string cdranly { get; set; }
    public string confacts {get; set;}
    public string crimesc { get; set; }
    public string crimere { get; set; }
    public string increvd { get; set; }
    public string wildanimal { get; set; }
    public string cdranaly { get; set; }
    public string dwlduplnk { get; set; }
    public string postmetrep { get; set; }
    public string witnesstm { get; set; }
    public string wtnstm { get; set; }
    public string confefact { get; set; }
    public string dnlduplin { get; set; }
    public string cdranalys { get; set; }
    public string exeplabrep { get; set; }
    public string seizrepo { get; set; }
    public string ownershipver { get; set; }
    public string vehicleinsp { get; set; }
    public string invcontents { get; set; }
    public string driverownerdtl { get; set; }
    public string transdoc { get; set; }
    public string indepwtns { get; set; }
    public string frensicex { get; set; }
    public string photoevd { get; set; }
    public string legaldoc { get; set; }
    public string releaseproc { get; set; }

}
public partial class ckwildlifeofnc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Searchdttx> GetAutoCompleteData(string prefix)
    {
        List<Searchdttx> services = new List<Searchdttx>();

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
                        services.Add(new Searchdttx
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

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Insert(List<Checkl> checklist, string pic, string path)
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
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpFolder + path.ToString().Split('.')[0] + "offencechecklist" + "." + path.ToString().Split('.')[1].ToString());
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




        string pthh = "https://iicaapp.co.in/httpdocs/cmndcrt" + path.ToString().Split('.')[0] + "offencechecklist" + "." + path.ToString().Split('.')[1].ToString();

        // Insert data from caselist



        foreach (var checkl in checklist)
        {
            string sql = "INSERT INTO [forestdata].[dbo].[tbl_checklistofnc] " +
                         "(caseno, spotel, elctins, wildani, othrdis, postmotre, charredtl, spcerpo, " +
                         "factsconfe, cdranal, confesfa, crimesc, crimescrecr, increvd, wildanim, " +
                         "dwldup, postmrt, wtnstm, wtnstatem, confefct, dnldupli, cdranly, explabre, " +
                         "seizurepo, ownerver, vehlinsp, invcnt, driverowdtls, transdoc, indepenwtns, " +
                         "frncexm, phtoevd, legaldoc, relsepro, paths) " +
                        "VALUES ('" + checkl.caseno + "', '" + checkl.spotelct + "', '" + checkl.electinsp + "', '" +
                        checkl.wildani + "', '" + checkl.othrdisco + "', '" + checkl.postmrtrep + "', '" +
                        checkl.chrdtissue + "', '" + checkl.spcsex + "', '" + checkl.factsconfe + "', '" +
                        checkl.cdranly + "', '" + checkl.confacts + "', '" + checkl.crimesc + "', '" +
                        checkl.crimere + "', '" + checkl.increvd + "', '" + checkl.wildanimal + "', '" +
                        checkl.dwlduplnk + "', '" + checkl.postmetrep + "', '" + checkl.witnesstm + "', '" +
                        checkl.wtnstm + "', '" + checkl.confefact + "', '" + checkl.dnlduplin + "', '" +
                        checkl.cdranalys + "', '" + checkl.exeplabrep + "', '" + checkl.seizrepo + "', '" +
                        checkl.ownershipver + "', '" + checkl.vehicleinsp + "', '" + checkl.invcontents + "', '" +
                        checkl.driverownerdtl + "', '" + checkl.transdoc + "', '" + checkl.indepwtns + "', '" +
                        checkl.frensicex + "', '" + checkl.photoevd + "', '" + checkl.legaldoc + "', '" +
                        checkl.releaseproc + "', '" + pthh + "')";

            con1 = DB.getCon();
            SqlCommand cmmds = new SqlCommand(sql, con1);
            DB.ExecQry(cmmds);
        }





        return "";

    }

}