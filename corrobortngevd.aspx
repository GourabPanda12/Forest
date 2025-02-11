<%@ Page Language="C#" AutoEventWireup="true" CodeFile="corrobortngevd.aspx.cs" Inherits="corrobortngevd" %>


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
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>


	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Corroborating Evidence Summary</title>


    <script>
        var rqtn = [];
        let formData22 = [];
        $(document).ready(function () {

            $('#submit-form').click(function () {
                let formData = '';

                // Loop through each checkbox and find its corresponding input if checked
                $('input[type="checkbox"]').each(function () {
                    if ($(this).is(':checked')) {
                        const label = $(this).parent().text();
                        const inputValue = $(this).closest('p').find('.evidence-input').val();

                        formData += `<div class="styled-item"><strong>${label}</strong> <span>${inputValue}</span></div>`;
                        formData22.push({
                            name: label,
                            txtx: inputValue
                        });
                    }
                });

                // Append the collected data to the styled container
                $('#styled-output').html(formData);
            });



            let fileIndex = 1; // Track the number of file inputs

            // Trigger file input when the "+" button is clicked
            $('#addFilesBtn').click(function () {
                $(`#fileInput${fileIndex}`).click();
            });

            // Event handler for file input change
            $(document).on('change', '.file-input', function () {
                // Create a new file input when files are selected
                fileIndex++;
                let newFileInput = `<input type="file" class="file-input" multiple id="fileInput${fileIndex}">`;
                $('#fileContainer').append(newFileInput);

                // Render image previews
                renderImagePreviews(this.files);
            });

            // Render image previews
            function renderImagePreviews(files) {
                for (let i = 0; i < files.length; i++) {
                    let file = files[i];
                    if (file.type.startsWith("image/")) {
                        let reader = new FileReader();
                        reader.onload = function (e) {
                            let img = $('<div class="image-preview"><img src="' + e.target.result + '" alt="Preview"></div>');
                            $('#imagePreviewContainer').append(img);
                        };
                        reader.readAsDataURL(file);
                    }
                }
            }


            // Handle form submission
            $('#submitFiles').click(function () {
                var caseNo = localStorage.getItem('caseno');
                var heading = $("h2.text-center").text(); // Get the heading value
                var nameDesignation = $("#name-designation").val(); // Get the input value

                // Show loading indicator
                $(".loading").show();

                // Function to process each file and call the callback when done
                function processFiles(callback) {
                    var totalFiles = $('.file-input')[0].files.length; // Get total file count
                    var processedFiles = 0; // To track processed files

                    $('.file-input').each(function () {
                        let fileInput = this;

                        $.each(fileInput.files, function (index, file) {
                            let reader = new FileReader();

                            reader.onload = function (e) {
                                let base64String = e.target.result;

                                // Push the base64 string into rqtn
                                rqtn.push({
                                    "pic": base64String,
                                    "paths": $("#hidden").val(),
                                    "caseno": caseNo
                                });

                                processedFiles++; // Increment processed file count

                                // Check if all files have been processed
                                if (processedFiles === totalFiles) {
                                    callback(); // Call the callback once all files are processed
                                }
                            };

                            reader.readAsDataURL(file); // Start reading file
                        });
                    });
                }

                // Function to send additional data to the backend
                function submitAdditionalData() {
                    var fullPath = window.location.pathname;

                    // Extract the page name using JavaScript's split method
                    var pageName = fullPath.substring(fullPath.lastIndexOf('/') + 1);

                    // Display or use the page name
                    console.log("Current Page Name: " + pageName.split('.')[0]);
                    var additionalData = {
                        "heading": pageName.split('.')[0],
                        "nameDesignation": nameDesignation,
                        "caseNo": caseNo
                    };
                    console.log(additionalData);
                    $.ajax({
                        type: "POST",
                        url: "rqtnwtns.aspx/InsertAdditionalData",
                        data: JSON.stringify({ jsonDynmxcxxz: additionalData }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "Record already exists with status 'active'.") {
                                alert("Record already exist");
                                // Show the modal if a duplicate record exists

                            } else {
                                alert("Additional data submitted successfully.")

                            }
                        },
                        error: function (response) {
                            alert("Error while sending additional data: " + response.responseText);
                        }
                    });
                }

                // Function to make AJAX call after all files are processed


                // First submit additional data, then process files and submit them

                processFiles(submitAdditionalData);

            });





            $('input[type="checkbox"]').change(function () {
                // Find the input of type text that is a sibling of the changed checkbox
                $(this).closest('p').find('.form-control').toggle(this.checked);
            });


            
        });
        function printzx() {
            // Access jsPDF from the loaded UMD module
            const { jsPDF } = window.jspdf;

            // Create new jsPDF instance with portrait orientation, A4 size, and units in px
            const doc = new jsPDF({
                orientation: 'portrait',
                unit: 'px',
                format: 'a4'
            });
            const margin = 30;
            const pageWidth = doc.internal.pageSize.getWidth();
            const tablePaddingRight = 30;
            // Add header section
            doc.setFont("times", "bold");
            doc.setFontSize(14);
            doc.text("Corroborative Evidence", pageWidth / 2, 30, { align: 'center' });
            doc.setDrawColor(0, 0, 0);
            doc.line(pageWidth / 2 - 50, 32, pageWidth / 2 + 50, 32); // Underline

            // Case Number and Date
            const caseNumber = 'Case No: ' + (localStorage.getItem('caseno') || 'Unknown');
            const currentDate = new Date().toLocaleDateString();
            doc.setFontSize(12);
            doc.setFont("times", "normal");
            doc.text(caseNumber, pageWidth / 2, 50, { align: 'center' });
            doc.text(`Date: ${currentDate}`, pageWidth / 2, 65, { align: 'center' });

            let yPosition = 90;
            // Prepare table data
            const tableData = [];
            $('input[type="checkbox"]:checked').each(function () {
                const checkbox = $(this);
                const parentP = checkbox.closest('p');
                const label = parentP.find('label').text().trim();
                const inputValue = parentP.find('input.evidence-input').val().trim();

                if (label && inputValue) {
                    tableData.push([label, inputValue]);
                }
            });

            // Add table to PDF using autoTable with custom column styles
            doc.autoTable({
                head: [['Evidence Type', 'Summary']],
                body: tableData.map(row => [row[0], row[1]]),
                startY: yPosition, // Adjust starting Y position to prevent overlap with header
                margin: { top: margin, left: margin, right: margin },
                theme: 'grid',
                styles: {
                    font: "times",
                    fontSize: 10,
                    cellPadding: 10,
                    overflow: 'linebreak',
                    lineColor: [0, 0, 0],
                    lineWidth: 0.5,
                    fillColor: [255, 255, 255],
                },
                headStyles: {
                    fillColor: [255, 255, 255],
                    textColor: [0, 0, 0],
                    fontStyle: 'bold',
                    lineColor: [0, 0, 0],
                    lineWidth: 0.5
                },
                columnStyles: {
                    0: { // First column (Evidence Type)
                        cellWidth: 120, // Adjust width as needed
                        halign: 'left', // Align text to the left
                        minCellHeight: 30, // Minimum cell height for better spacing
                        cellPadding: { right: 5, top: 5, left: 5, bottom: 5 },
                        fillColor: [255, 255, 255],// Add padding to create spacing between columns
                    },
                    1: { // Second column (Summary)
                        cellWidth: pageWidth - 150 - tablePaddingRight, // Adjust width as needed
                        halign: 'left', // Align text to the left
                        minCellHeight: 30, // Minimum cell height for better spacing
                        cellPadding: { right: 5, top: 5, left: 5, bottom: 5 },
                        fillColor: [255, 255, 255],// Add padding to create spacing between columns
                    }
                },
                drawCell: function (hookData) {
                    // Draw a vertical line between columns
                    if (hookData.column.index === 0 && hookData.cell.raw !== null) {
                        doc.setDrawColor(150); // Gray line color
                        doc.setLineWidth(0.5); // Line thickness
                        const lineX = hookData.cell.x + hookData.cell.width;
                        const lineYTop = hookData.cell.y;
                        const lineYBottom = hookData.cell.y + hookData.cell.height;
                        doc.line(lineX, lineYTop, lineX, lineYBottom); // Draw vertical line
                    }
                }
            });


            doc.setFontSize(12);
            doc.addPage();
            yPosition = 20;
            const pdfWidth = doc.internal.pageSize.getWidth();
            rqtn.forEach(item => {
                // Center "Document Uploaded" Text
                doc.setTextColor(0, 0, 0);
                doc.text(`Document Uploaded:-  ${item.caseno}`, pdfWidth / 2, yPosition, { align: "center" });
                yPosition += 20; // Increase spacing between text and image

                // Calculate center position for the image
                const imgWidth = doc.internal.pageSize.getWidth(); // Image width
                const imgHeight = doc.internal.pageSize.getHeight() - yPosition - 40; // Image height
                const imgX = (pdfWidth - imgWidth) / 2; // Center image horizontally

                // Draw border around the image
                doc.rect(imgX - 5, yPosition - 5, imgWidth + 10, imgHeight + 10); // Adjust the border size

                // Add the image
                const imgPath = item.pic;
                const img = new Image();
                img.src = imgPath;
                doc.addImage(img, 'GIF', imgX, yPosition, imgWidth, imgHeight); // Center the image

                yPosition += imgHeight + 20; // Move y position after the image

                // Check if we need to add a new page
                if (yPosition + imgHeight + 20 > doc.internal.pageSize.getHeight()) {
                    doc.addPage(); // Add new page
                    yPosition = 20; // Reset y position for the new page
                }
            });


         




            // Save PDF
            doc.save('case-document-corrobortngevd.pdf');

            // Convert PDF to base64 and send to server
            const pdfBase64 = doc.output('datauristring').split(',')[1];
            const caseNo = localStorage.getItem('caseno');
            const pageName = window.location.pathname.split('/').pop();
            $.ajax({
                type: "POST",
                url: "rqtnwtns.aspx/SavePdf",
                data: JSON.stringify({ pdfData: pdfBase64, caseNo: caseNo, pageName: pageName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log('PDF saved successfully:', response);
                },
                error: function (xhr, status, error) {
                    console.error('Error saving PDF:', error);
                }
            });
        }
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

 
  .form-control { display: none; }
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

<h2 class="text-center" style="color: #fff;">Corroborating Evidence-Summary</h2>


             </div>
             <div class="row " style="margin-top:50px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">

          <div class="login-form">
  <div class="row asd d-flex">
    <!-- Hidden Fields -->
    <div class="col-lg-6 col-sm-6 col-xs-6" style="display:none;">
      <label class="lebl">Command Certificate No</label>
      <input type="text" id="txtcno" class="form-control">
    </div>
    <div class="col-lg-6 col-sm-6 col-xs-6" style="display:none;">
      <label class="lebl">FIR No</label>
      <input type="text" id="txtfir" class="form-control">
    </div>

    <!-- Evidence Fields -->
    <p>
      <label><input type="checkbox" name="Forensic" value="Forensic"> Forensic Evidence</label>
      <input type="text" class="form-control evidence-input" style="display: inline-block;">
    </p>
    <p>
      <label><input type="checkbox" name="Documentary" value="Documentary"> Documentary Evidence</label>
      <input type="text" class="form-control evidence-input" style="display: inline-block;">
    </p>
    <p>
      <label><input type="checkbox" name="Material" value="Material"> Material Evidence</label>
      <input type="text" class="form-control evidence-input" style="display: inline-block;">
    </p>
    <p>
      <label><input type="checkbox" name="Corroborating" value="Corroborating"> Other Corroborating Evidences</label>
      <input type="text" class="form-control evidence-input" style="display: inline-block;">
    </p>
  </div>
</div>

<button id="submit-form" type="button" class="btn btn-primary">+ ADD</button>

<div id="styled-output" class="styled-output"></div>

    </div>
    </div>
            
         

                      <div class="row " style="margin-top:50px;">
                    <div class="col-md-10  col-12 mx- auto offset-md-1">
          
          
                      <div class="login-form">
          
                       
                        <div class="row asd d-flex">

                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc" id="fileContainer">
      <!-- Hidden file input -->
      <input type="file" class="file-input" multiple id="fileInput1">
  </div>




<div style="margin-bottom: 10px; font-family: Arial, sans-serif;">
  <label for="name-designation" style="display: block; font-weight: bold; margin-bottom: 5px;">Name & Designation:</label>
  <input type="text" id="name-designation" name="name-designation" 
         placeholder="Enter your name and designation" 
         style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; letter-spacing: 1px;">
</div>


  <!-- Button to trigger the file input -->
  <label>Choose Multiple Files   <abbr style="
    color: red;
"><i>(Supported image file formats - jpeg/png/jpg)</i></abbr></label>
  <button id="addFilesBtn" type="button">+ Add Images</button>

  <!-- Button to submit files -->
  <button id="submitFiles" type="button" >Final Submit</button>
                                <button class="prnt" type="button" onclick="printzx()" ><i class="fa fa-print"></i>&nbsp;&nbsp;Print</button>
  <div id="imagePreviewContainer" class="image-preview-container"></div>
          
                             <div class="col-lg-4  col-sm-4 col-xs-4 abc d-none">

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
                                                  document.getElementById('hiden').value = e.target.result;
                                                  document.getElementById('hidden').value = input.files[0].name;


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



                          <div class="col-lg-4  col-sm-4 col-xs-4 abc d-none">

                             
          
                           <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
          
                          </div>
          
                        
                          <div class="col-lg-4  col-sm-4 col-xs-4 d-none">

   
          
 <button class="btnx mt-4" type="button" onclick="print()" >Print</button>
          
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