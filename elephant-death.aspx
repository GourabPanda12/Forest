<%@ Page Language="C#" AutoEventWireup="true" CodeFile="elephant-death.aspx.cs" Inherits="elephant_death" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ELEPHANT DEATH CASES</title>
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">


    <style>


        table {
            width: 100%;
            margin: auto;
            background-color: #fff;
        }

        table, th, td, tr {
            border: 1px solid #000;
            border-collapse: collapse;
            color: #06508d;
            font-size: 13px;
        }

        th, td {
            padding: 15px!important;
        }

        th{
            letter-spacing: 1px;
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
        

    <section id="content">

        <nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
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
                    <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                        <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
<h2 class="end">Elephant Death Cases  of BLACK TIGER, Sambalpur from 2000-01 to 2023-24</h2>



<div class="table-responsive">
    <table class="table table-bordered table-hover">

        <thead>
            <tr>
                <th>Sl No</th>
                <th>Year of detection</th>
                <th>Case reference
                    date of detection /
                    Case  No./ Range
                    </th>
                <th>Place</th>
                <th>Species of
                    Wildlife hunted/killed
                    </th>
                <th>Description
                    of wildlife/body
                     part recovered
                    </th>
                <th>Weapon/ 
                    tools used
                    </th>
                <th>Name ,age and address 
                    of  poachers/traders
                    </th>
                <th>Present status (PR Submitted or not)</th>
                </tr>
                </thead>

                <tbody>
                    <tr>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                        <td>6</td>
                        <td>7</td>
                        <td>8</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td>1</td>
                        <td>2000-01</td>
                        <td>Dt.3.1.2001
                            O.R. 545 of 
                            2000-01
                            of Sadar Range
                            </td>
                        <td>Kholbadi  having plot No.554 
                            of Sadar Range
                            </td>
                        <td>Elepahant maximus
                            Illegal hunting
                            </td>
                        <td>Elephant tusk -2pcs
                            Left& right left=weight=6.33kg
                            Right=5.900kg. 
                            deposited in the strong room,DTO,Sambalpur
                            </td>
                        <td>-</td>
                        <td>1. Jagadish pradhan,S/O L.choudhuri Vill-Gargadbahal
                            P.S- Jujumura
                            Dist-SBP
                            </td>
                        <td></td>
                    </tr>


                    <tr>
                        <td>2</td>
                        <td>2001-02</td>
                        <td>1.11.2001
                            O.R.No.478 of 2001-02
                            Of Sadar Range
                            </td>
                        <td>Near Mundher-RF of Sadar Range

                        </td>
                        <td>Elephas maximus
                            Illegal hunting
                            </td>
                        <td>Elephant tusks
                            (Left& Right)
                            14.100kg, 
                            deposited in the Strong room,DTO,Sambalpur
                            </td>
                        <td>-</td>
                        <td>1.Bisikesan Mirdha
                            2.Maheswar Mirdha
                            3.Surendra Mirdha
                            4.Asadie Mirdha
                            At- Maitkhai P.S- Dhama ,
                            Dist-SBP
                            </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td>3</td>
                        <td>
                            2002-03
                            </td>
                        <td>17.12.2002
                            O.R.No.588 of Sadar Range
                            </td>
                        <td>Near Burda
                            Village adjoining Football ground
                            </td>
                        <td>Elephant
                            ( Elephas maximus)
                            (Electrocution)
                            </td>
                        <td>One dead Tusker having 2Nos Tusks
                            Wight=32.800kg
                            S.P.has been deposited in the strong room
                            DTO,Sambalpur
                            </td>
                        <td>-</td>
                        <td>1. M.S. Munda J.E.(Elct.
                            2. R.N. Badhei
                            3. P.K. Pradhan
                            E.E. Wesco,Sambalpur
                            </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>
                            2003-04
                            </td>
                        <td>24.3.2004
                            O.R. No.307 of 2003-04
                            Dhama Range
                            </td>
                        <td>Inside Tabloi
                            Deogaon-RF in Lembukhulia
                            </td>
                        <td>Elephant
                            (Elephas maximus)
                            Illegal hunting
                            </td>
                        <td>Dead male elephant
                            With tusk=2Nos 
                            (30.400Kg.)S.P
                            has been deposited in the strong room
                            DTO,Sambalpur
                            </td>
                        <td>-</td>
                        <td>1. Babulal Pradhan
                            S/O Krushna
                            2. Lingaraj Pradhan
                            S/O Bishi
                            3. LachhamanBagarty
                            S/O Shyamsundar
                            4. Dhanpati Kumbhar
                            </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>2007-08</td>
                        <td>17.11.2007
                            O.R.No.89 of Padiabahal
                             Range
                            </td>
                        <td>Inside
                            Chhamunda-RF
                            </td>
                        <td>Elephant
                            (Elephas
                            Maximus)
                            Electrocution
                            </td>
                        <td>One dead wild Elephant male 
                            Right side tusk
                            Weight=5.920,
                            deposited in the Dist. Treasury,Sambalpur
                            </td>
                        <td>-</td>
                        <td>1.Iven Robert,S/O John
                            2.Golekh,S/O Akhe
                            3. Jalandhar Pradhan
                            S/O Shankar
                            4.Khulu SunaS/O Satrughan
                            5.Achuta Bhoi,S/O Purna
                            6.Iswar Bhoi,S/O Nrupa
                            7.Sec. Elect.Officer ,Hatibari
                            8. Pramod Mahanda
                            S/O Chhelia Villa-
                            Chhamunda P.S- Jujumura
                            Dist-Sambalpur
                            </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>
                            2009-10
                            </td>
                        <td>26.11.2009
                            O.R..142 2009-10
                            Rengali Range
                            </td>
                        <td>
                            Sangramal-
                            Batemura-RF
                            </td>
                        <td>Elephant
                            (Elephas maximus)
                            Illegal hunting
                            </td>
                        <td>
                            Carcass of a tusker
                            Tusks could not be
                             recovered
                            </td>
                        <td>-</td>
                        <td>1. Naths S/O Age-40 years
                            Late Rasa Budha
                            </td>
                        <td>Not Submitted</td>
                    </tr>



                    <tr>
                        <td>7</td>
                        <td>2010-11</td>
                        <td>   11-09-2010
                            U.D.101
                            of 2010-11
                            SadarRange
                            </td>
                        <td>Sahajkhulia
                            Forest Area 
                            Barloi- village 
                            Basipada  Sec.KumbharBeat
                            </td>
                        <td>Elephant
                            (Elphas maximus
                            Illegal hunting
                            </td>
                        <td>Carcass of tusker
                            Tusks could not be recovered
                            </td>
                        <td>-</td>
                        <td>Not known</td>
                        <td>UD Case</td>
                    </tr>


                    <tr>
                        <td>8</td>
                        <td>2012-13</td>
                        <td>7.8.2012
                            U.D. No.8
                            2012-13 Dhama
                            Range
                            </td>
                        <td>Bhalugad TDRF
                            Dhama Range
                            </td>
                        <td>Elephant
                            (Elephas maximus)
                            Illegal hunting
                            </td>
                        <td>Tusk two Nos.
                            Left side=7.00 kgs
                            Right side=6.00 kg
                            Total=13.0kgs
                            deposited in the strong room,DTO,Sambalpur
                            </td>
                        <td>-</td>
                        <td>Not known</td>
                        <td>UD Case</td>
                        </tr>

                        <tr>
                            <td>9</td>
                            <td>2013-14</td>
                            <td>24.01.2014 O.R.156
                                2013-14
                                Dhama Range
                                </td>
                            <td>Near Ludhaguda TDRF</td>
                            <td>Carcass of Tusker tusks could not be recovered
                                Illegal  hunting
                                </td>
                            <td>Tusks could not be recovered.</td>
                            <td>One jeep with Ammunitions Mobile Hand Set-3 nos Arms license etc.</td>
                            <td>1.Bhagaban Singh 
                                Age-52 yearsS/o Suket At-Bazar Road, Ranchi House No.287 Jharkhand
                                Presently at Madbhati
                                Office,Dhanupali Sambalpur
                                2.Gupte Dharua,Age-58
                                Years,S/OJogi, At- Bamhanipali, Subarnpur
                                </td>
                            <td>Case handed over to Crime Branch.</td>
                            </tr>
                            <tr>
                                <td>10</td>
                                <td>2014-15</td>
                                <td>24.05.2014
                                    U.D. No.2 of 
                                          2014-15 of
                                          Sadar Range   
                                    </td>
                                <td>Dumerchuan
                                    Mundher-R.F
                                    </td>
                                <td>Elephant
                                    Elephas maximus
                                    </td>
                                <td>Tusk two Nos(2)
                                    Left side=2.550 kg
                                    Right side=2.600kg
                                    Total-5.150 kgs.
                                    S.P.has been deposited in the strong room
                                    DTO,Sambalpur
                                    </td>
                                <td>Nil</td>
                                <td>DROPPED(Natural death)
                                    U.D. No.2 of 
                                    2014-15 of
                                    Sadar Range   
                              </td>
                                <td>UD Case</td>
                                </tr>

                                <tr>
                                    <td>11</td>
                                    <td>2014-15</td>
                                    <td>25.07.2014
                                        O.R.No.25 
                                        2014-15 of Padiabahal Range
                                        </td>
                                    <td>Near Village Dudukakud of Kendrapat-RF</td>
                                    <td>Elephant 
                                        Elephas maximus
                                        Illegal hunting
                                        </td>
                                    <td>Carcass of tusker 
                                        tusks could not be recovered
                                        </td>
                                    <td>Slug(Metal piece) 1 no. CashRs.72,000/
                                        Mobile Set=1No. Country Gun=2 Nos. Axe= 1no. 
                                        & cash 72,000/-
                                        For trading
                                        Animals articles
                                        </td>
                                    <td>1.JogeshLugun,Age-35Yr. S/O Jagan Lugun
                                        2.Motilal Munda ,Age-25 years
                                        S/O Saharai Munda
                                        3. Bipin Kishore Barua,
                                        Age-41 years
                                        S/O Benedic Barua
                                        Vill- Kadalipal
                                        P.S- JamenkiraDist.Sambalpur
                                        </td>
                                    <td>Case handed over to Crime Branch.</td>
                                    </tr>

                                    <tr>
                                        <td>12</td>
                                        <td>2014-15</td>
                                        <td>1.08.2014
                                            O.R. 26 of 2014-15Padiabahal Range
                                            </td>
                                        <td>Near Village- Bhoipali of Kendrapat-RF</td>
                                        <td>Elephant
                                            (Elephas maximus
                                            Illegal hunting
                                            </td>
                                        <td>Carcass of tusker 
                                            tusks could not be recovered
                                            </td>
                                        <td>Slug( metal piece) 1 No. Axe= 2No.
                                            Blood Stained
                                            
                                            </td>
                                        <td>1.Dhaneswar Hara 
                                            S/O Ramesh Hara
                                            2. Ramesh Sanara,
                                            S/O Late Rabi samara
                                            3. Kishore Sanara 
                                            S/O Late Rabi Sanara
                                            Peon Hara S/O Ramesh
                                            Vill- Babupali P.O- Jhankarpali
                                            P.S-Jujumura, Dist- Sambalpur
                                            </td>
                                        <td>Case handed over to Crime Branch.</td>
                                        </tr>
                                        <tr>
                                            <td>13</td>
                                            <td>2016-17</td>
                                            <td>21.02.2017.
                                                OR. No.196
                                                of 2016-17
                                                of Sadar Range
                                                2(b)CC.01/2017
                                                </td>
                                            <td>Sai Dhaba Kansar Chowk
                                                of Jujumura
                                                of Sadar Range
                                                </td>
                                            <td>Elephant
                                                (Elephas maximus
                                                
                                                (2 nos. of Tusks)
                                                </td>
                                            <td>Deposited in Dist. Treasury,Sambalpur</td>
                                            <td>2 nos. of Elephant Tusks
                                                Left Tusk 
                                                = 6.113 kg.
                                                 Right Tusk 
                                                 = 6.207 kg.
                                                </td>
                                            <td>1. Sujit Tapan, Kansar
                                                2. Saul alias BhatangTapan,  Kansar
                                                3. Sudam Pradhan, Dangapal,
                                                 4. Dinesh Hara, 
                                                5. SalegramPradhan,  Beherenbasa
                                                6. Deepak Pradhan, Dangapal
                                                7. Kamil Surein, 
                                                Butuberna
                                                8. Om praksash Biswal, Dangalpal
                                                All are of P.S- Jujumura ,
                                                Dist. Sambalpur
                                                </td>
                                            <td></td>
                                            </tr>
                                            <tr>
                                                <td>14</td>
                                                <td>2017-18</td>
                                                <td>21.05.2017
                                                    UDC.02 of 2017-18 of Rengali Range.
                                                    </td>
                                                <td>Inside Mango orchard of Kishore Ch. Naik, Haldi village of Rengali Range</td>
                                                <td>Elephant
                                                    (Elephas maximus
                                                    </td>
                                                <td>Death due to
                                                    sunstroke
                                                   </td>
                                                <td>Tusks=2 nos.
                                                    Right Tusk 0.145kg,
                                                     Left tusk 0.150kg
                                                    </td>
                                                <td></td>
                                                <td>UD Case</td>
                                                </tr>

                                                <tr>
                                                    <td>15</td>
                                                    <td>2019-20</td>
                                                    <td>15.11.2019
                                                        U.D.Case No.21 of 2019-20 of Sadar Range
                                                        </td>
                                                    <td>Mahulpalipatra jungle of BirsinghgarhR.F.,Bhimkhoj Section of Sadar Range.</td>
                                                    <td>Elephant 
                                                        (Elephas maximus)
                                                        </td>
                                                    <td>Death of a juvenile male elephant  due to eletrocution</td>
                                                    <td>. Left tusk=150 gm.
                                                        Right tusk=200gm
                                                        </td>
                                                    <td></td>
                                                    <td>UD Case</td>
                                                    </tr>


                                                    <tr>
                                                        <td>16</td>
                                                        <td>2019-20</td>
                                                        <td>04.03.2020
                                                            U.D.Case No.25 of 2019-20 of Sadar Range 
                                                            </td>
                                                        <td>Near Ichhapal village under Basiapada-Birsinghgarh R.F. of Basiapada  Section of Sadar Range.</td>
                                                        <td>Elephant 
                                                            (Elephas maximus)
                                                            </td>
                                                        <td>Death of a male  elephant  due to  Septicaemia caused by multiple wounds </td>
                                                        <td>Both the tusks weighing 
                                                            6.850kg in total
                                                            Left tusk=3.500 kg.
                                                            Right tusk=3.350 kg.
                                                            2-one metal pc
                                                          3-one sharp wooden pc.

                                                            </td>
                                                        <td></td>
                                                        <td>Under Investigation</td>
                                                        </tr>

                                                        <tr>
                                                            <td>17</td>
                                                            <td>2020-21</td>
                                                            <td>12.08.2020
                                                                UD.01/OR.17 of 2020-21 of Dhama Range.
                                                                </td>
                                                            <td>Near Elbo village,TDRF, under Dhama Range</td>
                                                            <td>Elephant 
                                                                (Elephas maximus)
                                                                </td>
                                                            <td>Death of a juvenile male elephant  due to hypo volumic shock (cobbaldiaelephantis)</td>
                                                            <td>Carcass along with the tusks were buried.</td>
                                                            <td></td>
                                                            <td>UD Case</td>
                                                            </tr>

                                                            <tr>
                                                                <td>18</td>
                                                                <td>2020-21</td>
                                                                <td>30.11.2020
                                                                    UD. 07/0R 89 of 2020-21 of Sadar  Range
                                                                    </td>
                                                                <td>Village Jaduloising, 
                                                                    Jaduloising beat, Basiapada Section
                                                                    Sadar Range
                                                                    about 1.5 km. from Jaduloisingh – Gunjghar Reserved Forest
                                                                    </td>
                                                                <td>Elephant 
                                                                    (Elephas maximus)
                                                                    </td>
                                                                <td>Death of a male wild elephant  due to eletrocution</td>
                                                                <td>one stick of 1 mtr. and long bamboo handle with plastic tape
                                                                    Left tusk=1.5 kg.
                                                                    Right tusk=1.5 kg.
                                                                    </td>
                                                                <td>1-Baikuntha Mirdha,  S/o – Gopa Mirdha of village - Jaduloisingh, PS – Dhama,         Dist – Sambalpur 2- Nandalal Bhoi,        S/o – Upendra Bhoi village - Jaduloisingh, PS – Dhama,         Dist – Sambalpur &3-Dillip Bhoi,             S/o – Okil Bhoi  of village - Jaduloisingh, PS – Dhama,          Dist – Sambalpur</td>
                                                                <td>Not submitted</td>
                                                                </tr>

                                                                <tr>
                                                                    <td>19</td>
                                                                    <td>2020-21</td>
                                                                    <td>05.12.2020
                                                                        UD. 08 of 2020-21 of Sadar  Range
                                                                        </td>
                                                                    <td>on the railway track which is between Jujumura and Hatibari railway station</td>
                                                                    <td>Elephant 
                                                                        (Elephas maximus)
                                                                        </td>
                                                                    <td>Death of an adult male wild elephant  due to train accident</td>
                                                                    <td>Carcass was buried.
                                                                        Left tusk=2.250 kg.
                                                                        Right tusk=2.100 kg.
                                                                        </td>
                                                                    <td></td>
                                                                    <td>UD Case</td>
                                                                    </tr>



                                                                    <tr>
                                                                        <td>20</td>
                                                                        <td>2020-21</td>
                                                                        <td>21.12.2020
                                                                            UD. 10 of 2020-21 of Sadar  Range
                                                                            </td>
                                                                        <td>on the railway track which is between Maneswar and Hatibari railway station</td>
                                                                        <td>Elephant 
                                                                            (Elephas maximus)
                                                                            </td>
                                                                        <td>Death of an adult male wild elephant  due to train accident</td>
                                                                        <td>Carcass along with the tusks were buried.
                                                                            Left tusk=1.4 kg.
                                                                            Right tusk=1 kg.
                                                                            </td>
                                                                        <td></td>
                                                                        <td>UD Case</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>21</td>
                                                                            <td>2020-21</td>
                                                                            <td>21.01.2021
                                                                                UD. 12 of 2020-21 of Sadar  Range
                                                                                </td>
                                                                            <td>Near NH-55 side within open Jail boundary wall near KansarJharan,Jujumura DLC Forest under Sadar Range, BLACK TIGER</td>
                                                                            <td>Elephant 
                                                                                (Elephas maximus)
                                                                                </td>
                                                                            <td>Death of a female wild elephant  due to electrocution accidentally.</td>
                                                                            <td>Carcass  was buried.</td>
                                                                            <td></td>
                                                                            <td>UD Case</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>22</td>
                                                                                <td>2021-22</td>
                                                                                <td>09.11.2021
                                                                                    OR.94 of Sadar  Range
                                                                                    2(b)cc No. 9/2021
                                                                                    </td>
                                                                                <td>Inside  Amlipani village forest
                                                                                    Under Kayakud beat, Jujumura Sec of Sadar Range. R.F. of Sadar Range
                                                                                    </td>
                                                                                <td>Female Elephant 
                                                                                    (Elephas maximus)
                                                                                    </td>
                                                                                <td>hunting of a  female wild elephant by deliberate electrocution.</td>
                                                                                <td>Binding wire 
                                                                                    =610 m.
                                                                                    Bottle =50 nos.
                                                                                    Dry Bamboo stick=100 nos.
                                                                                    </td>
                                                                                <td>1-Cheru   Munda 
                                                                                    S/o Jenga Munda, 43 years 
                                                                                     2-BasudebDhurua, S/o – Driver Dharua , – 37 years
                                                                                     (3)  JugendraBhue, S/o – Late Krushna Bhue , 45 yrs.
                                                                                     (4) NilambaraBhue, S/o – Late KrushnaBhue ,50 Yrs .
                                                                                     (5)  Lambodar Bhue, S/o – Late AnandaBhue, 45  yrs.
                                                                                    All are of Amlipani village, 
                                                                                    PS – Jujomura, Dist – Sambalpur
                                                                                    6-Dibakara Bhoe, S/o – Late BhubanaBhoe , 49 years of Taljharan village, PS – Jujomura, Dist – Sambalpur 
                                                                                    (PR SUBMITTED)
                                                                                    </td>
                                                                                <td>(PR SUBMITTED)</td>
                                                                                </tr>


                                                                                <tr>
                                                                                    <td>23</td>
                                                                                    <td>2022-23</td>
                                                                                    <td>21.06.2022
                                                                                        U.D.02/OR.No.20 of 2022-23 of Padiabahal Range
                                                                                        </td>
                                                                                    <td>Near Saplahara Village Pond of Beat/Sec-Badsahir.
                                                                                        Range-Padiabahal
                                                                                        </td>
                                                                                    <td>Male wild elephant </td>
                                                                                    <td>Poaching (Septicemia due to bullet injury leading to multiple organs failure)
                                                                                        Elephant tusk -2pcs
                                                                                        Right tusk= 1.280 kg.
                                                                                        Left tusk= 1.360 kg.
                                                                                        </td>
                                                                                    <td>A iron bullet of size 10 cm length, 4.5 cm girth and 15mm dia with a bamboo stick of size 14cm length and 4.5 cm girth were recovered from the right fore leg of the Elephant on 21st June, 2022.
                                                                                        one country made gun with an iron rod, blasting gel, mobile phone, bow and arrow, axe, knife, GI wire and trapping nets were seized from the house of the accused person on 23rd June, 2022.
                                                                                        </td>
                                                                                    <td>1.Rajib Hembram, Age 35 years ,S/o – Ramsingh Hembram of Village Aanda Nagar, Kadalipal, Po- Kulundi,Ps- Jamankira, Dist- Sambalpur
                                                                                        2.Lalu Hara, Aged 50 years, of Village.SitlenpaliPo.JhankarpaliPs.JujumuraDist.Sambalpur (He has been absconding since 22nd June, 2022)
                                                                                        </td>
                                                                                    <td>(PR SUBMITTED)</td>
                                                                                    </tr>

                                                                                    <tr>
                                                                                        <td>24</td>
                                                                                        <td>2022-23</td>
                                                                                        <td>07.12.2022
                                                                                            UD.No.05 of 2022-23 of Padiabahal Range
                                                                                            </td>
                                                                                        <td>Near Tampargarh Village Forest near Dhalapal .
                                                                                            Beat.-Ladladi
                                                                                            Sec-Padaiabahal
                                                                                            Range- Padiabahal
                                                                                            </td>
                                                                                        <td>Female Elephant</td>
                                                                                        <td>Staff of Padiabahal Range detected the carcass of a female elephant on dt. 07.12.2022  nearDhalapalvillage.According to PM Report ,death might be due to respiratory distress & cardiac insufficiency arising out of intestinal torsion.</td>
                                                                                        <td>Carcass of a female elephant.</td>
                                                                                        <td>Natural Death</td>
                                                                                        <td>UD Case</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>25</td>
                                                                                            <td>2022-23</td>
                                                                                            <td>07.01.2023
                                                                                                OR 38 (converted from UD 12)of 2022-23 of Sadar Range
                                                                                                </td>
                                                                                            <td>Inside HatibariBandher RF, Near Raghudera Village. 
                                                                                                Beat-Hatibari
                                                                                                Sec-Bhimkhoj
                                                                                                Range-Sadar.
                                                                                                </td>
                                                                                            <td>Male Elephant</td>
                                                                                            <td>Death due to deliberate electrocution.</td>
                                                                                            <td>Carcass of a male elephant . tusk=2 nos.
                                                                                                G.I wire – 200 Meters.
                                                                                                Dry Bamboo Sticks under 2ft length – 38 nos.
                                                                                                Broken Bottle – 32 nos.
                                                                                                Mobile -1 no. (Model –mafe ATOM+)
                                                                                                </td>
                                                                                            <td>1-Prashanta Mirdha, S/o Nama Mirdha of Aged -29 Years of Khairmal village, PS- Jujomura, Dist- Sambalpur
                                                                                                2-Dillip Mirdhan, S/o-Goura Mirdha of Aged – 32 Years of Khairmal village, PS – Jujomura, Dist- Sambalpur.
                                                                                                3-Bideshi Mirdha, S/o- Sitaram Mirdha of Aged – 42 Years of Khairmal village, PS – Jujomura, Dist- Sambalpur 
                                                                                                </td>
                                                                                            <td>Not submitted</td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <td>26</td>
                                                                                                <td>2023-24</td>
                                                                                                <td>13.06.2023
                                                                                                    U.D.01 of 2023-24 of Sadar Range
                                                                                                    </td>
                                                                                                <td>Outside of Basiapada-Birsinghgarh RF, Near Basiapada Village ( near old crusher)
                                                                                                    Beat- Basiapada
                                                                                                    Sec- Basiapada Range-Sadar.
                                                                                                    </td>
                                                                                                <td>Male Elephant</td>
                                                                                                <td>Death due to disease.
                                                                                                    ( severe maggot infection in the lower mendable leading up to esophagus.)
                                                                                                    (Anthrax) 
                                                                                                    </td>
                                                                                                <td>Carcass of a male elephant .
                                                                                                    tusk=2 nos.(found intact)
                                                                                                    </td>
                                                                                                <td></td>
                                                                                                <td>UD Case</td>
                                                                                                </tr>


                </tbody>
</table>
</div>
</div>
                    </div>
                </div>
            </div>






            <div style="float: right; padding-top: 7px;" class="re">
                <p class="ppl">Divisional Forest Officer,</p>
                <p class="ppl" style="margin-top: -20px;">Sambalpur Forest  Division</p>
                </div>

     </main>




    </section>






    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
        integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>


    <script src="js/script.js"></script>


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