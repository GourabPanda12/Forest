<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invstgtnfrstofnc.aspx.cs" Inherits="invstgtnfrstofnc" %>

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

	<title>Investigation of Forest Offences</title>


     <script>

         $(document).ready(function () {
             $('#slctgnrl').change(function () {
                 var selectedValue = $(this).val();
                 $('.section').hide();
                 if (selectedValue) {
                     $('#' + selectedValue).show();
                 }
             });
         });



     </script>

<style>

.btnx{

    width: 66%;
    height: 33px;
    background-color:#101357;
    color: #fff;
    border: none;
    letter-spacing: 1px;
    border-radius: 6px;

}
.btnx:hover {
    background-color: #0d0f38;
    color: #ffcc00;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

 h6{
     color:#000;
 }

 

.container111 {
    display: flex;
    justify-content: center;
    align-items: center;
}
.dropdown {
    padding: 5px;
    font-size: 16px;
}

 .section {
            display: none;
        }
</style>

</head>
<body>
      <form id="form1" runat="server">

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
      
                        <%--<li><a href="malhnadtls.aspx">Malkhana details </a></li>
                       <li><a href="forms1.aspx">FIR (complaint form(24)) </a></li>
                      <li><a href="appointmntinvofcr.aspx">Appointment Of Investing Officer</a></li>
                     <li><a href="appointmntinvofcr.aspx">Intimation To The DFO Cum Wildlife Warden</a></li>
                      <li><a href="accused.aspx">Section 41a Notice To Accused </a></li>
                       
                     
                       <li><a href="mdclrepoacsd.aspx">Medical Report Of Accused</a></li>
                      
                     
                      <li><a href="rqstnfrpmortem.aspx">Requisition form for Post Motem examination</a></li>
                      <li><a href="mdclofcr.aspx">Medical Officer </a></li>
                        <li><a href="prlimpstmrtemrepo.aspx">Preliminary Post Mortem Report By The Concerned  Verinary Authority</a></li>
                     <li><a href="rqsnchemex.aspx">Requisition for chemical examination in concerned scientific lab </a></li>
      
                       <li><a href="calldtlsrecord.aspx">Call Details Record</a></li>
                        <li><a href="exhbitltr.aspx">Exhibit Forwarding Letter By Concerned  Magistrate to Concered Lab</a></li>
                        <li><a href="rqsnfrnsicex.aspx">Requisition for Forensic Examination for identification of Species</a></li>
                       <li><a href="chlnfrwdng.aspx">Challan Forwarding </a></li>
                       <li><a href="frnscexmnrepo.aspx">Forensic Examination Report </a></li>
                       <li><a href="prdctnrepo.aspx">Production report before wildlife warden </a></li>--%>
                    
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
          
                   <!-- <li class="sub-menu">
                      <a href="./court-case-status.html"><i class="fa fa-fort-awesome" aria-hidden="true"></i><span>Court Case Status</span></a>
          
                    </li>--> 
          
          
          
                    <li class="sub-menu">
                      <a href="index.aspx"><i class="fa fa-sign-out" aria-hidden="true"></i><span>
                        Logout</span></a>
          
                    </li>
          
          
          
                </ul>
              </div>
            </aside>



  



	<!-- CONTENT -->


	<section id="content">

		<nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>


<h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>



		<main>

             <div class="container">
             <div class="row "style="margin-top: 70px;margin-bottom:3px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">

            <h2 class="text-center" style="color: #fff;">Investigation of Forest Offences</h2>
                        <div class="login-form">
            
                          <div class="row asd d-flex">

                               
            
                            <div class="col-lg-12 col-sm-6 col-xs-6 text-center pb-4">
       <h6>Choose Offence</h6>
         <select id="slctgnrl" class="form-control">
            <option value="">Select an option</option>
            <option value="Procedures">A. General Investigation Procedures</option>
            <option value="Seized">B. Detailed Procedures for Seized Vehicle</option>
        </select>
    </div>
            
                          </div>
                        </div>
                      </div>
                    </div>
                </div>
            
    <div id="Procedures" class="container section">
        <div class="row">
            <div class="col-md-10 col-12 mx-auto offset-md-1">
                <h3 class="text-center" style="color:#fff; margin-top: 40px;">A. General Investigation Procedures</h3>
                <div class="login-form">
                    <div class="row asd d-flex pt-4">
                <!-- Content for General Investigation Procedures section goes here -->

                <div>
            <h6>1. Verification of Forest Status:</h6>
            <p>
                <input type="checkbox" name="Forest" value="Forest">
                <label>Has the relevant Reserve Forest or Forest block notification been included?</label>
            </p>

            <p>
                <input type="checkbox" name="verified" value="verified">
                <label>Is the area of the Offence verified as per the forest block notification?</label>
            </p>

            <label>Remarks</label>
            <input type="text" id="txtrm" class="form-control">
        </div>

        <div>
            <h6>2.Seized Material Verification:</h6>

            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Is the seized material verified as per the definitions under Section 2 of The Orissa forest act, 1972?</label>
            </p>

            <p>
                <input type="checkbox" name="quantities" value="quantities">
                <label>Are the types and quantities of forest produce recorded?</label>
            </p>

            <p>
                <input type="checkbox" name="inspection" value="inspection">
                <label>Is inspection Report attached to the forwarding report and report identification number is mentioned?</label>
            </p>

            <label>Remarks</label>
            <input type="text" id="txtrmk" class="form-control">
        </div>
        <div>
            <h6>3. Forensic Examination:</h6>
              <label>Lab Analysis:</label>

            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Have samples from the vehicle (such as timber or other materials(may include wildlife)) been sent to a forensic lab?</label>
            </p>

            <p>
                <input type="checkbox" name="quantities" value="quantities">
                <label>Is the forensic report attached?</label>
            </p>

            <label>Remarks</label>
            <input type="text" id="txtrrm" class="form-control">
        </div>

        <div>
            <h6>4. Documentation and Legal Compliance:</h6>
              <h6>Section 56 of THE ORISSA FOREST ACT, 1972:</h6>

            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Has the seizure been conducted in accordance with Section 56?</label>
            </p>

            <p>
                <input type="checkbox" name="quantities" value="quantities">
                <label>Are the proper seizure forms filled out and signed?</label>
            </p>

            <label>Remarks</label>
            <input type="text" class="form-control">

            <h6 style="color:#000;">Section 77 of THE ORISSA FOREST ACT, 1972</h6>
            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Have the procedures for confiscation under Section 77 been followed?</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Are the necessary legal documents for confiscation attached to the final PR and forwarding report?</label>
            </p>
            <label>Remarks</label>
            <input type="text" class="form-control">
        </div>

         <div>
            <h6>5. Geographical Verification:</h6>
              <label>E-parivan Map Verification:</label>

            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Has the E-parivan map been verified?</label>
            </p>

            <p>
                <input type="checkbox" name="quantities" value="quantities">
                <label>Is the location of the Offence accurately marked and documented on the map?</label>
            </p>

            <label>Remarks</label>
            <input type="text" class="form-control">
           
        </div>
        <div>
             <h6>6. Independent Witnesses:</h6>
            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Have statements from independent witnesses been obtained regarding the seizure?</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Are these statements documented and attached to the final PR and forwarding report?</label>
            </p>
            <label>Remarks</label>
            <input type="text" class="form-control">
        </div>
        <div>
             <h6>7. Photographic Evidence:</h6>
            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Have photographs of the Offence site and seized materials been taken?</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Are these photographs attached to the investigation report?</label>
            </p>
            <label>Remarks</label>
            <input type="text" class="form-control">
        </div>
        <div>
             <h6>8. Call details record </h6>
            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Has the cdr analysis checked to connect all the accused with each other</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Has65b certificate has been produced</label>
            </p>
            <label>Remarks</label>
            <input type="text" class="form-control">
        </div>
        <div>
             <h6>9. Facts from Confession  </h6>
            <h6>Has the following facts have been discovered from the Confession </h6>
            <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Scene of crime</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Weapon used to commit the crime</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Whether fir has been lodged in localps under arms act,1959</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Any other incriminating evidence related to the case</label>
            </p>
             <p>
                <input type="checkbox" name="Material" value="Material">
                <label>Downward link and upward link has been established from.the Confession statement </label>
            </p>
            <label>Remarks</label>
            <input type="text" class="form-control mb-3">
        </div>
            </div>
        </div>
    </div>
 </div>
    </div>
    <div id="Seized" class="container section">
       
        <div class="row">
            <div class="col-md-10 col-12 mx-auto offset-md-1">
                <h3 class="text-center" style="color:#fff; margin-top: 40px;">B. Detailed Procedures for Seized Vehicle</h3>
                <div class="login-form">
                    <div class="row asd d-flex pt-4">
                        <!-- Content for Detailed Procedures for Seized Vehicle section goes here -->
                        
                        <div>
<h6>1. Seizure Report:</h6>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Is the vehicle seizure report filled out and attached?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are the details of the vehicle (make, model, registration numberetc) recorded?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Is vehicle involved in Offence commission</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>2. Ownership Verification:</h6>


<p>
<input type="checkbox" name="Material" value="Material">
<label>Have the ownership details of the vehicle been verified through the RTO?</label>
</p>

<p>
<input type="checkbox" name="quantities" value="quantities">
<label>Is a copy of the vehicle registration certificate attached?</label>
</p>

<label>Remarks</label>
<input type="text" class="form-control">

</div>
<div>
<h6>3. Vehicle Inspection:</h6>


<p>
<input type="checkbox" name="Material" value="Material">
<label>Has the vehicle been inspected for any hidden compartments or modifications?</label>
</p>

<p>
<input type="checkbox" name="quantities" value="quantities">
<label>Is a detailed inspection report included in Forwarding Report</label>
</p>

<label>Remarks</label>
<input type="text" class="form-control">
<h6>Inventory of Contents:</h6>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Is  inventory of the contents of the vehicle documented?</label>
</p>

<p>
<input type="checkbox" name="quantities" value="quantities">
<label>Are all items found in the vehicle listed and described?</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>4. Driver and Owner Details</h6>
<h6>a)Identity Verification:</h6>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Have the driver and owner’s identities been verified?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>copies of the driver’s license and identity documents attached?</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>5. Transport Documentation:</h6>
<label>Transport Permits:</label>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are any transport permits or related documents verified?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are copies of these permits attached?</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>6. Independent Witnesses:</h6>
<label>Transport Permits:</label>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Have statements from witnesses present during the vehicle seizure been recorded?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are these statements included in the report? </label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>7. Photographic Evidence:</h6>

<p>
<input type="checkbox" name="Material" value="Material">
<label>Have photographs of the vehicle, including license plate, contents, and any modifications, been taken?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are these photographs attached to the case file?</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>8. Legal Documentation:</h6>
<label>Compliance with Legal Procedures:</label>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are all legal documents related to the vehicle seizure and inspection properly filled and signed?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Is compliance with relevant motor vehicle and forest laws ensured?</label>
</p>
<label>Remarks</label>
<input type="text" class="form-control">
</div>
<div>
<h6>9.Release Procedures (Section 57 of Orissa Forest act. 1972)</h6>
<label>Compliance with Legal Procedures:</label>
<p>
<input type="checkbox" name="Material" value="Material">
<label>If the vehicle is to be released, have all legal procedures been followed?</label>
</p>
<p>
<input type="checkbox" name="Material" value="Material">
<label>Are release orders and compliance documents included?</label>
</p>
<label>Remarks</label>
<input type="text" id="txtrmrk" class="form-control mb-3">
</div>

                    </div>
                </div>
            </div>
        </div>
    </div>

         
         


            
         

             <div class="row " style="margin-top:-10px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
            
                         
                          <div class="col-lg-12 col-sm-12 col-xs-12 w-100 text-center mb-3">
    <button class="btnx mt-4" type="button" onclick="sub()" style="display: block; margin: 0 auto; text-align: center;">Submit</button>
</div>
                          
                       
                          </div>
                        </div>
            
                      </div>
             </div>


		</main>

	</section>






    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
        integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script src="js/script.js"></script>



<script>
    $(document).ready(function () {
        // Target all submenu anchors
        $("#leftside-navigation .sub-menu > a").click(function (e) {
            // Slide up all submenus except the one associated with the clicked anchor tag
            $(this).parent().siblings().find("ul").slideUp();

            // Slide down or toggle the visibility of the submenu associated with the clicked anchor tag
            $(this).next("ul").slideToggle();

            // Prevent event propagation
            e.stopPropagation();
        });
    });
</script>



<script>
    $(document).ready(function () {
        $('#options').change(function () {
            var selectedValue = $(this).val();
            $('.section').hide();
            if (selectedValue) {
                $('#' + selectedValue).show();
            }
        });
    });
</script>




</form>

</body>
</html>

