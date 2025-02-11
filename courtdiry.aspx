<%@ Page Language="C#" AutoEventWireup="true" CodeFile="courtdiry.aspx.cs" Inherits="courtdiry" %>


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
                   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
    <script>
        $(document).ready(function () {

            $('.btn-upload').on('click', function () {
                $(this).next('.file-input').trigger('click');
            });
            $('.file-input').on('change', function () {
                const inputId = $(this).attr('id');
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result;
                        const fileName = file.name;

                        if (inputId === 'fileInputPhoto') {
                            $('#hidenz').val(base64Data);
                            $('#hiddenz').val(fileName);

                            // Show preview
                            $('#imgPreview').attr('src', base64Data).show();
                            $('#removeImg').show();
                        }
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Remove image for first input
            $('#removeImg').on('click', function () {
                $('#imgPreview').hide();
                $(this).hide();
                $('#fileInputPhoto').val(''); // Reset input
                $('#hidenz').val('');
                $('#hiddenz').val('');
            });

            $('.btn-uploadx').on('click', function () {
                $('#fileInputPhotox').click(); // Trigger the hidden file input
            });


            $('.file-inputx').on('change', function () {
                const inputIdx = $(this).attr('id');
                const filex = this.files[0];
                if (filex) {
                    const readerx = new FileReader();
                    readerx.onload = function (e) {
                        const base64Datax = e.target.result;
                        const fileNamex = filex.name;

                        if (inputIdx === 'fileInputPhotox') {
                            $('#hidenzx').val(base64Datax);
                            $('#hiddenzx').val(fileNamex);

                            // Show preview
                            $('#imgPreviewx').attr('src', base64Datax).show();
                            $('#removeImgx').show();
                        }
                    };
                    readerx.readAsDataURL(filex);
                }
            });

            // Remove image for second input
            $('#removeImgx').on('click', function () {
                $('#imgPreviewx').hide();
                $(this).hide();
                $('#fileInputPhotox').val(''); // Reset input
                $('#hidenzx').val('');
                $('#hiddenzx').val('');
            });


            $('.btn-primary').on('click', function (e) {
                e.preventDefault(); // Prevent default form submission

                // Collect data from the form
                const caseDetails = {
                    courtName: $('#signature').val(),
                    at: $('#dateTime').val(),
                    forestRangeDivision: $('#signaturea').val(),
                    district: $('#dateTimea').val(),
                    state: $('#dateTimeb').val(),
                    courtCaseNo: $('#froma').val(),
                    dateOfFiling: $('#signatureb').val(),
                    courtDiaryNo: $('#dateTimed').val(),
                    sectionsInvoked: $('#frome').val(),
                    previousDate: $('#fromf').val(),
                    accusedDetails: $('#addresss').val(),
                    relativeDetails: $('#fromk').val(),
                    accusedAddress: $('#addressk').val(),
                    pinCode: $('#dateTimet').val(),
                    summonStage: $('#pleadGuilty').is(':checked'),
                    bailStage: $('#postCharge').is(':checked'),
                    preCharge: $('#prosEvidence').is(':checked'),
                    pleadGuilty: $('#pleadGuiltya').is(':checked'),
                    postCharge: $('#postChargeg').is(':checked'),
                    prosEvidence: $('#prosEvidencej').is(':checked'),
                    defenceWitness: $('#defenceWitness').is(':checked'),
                    statement: $('#statementx').is(':checked'),
                    argument: $('#argument').is(':checked'),
                    witnessType: $('#options').val(),
                    nameOfWitness: $('#fromz').val(),
                    summonedOrAppeared: $('#fromw').val(),
                    fullySupported: $('#fromm').val(),
                    partlySupported: $('#fromn').val(),
                    becameHostile: $('#fromo').val(),
                    reasonsNotExamined: $('#fromp').val(),
                    proceedingsBrief: $('#callData').val(),
                    remediesSuggested: $('#requestingOfficer').val(),
                    officerNameRank: $('#dateTimez').val(),
                    rangeDivision: $('#dateTimex').val(),
                    dcfDfoComments: $('#callDatay').val(),
                    signatureBase64: $('#hidenz').val(),
                    signatureFileName: $('#hiddenz').val(),
                    imageBase64: $('#hidenzx').val(),
                    imageFileName: $('#hiddenzx').val()
                };

                console.log('Form Data to be Sent:', caseDetails); // Log the data for debugging

                // AJAX request
                $.ajax({
                    url: 'courtdiry.aspx/SaveCaseDetails', // Replace with your actual backend endpoint
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ caseDetails: caseDetails }),
                    success: function (response) {
                        console.log('Success Response:', response);
                        alert('Data submitted successfully!');
                    },
                    error: function (error) {
                        console.log('Error Response:', error);
                        alert('An error occurred while submitting the data.');
                    },
                });




            });





        });
     
    </script>
	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Court Diary</title>


    

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

 
    .input-container {
      position: relative;
    }
    .close-button {
      position: absolute;
      right: 5px;
      top: 5px;
      cursor: pointer;
      color:red;
    }


.btnz{

    width: 66%;
    height: 33px;
    background-color:#198754;
    color: #fff;
    border: none;
    letter-spacing: 1px;
    border-radius: 6px;

}
.btnz:hover {
    background-color: #198754;
    color: #ffcc00;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

  

 h6{
     color:#000;
 }

.form-head{
    text-align: center;
    margin-bottom: 40px;
}
.fm-head{
    font-size: 24px;
}

.form-section {
    margin-bottom: 20px;
}
.form-section label {
    font-weight: 600;
}

.container{
box-sizing: border-box;
}
.form-container { 
    max-width: 800px; 
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #000;
    border-radius: 8px;
}

.form-control {
    width: 100%; 
    height: auto; 
}
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    border: 1px solid #000;
    padding: 8px;
    text-align: left;
    color: #000;
}
th {
    background-color: #f2f2f2;
    color: #000;
}

.table-input {
    width: 100%;
    box-sizing: border-box; 
    padding: 5px; 
    border: none;
}
           .file-input {
    display: none; /* Hide the file input by default */
}

.image-preview-container {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 20px;
}

.image-preview {
    position: relative;
    width: 100px;
    height: 100px;
    overflow: hidden;
    border: 2px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.image-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
 #addFilesBtn {
     display: flex;
     flex-direction: row;
     width: fit-content;
     padding: 7px;
     margin: 9px;
     background-color: #101357;
     color: white;
     border-radius: 7px;
 }
 #submitFiles {
     display: flex;
     flex-direction: row;
     width: fit-content;
     text-align: center;
     padding: 7px;
     margin: 9px;
     background-color: #101357;
     color: white;
     border-radius: 7px;
 }
  .prnt {
     display: flex;
     flex-direction: row;
     width: fit-content;
     text-align: center;
     padding: 7px;
     margin: 9px;
     background-color: #101357;
     color: white;
     border-radius: 7px;
 }

  .fa-print{
     
    padding-top: 5px;

  }

  #outputContainer {
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-output-item {
    padding: 10px;
    margin: 5px 0;
    border-bottom: 1px solid #ddd;
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



	<!-- CONTENT -->


	<section id="content">

		<nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>


        <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>



	<main>

         <div class="container" style="margin-top: 80px;">

            <h2 class="text-center" style="color: #fff;">FOREST DEPARTMENT, ODISHA </h2>

         </div>

             <div class="row " style="margin-top:50px;">
                <div class="col-md-10  col-12 mx- auto offset-md-1">
                   <div class="login-form">
                      <div class="row asd d-flex pt-4">

                        <h3 class="text-center" style="color: #000;">Court Diary </h3>
                        <p class="text-center" style="color: #000; font-weight: 500;">(To bes ubmitted by I.O. or any other case officer deputed to follow up trial in court) </p>


             <form>
                <div class="row pt-4">
                    <div class="col-md-6">
                        <label for="refNumber">(i).	Name of court </label>
                        <input type="text" class="form-control form-control-custom" id="signature" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">At</label>
                        <input type="text" class="form-control" id="dateTime" placeholder="">
                    </div>
                </div> 

                <div class="row ">
                    <div class="col-md-6">
                        <label for="refNumber">(ii). Forest Range/Division. </label>
                        <input type="text" class="form-control form-control-custom" id="signaturea" placeholder="">
                    </div>
                    <div class="col-md-3">
                        <label for="dateTime">Dist.</label>
                        <input type="text" class="form-control" id="dateTimea" placeholder="">
                    </div>
                    <div class="col-md-3">
                        <label for="dateTime">State.</label>
                        <input type="text" class="form-control" id="dateTimeb" placeholder="">
                    </div>
                </div> 

                 <div class="form-group form-section">
                     <label for="from">(iii).Court case No :</label>
                     <input type="text" class="form-control" id="froma" placeholder="">
                 </div>


                 <div class="row">
                    <div class="col-md-6">
                        <label for="refNumber">(iv). Date of Filing of Complaint </label>
                        <input type="date" class="form-control form-control-custom" id="signatureb" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Forest Deptt. Court Diary No.</label>
                        <input type="text" class="form-control" id="dateTimed" placeholder="">
                    </div>
                </div> 


                <div class="form-group form-section">
                    <label for="from">(v).	Sections Invoked under WL.P. Act</label>
                    <input type="text" class="form-control" id="frome" placeholder="">
                </div>

                <div class="form-group form-section">
                    <label for="from">(vi). Previous date. </label>
                    <input type="date" class="form-control" id="fromf" placeholder="">
                </div>

                <div class="form-group form-section">
                    <label for="from">(vii). Name(s) & Address (s) of Accused(s) : </label>
                    <textarea class="form-control" id="addresss" rows="3" placeholder=""></textarea>
                </div>

                <div class="form-group form-section">
                    <label for="from">(viii). Son/Daughter/Wife of :</label>
                    <input type="text" class="form-control" id="fromk" placeholder="">
                </div>


                <div class="row">
                    <div class="col-md-8">
                        <label for="refNumber">(ix). Address : </label>
                        <textarea class="form-control" id="addressk" rows="3" placeholder=""></textarea>

                    </div>
                    <div class="col-md-4 mt-5">
                        <label for="dateTime">Pin.</label>
                        <input type="text" class="form-control" id="dateTimet" placeholder="">
                    </div>
                </div> 


                <div class="form-group form-section mt-3">
                    <label for="from">(x). Prosecution Status in Court (Tick) :</label>
                </div>
                <div class="form-group ">
                    <div class="section-title" style="color: #000; font-weight: 500;">TRIAL STAGE :</div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="pleadGuilty" value="Plead guilty">
                        <label class="form-check-label" for="pleadGuilty">Summon Stage</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="postCharge" value="Post-Charge">
                        <label class="form-check-label" for="postCharge">Bail Stage</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="prosEvidence" value="Pros. Evidence">
                        <label class="form-check-label" for="prosEvidence">Pre-Charge</label>
                    </div>
                    
                </div>
                <div class="form-group">
                    <div class="section-title" style="color: #000; font-weight: 500;">CHARGE STAGE :</div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="pleadGuiltya" value="Plead guilty">
                        <label class="form-check-label" for="pleadGuilty">Plead Guilty</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="postChargeg" value="Post-Charge">
                        <label class="form-check-label" for="postCharge">Post-Charge</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="prosEvidencej" value="Pros. Evidence">
                        <label class="form-check-label" for="prosEvidence">Pros. Evidence </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="defenceWitness" value="Defence Witness">
                        <label class="form-check-label" for="defenceWitness">Defence Witness</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="statementx" value="Statement">
                        <label class="form-check-label" for="statement">Statement</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="argument" value="Argument">
                        <label class="form-check-label" for="argument">Argument</label>
                    </div>
                </div>
                

                
                <div class="form-group form-section mt-3">
                    <label for="from">(xi). Performance of the witness during trial :</label>
                </div>

                
                <div class="form-group form-section">
                    <label for="from">Type of Witness :</label>
                    <select id="options" class="dropdown form-control">
                        <option value="">Select</option>
                         <option value="Eye">Eye</option>
                         <option value="Factual">Factual</option>
                         <option value="Technical">Technical</option>
                         <option value="Official">Official</option>
                         <option value="Seizure">Seizure</option>
                         <option value="Defence">Defence</option>
                         <option value="Forensic">Forensic</option>
                         <option value="Formal">Formal</option>
                     </select>
                </div>


                <div class="form-group form-section">
                    <label for="from">Name of Witnesses</label>
                    <input type="text" class="form-control" id="fromz" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="from">Summoned or Appeared</label>
                    <input type="text" class="form-control" id="fromw" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="from">Fully Supported</label>
                    <input type="text" class="form-control" id="fromm" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="from">Partly Supported</label>
                    <input type="text" class="form-control" id="fromn" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="from">Became Hostile</label>
                    <input type="text" class="form-control" id="fromo" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="from">If not Examined then Reasons</label>
                    <input type="text" class="form-control" id="fromp" placeholder="">
                </div>
     
                  
             
                 <div class="form-group form-section ">
                     <label for="callData">(xii). Brief description of proceedings including cause of hostile witness & if any adjournment:</label>
                     <textarea class="form-control" id="callData" rows="3" placeholder=""></textarea>
                 </div>

                 <div class="form-group form-section">
                     <label for="requestingOfficer">(xiii).	Remedies Suggested by Conducting P.P. if any damage caused to the case:</label>
                     <input type="text" class="form-control" id="requestingOfficer" placeholder="">
                 </div>

                 <div class="row">
                    <div class="col-md-6">
                        <label for="refNumber">(xiv). Pairvi (Case) officer’s Name & Rank :</label>
                        <input type="text" class="form-control" id="dateTimez" placeholder="">

                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Range/Division.</label>
                        <input type="text" class="form-control" id="dateTimex" placeholder="">
                    </div>
                </div> 
                 
                
                 <div class="form-group form-section">
                    <label for="dateTimeRequest">(xvi). DCF/DFO Comments</label>
                    <textarea class="form-control" id="callDatay" rows="3" placeholder=""></textarea>
                </div>

                 
        <div class="form-group">
            <label class="form-label fw-bold">Upload Signature(I.O. / Case Officer):</label>
                                      <button type="button" class="btn-upload">Choose File</button>
                        <input type="file" id="fileInputPhoto" class="file-input" style="display:none;">
                        <div id="imgContainer" style="position: relative;">
                            <img id="imgPreview" src="#" alt="Image Preview" style="display:none;">
                            <button class="remove-img" id="removeImg" style="display:none;">&times;</button>
            </div>

             <input type="hidden" id="hidenz">
            <input type="hidden" id="hiddenz">
                      


                      </div>



                              <div class="form-group">
            <label class="form-label fw-bold">Upload Image:</label>
                                      <button type="button" class="btn-uploadx">Choose File</button>
                        <input type="file" id="fileInputPhotox" class="file-inputx" style="display:none;">
                        <div id="imgContainerx" style="position: relative;">
                            <img id="imgPreviewx" src="#" alt="Image Preview" style="display:none;">
                            <button class="remove-img" id="removeImgx" style="display:none;">&times;</button>
            </div>

             <input type="hidden" id="hidenzx">
            <input type="hidden" id="hiddenzx">
                      


                      </div>

                      <div class="text-center mt-4">
    <button type="submit" class="btn btn-primary">Submit</button>
</div>


            
            
             </form>
         
                      

            </div>
               
        </div>
                     
                
    </div>
</div>
          
        <div class="row" style="margin-top:-20px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
<%--                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
            <div class="col-lg-6  col-sm-6 col-xs-6 abc" id="fileContainer">
      <!-- Hidden file input -->
      <input type="file" class="file-input" multiple id="fileInput1">
  </div>

  <!-- Button to trigger the file input -->
  <label>Choose Multiple Files   <abbr style="
    color: red;
"><i>(Supported image file formats - jpeg/png/jpg)</i></abbr></label>
  <button id="addFilesBtn" type="button">+ Add Images</button>

  <!-- Button to submit files -->
  <button id="submitFiles" type="button" >Final Submit</button>
                                <button class="prnt" type="button" onclick="print()" ><i class="fa fa-print"></i>&nbsp;&nbsp;Print</button>
  <div id="imagePreviewContainer" class="image-preview-container"></div>
                                <div class="col-lg-4  col-sm-4 col-xs-4 abc d-none">

                                    <label class="lebl" style="color:#228B22;">Manually Upload File</label>
            
                                     <input id="txtmupld" type="file">
            
                                </div>


                              <div class="col-lg-4  col-sm-4 col-xs-4 abc d-none">

                               
            
                             <button class="btnz mt-4" type="button">Save</button>
            
                            </div>


                             <div class="col-lg-4  col-sm-4 col-xs-4 d-none">

                               
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                          
                          

                         
   
            
                          </div>
                        </div>--%>
            
                      </div>
                    </div>

                </main>
            </section>








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
    </form>
</body>
</html>