﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="petition.aspx.cs" Inherits="petition" %>


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

	<title>Compounding Petition</title>

    <script>
        $(document).ready(function () {
            $(".add1").click(function () {
                var signature = $("#txtfle")[0].files[0];
                var address = $("#txtadrsac").val();
                var date = $("#txtdtac").val();

                if (!signature || !address || !date) {
                   // alert("Please fill in all fields.");
                    return;
                }

                // Check if the file name already exists
                var fileName = signature ? signature.name : '';
                var exists = $("#acsData").find(".address-span:contains('Address: " + address + "'), .date-span:contains('Date: " + date + "'), .preview[src='img/" + fileName + "']").length > 0;

                if (!exists) {
                    // Display preview of the image
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var preview = $("<img>").attr("src", e.target.result).addClass("preview");
                        var dataContainer = $("<div>").addClass("data-container");
                        var addressSpan = $("<span>").addClass("address-span").text("Address: " + address);
                        var dateSpan = $("<span>").addClass("date-span").text("Date: " + date);
                        var closeButton = $("<span>").addClass("closeBtn").text("x");

                        dataContainer.append(preview, "&nbsp;", addressSpan, "&nbsp;", dateSpan, closeButton);
                        $("#acsData").append(dataContainer);

                        // Clear input fields and reset file input
                        $("#txtadrsac, #txtdtac").val("");
                        $("#txtfle").val("");
                        $(".preview").empty();
                    };
                    reader.readAsDataURL(signature);
                } else {
                    // Alert the user about the duplicate value
                    alert("Duplicate data! This data is already listed.");
                }


                // Event listener for the close button
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });


            });

            $(".add2").click(function () {
                var signature = $("#txtsignw")[0].files[0];
                var address = $("#txtadrsw").val();
                var date = $("#txtdtw").val();

                if (!signature || !address || !date) {
                    // alert("Please fill in all fields.");
                    return;
                }

                // Check if the file name already exists
                var fileName = signature ? signature.name : '';
                var exists = $("#wtnsData").find(".address-span:contains('Address: " + address + "'), .date-span:contains('Date: " + date + "'), .preview[src='img/" + fileName + "']").length > 0;

                if (!exists) {
                    // Display preview of the image
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var preview = $("<img>").attr("src", e.target.result).addClass("preview");
                        var dataContainer = $("<div>").addClass("data-container");
                        var addressSpan = $("<span>").addClass("address-span").text("Address: " + address);
                        var dateSpan = $("<span>").addClass("date-span").text("Date: " + date);
                        var closeButton = $("<span>").addClass("closeBtn").text("x");

                        dataContainer.append(preview, "&nbsp;", addressSpan, "&nbsp;", dateSpan, closeButton);
                        $("#wtnsData").append(dataContainer);

                        // Clear input fields and reset file input
                        $("#txtadrsw, #txtdtw").val("");
                        $("#txtsignw").val("");
                        $(".preview").empty();
                    };
                    reader.readAsDataURL(signature);
                } else {
                    // Alert the user about the duplicate value
                    alert("Duplicate data! This data is already listed.");
                }


                // Event listener for the close button
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });


            });

           
        });
       


        //submit code 

        function sub() {


            // Get form input values
            var division = $("#txtdvsn").val();
            var nmof = $("#txtnm").val();
            var sonof = $("#txtsn").val();
            var resdof = $("#txtrsd").val();
            var po = $("#txtpo").val();
            var dist = $("#txtdist").val();
            var acsdnm = $("#txtacsnm").val();
            var fnm = $("#txtfnm").val();
            var pmntadr = $("#txtpadrs").val();
            var tempadr = $("#txttadrs").val();
            var prtclrofnc = $("#txtofnc").val();
            var iprpty = $("#txtiprty").val();
            var adrsac = $("#txtadrsac").val();
            var dateac = $("#txtdtac").val();
            var adrsw = $("#txtadrwt").val();
            var datew = $("#txtdtw").val();
            var ofcrnm = $("#txtofnm").val();
            var ofcrdsg = $("#txtdesign").val();
            var officerlist = [];
            // Create and push user object to users array
            officerlist.push({
                division: division,
                nmof: nmof,
                sonof: sonof,
                resdof: resdof,
                po: po,
                dist: dist,
                acsdnm: acsdnm,
                fnm: fnm,
                pmntadr: pmntadr,
                tempadr: tempadr,
                prtclrofnc: prtclrofnc,
                iprpty: iprpty,
                adrsac: adrsac,
                dateac: dateac,
                adrsw: adrsw,
                datew: datew,
                ofcrnm: ofcrnm,
                ofcrdsg: ofcrdsg

            });


            $.ajax({
                type: "POST",
                url: "petition.aspx/Insert",
                data: "{officerlist:" + JSON.stringify(officerlist) + "}",
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

        //code for refresh
        function refreshPage() {
            location.reload();
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

/*ne css*/
 .data-container {
    border: 1px solid black;
    padding: 10px;
    margin-bottom: 10px;
    color: #000;
    position: relative;
  }
  .preview {
    max-width: 100px;
    max-height: 100px;
    margin-bottom: 5px;
    padding-right: 10px;
    display: inline-block;
    vertical-align: top;
  }
 
  .closeBtn {
    position: absolute;
    top: 5px;
    right: 5px;
    cursor: pointer;
    color: red;
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
                    <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                        <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                             <div class="text-center">
                                <p id="heading1"></p>
                              <h2 id="heading">FOREST DEPARTMENT, ODISHA</h2>
                              <p id="heading1">FORM (IV)
                                [VIDE RULE 4]
                             </p>
                              <p id="heading1">
        
                                COMPOUNDING PETITION
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
                                                    <div class="col-lg-12  col-sm-12 col-xs-12 abc1">
        
                                            <p class="to">To</p>
                        <p class="to1">   The Divisional Forest Officer</p>



                        <p class="to3"><input type="text" id="txtdvsn" class="inp">Division</p>
                                                     <p class="to3"> (Through the range Officer (Range)</p>
                                                     <p class="to3">   I <input type="text" id="txtnm" class="inp"> son of <input type="text" id="txtsn" class="inp">resident of<input   type="text" id="txtrsd" class="inp">
                                                     P.O<input type="text" id="txtpo" class="inp">Dist<input type="text"  id="txtdist" class="inp">having committed the Forest Offence
                                                     (s) hereby undertake of my own free will to pay compensation under Section 73 of
                                                     the Orissa Forest Act, 1972, as may be assessed by the competent authority.</p>
                                                     <p class="to3"> 2. Should I fail to pay the amount of compensation imposed the same
                                                     may be recovered, as if it were an arrear of land revenue as provided under Section 87
                                                     of the Orissa Forest Act, 1972.</p>
                                                     <p class="to3"> 3. I also clearly understand that compounding of the Offence by the
                                                     competent authority under the rules is discretionary and my willingness to pay
                                                     compensation or payment made under Rule 5, in anticipation of compounding order,
                                                     does not prevent the competent authority to decide a different course of action.</p>





                                                     <h5 class="heading1" style="color: #000; text-align: center;letter-spacing: 2px;margin-bottom: 17px;">Particulars</h5>

                                                     <div class="row">
                                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                                                      <label class="lebl">Name Of The Accused</label>
                                                       <input type="text" id="txtacsnm"  class="form-control console" placeholder="">
                                                      </div>

                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                    
                                                      <label class="lebl">Father’s Name</label>
                                                       <input type="text" id="txtfnm"  class="form-control console" placeholder="">
                                                      </div>
                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                                                      <label class="lebl">Permanent Address</label>
                                                       <input type="text" id="txtpadrs"  class="form-control console" placeholder="">
                                                      </div>
                                                    
                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                    
                                                      <label class="lebl">Temporary Address</label>
                                                       <input type="text" id="txttadrs"  class="form-control console" placeholder="">
                                                      </div>
                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                    
                                                      <label class="lebl">Particulars Of Offence </label>
                                                       <input type="text" id="txtofnc"  class="form-control console" placeholder="">
                                                      </div>
                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                    
                                                      <label class="lebl">Situation Of The Immovable Property </label>
                                                       <input type="text" id="txtiprty"  class="form-control console" placeholder="">
                                                      </div>
                                                    </div>

<!--
                            <p  class="to3">
                          1. Name of the accused <input type="text" id="txtacsnm" class="inp"></p>
                                                     <p  class="to3"> 2. Father’s Name <input type="text" id="txtfnm" class="inp"></p>
                                                     <p  class="to3"> 3. Permanent address <input type="text"  id="txtpadrs" class="inp"></p>
                                                     <p  class="to3"> 4. Temporary address <input type="text"  id="txttadrs" class="inp"></p>
                                                     <p  class="to3"> 5. Particulars of Offence <input type="text"  id="txtofnc"  class="inp"></p>
                                                     <p  class="to3"> 6. Situation of the immovable property and list of such property <input type="text" id="txtiprty" class="inp"></p>
                                                     <p  class="to3">

                                                      -->



<br><br>

<h5 class="heading1" style="color: #000; text-align: center;letter-spacing: 2px;margin-bottom: 20px;font-size: 17px;"> Signature Of The Accused</h5>


<div class="row mb-4">
  <div class="col-lg-4  col-sm-4 col-xs-4 abc">

  <label class="lebl">Signature Of Accused</label>
  <input type="file" id="txtfle" class="form-control console">
  </div>

  <div class="col-lg-4  col-sm-4 col-xs-4 abc">

    <label class="lebl">Address</label>
    <input type="text" id="txtadrsac" class="form-control console">
    </div>

    <div class="col-lg-4  col-sm-4 col-xs-4 abc">

      <label class="lebl">Date</label>
      <input id="txtdtac" type="date" class="form-control console">
      </div>

  </div>

  <p class="button-container">
    <button class="bt11 add1" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                   </p>
                                                             <div id="acsData"></div>


<h5 class="heading1" style="color: #000; text-align: center;letter-spacing: 2px;margin-bottom: 20px;font-size: 17px;"> Signature Of The Witness</h5>


<div class="row mb-4">
  <div class="col-lg-4  col-sm-4 col-xs-4 abc">

  <label class="lebl">Signature Of Witness</label>
  <input type="file" id="txtsignw" class="form-control console">
  </div>

  <div class="col-lg-4  col-sm-4 col-xs-4 abc">

    <label class="lebl">Address</label>
    <input type="text" id="txtadrsw" class="form-control console">
    </div>

    <div class="col-lg-4  col-sm-4 col-xs-4 abc">

      <label class="lebl">Date</label>
      <input id="txtdtw" type="date" class="form-control console">
      </div>



  </div>


  <p class="button-container">
    <button class="bt11 add2" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                   </p>
                                                             <div id="wtnsData"></div>






<div class="row mt-2 mb-3">
  <div class="col-lg-6  col-sm-6 col-xs-6 " style="display:hidden;">
 </div>

  <div class="col-lg-6  col-sm-6 col-xs-6 ">

    <label class="lebl">Forest Range Officer</label>
    <input type="file" id="" class="form-control console">
    </div>


</div>

<div class="row mb-3">
  <div class="col-lg-6  col-sm-6 col-xs-6 " style="display:hidden;">
 </div>

  <div class="col-lg-6  col-sm-6 col-xs-6 ">

    <label class="lebl">Range</label>
    <input type="text" id="" class="form-control console">
    </div>


</div>



                                          <!--

                                                     Signature of witness (1)<input type="file" id="txtfle" class="inp"> Address <input type="text" id="txtadrsac" class="inp"> date
                                                      (2)<input id="txtdtac" type="date" class="inp"> Address <input type="text"  id="txtadrwt" class="inp">date<input type="date" class="inp" id="txtdtw"></p>
                                                      <p  class="to3">
                                                     Name <input type="text" id="txtofnm" class="inp">, designation <input type="text" id="txtdesign" class="inp"> and signature of the
                                                     Forest Officer receiving the petition</p>
-->


                                                                       </div>
                                                                        </div>
        
                                                                      </div>
                                                                     </div>
                                                                    </div>
                                        </div>



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
						   
                            <button class="btny mt-4" type="button" onclick="window.location.href='petitionpdf.aspx'">Download Pdf</button>
                              
                            </div>

            
            
                          </div>
                        </div>
            
                      </div>
                    </div>


              </fieldset>
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
