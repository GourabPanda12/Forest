﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="act.aspx.cs" Inherits="act" %>



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

       <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<title>Acts And Rules</title>

    <script type="text/javascript">
        $(document).ready(function () {


        });

        function sub() {
            var description = $("#txttlx").val();

            // Show loading indicator
            $(".loading").show();

            $.ajax({
                type: "POST",
                url: "act.aspx/Insert",
                data: JSON.stringify({
                    description: description,
                    pic: $("#hiden123").val(),
                    path: $("#hidden123").val()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessrrd,
                error: function (response) {
                    // Improved error logging
                    console.error("Error: ", response);
                    alert("Error: " + response.responseText);
                }
            });

            function OnSuccessrrd(response) {
                // Reset form fields
                $(".file-upload-image").attr("src", "");
                $("#hiden123").val('');
                $("#hidden123").val('');
                $(".loading").hide();

                alert("You have submitted the judgement with the respective case number successfully!");
                // Optionally reload the page
                // window.location.reload(); 
            }
        }


    </script>

  <style>

    .form-input input {
        width: 90%!important;
        box-sizing: border-box!important;
        border-bottom-left-radius: 2px!important;
        border-top-left-radius: 2px!important;
        background-color: #ffffff!important;
        box-shadow: 1px 2px 4px 0 rgba(0, 0, 0, 0.08)!important;
        padding: 11px 28px!important;
        border: 1px solid #b6c3cd!important;
        border-right: 0!important;
        color: #4E565C!important;
        outline: none!important;
        -webkit-appearance: none!important;
          margin-left: 15px;

    }

    
    
    .form-input button {
        border-bottom-right-radius: 2px!important;
        border-top-right-radius: 2px!important;
        background-color: #02b01c!important;
        box-shadow: 1px 2px 4px 0 rgba(0, 0, 0, 0.08)!important;
        color: #ffffff!important;
        padding: 11px 28px!important;
        margin-left: -4px!important;
        cursor: pointer!important;
        border: none!important;
        outline: none!important;
        font-size: 17px;

      }

    
    @media(max-width:480px){

      .form-input input {
        width: 75% !important;
        box-sizing: border-box !important;
        border-bottom-left-radius: 2px !important;
        border-top-left-radius: 2px !important;
        background-color: #ffffff !important;
        box-shadow: 1px 2px 4px 0 rgba(0, 0, 0, 0.08)!important;
        padding: 11px 28px!important;
        border: 1px solid #b6c3cd !important;
        border-right: 0 !important;
        color: #4E565C !important;
        outline: none !important;
        -webkit-appearance: none !important;
    
        margin-left: 7px;
    }
    }
    
    
      </style>





</head>
<body>
     <form id="form1" runat="server">
<input type="hidden" value="" id="hiden123" runat="server" /> <input type="hidden" value="" runat="server" id="hidden123"  />
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
              <a href="grievance.aspx"><i class="fa fa-rocket" aria-hidden="true"></i><span>Offence Information</span></a>
    
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
                <
    
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
         <!-- NAVBAR
			<form action="#">
				<div class="form-input">
					<input type="search" placeholder="Search...">
					<button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
				</div>
			</form>
			<input type="checkbox" id="switch-mode" hidden>
			<label for="switch-mode" class="switch-mode"></label>
			<a href="#" class="notification">
				<i class='bx bxs-bell' ></i>
				<span class="num">8</span>
			</a>
			<a href="#" class="profile">
				<img src="img/people.png">
			</a>
             -->
		</nav>


    <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>









		<main>

         <div class="container" style="margin-top: 80px; margin-bottom:150px;">


          <form action="#">
            <div class="form-input" style="margin-bottom: 50px;">
              <input type="search" placeholder="Search...">
              <button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
            </div>
          </form>






                <div class="flx">
            <a href="images/Forest (Conservation) Amendment Rules, 2004_0.pdf" class="button1">Forest (Conservation) Amendment Rules, 2004_0
</a>
            <a href="images/Forest (Conservation) Amendment Rules, 2014.pdf" class="button1">Forest (Conservation) Amendment Rules, 2014
</a>
            <a href="images/Forest (Conservation) Amendment Rules, 2017.pdf" class="button1">Microsoft Word - 1261GI
</a>
            <a href="images/Forest (Conservation) Second Amendment Rules, 2014.pdf" class="button1">Forest (Conservation) Second Amendment Rules, 2014
</a>
            
            <a href="images/Forest conservation act amendment 1988.pdf" class="button1">Forest conservation act amendment 1988
</a>
            <a href="images/Forest conservation act_0.pdf" class="button1">Forest conservation act_0
</a>
            <a href="images/Forest conservation Rules 2003_0.pdf" class="button1">Forest Conservation Rules 2003
</a>
            <a href="images/Forest Rights Act.pdf" class="button1">Forest Rights Act
</a>
            
            <a href="images/The Orissa Forest (Amendment) Act, 1982.pdf" class="button1">The Orissa Forest (Amendment) Act, 1982
</a>
            <a href="images/The Orissa Forest (Amendment) Act, 2000..pdf" class="button1">The Orissa Forest (Amendment) Act, 2000
</a>
            <a href="images/The Orissa Forest (Detection, Enquiry and Disposal of Forest Offence) Rules, 1980.pdf" class="button1">The Orissa Forest (Detection, Enquiry and Disposal
of Forest Offence) Rules, 1980</a>
            <a href="images/HANDBOOK_GUIDELINES FOrest Act and Forest Rules.pdf" class="button1">Handbook-Guidelines Forest Act and Forest Rules</a>


            <a href="images/The Elephants Preservation Act, 1879.pdf" class="button1">The Elephants Preservation
</a>
            <a href="images/the_orissa_forest_act_1972.pdf" class="button1">The Orissa Forest Act 1972
</a>
            <a href="images/Corrigendum to the Forest(Conservation) Amendment Rules, 2004_0.pdf" class="button1">Corrigendum to the Forest (Conservation) Amendment Rules, 2004_0
</a>
            <a href="images/Orissa Forest Contract Rules 1966.pdf" class="button1">IELRC.ORG - The Orissa Forest Contract Rules, 1966
</a>

<a href="images/Corrigendum to the Forest(Conservation) Amendment Rules, 2004_0.pdf" class="button1">Corrigendum to the Forest(Conservation) Amendment Rules, 2004_0
</a>
  
        <a href="images/The Wild Birds & Animals Protection Act, 1912.pdf" class="button1">The Wild Birds & Animals
</a>
        <a href="images/The Orissa Forest Saw Pits and Saw Mills (Control) Rules, 1980.pdf" class="button1">The Orissa Forest Saw Pits and Saw Mills (Control) Rules, 1980
</a>
        <a href="images/The Orissa Forest Fire Protection Rules, 1979.pdf" class="button1">The Orissa Forest Fire Protection Rules, 1979
</a>
        <a href="images/The Orissa Kendu Leaves (Control of Trade) Rules, 1962.pdf" class="button1">1The Orissa Kendu Leaves (Control of Trade) Rules 1962
</a>


        <a href="images/The Wild Life (Transactions and Taxidermy) Rules, 1974.pdf" class="button1">*The Wild Life (Transactions and Taxidermy) Rules, 1974
</a>

  <a href="images/The Wild Birds & Animals Protection Act, 1912.pdf" class="button1">The Wild Birds & Animals
</a>


        <a href="images/The Orissa Kendu Leaves (Control of Trade) Act, 1961.pdf" class="button1">The Orissa Kendu Leaves (Control of Trade) Act, 1961
</a>
        <a href="images/HANDBOOK_GUIDELINES FOrest Act and Forest Rules.pdf" class="button1">Handbook_guidelines Forest Act and Forest Rules
</a>

        
        <a href="images/The Elephants Preservation Act, 1879.pdf" class="button1">The Elephants Preservation
</a>
        <a href="images/the_orissa_forest_act_1972.pdf" class="button1">The Orissa Forest Act 1972
</a>
        <a href="images/Corrigendum to the Forest(Conservation) Amendment Rules, 2004_0.pdf" class="button1">Corrigendum to the Forest(Conservation) Amendment Rules, 2004_0
</a>
        <a href="images/Orissa Forest Contract Rules 1966.pdf" class="button1">IELRC.ORG - The Orissa Forest Contract Rules, 1966
</a>
        <a href="images/Orissa Forest Contract Rules 1966.pdf" class="button1">IELRC.ORG - The Orissa Forest Contract Rules, 1966
</a>

            </div>
            
            </div>
            




            <div class="row " style="margin-top:50px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
            
                                           <div class="col-md-12">
    <label for="refNumber">Title / Description</label>
    <input type="text" class="form-control form-control-custom" id="txttlx" placeholder="">
</div>
                               
                               <div class="col-lg-6  col-sm-6 col-xs-6 abc">

     <label class="lebl" style="color:#228B22;">Manually Upload File</label>

      <img class="file-upload-image" src="#" alt="your image" />
      <input id="txtmupld" type="file" onchange="readURL(this);" accept="image/*">

     
     <script type="text/javascript" id="rendered-js">
         function readURL(input) {
             if (input.files && input.files[0]) {
                 //alert($('.file-upload-input').val());
                 var reader = new FileReader();

                 reader.onload = function (e) {
                     //  $('.image-upload-wrap').show();
                     //  $('.file-upload-content').show();
                     $('.file-upload-image').attr('src', e.target.result);
                     document.getElementById('hiden123').value = e.target.result;
                     document.getElementById('hidden123').value = input.files[0].name;


                     // $('.image-title').html(input.files[0].name);
                 };

                 reader.readAsDataURL(input.files[0]);

             } else {
                 removeUpload();
             }
         }

         function removeUpload() {
             //   $('.file-upload-input').replaceWith($('.file-upload-input').clone());
             //   $('.file-upload-content').hide();
             //$('.image-upload-wrap').show();
         }
         //$('.image-upload-wrap1').bind('dragover', function () {
         // //   $('.image-upload-wrap1').addClass('image-dropping');
         //});
         //$('.image-upload-wrap1').bind('dragleave', function () {
         //  //  $('.image-upload-wrap1').removeClass('image-dropping');
         //});


     </script>
            
 </div>

                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                            
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                          
                          

                         
   
            
                          </div>
                        </div>
            
                      </div>
                    </div>


		</main>

	</section>




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



