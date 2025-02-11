<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Userroles.aspx.cs" Inherits="Userroles" %>


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

    <title>User Logs</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


 <script>

     $(document).ready(function () {


         // Modified sample data for checkboxes
         var sampleData = [
             { label: 'Dashboard', state: false },
             { label: 'Account', state: false },
             { label: 'Offence', state: false },
             { label: 'Lease & Miscellaneous', state: false },
             { label: 'Schelduled Forms', state: false },
             { label: 'Legal Cell', state: false },
             { label: 'Public Grievance', state: false },
             { label: 'Judgements', state: false },
             { label: 'Acts and Rules', state: false },
             { label: 'Logout', state: false }
         ];

         // Function to generate checkboxes
         function generateCheckboxes(data) {
             var checkboxesHtml = '';
             $.each(data, function (index, value) {
                 var checked = value.state ? 'checked' : '';
                 checkboxesHtml += '<input type="checkbox" id="checkbox_' + index + '" name="checkbox_' + index + '" ' + checked + '>';
                 checkboxesHtml += '<label for="checkbox_' + index + '">' + value.label + '</label>';
             });
             return checkboxesHtml;
         }

         // Show modal popup on button click
         $('#showModalBtn').click(function () {
             var checkboxesHtml = generateCheckboxes(sampleData);

           
             $('#checkboxContainer').html(checkboxesHtml);
             $('#checkboxContainer input[type="checkbox"]').each(function (index) {
                 if (index % 2 === 1) { // Check if the index is odd
                     $(this).next('label').addClass('alternate-background');
                 }
                 else {
                     $(this).next('label').addClass('even-background');
                 }
             });
             $('#myModal').css('display', 'block');

             
         });

         // Close modal when clicking on the close button
         $('.close').click(function () {
             $('#myModal').css('display', 'none');
         });

         $('#showModalBtnx').click(function () {
             $('#myModal').css('display', 'none');
         });

         // Close modal when clicking outside of it
         $(window).click(function (event) {
             if (event.target == $('#myModal')[0]) {
                 $('#myModal').css('display', 'none');
             }
         });
        
         // Handle checkbox state changes
         $('#checkboxContainer').on('change', 'input[type="checkbox"]', function () {
             var index = $(this).attr('id').split('_')[1];
             sampleData[index].state = $(this).is(':checked');
             console.log(sampleData);
         });

         $('#saveBtn').click(function () {
             console.log(JSON.stringify(sampleData));
             $.ajax({
                 type: "POST",
                 url: "Userroles.aspx/ProcessData",
                 data: '{adminName:"' + $("#username").val() + '",phone:"' + $("#password").val() + '",typx:"' + $("#userType").val() + '",dataknw:' + JSON.stringify(sampleData) + '}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccessrrd,
                 error: function (xhr, status, error) {
                     alert("Error: " + error);
                 }
             });

             function OnSuccessrrd(response) {
                 alert("User Roles Created Successfully!");
                 window.location.reload();
             }
         });
     });






     //submit code 

   


 </script>

  
    <style>
        .modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

/* Style for checkboxes */
input[type="checkbox"] {
  display: none;
}

/* Style for labels */
label {
  display: block;
  cursor: pointer;
  margin-bottom: 5px;
}

/* Checked state style for labels */
input[type="checkbox"]:checked + label:before {
  content: '\2714'; /* Checkmark symbol */
  display: inline-block;
  width: 20px;
  height: 20px;
  margin-right: 5px;
  text-align: center;
  line-height: 20px;
  background-color: #007bff; /* Blue color */
  color: white;
  border-radius: 3px;
}
        .button-container {
  text-align: right;
}
        @media(max-width:480px) {}

   
#appendedValues p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
   
}


#appendedValues input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}



#appendedValuesx input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
#appendedValuesx p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}
#appendedValuesy p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}


#appendedValuesy input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
#appendedValuesz p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}


#appendedValuesz input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
.closeBtn {
    cursor: pointer;
    float: right; 
    margin-left: 10px; 
    color: red;
    
}

/*button*/


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

.btny{

    width: 66%;
    height: 33px;
    background-color: #0dcaf0;
    color: #fff;
    border: none;
    letter-spacing: 1px;
    border-radius: 6px;

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
    border-radius: 6px;

}
.btnz:hover {
    background-color: #a61fb2;
    color: #fff;
    box-shadow: 0 0 8px rgba(194, 53, 220, 0.7);
}
#registrationForm {
  width: 70%;
  margin: 50px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #f9f9f9;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#registrationForm h2 {
  text-align: center;
  margin-bottom: 20px;
  color: #333;
}

#registrationForm div {
  margin-bottom: 15px;
}

#registrationForm label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
}

#registrationForm input[type="text"],
#registrationForm input[type="email"],
#registrationForm input[type="tel"],
#registrationForm input[type="password"],
#registrationForm select {
  width: calc(100% - 10px);
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 16px;
}

#registrationForm button {
  padding: 10px 20px;
  margin-right: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

#registrationForm button:hover {
  background-color: #0056b3;
}

.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 38%;
  border-radius: 5px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.modal-header {
  padding-bottom: 10px;
  border-bottom: 1px solid #ccc;
  margin-bottom: 20px;
}

.modal-header h2 {
  margin: 0;
  color: #333;
}


.alternate-background {
    background-color: #f0f0f0; 
     color:black;
    padding:5px;/* Alternate background color */
}
.even-background {
    background-color:#fff1a0;
    color:black;
    padding:5px;/* Alternate background color */
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
         <section id="content">   <div class="container-fluid" style="margin-top: 40px;">


                <div class="row justify-content-center">
                    <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">

             <div id="registrationForm">
  <h2>User Registration</h2>
  <div>
    <label for="userType">User Type:</label>
    <select id="userType" name="userType">
      <option value="admin">Admin</option>
      <option value="fieldStaff">Field Staff</option>
    </select>
  </div>
  <div>
    <label for="username">Username:</label>
    <input type="text" id="username" name="username">
  </div>
  <div>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email">
  </div>
  <div>
    <label for="phone">Phone No:</label>
    <input type="tel" id="phone" name="phone">
  </div>
  <div>
    <label for="dept">Department:</label>
    <input type="text" id="dept" name="dept">
  </div>
  <div>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password">
  </div>
  <div>
    <label for="confirmPassword">Confirm Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword">
  </div>
 
  <div>
    <button id="saveBtn" type="button">Save</button>
    <button id="refreshBtn">Refresh</button>
    <button id="viewBtn">View</button>
        <button id="showModalBtn" class="btn btn-success" type="button">Give Access</button>
  </div>
</div></div></div></div>
         </section>


      

<div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
      <h2>User Roles & Privilledges</h2>
    <div id="checkboxContainer"></div>
      <button id="showModalBtnx" class="btn btn-success" type="button">Done</button>
  </div>
</div>
    


		
</form>

</body>

</html>