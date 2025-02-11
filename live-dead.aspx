<%@ Page Language="C#" AutoEventWireup="true" CodeFile="live-dead.aspx.cs" Inherits="live_dead" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>10.	LIVE AND DEAD STOCK</title>
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
            font-size: 14px;
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
<h2 class="end">LIVE AND DEAD  STOCK
    </h2>


    <div class="table-responsive">
        <table class="table table-bordered table-hover">

            <thead>
                <tr>
                    <th>Sl.
                        No
                        </th>
                    <th>Case No./Year/Range</th>
                    <th>Details of wild
                        Animal parts
                        </th>
                    <th>Quantity
                        ( in suitable 
                          Nos, Kgs etc.)
                        </th>
                    <th>Deposited in the Dist. Treasury,SBP vide L.No. and date</th>
                    <th>
                        Now in Possession of
                        </th>

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


                        </tr>

                        <tr>
                            <td>1</td>
                            <td>UD.71 of 2000-01 of Dhama Range.</td>
                            <td>Elephant
                                Tusks
                                </td>
                            <td>1nos= 0.450 kg</td>
                            <td>Receipt No.113 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>
                         </tr>

                         <tr>
                            <td>2</td>
                            <td>OR.533 of 2000-01 of Sadar Range.</td>
                            <td>Elephant
                                Tusks
                                </td>
                            <td>2 nos.=5.00kgs
                                Left =2.500 kg.
                                Right=2.500 kg
                                </td>
                            <td>Receipt No.113 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>


                        </tr>

                        <tr>
                            <td>3</td>
                            <td>OR.545 of 2000-01 of Sadar Range.</td>
                            <td>Elephant
                                Tusks
                                </td>
                            <td>2 nos.=12.200kgs
                                Left =6.300 kg.
                                Right=5.900 kg
                                </td>
                            <td>Receipt No.113 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>
                         </tr>

                        <tr>
                            <td>4</td>
                            <td>OR.478 of 2001-02 of Sadar Range.</td>
                            <td>Elephant
                                Tusks
                                </td>
                            <td>2 nos.=14.100 kgs.
                                Left =7.000 kg.
                                Right=7.100 kg
                                </td>
                            <td>Receipt No.113 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>


                        </tr>



                             <tr>
                            <td>5</td>
                            <td>UD.150 of 1999-2000 of Dhama Range.</td>
                            <td>
                                Elephant
Tusks
</td>
                            <td>
                                2 nos.= 3.800kgs
Left =1.900 kg.
Right=1.900 kg
</td>
                            <td>Receipt No.113 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>
                                Dist. Treasury,
Sambalpur
</td>


                        </tr>


                        <tr>
                            <td>6</td>
                            <td>OR.333 of 2001-02 of Rengali Range</td>
                            <td>
                                Elephant
Tusks
</td>
                            <td>
                                2nos=13.300kgs</td>
                            <td>Receipt No.114 dtd.15.03.2002 of DTO,Sbp.</td>
                            <td>
                                Dist. Treasury,
Sambalpur
</td>


                        </tr>

                        <tr>
                            <td>7</td>
                            <td>OR.588 of 2002-03 of Sadar Range</td>
                            <td>
                                Elephant
Tusks
</td>
                            <td>
                                2 nos.=32.800kgs
                                Left =20.000 kg.
                                Right=12.800 kg
                                 </td>
                            <td>Receipt No.104 dtd.11.02.2003 of DTO,Sbp.</td>
                            <td>
                                Dist. Treasury,
Sambalpur
</td>


                        </tr>


                        <tr>
                            <td>8</td>
                            <td>2003-04 of Dhama Range.</td>
                            <td>
                                Elephant
                                Tusks
                                 </td>
                            <td>
                                2 nos.=30.400kgs</td>
                            <td>Receipt No.96 dtd.11.01.2005 of DTO,Sbp.</td>
                            <td>
                                Dist. Treasury,
Sambalpur
</td>


                        </tr>

                        <tr>
                            <td>9</td>
                            <td>2004-05 of Sadar Range.</td>
                            <td>
                                Elephant
                                Tusks </td>
                            <td>
                                1 nos.8.00 kgs
</td>
                            <td>Receipt No.96 dtd.11.01.2005 of DTO,Sbp.</td>
                            <td>
                                Dist. Treasury,
                                Sambalpur
                                 </td>


                        </tr>

                        <tr>
                            <td>10</td>
                            <td>2005-06</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>1 nos.=3.200kgs</td>

                            <td>Receipt No.107 dtd.18.09.2007 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                 </td>



                        </tr>

                        <tr>
                            <td>11</td>
                            <td>OR. 89 of 2007-08 of Padiabahal Range </td>
                            <td> Elephant
                                Tusks
                                </td>

                            <td> 2 nos.=6.048 kgs.</td>

                            <td>Receipt No.74 dtd.05.05.2012 of DTO,Sbp.</td>
                            <td> Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>
                        <tr>
                            <td>12</td>
                            <td>UD. 08 of 2012-13 of Dhama Range.</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.=13.00kg.
                                Left =7.00 kg.
                                Right=6.00 kg
                                </td>

                            <td>Receipt No.91 dtd.04.09.2012 of DTO,Sbp.</td>
                            <td> Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>
                        <tr>
                            <td>13</td>
                            <td>UD. 02 of 2014-15 of Sadar Range</td>
                            <td> Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.=5.150kg
                                Left =2.550 kg.
                                Right=2.600 kg
                                </td>

                            <td>Receipt No.85 dtd.25.06.2015 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>
                        <tr>
                            <td>14</td>
                            <td>2015-16</td>
                            <td>Nil </td>

                            <td>Nil</td>

                            <td></td>
                            <td>Nil </td>



                        </tr>
                        <tr>
                            <td>15</td>
                            <td>OR.196 of 2016-17 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left =5.880kg.
                                Right=5.920 kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O.,Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>16</td>
                            <td>OR.196 of 2016-17 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.(sample)
                                Left=0.060kg.
                                Right=0.080 kg.
                                 </td>

                            <td>929 dtd.06.10.2023 of R.O.,Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>17</td>
                            <td>O.R.37 of 2017-18 U.D.No.2 of 2017-18 of Rengali Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left =0.150  kg.
                                Right=0.150  kg.
                                 </td>

                            <td>595 dtd.12.10.2023 of R.O.,Rengali.
                                Receipt No.356 dtd.04.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>18</td>
                            <td>2018-19</td>
                            <td>Nil</td>

                            <td>Nil </td>

                            <td></td>
                            <td>Nil</td>



                        </tr>



                        <tr>
                            <td>19</td>
                            <td>UD.21 of 2019-20 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left= 150 gm
                                Right= 200 gm
                                 </td>

                            <td>929 dtd.06.10.2023 of R.O.,Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>20</td>
                            <td>UD.21 of 2019-20 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left=3.500 kg.
                                Right= 3.350 kg.
                                 </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>21</td>
                            <td>UD.08 of 2020-21 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td> Qnty=2 Nos.
                                Left=2.250 kg.
                                Right= 2.100 kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>
                        <tr>
                            <td>22</td>
                            <td>UD.10 of 2020-21 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>
                            <td>Qnty=2 Nos.
                                Left=1.400 kg.
                                Right= 1.000 kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                 </td>


                            <td>Dist. Treasury,
                                Sambalpur.
                                </td>



                        </tr>

                        <tr>
                            <td>23</td>
                            <td>UD.07(OR.89) of 2020-21 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td> Qnty=2 Nos.
                                Left=1.500 kg.
                                Right= 1.500 kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.</td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>24</td>
                            <td>OR No. 20 of 2022-23 ( converted from UD.02/2022-23 ) of Padiabahal Range.</td>

                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left =1.360  kg.
                                Right=1.280  kg.
                                </td>
                            <td>538 dtd.15.12.2023 of R.O., Padiabahal.
                                Receipt No.387 dtd.15.12.2023 of DTO,Sbp.
                                </td>

                                <td>Dist. Treasury,
                                    Sambalpur
                                    </td>


                        </tr>

                        <tr>
                            <td>25</td>
                            <td>OR.38 of 2022-23 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left= 2.450 kg.
                                Right= 2.600  kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



                        </tr>

                        <tr>
                            <td>26</td>
                            <td>UD No.11 of 2022-23 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=01 No.
                                Weight=230 gm
                                </td>

                            <td>Not yet deposited.</td>
                            <td>R.O. Sadar Range</td>



                        </tr>

                        <tr>
                            <td>27</td>
                            <td>UD No.01 of 2023-24 of Sadar Range</td>
                            <td>Elephant
                                Tusks
                                </td>

                            <td>Qnty=2 Nos.
                                Left= 5.350 kg.
                                Right= 4.900  kg.
                                </td>

                            <td>929 dtd.06.10.2023 of R.O., Sadar.
                                Receipt No.357 dtd.06.10.2023 of DTO,Sbp.
                                </td>
                            <td>Dist. Treasury,
                                Sambalpur
                                </td>



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