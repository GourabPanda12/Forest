<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forms8.aspx.cs" Inherits="forms8" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

 <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Additional Information</title>

      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
       
      
        $(document).ready(function () {
            // Function to handle the click event for adding new data
            $(".add23").click(function () {
                // Retrieve the values entered by the user
                var sectionValue = $("#txtsec").val().trim();
                var actValue = $("#txtuacti").val().trim();

                // Check if both section and act values are not empty
                if (sectionValue !== "" && actValue !== "") {
                    // Check if the combination of section and act already exists
                    var duplicate = $("#appendData").find("p").filter(function () { return $(this).text().includes("Section/s: " + sectionValue) && $(this).text().includes("Under Act: " + actValue); }).length > 0;



                    if (!duplicate) {
                        // Create a new paragraph element with the section and act values
                        var newParagraph = $("<p>").text("Section/s: " + sectionValue + ", Under Act: " + actValue);

                        // Create a close button
                        var closeButton = $("<span>").addClass("closeBtn").text("x");
                        newParagraph.append(closeButton);

                        // Append the new paragraph to the appropriate location
                        $("#appendData").append(newParagraph);

                        // Clear the input fields
                        $("#txtsec").val("");
                        $("#txtuacti").val("");
                    } else {
                        alert("Duplicate value! This value already exists.");
                    }
                }
            });

            // Function to handle the click event for closing the appended values
            $(document).on('click', '.closeBtn', function () {
                $(this).parent().remove();
            });
        });






        //submit code 

        function sub() {


            // Get form input values 
            var incrtof = $("#txtcrt").val();
            var reformi = $("#txtrfrmino").val();
            var dvsn = $("#txtdvsn").val();
            var year = $("#txtyr").val();
            var rangeofc = $("#txtrngeog").val();
            var caseno = $("#txtcsno").val();
            var date = $("#txtdt").val();
            var fprprtno = $("#txtfprepon").val();
            var datec = $("#txtdtx").val();
            var sec = $("#txtsec").val();
            var undact = $("#txtuacti").val();
            var typfrepo = $("#txtofnse").val();
            var mncntocr = $("#txtmovr").val();
            var nmofinvofcr = $("#txtnminvof").val();
            var mdtctnofnc = $("#txtmofense").val();
            var rank = $("#txtrank").val();
            var cmplnorinf = $("#txtcmpln").val();
            var withszslno = $("#txtszno").val();
            var resultofany = $("#txtanlys").val();
            var anm = $("#txtacsnm").val();
            var fandhnm = $("#txtfhnm").val();
            var whetherverified = $("#txtwh").val();
            var dob = $("#txtdob").val();
            var gndr = $("#txtsgbdr option:selected").text()
            var aadhar = $("#txtadhrbo").val();
            var ntonlty = $("#txtntonlty").val();
            var dateofissue = $("#txtdtois").val();
            var plceofisu = $("#txtplceis").val();
            var whterscst = $("#txtwscst").val();
            var rlgn = $("#txtrlgn").val();
            var ocptn = $("#txtocptn").val();
            var adrs = $("#txtadrs").val();
            var bdyidnmrk = $("#txtbdyidnm").val();
            var whetherverifiedd = $("#txtw").val();
            var validid = $("#txtvalidid").val();
            var stsacsd = $("#txtcsedssts").val();
            var arstmemorefno = $("#txtarstm").val();
            var dtofarst = $("#txtdtarst").val();
            var dtofrlse = $("#txtdtrlse").val();
            var dtonwhftocrt = $("#txtdtwhch").val();
            var nmadrsofsrtes = $("#txtnmscrty").val();
            var bkedvlnsecact = $("#txtbku").val();
            var pvscnvctnwithcase = $("#txtpvscnv").val();
            var anmx = $("#txtnmy").val();
            var fandhnmx = $("#txtfhnmx").val();
            var whetherverifiedxd = $("#txtwhv").val();
            var dobx = $("#txtdobc").val();
            var gndrx = $("#txtsdob option:selected").text();
            var aadharx = $("#txtadhr").val();
            var ntonltyx = $("#txtntoblty").val();
            var dateofissuex = $("#txtdtis").val();
            var plceofisux = $("#txtplcis").val();
            var whterscstx = $("#txtwhsc").val();
            var rlgnx = $("#txtrelgn").val();
            var ocptnx = $("#txtocptnx").val();
            var adrsx = $("#txtadrsx").val();
            var bdyidnmrkx = $("#txtbdyidn").val();
            var whetherverifieddx = $("#txtwhc").val();
            var valididx = $("#txtvidtl").val();
            var stsacsdx = $("#txtsts").val();
            var bkedvlnsecactx = $("#txtsecact").val();
            var ntbngchrofnc = $("#txtrmk").val();
            var prtclrwtnsdtl = $("#txtwtnsdtl").val();
            var brfctofcase = $("#txtbrfcse").val();
            var casedryrefno = $("#txtcsdryno").val();
            var amemorefno = $("#txtamemoref").val();
            var forthrmrefno = $("#txtfrmiiirefno").val();
            var formsvnrefno = $("#txtviino").val();
            var nmofcr = $("#txtnmx").val();
            var rnkofcr = $("#txtrnkx").val();
            var ofcridno = $("#txtidno").val();
            var nmofcrx = $("#txtnmj").val();
            var rnkofcrx = $("#txtrnkj").val();
            var ofcridnox = $("#txtidnoj").val();

            var adinfolist = [];
            // Create and push user object to users array
            adinfolist.push({
                incrtof: incrtof,
                reformi: reformi,
                dvsn: dvsn,
                year: year,
                rangeofc: rangeofc,
                caseno: caseno,
                date:date,
                fprprtno: fprprtno,
                datec: datec,
                sec: sec,
                undact: undact,
                typfrepo: typfrepo,
                mncntocr: mncntocr,
                nmofinvofcr: nmofinvofcr,
                mdtctnofnc: mdtctnofnc,
                rank: rank,
                cmplnorinf: cmplnorinf,
                withszslno: withszslno,
                resultofany: resultofany,
                anm: anm,
                fandhnm: fandhnm,
                whetherverified: whetherverified,
                dob: dob,
                gndr: gndr,
                aadhar: aadhar,
                ntonlty: ntonlty,
                dateofissue: dateofissue,
                plceofisu: plceofisu,
                whterscst: whterscst,
                rlgn: rlgn,
                ocptn: ocptn,
                adrs: adrs,
                bdyidnmrk: bdyidnmrk,
                whetherverifiedd: whetherverifiedd,
                validid: validid,
                stsacsd: stsacsd,
                arstmemorefno: arstmemorefno,
                dtofarst: dtofarst,
                dtofrlse: dtofrlse,
                dtonwhftocrt: dtonwhftocrt,
                nmadrsofsrtes: nmadrsofsrtes,
                bkedvlnsecact: bkedvlnsecact,
                pvscnvctnwithcase: pvscnvctnwithcase,
                anmx: anmx,
                fandhnmx: fandhnmx,
                whetherverifiedxd: whetherverifiedxd,
                dobx: dobx,
                gndrx: gndrx,
                aadharx: aadharx,
                ntonltyx: ntonltyx,
                dateofissuex: dateofissuex,
                plceofisux: plceofisux,
                whterscstx: whterscstx,
                rlgnx: rlgnx,
                ocptnx: ocptnx,
                adrsx: adrsx,
                bdyidnmrkx: bdyidnmrkx,
                whetherverifieddx: whetherverifieddx,
                valididx: valididx,
                stsacsdx: stsacsdx,
                bkedvlnsecactx: bkedvlnsecactx,
                ntbngchrofnc: ntbngchrofnc,
                prtclrwtnsdtl: prtclrwtnsdtl,
                brfctofcase: brfctofcase,
                casedryrefno: casedryrefno,
                amemorefno: amemorefno,
                forthrmrefno: forthrmrefno,
                formsvnrefno: formsvnrefno,
                nmofcr: nmofcr,
                rnkofcr: rnkofcr,
                ofcridno: ofcridno,
                nmofcrx: nmofcrx,
                rnkofcrx: rnkofcrx,
                ofcridnox: ofcridnox

            });







            $.ajax({
                type: "POST",
                url: "forms8.aspx/Insert",
                data: "{adinfolist:" + JSON.stringify(adinfolist) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessrrd,
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });

            function OnSuccessrrd(response) {
                alert("Record Submitted Successfully!");
                window.location.reload();
            }
        }




    </script>


<style>
.closeBtn {
    cursor: pointer;
    float: right; 
    margin-left: 10px; 
    color: red;
    
}
#appendData p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#appendData input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}


/*button*/


.btnx{

    width: 66%;
    height: 33px;
    background-color:#101357;
    color: #fff;
    border: none;
    letter-spacing: 1px;

}
.btnx:hover {
    background-color: #0d0f38;
    color: #ffcc00;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}
.btny{

    width: 66%;
    height: 33px;
    background-color: #0dcaf0;
    color: #fff;
    border: none;
    letter-spacing: 1px;

}
.btny:hover {
    background-color: #08a0e9;
    color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}
.btnz{

    width: 66%;
    height: 33px;
    background-color:#c235dcfc;
    color: #fff;
    border: none;
    letter-spacing: 1px;

}
.btnz:hover {
    background-color: #a61fb2;
    color: #fff;
    box-shadow: 0 0 8px rgba(194, 53, 220, 0.7);
}





</style>

</head>
<body>
     <form id="form1" runat="server">

	 
	<!-- SIDEBAR -->

  <aside id="sidebar">
    <!--
        <li>
            <a href="" style="font-weight: 500; font-size: 10px;"><i class="fa fa-dashboard"></i><span>BLACK TIGER</span></a>
          </li>
    
        -->
          <h3 class="for"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>
    
        <div id="leftside-navigation" class="nano">
          <ul class="nano-content">
            <li class="sub-menu">
                <a href="dashboard.aspx"><i class="fa fa-tachometer" aria-hidden="true"></i><span>DashBoard</span></a>
    
              </li>
    
           
    
     <li class="sub-menu">
    <a href="javascript:void(0);">
        <i class="fa fa-window-restore" aria-hidden="true"></i>
        <span>Offence</span>
        <i class="arrow fa fa-angle-right pull-right"></i>
    </a>
    <ul>
       
        <!-- New submenus -->
        <li class="sub-menu">
    <a href="javascript:void(0);">Wildlife<i class="arrow fa fa-angle-right pull-right"></i></a>
    <ul>
      
          <li class="sub-menu">
            <a href="#">NEW CASES<i class="arrow fa fa-angle-right pull-right"></i></a>
            <ul>
                  <li class="sub-menu">
            <a href="#">FORWARDING TO MAGISTRATE/UNDECTED<i class="arrow fa fa-angle-right pull-right"></i></a>
            <ul>
               <li><a href="rqtnwtns.aspx">Requisition for independent witness/ official witness</a></li>
               <li><a href="deputationoder.aspx">Deputation order of witnesses by concerned authority</a></li>
                <li><a href="cmndcertfcte.aspx">Command certificate</a></li>
                  <li><a href="searchwrnt.aspx">Search warrant by ACF</a></li>
                  <li><a href="beforesearch.aspx">Before search protocol</a></li>
                <li><a href="forms3.aspx">Seizure list (with supporting documents) </a></li>
                <li><a href="aftersearch.aspx">After search protocol</a></li>
                  <li><a href="pregno.aspx">Property Register Number/MR No/CMR No</a></li>
                 <li><a href="fircopy.aspx">FIR Copy</a></li>
                 <li><a href="forms5.aspx">Arrest memo</a></li>
                 <li><a href="ckwildlifeofnc.aspx">Checklist</a></li>
               <li><a href="reportingdfo.aspx">Reporting to DFO cum wildlife warden by Range officer regarding registration of case</a></li>
                  <li><a href="appoitmntiofcr.aspx">Appointment of Investigating Officer</a></li>
                 <li class="sub-menu"><a href="#">Inspection memo<i class="arrow fa fa-angle-right pull-right"></i></a>
                 <ul>
                <li><a href="carcassmemo.aspx">Carcass Inspection Memo </a></li>
                <li><a href="dforprt.aspx">DFO/JTF/Other Experts Report</a></li>
                </ul>
                </li>
                  <li><a href="rqtnpmrtmvofcr.aspx"> Requisition for post mortem examination to Veterinary officer </a></li>
                   <li><a href="dispsalcarcs.aspx">Disposal of Carcass report</a></li>
                <li  class="sub-menu"><a href="#">Confession statement Sec- 50(8) WPA 1972 <i class="arrow fa fa-angle-right pull-right"></i></a>
                <ul>
                <li><a href="statemntwitns.aspx">Statement Of Witness </a></li>
                <li><a href="statemntacsed.aspx">Statement Of Accused</a></li>
                </ul>
                </li>
                <li><a href="crimerecrtnmemo.aspx">Crime Scene recreation memo by accused and statements of independent witnesses </a></li>
                <li><a href="szrememospot.aspx">Seizure memo of spot/weapon/trap led to discovery by accused </a></li>
                <li><a href="prlimnarypstmrtmrepo.aspx">Preliminary post mortem report by the concerned veterinary authority</a></li>
                  <li><a href="rqsnchemex.aspx">Requisition for chemical examination in concerned scientific lab  </a></li>
                <li><a href="exhibitfrdingcncrninsn.aspx">Exhibit forwarding letter by concerned magistrate to Concerned institution  such as    SFSL/ZSI/WII for chemical/biological/ballistic examination u/s 293 CrPC</a></li>
                 <li><a href="exhibtnfrnsicexmn.aspx">Exhibit forwarding letter by concerned magistrate for Forensic Examination for Identification of Species/sex etc by concerned institution such as ZSI/WII.</a></li>
                  <li><a href="rqtnmdexm.aspx">Requisition for medical examination of the accused</a></li>
                <li><a href="rwtnmdclexmacsd.aspx">Inspection Memo of the accused by Medical officer</a></li>
                <li><a href="acusedfrwding.aspx">Accused Forwarding</a></li>

                
              
            </ul>
        </li>
        <li class="sub-menu">
            <a href="#">FINAL PROSECUTION REPORT<i class="arrow fa fa-angle-right pull-right"></i></a>
            <ul>
                 <li><a href="finalpmstemrepo.aspx">Final Post Mortem Report </a></li>
                <li><a href="crimedtlspotmp.aspx">Crime Details Form along with Spot map (along with RI inspection report/joint verification report, Notification of sanctuary/ national park & notification of RF BLOCK included in the sanctuary/national park notification)</a></li>
                  <li><a href="chemicalexrepo.aspx">Chemical examination report</a></li>
                 <li><a href="frnscexmnrepo.aspx">Forensic Examination Report</a></li>
                  <li><a href="rqstntosp.aspx">Requisition to SP for Forensic examination of digital evidence such as photography and videography during seizure/crime scene recreation/ discovery of spot/weapon/trap by accused</a></li>
                 <li><a href="sec65b.aspx">Section 65B certificate  by DFSL of digital evidence with a copy on pendrive </a></li>
                 <li><a href="cdrepotrqsn.aspx">CDR report requisition letter to RCCF concerned</a></li>
                <li><a href="cdrepo65b.aspx">CDR report along with 65 B certificate by concerned Nodal officer through Superintendent of Police concerned </a></li>
                 <li><a href="bailacsed.aspx">Bail order of the accused (if any)</a></li>
                <li><a href="casediary.aspx">Case Diary</a></li>
                <li><a href="cwhrepot.aspx">CWH report with impression for electrocution if any</a></li>
                <li><a href="electricalinsreo.aspx">Electrical Inspector report</a></li>
                 <li><a href="electricalinsreo.aspx">Revenue Inspector Report</a></li>
                 <li><a href="characteranteced.aspx">Character  Antecedents</a></li>
                  <li><a href="corrobortngevd.aspx">Corroborating Evidence Summary</a></li>
                <li><a href="prosectnrepo.aspx">Prosecution Report/Complaint (final)</a></li>
                   <li><a href="">Checklist for final submission of PR</a></li>
                 
            </ul>
        </li>
            </ul>
        </li>
        <li class="sub-menu">
            <a href="exstngcase.aspx">EXISTING CASES<i class="arrow fa fa-angle-right pull-right"></i></a>
            
        </li>
        <li class="sub-menu">
            <a href="userlogs.aspx">User Logs</a>
            
        </li>
    </ul>




  </li>
        
        <li class="sub-menu">
            <a href="javascript:void(0);">Forest<i class="arrow fa fa-angle-right pull-right"></i></a>
    <ul>
        <li class="sub-menu">
            <a href="#">FORWARDING TO MAGISTRATE/UNDECTED<i class="arrow fa fa-angle-right pull-right"></i></a>
            <ul>
                <li><a href="cmndcertfcte.aspx">Command certificate </a></li>
                 <li><a href="range-diary.aspx">Station Diary </a></li>
                 <li><a href="rqtnwtns.aspx">Requisition for Independent Witness/Official </a></li>
                <li><a href="beforesearch.aspx">Before search protocol</a></li>
                <li><a href="forms3.aspx">Seizure list </a></li>
                <li><a href="aftersearch.aspx">After search protocol</a></li>
                <li><a href="zimmanama.aspx">Zimmanama form </a></li>
                <li><a href="forms1.aspx">FIR (complaint form(24)) </a></li>
            <li><a href="accused.aspx">Section 41a Notice To Accused </a></li>
                <li><a href="forms5.aspx">Arrest memo</a></li>
                <li><a href="rqtnmdexm.aspx">Requisition From Of Medical</a></li>
                <li><a href="mdclrepoacsd.aspx">Medical Report Of Accused</a></li>
                <li><a href="cnfsnstmnt.aspx">Confession statement Sec- 77 ofOFA 197</a></li>
                <li><a href="malhnadtls.aspx">Malkhana details </a></li>
                <li><a href="inspctnmemo.aspx">Inspection memo</a></li>
                <li><a href="ri.aspx">RI </a></li>
                <li><a href="dforprt.aspx">DFO/JTF/Other Experts </a></li>
                <li><a href="rqsnfrnsicex.aspx">Requisition for Forensic Examination for identification of Species</a></li>
                <li><a href="frnscexmnrepo.aspx">Forensic Examination Report </a></li>
                <li><a href="prdctnrepo.aspx">Production report before DFO</a></li>
                <li><a href="calldtlsrecord.aspx">Call Details Record</a></li>
                <li><a href="dispsalcarcs.aspx">Disposal of Forest produce</a></li>
                <li><a href="corrobortngevd.aspx">Corroborating Evidence </a></li>
                <li><a href="invstgtnfrstofnc.aspx">Checklist [forwarding to magistrate]</a></li>
            </ul>
        </li>
        <li class="sub-menu">
            <a href="#">FINAL PROSECUTION REPORT<i class="arrow fa fa-angle-right pull-right"></i></a>
            <ul>
                <li><a href="spotmapcrmscene.aspx">Spot map of crime scene </a></li>
                <li><a href="phtgrphofndrs.aspx">Photographs of carcass and offenders</a></li>
                 <li><a href="bailacsed.aspx">Bail order of the accused if any</a></li>
                 <li><a href="rlseodervehcle.aspx">Release order of vehicle if any </a></li>
                 <li><a href="forms9.aspx">Case Diary</a></li>
                 <li><a href="prdctnrepo.aspx">Prosecution Report(Final)</a></li>
                <li><a href="final.aspx">Check List (Final pr)</a></li>
                  <li><a href="summary.aspx">Summary</a></li>
            </ul>
        </li>
         
    </ul>
             
        </li>
        
        <li class="sub-menu">
              <a href="javascript:void(0);">Forms(Miscellaneous)<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                  

               
                
              <li><a href="forms1.aspx">FIR (complaint form(24)) </a></li>
                
                <li><a href="forms4.aspx">Form(III) [ Seizure information]</a>
                </li>
                <li><a href="petition.aspx">Form(IV) [ Compounding Petition]</a>
                </li>
                <li><a href="Offence.aspx">Form (V) [ Compounding receipt]</a>
                </li>
                <li><a href="compoundorder.aspx">Form (VI) [ Compounding Order]</a>
                </li>

                <li><a href="forms9.aspx">Case Diary</a>
                </li>
                <li><a href="witness.aspx">Attendance Of Witness</a>
                </li>
                <li><a href="accused.aspx">Attendance Of Accused</a>
                </li>
                <li><a href="forms8.aspx">Additional Information</a>
                </li>
                <li><a href="pr-death-elephant.aspx">PR ON DEATH OF ELEPHANT</a>
                </li>
        
                 <li><a href="pending-trial.aspx">QUATERLY PROGRESS REPORT OF WILDLIFE CASES PENDING TRIAL </a>
                 </li>
        
                <li><a href="half-yearly-Offence.aspx">HY PROGRESS REPORT ON FOREST Offence CASES</a>
                </li>
        
        
                <li><a href="disposal-ud.aspx">HYPROGRESS REPORT ON DISPOSAL OF SEIZED PRODUCE (UD)</a>
                </li>
        
                <li><a href="disposal-or.aspx">HY PROGRESS REPORT ON DISPOSAL OF SEIZED PRODUCE (OR)</a>
                 </li>
        
                <li><a href="rescue-release.aspx">RESCUE AND RELEASE OF WILDLIFE</a>
                   </li>
        
                    <li><a href="Offence-cases-booked.aspx">Offence CASES BOOKED UNDER WILDLIFE PROTECTION ACT,1972</a>
                    </li>
        
                    <li><a href="annual-Offence.aspx">ANNUAL REPORT ON FOREST CASES BOOKED</a>
                    </li>
        
                    <li><a href="elephant-death.aspx">ELEPHANT DEATH CASES</a>
                    </li>
        
                    <li><a href="live-dead.aspx">LIVE AND DEAD STOCK</a>
                    </li>
        
                    <li><a href="case-booked.aspx">CASES BOOKED U/S 56, OFA, 1972</a>
                    </li>
        
                    <li><a href="wildlife-database.aspx">WILDLIFE CRIME DATA BASE</a>
                    </li>    
    
    
    
    
              </ul>
        </li>
        
        <li class="sub-menu">
          <a href="https://play.google.com/store/apps/details?id=in.gov.ecourts.eCourtsServices&pli=1"><span>Court Case Status</span></a>

        </li>


        <li class="sub-menu ">
          <a href="javascript:void(0);"><span>Crime Records</span><i class="arrow fa fa-angle-right pull-right"></i></a>
          <ul>
            <li class=""><a href="prsnldsior.aspx">Personal Dossier</a>
            </li>
            <li><a href="dossiervchl.aspx">Vehicle Dossier</a>
            </li>
            <li><a href="courtdiry.aspx">Court diary</a>
            </li>
          </ul>
        </li>
        
         <li class="sub-menu">
            <a href="javascript:void(0);">Circular Notification<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                
                <li><a href="">Developer Mode</a></li>
                 <li><a href="">Communication</a></li>
                 <li><a href="">Range Diary</a></li>
                 <li><a href="">Sample Form</a></li>
                 <li><a href="">Court Case Status</a></li>
                
            </ul>

        </li>
        <li class="sub-menu">
           <a href="javascript:void(0);">Communication<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                
                <li><a href="">Developer Mode</a></li>
                 <li><a href="">Communication</a></li>
                 <li><a href="">Range Diary</a></li>
                 <li><a href="">Sample Form</a></li>
                 <li><a href="">Court Case Status</a></li>
                
            </ul>

        </li>

        <li class="sub-menu">
            <a href="javascript:void(0);">sample2<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                
                <li><a href="">Developer Mode</a></li>
                 <li><a href="">Communication</a></li>
                 <li><a href="">Range Diary</a></li>
                 <li><a href="">Sample Form</a></li>
                 <li><a href="">Court Case Status</a></li>
                
            </ul>

        </li>

         <li class="sub-menu">
            <a href="javascript:void(0);">sample3<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                
                <li><a href="">Developer Mode</a></li>
                 <li><a href="">Communication</a></li>
                 <li><a href="">Range Diary</a></li>
                 <li><a href="">Sample Form</a></li>
                 <li><a href="">Court Case Status</a></li>
                
            </ul>

        </li>

         <li class="sub-menu">
            <a href="javascript:void(0);">sample4<i class="arrow fa fa-angle-right pull-right"></i></a>
             <ul>
                
                <li><a href="">Developer Mode</a></li>
                 <li><a href="">Communication</a></li>
                 <li><a href="">Range Diary</a></li>
                 <li><a href="">Sample Form</a></li>
                 <li><a href="">Court Case Status</a></li>
                




            </ul>

        </li>

    </ul>
</li>

          
    
    
            
    
    
          
               <li class="sub-menu">
              <a href="offline.aspx"><i class="fa fa-forumbee" aria-hidden="true"></i><span>Schelduled Forms</span></a>
    
            </li>
              <li class="sub-menu">
              <a href="legal.aspx"><i class="fa fa-hourglass-half" aria-hidden="true"></i><span>Legal  Guidance</span></a>
    
            </li>
              <li class="sub-menu">
              <a href="grievance.aspx"><i class="fa fa-rocket" aria-hidden="true"></i><span>Public Grievance</span></a>
    
            </li>
                <li class="sub-menu">
              <a href="judgement.aspx"><i class="fa fa-bar-chart-o"></i><span>Judgements</span></a>
    
            </li>
                 
            <li class="sub-menu">
                <a href="act.aspx"><i class="fa fa-certificate" aria-hidden="true"></i><span>Act And Rules</span></a>
    
              </li>
    
              <li class="sub-menu">
                <a href="Userroles.aspx"><i class="fa fa-users" aria-hidden="true"></i><span>User Access & Privilledges</span></a>
    
              </li>
    
              <li class="sub-menu">
                <a href="./circular-notification.aspx"><i class="fa fa-ravelry" aria-hidden="true"></i><span>Circular Notification</span></a>
    
              </li>
              <li class="sub-menu">
                <a href="./communication-two-fold.aspx"><i class="fa fa-futbol-o" aria-hidden="true"></i><span>Communication-Two-Fold</span></a>
    
              </li>
              <li class="sub-menu">
                <a href="./range-diary.aspx"><i class="fa fa-tint" aria-hidden="true"></i><span>Range Diary</span></a>
    
              </li>
              <li class="sub-menu">
                <a href="./sample-form.aspx"><i class="fa fa-fire" aria-hidden="true"></i><span>Sample Form</span></a>
    
              </li>
    
              <li class="sub-menu">
              <a href="javascript:void(0);"><i class="fa fa-table"></i><span>Establishment </span><i class="arrow fa fa-angle-right pull-right"></i></a>
              <ul>
                <li><a href="pending-pension.aspx">PENDING PENSION CASES</a>
                </li>
    
                <li><a href="vacancy.aspx">QUATERLY PROGRESS REPORT ON VACANCY</a>
                </li>
              </ul>
            </li>
    
            <li class="sub-menu ">
              <a href="javascript:void(0);"><i class="fa fa-envelope"></i><span>Accounts</span><i class="arrow fa fa-angle-right pull-right"></i></a>
              <ul>
                <li class=""><a href="account1.aspx">PLANTATION EXPENDITURE SCHEME WISE</a>
                </li>
                <li><a href="account3.aspx">QUATERLY PROGRESS REPORT (NBM)</a>
                </li>
                <li><a href="account2.aspx">MONTHLY PROGRESS REPORT</a>
                </li>
              </ul>
            </li>

              <li class="sub-menu">
              <a href="javascript:void(0);"><i class="fa fa fa-tasks"></i><span>Lease and Miscellaneous</span><i class="arrow fa fa-angle-right pull-right"></i></a>
              <ul>
                <li><a href="bamboo.aspx">HY RETURN OF BAMBOO</a>
                </li>
                <li><a href="timber.aspx">HY RETURN OF TIMBER</a>
                </li>
                <li><a href="report-demand.aspx">HY REPORT ON DEMAND, COLLECTION & BALANCE</a>
                </li>
                <li><a href="disposal.aspx">DISPOSAL OF CERTIFICATE CASES</a>
                </li>
                <li><a href="salvage.aspx">HY REPORT ON SALVAGE OPERATION</a>
                </li>
                <li><a href="record-holding.aspx">HY RECORDED HOLDING REPORT</a>
                </li>
                <li><a href="rti.aspx">RTI</a>
                </li>
              </ul>
            </li>
    
    
    
              <li class="sub-menu">
                <a href="index.aspx"><i class="fa fa-sign-out" aria-hidden="true"></i><span>
                  Logout</span></a>
    
              </li>
    
    
    
          </ul>
        </div>
      </aside>
	<!-- SIDEBAR -->



	<!-- CONTENT -->


	<section id="content">

		<nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>


<h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>





		<main>




            <div class="container-fluid" style="margin-top: 40px;">
                <div class="row justify-content-center">
                  <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                    <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                      <div class="text-center">
                        <p id="heading1"></p>
                        <h2 id="heading">SUPPORTING PARTICULARS TO PROSECUTION REPORT</h2>
                        <h2 id="heading">FOREST DEPARTMENT, ODISHA</h2>
                        <p id="heading12">UNDER SECTION 173 OF CODE OF CRIMINAL PROCEDURE &
                          UNDER SECTION 193 OF THE BHARATIYA NAGARIK SURAKSHA SANHITA, 2023
            
            
                        </p>
                        <p id="heading1">
            
                        </p>
                      </div>
            
            
            
                      <form id="msform">
            
            
                        <fieldset>
            
                          <div class="form-card">
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"> </h3>
            
                                      <label class="lebl">IN THECOURTOF</label>
            
                                      <input type="text" id="txtcrt" class="form-control console" placeholder="IN THECOURTOF">
            
            

            
                                    </div>
            
            
            
            
                                    <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Reference Form – I No</label>
            
                                      <input type="text" id="txtrfrmino" class="form-control console"
                                        placeholder="Reference Form – I No">
            
            
                                    </div>
            
            
            
                                  </div>
                                </div>
            
                              </div>
                            </div>
            
            
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"> </h3>
            
                                      <label class="lebl">Division</label>
            
                                      <input type="text" id="txtdvsn" class="form-control console" placeholder="Division">
            
                                      <label class="lebl">Range office</label>
            
                                      <input type="text" id="txtrngeog" class="form-control console" placeholder="Range office">
            
            
            
            
            
                                    </div>
            
            
            
            
                                    <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Year</label>
            
                                      <input type="text" id="txtyr" class="form-control console" placeholder="Year">
                                      <label class="lebl">CaseNo</label>
            
                                      <input type="text" id="txtcsno" class="form-control console" placeholder="CaseNo">
            
            
            
                                    </div>
            
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Date</label>
            
                                      <input type="date" id="txtdt" class="form-control console" placeholder="Date">
            
                                    </div>
            
            
                                  </div>
            
            
            
                                </div>
            
                              </div>
                            </div>
            
            
            
            
            
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"> </h3>
            
                                      <label class="lebl">Final Prosecution ReportNo</label>
            
                                      <input type="text" id="txtfprepon" class="form-control console"
                                        placeholder="Final Prosecution ReportNo">
            
            
            
            
            
            
                                    </div>
            
            
            
            
                                    <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Dated</label>
            
                                      <input type="date" id="txtdtx" class="form-control console" placeholder="Dated">
            
            
                                    </div>
            
            
            
                                  </div>
                                </div>
            
                              </div>
                            </div>
            
            
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
                                    <h3 class="pp">Booked Under </h3>
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
            
            
                                      <label class="lebl">Section/s</label>
            
                                      <input type="text" id="txtsec" class="form-control console" placeholder="Section/s">
            
            
                                    </div>
            
            
            
            
                                    <div class="col-lg-6 col-sm-6 col-xs-6 abc">
            
            
                                      <label class="lebl">Under Act</label>
            
                                      <input type="text" id="txtuacti" class="form-control console" placeholder="Under Act">
            
                                    </div>
            
            <p class="button-container" style="text-align:right;">
                             <button class="bt11 add23" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                                <div id="appendData">  </div>
            
                                  </div>
                                </div>
            
                              </div>
                            </div>
            
            
           
            
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Type of final Report:Charged with Offence /Undetected/Not Charged with
                                        Offence for want ofevidence</label>
            
                                      <input type="text" id="txtofnse" class="form-control console" placeholder="">
            
                                    </div>
            
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h3 class="pp">If Not
                                        Occurred</h3>
            
                                      <label class="lebl">Mistakeoflaw/Non-cognizable/Civilnature</label>
            
                                      <input type="text" id="txtmovr" class="form-control console" placeholder="">
            
                                    </div>
            
            
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"> </h3>
            
                                      <label class="lebl">Nameofthe Investigating Officer</label>
            
                                      <input type="text" id="txtnminvof" class="form-control console" placeholder="">
            
                                      <label class="lebl">Rank</label>
            
                                      <input type="text" id="txtrank" class="form-control console" placeholder="">
            
            
            
            
            
                                    </div>
            
            
            
            
                                    <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Mode of Detection of Offence</label>
            
                                      <input type="text" id="txtmofense" class="form-control console" placeholder="">
                                      <label class="lebl">Complainant/Informant</label>
            
                                      <input type="text" id="txtcmpln" class="form-control console" placeholder="">
            
            
            
                                    </div>
            
            
            
            
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h5 class="pp" style="font-size: 16px;">Dateofproperties/Articles/Documentsrecovered/seizedduringinvestigationandreliedupon as evidence (separatelist can beattached, ifnecessary).</h5>
            
                                      <label class="lebl">[ with reference to seizure list serial number] Reference Form – II No</label>
            
                                      <input type="text" id="txtszno" class="form-control console" placeholder="">
                                        <p style="letter-spacing: 1px;">*May add annexure if lists exceed the space provided.</p>
                                    </div>
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Resultofany forensic Analysis (if any done on any seized articles to relied upon as evidence)</label>
            
                                      <input type="text" id="txtanlys" class="form-control console" placeholder="">
            
                                    </div>
            
            
            
            
            
            
                                    <h4 style="color:#101357;letter-spacing:1px;font-size:16px;padding-top: 18px;padding-bottom:15px; text-align:center ;font-weight: 700;">Particulars Of Accusedpersons Charged Of Offence
                                      (useseparatesheet for each accused)
                                      </h4>
            
            
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Name</label>
            
                                        <input type="text" id="txtacsnm" class="form-control console" placeholder="">
                                        <label class="lebl">Whetherverified</label>
            
                                        <input type="text" id="txtwh" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Father’s/Husband’s Name</label>
            
                                        <input type="text" id="txtfhnm" class="form-control console" placeholder="">
                                        <label class="lebl">Date/Yearof Birth</label>
            
                                        <input type="date" id="txtdob" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc mt-4">
                                        <h3 class="pp"></h3>
                                          <select id="txtsgbdr" class="form-control console">
                                              <option>Select Gender</option>
                                               <option>Male</option>
                                              <option>Female</option>
                                          </select>
            
                                      
                                        <label class="lebl">Nationality</label>
            
                                        <input type="text" id="txtntonlty" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Aadhar No</label>
            
                                        <input type="number" id="txtadhrbo" class="form-control console" placeholder="">
                                        <label class="lebl">Dateofissue</label>
            
                                        <input type="date" id="txtdtois" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Placeof Issue</label>
            
                                        <input type="text" id="txtplceis" class="form-control console" placeholder="">
                                        <label class="lebl">Religion</label>
            
                                        <input type="text" id="txtrlgn" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Whether SC/ST</label>
              
                                        <input type="text" id="txtwscst" class="form-control console" placeholder="">
                                        <label class="lebl">Occupation</label>
              
                                        <input type="text" id="txtocptn" class="form-control console" placeholder="">
              
              
              
                                      </div>
              
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Address</label>
              
                                        <input type="text" id="txtadrs" class="form-control console" placeholder="">
                                        <label class="lebl">Whetherverified</label>
              
                                        <input type="text" id="txtw" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Body Identification Marks</label>
              
                                        <input type="text" id="txtbdyidnm" class="form-control console" placeholder="">
                                        <label class="lebl">Valid ID Card Details</label>
              
                                        <input type="text" id="txtvalidid" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Status of The Accused</label>
            
                                        <input type="text" id="txtcsedssts" class="form-control console" placeholder="">
                                        <label class="lebl">Date Of Arrest</label>
            
                                        <input type="date" id="txtdtarst" class="form-control console" placeholder="">
            
              
              
                                      </div>
            
            
            
                                      <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                        <h3 class="pp"></h3>
            
                                        <label class="lebl">Arrest Memo Ref</label>
            
                                        <input type="text" id="txtarstm" class="form-control console" placeholder="">
                                        <label class="lebl">Date Of Release On Bail</label>
            
                                        <input type="date" id="txtdtrlse" class="form-control console" placeholder="">
            
            
            
                                      </div>
            
            
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <h3 class="pp"></h3>
            
              <label class="lebl">Date On Which Forwarded To Court</label>
            
              <input type="date" id="txtdtwhch" class="form-control console" placeholder="">
              <label class="lebl">Booked Underviolation Of Sections In Acts</label>
            
              <input type="text" id="txtbku" class="form-control console" placeholder="">
            
            
            
            </div>
            
            
            
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <h3 class="pp"></h3>
            
              <label class="lebl">Name(s)and Address(es)of Sureties</label>
            
              <input type="text" id="txtnmscrty" class="form-control console" placeholder="">
              <label class="lebl">Previous Convictions with Case References</label>
            
              <input type="text" id="txtpvscnv" class="form-control console" placeholder="">
            
            
            
            </div>
            
            
            
            <h4 style="color:#101357;letter-spacing:1px;font-size:16px;padding-top: 18px;padding-bottom:15px; text-align:center ;font-weight: 700;">Particulars Of Accused Persons–Not Charged Of Offence (suspected)(separatesheet foreach suspect)
              </h4>
            
            
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Name</label>
            
                <input type="text" id="txtnmy" class="form-control console" placeholder="">
                <label class="lebl">Whetherverified</label>
            
                <input type="text" id="txtwhv" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Father’s/Husband’s Name</label>
            
                <input type="text" id="txtfhnmx" class="form-control console" placeholder="">
                <label class="lebl">Date/Yearof Birth</label>
            
                <input type="date" id="txtdobc" class="form-control console" placeholder="">
            
            
            
              </div>
            
                                      
           <div class="col-lg-6 col-sm-6 col-xs-6 abc mt-4">
              <h3 class="pp"></h3>
             <select id="id=txtsdob" class="form-control console">
            <option>Select Gender</option>
           <option>Male</option>
           <option>Female</option>
           </select>
            
                                      
           <label class="lebl">Nationality</label>
            
         <input type="text" id="txtntoblty" class="form-control console" placeholder="">
            
            
            
              </div>
            
              <%--<div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Sex</label>
            
                <input type="text" id="theDate" class="form-control console" placeholder="">
                <label class="lebl">Nationality</label>
            
                <input type="text" id="theDate" class="form-control console" placeholder="">
            
            
            
              </div>--%>
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Aadhar No</label>
            
                <input type="number" id="txtadhr" class="form-control console" placeholder="">
                <label class="lebl">Dateofissue</label>
            
                <input type="date" id="txtdtis" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Placeof Issue</label>
            
                <input type="text" id="txtplcis" class="form-control console" placeholder="">
                <label class="lebl">Religion</label>
            
                <input type="text" id="txtrelgn" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Whether SC/ST</label>
            
                <input type="text" id="txtwhsc" class="form-control console" placeholder="">
                <label class="lebl">Occupation</label>
            
                <input type="text" id="txtocptnx" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Address</label>
            
                <input type="text" id="txtadrsx" class="form-control console" placeholder="">
                <label class="lebl">Whetherverified</label>
            
                <input type="text" id="txtwhc" class="form-control console" placeholder="">
            
            
            
              </div>
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Body Identification Marks</label>
            
                <input type="text" id="txtbdyidn" class="form-control console" placeholder="">
                <label class="lebl">Valid ID Card Details</label>
            
                <input type="text" id="txtvidtl" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Status of The Accused</label>
            
                <input type="text" id="txtsts" class="form-control console" placeholder="">
            
            
              </div>
            
            
            
              <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Booked Under Violation Of Sections In Acts</label>
            
                <input type="text" id="txtsecact" class="form-control console" placeholder="">
            
            
            
              </div>
            
            
            
              <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                <h3 class="pp"></h3>
            
                <label class="lebl">Any Special Remarks Including Reasons For Not Being Charged Of Offence</label>
            
                <input type="text" id="txtrmk" class="form-control console" placeholder="">
            
            </div>
            
            
            
            
            <div class="col-lg-12 col-sm-12 col-xs-12 abc">
              <h3 class="pp"></h3>
            
              <label class="lebl">Particulars Of Witnesses (with name, parentage, address for communication, Valid ID reference)</label>
            
              <input type="text" id="txtwtnsdtl" class="form-control console" placeholder="">
            
            
            
            
            </div>
            
            
            <div class="col-lg-12 col-sm-12 col-xs-12 abc">
              <h3 class="pp"></h3>
            
              <label class="lebl">Brief Facts Of The Case</label>
            
              <input type="text" id="txtbrfcse" class="form-control console" placeholder="">
            
            
            
            
            </div>
            
            
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <p style="color:red;letter-spacing: 1px;">References:</p>
            
              <label class="lebl">Case Diary reference number</label>
            
              <input type="text" id="txtcsdryno" class="form-control console" placeholder="">
              <label class="lebl">Form-III Reference Number</label>

              <input type="text" id="txtfrmiiirefno" class="form-control console" placeholder="">
            
            

            </div>
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <h3 class="pp"></h3>
            
              <label class="lebl">Arrest Memo Reference Number</label>
            
              <input type="text" id="txtamemoref" class="form-control console" placeholder="">
              <label class="lebl">Form – VII Reference Number</label>
            
              <input type="text" id="txtviino" class="form-control console" placeholder="">
            
            
            
            </div>
            
            
            
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <p class="" style="font-size: 16px; letter-spacing: 1px; color: #000;">Forwarded by Range Officer</p>
              <p class="" style="font-size: 16px;letter-spacing: 1px; color: #000;">Signature of the Investigating officer</p>
            
              <label class="lebl">Name</label>
            
              <input type="text" id="txtnmx" class="form-control console" placeholder="">
            
              <label class="lebl">Rank</label>
            
              <input type="text" id="txtrnkx" class="form-control console" placeholder="">
            
              <label class="lebl">Id No</label>
            
              <input type="number" id="txtidno" class="form-control console" placeholder="">
            
            
            
            </div>
            
            <div class="col-lg-6 col-sm-6 col-xs-6 abc">
              <p class="" style="font-size: 16px; letter-spacing: 1px;color: #000;">Signature of the Investigating </p>
              <p class="" style="font-size: 16px;letter-spacing: 1px; color: #000;">Submitting the Final Report</p>
            
              <label class="lebl">Name</label>
            
              <input type="text" id="txtnmj" class="form-control console" placeholder="">
            
              <label class="lebl">Rank</label>
            
              <input type="text" id="txtrnkj" class="form-control console" placeholder="">
            
              <label class="lebl">Id No</label>
            
              <input type="number" id="txtidnoj" class="form-control console" placeholder="">
            
            
            
                                      </div> 
									</div>
            
                                </div>
            
                              </div>
                            </div>
            
                          </div>
            
                           
                        </fieldset>
						  
						    <div class="row " style="margin-top:-31px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
            
                          <div class="col-lg-4  col-sm-4 col-xs-4 abc">

                             <label class="lebl" style="color:#228B22;">Manually Upload File</label>
            
                             <input id="txtmupld" type="file">
            
                            </div>



                            <div class="col-lg-4  col-sm-4 col-xs-4 abc">
							
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                           <div class="col-lg-4  col-sm-4 col-xs-4 abc">
						   
                            <button class="btny mt-4" type="button" onclick="window.location.href='form8pdf.aspx'">Download Pdf</button>
                              
                            </div>
                          </div>
                        </div>
            
                      </div>
                    </div>

                      </form>
            
            
            
            
            
            
            
                    </div>
                  </div>
                </div>
              </div>
		</main>

	</section>




	<script src="js/script.js"></script>

   
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
        integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>



<script>
    $("#leftside-navigation .sub-menu > a").click(function (e) {
        // Slide up all submenus except the one associated with the clicked anchor tag
        $(this).parent().siblings().find("ul").slideUp();

        // Slide down or toggle the visibility of the submenu associated with the clicked anchor tag
        $(this).next("ul").slideToggle();

        // Prevent event propagation
        e.stopPropagation();
    });
</script>

    </form>
</body>
</html>