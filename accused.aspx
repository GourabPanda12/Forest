<%@ Page Language="C#" AutoEventWireup="true" CodeFile="accused.aspx.cs" Inherits="accused" %> 


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

	<title>Attendance Of Accused</title>

       <script>

           //submit code 

           function sub() {


               // Get form input values
               var slno = $("#txtslno").val();
               var tox = $("#txto").val();
               var acsnm = $("#txtacsn").val();
               var acsadrs = $("#txtlstkadrs").val();
               var phnoreml = $("#txtphoeml").val();
               var policestn = $("#txtps").val();
               var caseno = $("#txtcseno").val();
               var cdte = $("#txtdt").val();
               var dusx = $("#txtu").val();
               var regplcestn = $("#txtrp").val();
               var aprtme = $("#txtat").val();
               var aprplce = $("#txtata").val();
               var fslno = $("#txtslnox").val();
               var fdinsn = $("#txtdvsn").val();
               var frngeofc = $("#txtrngofc").val();
               var fdte = $("#txtdate").val();
               var ftme = $("#txtime").val();
               var frto = $("#txtto").val();
               var contct = $("#txtphn").val();
               var eml = $("#txteml").val();
               var enqrycaseno = $("#txtcsenox").val();
               var casedt = $("#txtdatex").val();
               var violtn = $("#txtvln").val();
               var plce = $("#txtatp").val();
               var aprtime = $("#txtaprat").val();
               var apdate = $("#txtaprdt").val();
               var aprday = $("#txtday").val();
               var apprplc = $("#txtplace").val();
               var ofcr = $("#txtofcrnm").val();
               var desig = $("#txtdsg").val();
               var noticeno = $("#txtntceno").val();
               var noticedt = $("#txtndt").val();
               var naprdt = $("#txtcapdt").val();
               var naprday = $("#txtapdy").val();
               var faprdt = $("#txfdy").val();
               var toaprdt = $("#txtdy").val();




               var accusedlist = [];
               // Create and push user object to users array 
               accusedlist.push({
                   slno: slno,
                   tox: tox,
                   acsnm: acsnm,
                   acsadrs: acsadrs,
                   phnoreml: phnoreml,
                   policestn: policestn,
                   caseno: caseno,
                   cdte: cdte,
                   dusx: dusx,
                   regplcestn: regplcestn,
                   aprtme: aprtme,
                   aprplce: aprplce,
                   fslno: fslno,
                   fdinsn: fdinsn,
                   frngeofc: frngeofc,
                   fdte: fdte,
                   ftme: ftme,
                   frto: frto,
                   contct: contct,
                   eml: eml,
                   enqrycaseno: enqrycaseno,
                   casedt: casedt,
                   violtn: violtn,
                   plce: plce,
                   aprtime: aprtime,
                   apdate: apdate,
                   aprday: aprday,
                   apprplc: apprplc,
                   ofcr: ofcr,
                   desig: desig,
                   noticeno: noticeno,
                   noticedt: noticedt,
                   naprdt: naprdt,
                   naprday: naprday,
                   faprdt: faprdt,
                   toaprdt: toaprdt


               });


               $.ajax({
                   type: "POST",
                   url: "accused.aspx/Insert",
                   data: "{accusedlist:" + JSON.stringify(accusedlist) + "}",
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



    <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>


       <main>



        <div class="container-fluid" style="margin-top: 40px;">


            <div class="row justify-content-center">
              <div class="col-11 col-sm-10 col-md-11 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                  <div class="text-center">
                    <p id="heading1"> </p>


                    <!--
                    <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
                    <h3 id="heading">  NOTICE FOR ATTENDANCE OF ACCUSED</h3>
                    <p id="heading1"> UNDER SECTION 35(3) OF THE BHARATIYA NAGARIK SURAKSHA SANHITA,
                        2023
                    </p>
                    <p id="heading1"> NOTICE FOR APPEARANCE BY THE POLICE
                    </p>
                    <p id="heading1">   [See section 35(3)]
                    </p>
                    -->









                  </div>


                  	<!--
                  <form id="msform">
                    <fieldset>
        
                      <div class="form-card">
        
                        <div class="row ">
                          <div class="col-md-10  col-12 mx- auto offset-md-1">
        
        
                            <div class="login-form">
                             <div class="row asd d-flex">
                              <h5 class="text-center mb-2 val"></h5>
                              <div class="col-lg-12  col-sm-12 col-xs-12 abc1">


								  

      <div class="row">
											
   <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
    <label class="lebl">Serial No </label>
    <input type="text" id="txtslno"  class="form-control console" placeholder="">	
 </div>
 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">  To </label>
      <input type="text" id="txto"  class="form-control console" placeholder="">	
	</div>

	 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl"> Name of the Accused Notice </label>
              <input type="text" id="txtacsn"  class="form-control console" placeholder="">	
		</div>
	</div>

								  
								  
								  
		 <div class="row">
											
   <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
    <label class="lebl"> Last known Address</label>
    <input type="text" id="txtlstkadrs"  class="form-control console" placeholder="">	
 </div>
 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">Phone No./Email ID (if any)   </label>
      <input type="text" id="txtphoeml"  class="form-control console" placeholder="">	
	</div>

	 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl"> Police Station  </label>
              <input type="text" id="txtps"  class="form-control console" placeholder="">	
		</div>
	</div>						  


       						  


                                <div style="margin-top: 70px; margin-bottom: 50px;">
                                    <p class="to34"> (1) Serial No<input type="text" id="txtslno" class="inp"> </p>
                                    <p class="to34"> (2) To, <input type="text" id="txto" class="inp"> </p>

                                    <p class="to34"> (3) Name of the Accused Notice <input type="text"id="txtacsn" class="inp"> </p>

                                    <p class="to34"> (4)Last known Address <input type="text" id="txtlstkadrs" class="inp"></p>
                                    <p class="to34"> (5)Phone No./Email ID (if any) <input type="text" id="txtphoeml" class="inp"></p>
                                    <p class="to34"> (6) Police Station <input type="text" id="txtps" class="inp"> </p>
                                </div>


								  
								  

                                <div style="margin-top: 70px; margin-bottom: 50px;">

          <p class="to34"> In pursuance of sub-section (3) of section 35 of the BharatiyaNagarik Suraksha Sanhita, 2023, I hereby inform you that during the investigation of FIR/ Case No <input type="text" id="txtcseno" class="inp"> dated <input type="date" id="txtdt" class="inp"> u/s <input type="text" id="txtu" class="inp"> registered at Police Station <input type="text" id="txtrp" class="inp">, it is revealed that there are reasonable grounds to question you to ascertain facts and circumstances from you, in relation to the present investigation. Hence you are directed to appear before me at <input type="text" id="txtat" class="inp"> AM/ PM on <input type="text" id="txtata" class="inp"> at Police Station. Name and Designation of the Officer In charge
                                  (Seal)</p>



                                </div>





                              </div>

                            </div>
							  
							  </div>
							  
							  
							  
							  

                          </div>
                        </div>
        


                      </div>




</fieldset>
</form>
-->





<div class="text-center">






    <h3 id="heading">    FOREST DEPARTMENT, ODISHA</h3>
    <h3 id="heading">NOTICE FOR ATTENDANCE OF ACCUSED</h3>
                      <p id="heading1">UNDER SECTION- 41A OF CRIMINAL PROCEDURE CODE 1973
                        &
                        UNDER SECTION 35(3) OF THE BHARATIYA NAGARIK SURAKSHA SANHITA,
                        2023 </p>

                    </div>






                    
                      <fieldset>
                      <div class="form-card">
          
                        <div class="row ">
                          <div class="col-md-10  col-12 mx- auto offset-md-1">


                            <div class="login-form">
        
                              <h5 class="text-center mb-2 val"></h5>
                              <div class="row asd d-flex">
        
                                <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                  <h3 class="pp"> </h3>
                                

                                  <label class="lebl">Command certificate no</label>
        
                                  <input type="text" id="cmnd no" class="form-control console" placeholder="">

                                  <label class="lebl">Serial No</label>
        
                                  <input type="text" id="txtslnox" class="form-control console" placeholder="">
        
        
        
        
                                    



                                  <label class="lebl">Range Office</label>
        
                                  <input type="text" id="txtrngofc" class="form-control console" placeholder="">

                                  <label class="lebl">Time</label>

                                  <input type="time" id="txtime" class="form-control console" placeholder="">
        
        
                                </div>

        
        
        
                                <div class="col-lg-6 col-sm-6 col-xs-6 abc">
                                  <h3 class="pp"></h3>
                                    
                                  <label class="lebl">FIR no</label>
        
                                  <input type="text" id="txtfir" class="form-control console" placeholder="">

                                  <label class="lebl">Division</label>
        
                                  <input type="text" id="txtdvsn" class="form-control console" placeholder="">
        
                                  <label class="lebl">Date</label>
        
                                  <input type="date" id="txtdate" class="form-control console" placeholder="">
        

        
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
                                      <input type="text" id="txtto" class="inp">
                                      Contact No. / Email ID<input id="txtphn" type="text" class="inp">
                                      Valid ID (if any) <input type="text" id="txteml" class="inp">

                                    </p>

                                    <p class="to34"> In exercise of the powers conferred under Section- 41A of Criminal Procedure Code 1973, I hereby inform you that during the investigation/enquiry of case number<input type="text"id="txtcsenox" class="inp">dated<input type="date" id="txtdatex" class="inp">. under violation of <input id="txtvln" type="text" class="inp">. registered against you at <input type="text" id="txtatp" class="inp">. Range Office, it is revealed that there are reasonable grounds to question you to ascertain facts and circumstances from you, in relation to the present investigation.

Hence you are directed to appear before us at <input type="text" id="txtaprat" class="inp" />am/pm on date <input type="date" id="txtaprdt" class="inp" />(day)<input type="text" id="txtday" class="inp" /> at<input type="text" class="inp" id="txtplace" />.</p>

                                  </div>
        
        


        
                    <div style="margin-top: 40px; margin-bottom: 50px;">
                <h5 style="margin-bottom: 40px;letter-spacing: 1px;color:#000;" class="text-center">You are directed to comply with all and/or the following directions</h5>


                                    <p class="to33"> 1.	You will not commit any Offence in future.</p>
                                        <p class="to33">  2.	You will not tamper with the evidences in the case in any manner whatsoever.</p>
                                            <p class="to33">  3.	You will not make any threat, inducement, or promise to any person acquainted with the fact of the case so as to dissuade him from disclosing, such facts to the court or to the police officer.</p>
                                                <p class="to33">  4.	You will appear before the Court as and when required/directed.</p>
                                                    <p class="to33"> 5.	You will join the investigation of the case as and when required and will cooperate in the investigation.</p>
                                                        <p class="to33"> 6.	You will disclose all the facts truthfully without concealing any part relevant for the purpose of investigation to reach to the right conclusion of the case.</p>
                                                            <p class="to33"> 7.	You will produce all relevant documents/material required for the purpose of investigation.</p>
                                                                <p class="to33">  8.	You will-render your full co-operation/assistance in apprehension of the accomplice.</p>
                                                                    <p class="to33"> 9.	You will not allow in any manner destruction of any evidence relevant for the purpose of investigation/trial of the case.</p>
                                                                        <p class="to33">  10.	Any other conditions, which may be imposed by the Investigating Officeras per the facts and circumstances of the case.</p>






                                    <p  style="color: #000; font-weight: 600; font-size: 15px;"> Failure to attend/comply with the terms of this Notice can render you liable for arrest under Section 41A (3) and (4) of Criminal Procedure Code 1973.</p>


                                    <h5 style="letter-spacing: 1px;margin-bottom:30px;margin-top: 40px;color:#000;">
                                      Requesting Officer</h5>

        
                                  </div>

                                  <div class="row mb-3">
                                    <div class="col-lg-4  col-sm-4 col-xs-4 ">

                                    <label class="lebl">Signature With Date Time</label>
                                     <input type="text" id=""  class="form-control console" placeholder="">
                                    </div>


                                    <div class="col-lg-4  col-sm-4 col-xs-4 " style="display:hidden;">

                                      <label class="lebl"></label>

                                      </div>


                                  <div class="col-lg-4  col-sm-4 col-xs-4 ">
                                  
                                    <label class="lebl">Seal Of The Range Office</label>
                                     <input type="text" id=""  class="form-control console" placeholder="">
                                    </div>

                                    </div>


                                    <div class="row mt-3 mb-3">
                                      <div class="col-lg-4  col-sm-4 col-xs-4 ">
                                        <label class="lebl">Name and Designation 
                                        </label>
                                     <input type="text" id=""  class="form-control console" placeholder="">
                                        </div>
                                        </div>

                                  <!--
                                  <div style="display: flex; justify-content: space-between;">
                                    <div style="float: left;">
                                      <p style="color: #000;">Signature with Date and Time </p>
                                      <p style="color:#000;">
                                        Name<input id="txtofcrnm" type="text" class="inp"> and Designation<input id="txtdsg" type="text" class="inp"></p>
                                    </div>
                                    <div style="float:right;">
                                      <p style="color: #000;">Seal of the Range Office </p>

                                    </div>


                                  </div>
                                  -->

<!--
                                  <h5 class="text-center" style="letter-spacing: 1px;color:#000;font-size: 17px;">ACKNOWLEDGEMENT</h5>

                                  <div style="margin-top: 40px;margin-bottom: 40px;">
                                    <p class="to34">

                                        In compliance with the abovementioned notice <input
                                        type="text" id="txtntceno"  class="inp">dated <input
                                        type="date" id="txtndt" class="inp">issued under Section 4lA of Criminal Procedure Code 1973, the noticee has appeared on date <input
                                        type="date" id="txtcapdt" class="inp">Day<input
                                        type="text" id="txtapdy" class="inp">from<input
                                        type="date"class="inp" id="txfdy">to <input
                                        type="date"  class="inp" id="txtdy">The noticee presence has been recorded in the Range Diary and Register maintained by the Range Office.</p>

                                        <p class="to34">  This acknowledgement is being issued in compliance with the notice. </p>

                                        <p class="to34">  Co-operation by the noticee during investigation (remarks)</p>
                                        
                                        
                                        <p class="to34"> The documents produced by the notice have duly been seized vide seizure list<input
                                        type="file" class="inp"> (copy enclosed) [ if any]</p>
                                        
                                        <p class="to34">  The notice undertakes to continue to comply with any further notice that she/he may receive during the course of the present investigation.


                                    </p>
        
        
                                    <div style="display: flex; justify-content: space-between;">
                                      <div style="float: left;">
                                        <p style="color: #000;">Signature of Accused/Notice</p>

                                      </div>
                                      <div style="float:right;">
                                        <p style="color: #000;">Signature of Investigating Officer</p>
        
                                      </div>
                                    </div>
                                  </div>
                                  -->



                                </div>
                              </div>
                            </div>
        
                          </div>
                        </div>
                      </div>
                    </fieldset>
                    </>






                        <div class="form" id="msform">
                          <fieldset>
                          <div class="form-card">
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
    


                        <div class="login-form">
                          <div class="row asd d-flex">

                          <h5 class="text-center" style="letter-spacing: 2px;color:#000;font-size: 19px; padding-top:10px;">Acknowledgement</h5>

                          <div style="margin-top: 40px;margin-bottom: 40px;">
                            <p class="to34">

                                In compliance with the abovementioned notice <input
                                type="text" id="txtntceno"  class="inp">dated <input
                                type="date" id="txtndt" class="inp">issued under Section 4lA of Criminal Procedure Code 1973, the noticee has appeared on date <input
                                type="date" id="txtcapdt" class="inp">Day<input
                                type="text" id="txtapdy" class="inp">from<input
                                type="date"class="inp" id="txfdy">to <input
                                type="date"  class="inp" id="txtdy">The noticee presence has been recorded in the Range Diary and Register maintained by the Range Office.</p>

                                <p class="to34">  This acknowledgement is being issued in compliance with the notice. </p>

                                <p class="to34">  Co-operation by the noticee during investigation (remarks)</p>
                                
                                
                                <p class="to34"> The documents produced by the notice have duly been seized vide seizure list<input
                                type="file" class="inp"> (copy enclosed) [ if any]</p>
                                
                                <p class="to34">  The notice undertakes to continue to comply with any further notice that she/he may receive during the course of the present investigation.


                            </p>

                            <div class="row mb-3">
                              <div class="col-lg-6  col-sm-6 col-xs-6 ">

                              <label class="lebl">Signature of Accused</label>
                               <input type="file" id=""  class="form-control console" placeholder="">
                              </div>





                            <div class="col-lg-6  col-sm-6 col-xs-6 ">

                              <label class="lebl">Signature of Investigating Officer</label>
                               <input type="file" id=""  class="form-control console" placeholder="">
                              </div>

                              </div>





                           <!--
                            <div style="display: flex; justify-content: space-between;">
                              <div style="float: left;">
                                <p style="color: #000;">Signature of Accused/Notice</p>

                              </div>
                              <div style="float:right;">
                                <p style="color: #000;">Signature of Investigating Officer</p>

                              </div>
                            </div>
                            -->


                          </div>

                          </div>
                          </div>
                          </div>
</div>
                          </div>

                        </fieldset>
                        </div>








                     <div class="row " style="margin-top:-31px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
            
                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
            
                             <button class="btnx" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                           <div class="col-lg-6  col-sm-6 col-xs-4 abc">
                             
                          
                              <button class="btny" type="button" onclick="window.location.href='accusedpdf.aspx'">Download Pdf</button>   
                                

                            </div>
                          </div>
                        </div>
            
                      </div>
                    </div>
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