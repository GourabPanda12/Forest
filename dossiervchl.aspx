<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dossiervchl.aspx.cs" Inherits="dossiervchl" %>


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
	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Dossier of Vehicle</title>

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

             // Store images array globally
             let uploadedImages = [];

             $('.btn-uploadx').on('click', function () {
                 $('#fileInputPhotox').click(); // Trigger the hidden file input
             });

             $('.file-inputx').on('change', function () {
                 const files = this.files; // Get selected files
                 const imgContainer = $('#imgContainerx');
                 const existingImages = imgContainer.find('img').length;

                 if (existingImages + files.length > 3) {
                     alert(`You can only upload up to 3 images. You currently have ${existingImages} uploaded.`);
                     $(this).val(''); // Reset input
                     return;
                 }

                 Array.from(files).forEach((file, index) => {
                     const readerx = new FileReader();
                     readerx.onload = function (e) {
                         const base64Datax = e.target.result;
                         const fileNamex = file.name;

                         // Store image data
                         uploadedImages.push({
                             base64: base64Datax,
                             fileName: fileNamex
                         });

                         // Update hidden input with stringified array
                         $('#hidenzx').val(JSON.stringify(uploadedImages));

                         // Append new image preview
                         const imgWrapper = $('<div>')
                             .css({
                                 position: 'relative',
                                 display: 'inline-block',
                             })
                             .attr('data-filename', fileNamex); // Add filename as data attribute

                         const imgPreview = $('<img>')
                             .attr('src', base64Datax)
                             .attr('alt', fileNamex)
                             .css({
                                 width: '100px',
                                 height: '100px',
                                 objectFit: 'cover',
                                 border: '1px solid #ccc',
                                 borderRadius: '5px',
                             });

                         const removeButton = $('<button>')
                             .html('&times;')
                             .css({
                                 position: 'absolute',
                                 top: '5px',
                                 right: '5px',
                                 backgroundColor: '#ff0000',
                                 color: '#fff',
                                 border: 'none',
                                 borderRadius: '50%',
                                 cursor: 'pointer',
                                 width: '20px',
                                 height: '20px',
                                 textAlign: 'center',
                                 lineHeight: '18px',
                             })
                             .on('click', function () {
                                 const filename = $(this).parent().attr('data-filename');
                                 // Remove image from array
                                 uploadedImages = uploadedImages.filter(img => img.fileName !== filename);
                                 // Update hidden input
                                 $('#hidenzx').val(JSON.stringify(uploadedImages));
                                 // Remove preview
                                 imgWrapper.remove();
                                 if (uploadedImages.length === 0) {
                                     $('#fileInputPhotox').val(''); // Reset input if no images left
                                 }
                             });

                         imgWrapper.append(imgPreview).append(removeButton);
                         imgContainer.append(imgWrapper);
                     };
                     readerx.readAsDataURL(file);
                 });
             });



             $('form').submit(function (e) {
                 e.preventDefault(); // Prevent form submission

                 // Collect data from the form fields
                 var formData = {
                     makeModel: $('#makeModel').val(),
                     vin: $('#vin').val(),
                     registrationNumber: $('#registrationNumber').val(),
                     color: $('#color').val(),
                     yearManufacture: $('#yearManufacture').val(),
                     odometerReading: $('#odometerReading').val(),
                     ownerName: $('#ownerName').val(),
                     ownerFatherName: $('#ownerFatherName').val(),
                     ownerAddress: $('#ownerAddress').val(),
                     ownerContact: $('#ownerContact').val(),
                     ownerEmail: $('#ownerEmail').val(),
                     ownerId: $('#ownerId').val(),
                     dateSeizure: $('#dateSeizure').val(),
                     locationSeizure: $('#locationSeizure').val(),
                     reasonSeizure: $('#reasonSeizure').val(),
                     authoritySeized: $('#authoritySeized').val(),
                     currentLocation: $('#currentLocation').val(),
                     vehicleType: $('#vehicleType').val(),
                     engineNumber: $('#engineNumber').val(),
                     chassisNumber: $('#chassisNumber').val(),
                     conditionVehicle: $('#conditionVehicle').val(),
                     additionalFeatures: $('#additionalFeatures').val(),
                     rc: $('#rc').is(':checked') ? 'Yes' : 'No',
                     insurance: $('#insurance').is(':checked') ? 'Yes' : 'No',
                     puc: $('#puc').is(':checked') ? 'Yes' : 'No',
                     otherDocuments: $('#otherDocuments').val(),
                     previousOffenses: $('#previousOffenses').val(),
                     caseNumber: $('#caseNumber').val(),
                     court: $('#court').val(),
                     investigatingOfficer: $('#investigatingOfficer').val(),
                     briefCase: $('#briefCase').val(),
                     vehicleUsage: $('#vehicleUsage').val(),
                     regionsOperated: $('#regionsOperated').val(),
                     acquittalsConvictions: $('#acquittalsConvictions').val(),
                     additionalNotes: $('#additionalNotes').val(),
                     signatureBase64: $('#hidenz').val(),
                     signatureFileName: $('#hiddenz').val(),
                     images: uploadedImages
                 };

                 console.log('Form Data to be Sent:', formData);

                 // Perform the AJAX request to the backend
                 $.ajax({
                     url: 'dossiervchl.aspx/SaveFormData', // Replace with your actual backend endpoint
                     method: 'POST',
                     contentType: 'application/json',
                     data: JSON.stringify({ formData: formData }),
                     success: function (response) {
                         console.log('Success Response:', response);
                         alert('Data submitted successfully!');
                         uploadedImages = [];
                         $('#imgContainerx').empty();
                         $('#hidenzx').val('');
                         $('#fileInputPhotox').val('');
                     },
                     error: function (error) {
                         console.log('Error Response:', error);
                         alert('An error occurred while submitting the data.');
                     },
                 });
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
  .data-output {
            background-color: #f8f9fa;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .data-item {
            margin-bottom: 15px;
        }

        .data-item label {
            font-weight: bold;
            color: #333;
        }

        .data-item span {
            color: #555;
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
   .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: auto;
        }

     .form-title {
            font-weight: bold;
            font-size: 24px;
            margin-bottom: 20px;
            color: #007bff;
            text-align: center;
        }

        .form-group label {
            font-weight: 600;
        }

        .form-control,
        .form-check-input,
        .custom-select {
            margin-bottom: 10px;
        }

        .section-title {
            font-size: 18px;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 15px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .checkbox-container,
        .radio-container {
            display: flex;
            flex-wrap: wrap;
        }

        .checkbox-container label,
        .radio-container label {
            margin-right: 15px;
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

             


            
         
          
         <div class="row" style="margin-top:-20px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            <div class="">
                  <div class="form-container">
        <div class="form-title">Dossier Of Vehicle</div>

        <!-- Section 1: Vehicle Details -->
        <div class="section-title">1. Vehicle Details</div>
        <div class="form-group">
            <label for="makeModel">Make and Model</label>
            <input type="text" class="form-control" id="makeModel" placeholder="Enter make and model">
        </div>
        <div class="form-group">
            <label for="vin">Vehicle Identification Number (VIN)</label>
            <input type="text" class="form-control" id="vin" placeholder="Enter VIN">
        </div>
        <div class="form-group">
            <label for="registrationNumber">Registration Number</label>
            <input type="text" class="form-control" id="registrationNumber" placeholder="Enter registration number">
        </div>
        <div class="form-group">
            <label for="color">Colour</label>
            <input type="text" class="form-control" id="color" placeholder="Enter colour">
        </div>
        <div class="form-group">
            <label for="yearManufacture">Year of Manufacture</label>
            <input type="number" class="form-control" id="yearManufacture" placeholder="Enter year of manufacture">
        </div>
        <div class="form-group">
            <label for="odometerReading">Odometer Reading</label>
            <input type="text" class="form-control" id="odometerReading" placeholder="Enter odometer reading">
        </div>

        <!-- Section 2: Owner Details -->
        <div class="section-title">2. Owner Details</div>
        <div class="form-group">
            <label for="ownerName">Owner's Name</label>
            <input type="text" class="form-control" id="ownerName" placeholder="Enter owner's name">
        </div>
        <div class="form-group">
            <label for="ownerFatherName">Owner's Father’s Name</label>
            <input type="text" class="form-control" id="ownerFatherName" placeholder="Enter owner's father's name">
        </div>
        <div class="form-group">
            <label for="ownerAddress">Owner's Address</label>
            <textarea class="form-control" id="ownerAddress" rows="2" placeholder="Enter owner's address"></textarea>
        </div>
        <div class="form-group">
            <label for="ownerContact">Owner's Contact Number</label>
            <input type="text" class="form-control" id="ownerContact" placeholder="Enter owner's contact number">
        </div>
        <div class="form-group">
            <label for="ownerEmail">Owner's Email Address</label>
            <input type="email" class="form-control" id="ownerEmail" placeholder="Enter owner's email">
        </div>
        <div class="form-group">
            <label for="ownerId">Owner's Identification Number (e.g., Aadhaar No.)</label>
            <input type="text" class="form-control" id="ownerId" placeholder="Enter identification number">
        </div>

        <!-- Section 3: Seizure Details -->
        <div class="section-title">3. Seizure Details</div>
        <div class="form-group">
            <label for="dateSeizure">Date of Seizure</label>
            <input type="date" class="form-control" id="dateSeizure">
        </div>
        <div class="form-group">
            <label for="locationSeizure">Location of Seizure</label>
            <input type="text" class="form-control" id="locationSeizure" placeholder="Enter location of seizure">
        </div>
        <div class="form-group">
            <label for="reasonSeizure">Reason for Seizure</label>
            <textarea class="form-control" id="reasonSeizure" rows="2" placeholder="Enter reason for seizure"></textarea>
        </div>
        <div class="form-group">
            <label for="authoritySeized">Authority Who Seized the Vehicle</label>
            <input type="text" class="form-control" id="authoritySeized" placeholder="Enter authority">
        </div>
        <div class="form-group">
            <label for="currentLocation">Current Location of the Vehicle</label>
            <input type="text" class="form-control" id="currentLocation" placeholder="Enter current location">
        </div>

        <!-- Section 4: Vehicle Type and Details -->
        <div class="section-title">4. Vehicle Type and Additional Details</div>
        <div class="form-group">
            <label for="vehicleType">Type (e.g., SUV, Sedan, Truck)</label>
            <select class="custom-select" id="vehicleType">
                <option value="" selected>Select vehicle type</option>
                <option value="SUV">SUV</option>
                <option value="Sedan">Sedan</option>
                <option value="Truck">Truck</option>
                <option value="Motorcycle">Motorcycle</option>
                <option value="Van">Van</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="engineNumber">Engine Number</label>
            <input type="text" class="form-control" id="engineNumber" placeholder="Enter engine number">
        </div>
        <div class="form-group">
            <label for="chassisNumber">Chassis Number</label>
            <input type="text" class="form-control" id="chassisNumber" placeholder="Enter chassis number">
        </div>
        <div class="form-group">
            <label for="conditionVehicle">Condition of the Vehicle</label>
            <select class="custom-select" id="conditionVehicle">
                <option value="" selected>Select condition</option>
                <option value="good">Good</option>
                <option value="fair">Fair</option>
                <option value="poor">Poor</option>
            </select>
        </div>
        <div class="form-group">
            <label for="additionalFeatures">Additional Features (e.g., sunroof, GPS)</label>
            <textarea class="form-control" id="additionalFeatures" rows="2" placeholder="Enter additional features"></textarea>
        </div>

        <!-- Section 5: Documents Attached -->
        <div class="section-title">5. Documents Attached</div>
        <div class="form-group checkbox-container">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="rc" value="Yes">
                <label class="form-check-label" for="rc">Registration Certificate (RC)</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="insurance" value="Yes">
                <label class="form-check-label" for="insurance">Insurance Policy</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="puc" value="Yes">
                <label class="form-check-label" for="puc">Pollution Under Control (PUC) Certificate</label>
            </div>
        </div>
        <div class="form-group">
            <label for="otherDocuments">Any Other Relevant Document</label>
            <textarea class="form-control" id="otherDocuments" rows="2" placeholder="Enter any other relevant document"></textarea>
        </div>

        <!-- Section 6: Previous Offenses -->
        <div class="section-title">6. Previous Offenses</div>
        <div class="form-group">
            <label for="previousOffenses">Previous Offenses Involving this Vehicle (if any)</label>
            <textarea class="form-control" id="previousOffenses" rows="3" placeholder="Enter previous offenses"></textarea>
        </div>

        <!-- Section 7: Current Case Details -->
        <div class="section-title">7. Current Case Details</div>
        <div class="form-group">
            <label for="caseNumber">Case Number</label>
            <input type="text" class="form-control" id="caseNumber" placeholder="Enter case number">
        </div>
        <div class="form-group">
            <label for="court">Court</label>
            <input type="text" class="form-control" id="court" placeholder="Enter court">
        </div>
        <div class="form-group">
            <label for="investigatingOfficer">Investigating Officer</label>
            <input type="text" class="form-control" id="investigatingOfficer" placeholder="Enter investigating officer">
        </div>
        <div class="form-group">
            <label for="briefCase">Brief of the Case</label>
            <textarea class="form-control" id="briefCase" rows="2" placeholder="Enter brief of the case"></textarea>
        </div>

        <!-- Section 8: Additional Information -->
        <div class="section-title">8. Additional Information</div>
        <div class="form-group">
            <label for="vehicleUsage">Description of How the Vehicle Was Used in the Crime</label>
            <textarea class="form-control" id="vehicleUsage" rows="3" placeholder="Describe vehicle usage"></textarea>
        </div>
        <div class="form-group">
            <label for="regionsOperated">Regions Where the Vehicle Was Operated/Seized</label>
            <textarea class="form-control" id="regionsOperated" rows="2" placeholder="Enter regions"></textarea>
        </div>
        <div class="form-group">
            <label for="acquittalsConvictions">Details of Any Acquittals or Convictions</label>
            <textarea class="form-control" id="acquittalsConvictions" rows="2" placeholder="Enter details"></textarea>
        </div>
        <div class="form-group">
            <label for="additionalNotes">Additional Notes or Observations</label>
            <textarea class="form-control" id="additionalNotes" rows="3" placeholder="Enter additional notes or observations"></textarea>
        </div>


                      
        <div class="form-group">
            <label class="form-label fw-bold">Upload Signature:</label>
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
    <button type="submit" id="btn" class="btn btn-primary">Submit</button>
</div>
    
    </div>
            </div>
            
<%--                        <div>
<%--            <div class="login-form">
                         
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
  <div id="imagePreviewContainer" class="image-preview-container"></div></div>
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
            
                          
                          

                         
   
            
                          </div>--%>
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