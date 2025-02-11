﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="witness.aspx.cs" Inherits="witness" %>

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
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Attendance Of Witness</title>



<script>
    //submit code
	
    function sub() {

        // Get form input values
        var slno = $("#txtslno").val();
        var divsn = $("#txtdiv").val();
        var rangeofc = $("#txtrngofc").val();
        var dat = $("#txtdt").val();
        var tofcr = $("#txto").val();
        var cntct = $("#txtmbl").val();
        var email = $("#txteml").val();
        var caseno = $("#txtcaseno").val();
        var dted = $("#txtcsedt").val();
        var vltn = $("#txtvln").val();
        var unkn = $("#txtunk").val();
        var regatp = $("#txtregat").val();
        var aprtme = $("#txtme").val();
        var aprdt = $("#txtrdt").val();
        var aprdy = $("#txtday").val();
        var aprplc = $("#txtplc").val();
        var ofcrnm = $("#txtnmofcr").val();
        var ofcrdsg = $("#txtdsg").val();
        var noticn = $("#txtntc").val();
        var ntdate = $("#txtndt").val();
        var waprdte = $("#txtaprdt").val();
        var waprdy = $("#txtaprday").val();
        var fromdt = $("#txtfrm").val();
        var todt = $("#txtfto").val();
        var szrelist = $("#txtszrel").val();
        var rupees = $("#txtrs").val();
        var atndcedtl = $("#txtcdtl").val();
        var ofnceof = $("#txtofnc").val();
        var wtnsdtl = $("#txtwtnsndtl").val();
        var wtnsnm = $("#txtnm").val();
        var acsnm = $("#txtanm").val();
        var place = $("#txtaplc").val();
        var court = $("#txtrcrt").val();
        var courtdt = $("#txtcrtdt").val();
        var crtday = $("#txtcrtday").val();
        var crtime = $("#txtctime").val();
        var touch = $("#txtching").val();
        var complndt = $("#txtofdt").val();
        var compday = $("#txtofday").val();
        var comyr = $("#txtofncyr").val();



        var witnesseslist = [];
        // Create and push user object to users array
        witnesseslist.push({
            slno: slno,
            divsn: divsn,
            rangeofc: rangeofc,
            dat: dat,
            tofcr: tofcr,
            cntct: cntct,
            email: email,
            caseno: caseno,
            dted: dted,
            vltn: vltn,
            unkn: unkn,
            regatp: regatp,
            aprtme: aprtme,
            aprdt: aprdt,
            aprdy: aprdy,
            aprplc: aprplc,
            ofcrnm: ofcrnm,
            ofcrdsg: ofcrdsg,
            noticn: noticn,
            ntdate: ntdate,
            waprdte: waprdte,
            waprdy: waprdy,
            fromdt: fromdt,
            todt: todt,
            szrelist: szrelist,
            rupees: rupees,
            atndcedtl: atndcedtl,
            ofnceof: ofnceof,
            wtnsdtl: wtnsdtl,
            wtnsnm: wtnsnm,
            acsnm: acsnm,
            place: place,
            court: court,
            courtdt: courtdt,
            crtday: crtday,
            crtime: crtime,
            touch: touch,
            complndt: complndt,
            compday: compday,
            comyr: comyr


        });


        $.ajax({
            type: "POST",
            url: "witness.aspx/Insert",
            data: "{witnesseslist:" + JSON.stringify(witnesseslist) + "}",
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
			<i class='bx bx-menu'  style="font-size: 30px;color: #fff;font-weight:600;"></i>
         <a href="#" class="nav-link"></a>
        
		</nav>
<h3 style="z-index: 99999999;
    /* width: 200px; */
    display: flex;
    float: left;
    position: absolute;
    color: white;
    top: 10px;
    left: 81%;">DFO SAMBALPUR</h3>
       <main>



        <div class="container-fluid" style="margin-top: 40px;">


            <div class="row justify-content-center">
              <div class="col-11 col-sm-10 col-md-11 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                  <div class="text-center">
                    <p id="heading1"> </p>
                    <h2 id="heading">FOREST DEPARTMENT, ODISHA</h2>
                    <p id="heading12">NOTICE FOR ATTENDANCE OF WITNESS
                      UNDER SECTION – 77(B) OF ODISHA FOREST ACT 1972 / SECTION – 50(8)(B) OF WILDLIFE PROTECTION ACT
                      1972&SECTION 71 OF THE BHARATIYA NAGARIK SURAKSHA SANHITA, 2023
        
                    </p>
        
        
                    <!--
                             <img src="" class="imgh">
                             -->
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
        
                                  <label class="lebl">Serial No</label>
        
                                  <input type="text" id="txtslno" class="form-control console" placeholder="Book No">
        
        
        
        
        
                                  <label class="lebl">Range Office</label>
        
                                  <input type="text" id="txtrngofc" class="form-control console" placeholder="Case No">
        
        
                                </div>
        
        
        
        
                                <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                  <h3 class="pp"></h3>
        
                                  <label class="lebl">Division</label>
        
                                  <input type="text" id="txtdiv" class="form-control console" placeholder="Serial No">
        
                                  <label class="lebl">Date </label>
        
                                  <input type="date" id="txtdt" class="form-control console" placeholder="">
        
        
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
                                <div class="col-lg-12  col-sm-12 col-xs-12 abc1">
        
                                  <div style="margin-top: 80px;">
                                    <p class="to34">To,
                                      <input type="text" id="txto" class="inp">
                                      Contact No. / Email ID<input type="text" id="txtmbl" class="inp">
                                      Valid ID (if any) <input type="email" id="txteml" class="inp">
                                      In exercise of the powers conferred under Section – 77(b) of Odisha Forest Act 1972 /
                                      Section – 50(8)(b) of Wildlife Protection Act 1972, I hereby inform you that during the
                                      investigation/enquiry of case number<input type="text" id="txtcaseno" class="inp">dated<input type="date"
                                        class="inp" id="txtcsedt">under violation of<input type="text" id="txtvln" class="inp">.
                                    </p>
                                    <p class="to34">
                                      <input type="text" id="txtunk" class="inp">registered at <input type="text"id="txtregat" class="inp">Range
                                      Office,it is revealed that there are reasonable grounds to question you to ascertain facts
                                      and circumstances from you, in relation to the present investigation.
        
                                      Hence you are directed to appear before us at<input type="time" id="txtme" class="inp">am/pm on
                                      date<input type="date" id="txtrdt" class="inp">(day)<input id="txtday" type="text" class="inp">at<input
                                        type="text" id="txtplc" class="inp">.
                                    </p>
                                  </div>
        
        


        
                    <div style="margin-top: 40px; margin-bottom: 50px;">
                <h5 style="margin-bottom: 40px;letter-spacing: 1px;color:#000;" class="text-center">You are directed to
                                      comply with all and/or the following directions</h5>
        
                                    <p class="to33"> (a) You will appear before the Court as and when required/directed.</p>
                                    <p class="to33">(b) You will join the investigation of the case as and when required and
                                      will cooperate in the
                                      investigation. </p>
                                    <p class="to33">(c) You will disclose all the facts truthfully without concealing any part
                                      relevant for the purpose of investigation to reach to the right conclusion of the case.
                                    </p>
                                    <p class="to33"> (d) You will produce all relevant documents/material required for the
                                      purpose of investigation. </p>
                                    <p class="to33"> (e) You will render your full co-operation/ assistance in apprehension of
                                      the accomplice.</p>
                                    <p class="to33"> (f) You will not allow in any manner destruction of any evidence relevant
                                      for the purpose of investigation/trial of the case. </p>
                                    <p class="to33"> (g) Any other conditions, which may be imposed by the Investigating Officer
                                      as per the facts and circumstances of the case.</p>

                                    <p  style="color: #000; font-weight: 600; font-size: 15px;"> Failure to attend/comply with the terms of this Notice can render
                                      you liable for legal action u/s 174 Indian Penal Code 1860.</p>
        

                                    <h5 style="letter-spacing: 1px;margin-bottom:30px;margin-top: 40px;color:#000;" class="text-center">
                                      Requesting Officer</h5>
        
        
                                  </div>
        
                                  <div style="display: flex; justify-content: space-between;">
                                    <div style="float: left;">
                                      <p style="color: #000;">Signature with Date and Time </p>
                                      <p style="color:#000;">
                                        Name<input type="text" id="txtnmofcr" class="inp"> and Designation<input type="text" id="txtdsg" class="inp"></p>
                                    </div>
                                    <div style="float:right;">
                                      <p style="color: #000;">Seal of the Range Office </p>

                                    </div>
        

                                  </div>


                                  <h5 class="text-center" style="letter-spacing: 1px;color:#000;font-size: 17px;">ACKNOWLEDGEMENT</h5>

                                  <div style="margin-top: 40px;margin-bottom: 40px;">
                                    <p class="to34">In compliance with the abovementioned notice<input id="txtntc" type="text"
                                        class="inp">dated <input type="date" id="txtndt" class="inp">issued underSection – 77(b) of Odisha
                                      Forest Act 1972 / Section – 50(8)(b) of Wildlife Protection Act 1972, the notice/witness
                                      has appeared on date <input type="date" id="txtaprdt" class="inp"> Day <input id="txtaprday" type="text"
                                        class="inp">from <input type="date" id="txtfrm" class="inp"> to <input type="date" id="txtfto" class="inp">The
                                      noticee presence has been recorded in the Range Diary and Register maintained by the Range
                                      Office.
        
                                      This acknowledgement is being issued in compliance with the notice.
        
                                      Co-operation by the noticee during investigation (remarks):
        
        
                                      The documents produced by the noticee have duly been seized vide seizure list<input
                                        type="text" id="txtszrel" class="inp"> (copy enclosed) [ if any].
        
                                      The noticee undertakes to continue to comply with any further notice that she/he may
                                      receive during the course of the present investigation.
        
                                      Paid with Rs <input type="text" id="txtrs" class="inp">towards reasonable expenses towards
                                      attendance.</p>
        
        
                                    <div style="display: flex; justify-content: space-between;">
                                      <div style="float: left;">
                                        <p style="color: #000;">Signature of Witness/Notice</p>
        
                                      </div>
                                      <div style="float:right;">
                                        <p style="color: #000;">Signature of Investigating Officer</p>
        
                                      </div>
        
        
                                    </div>
        
        
                                  </div>


                                 <div class="text-center">

                    <p id="heading1" style="color: #000;">SECTION 71 OF THE BHARATIYA NAGARIK SURAKSHA SANHITA, 2023
                      <p id="heading1" style="color: #000;">FORM No. 6</p>
                      <p id="heading1" style="color: #000;">PROCLAMATION REQUIRING THE ATTENDANCE OF A WITNESS </p>
                    </div>

                    <div style="margin-top: 40px;margin-bottom: 40px;">
                      <p class="to34">
                        (WHEREAS complaint has been made before me that<input id="txtcdtl" type="text"
                        class="inp">(name, description and address) has committed (or is suspected to have committed) the Offence of <input id="txtofnc" type="text"
                        class="inp">(mention the Offence concisely) and a warrant has been issued to compel the attendance of<input type="text"
                        class="inp" id="txtwtnsndtl">(name, description and address of the witness) before this Court to be examined touching the matter of the said complaint; and whereas it has been returned to the said warrant that the said<input type="text"
                        class="inp" id="txtnm">(name of witness) cannot be served, and it has been shown to my satisfaction that he has absconded (or is concealing himself to avoid the service of the said warrant); Proclamation is hereby made that the said<input id="txtanm" type="text"
                        class="inp">(name) is required to appear at<input type="text"
                        class="inp" id="txtaplc">(place) before the Court<input id="txtrcrt" type="text"
                        class="inp">on the<input type="date"
                        class="inp" id="txtcrtdt">day of <input type="text"
                        class="inp" id="txtcrtday">next at<input type="text"
                        class="inp"id="txtctime">o'clock to be examined touching <input type="text"
                        class="inp" id="txtching">the Offence complained of. Dated, this<input type="date"
                        class="inp" id="txtofdt"> day of <input type="text"
                        class="inp" id="txtofday">, 20<input type="text"
                        class="inp" id="txtofncyr">.


                      </p>
                      <p  class="to34"> (Seal of

                        the Court) (Signature) <input type="file"
                        class="inp"></p>
                      </div>

        


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
						   
                            <button class="btny mt-4" type="button" onclick="window.location.href='witnesspdf.aspx'">Download Pdf</button>
                              
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