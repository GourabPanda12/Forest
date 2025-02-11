﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="casediary.aspx.cs" Inherits="casediary" %>


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

	<title>Case Diary</title>

       <script type="text/javascript">
           var rqtn = [];
           const tableData = [];
           $(document).ready(function () {

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

               $('#appendButton').click(function () {
                   const date = $('#dateInput').val();
                   const time = $('#timeInput').val();
                   const description = $('#descriptionInput').val();
                   tableData.push([date, time, description]);

                   // Select the last input (of type text, datetime, and date) and the last textarea within the form
                   var formData = $('.login-form').find(' input[type="time"]:last, input[type="date"]:last, textarea:last').map(function () {
                       // Get the label text and field value
                       var fieldLabel = $(this).siblings('label').text(); // Get the label text
                       var fieldValue = $(this).val() || $(this).text();  // Get the field value

                       // Return the formatted label and value in a styled div
                       return $('<div>').addClass('appended-item').append(
                           $('<strong>').text(fieldLabel), // Bold label
                           $('<span>').addClass('ml-2').text(fieldValue)   // Field value
                       );
                   }).get();

                   // Create a new section to append the form data
                   var newSection = $('<div>').addClass('appended-section p-3 mt-3 border border-primary rounded').append(
                       $('<h5>').addClass('text-center').text('Case Diary Data'),
                       formData
                   );

                   // Append the new section to the target area
                   $('#appendArea').append(newSection);
               });


               $('#txtcno').autocomplete({
                   source: function (request, response) {
                       $.ajax({
                           type: "POST",
                           url: "characteranteced.aspx/GetAutoCompleteData",
                           data: JSON.stringify({ prefix: request.term }),
                           contentType: "application/json; charset=utf-8",
                           dataType: "json",
                           success: function (data) {
                               response($.map(data.d, function (item) {
                                   return {
                                       label: item.ServiceName,
                                       value: item.ServiceName,
                                       id: item.Id,
                                       categoryId: item.CategoryId,
                                       subCategoryId: item.SubCategoryId
                                   };
                               }));
                           },
                           error: function (error) {
                               console.log("Error:", error);
                           }
                       });
                   },
                   select: function (event, ui) {
                       // Set the selected item ID, category ID, and subcategory ID in hidden fields
                       //$('#selectedServiceId').val(ui.item.id);
                       //$('#selectedServiceCategoryId').val(ui.item.categoryId);
                       //$('#selectedServiceSubCategoryId').val(ui.item.subCategoryId);
                       // location.href = "catgry.aspx?cubd=" + ui.item.categoryId + "&cnnm=" + ui.item.label;

                   },
                   minLength: 2 // Set the minimum length of input to trigger autocomplete
               });
           });
           function sub() {
               $(".loading").show();

               $.ajax({
                   type: "POST",
                   url: "characteranteced.aspx/Insert",
                   data: '{ cmndctno:"' + $("#txtcno").val() + '",firno:"' + $("#txtfir").val() + '",pic:"' + $("#hiden").val() + '" ,path:"' + $("#hidden").val() + '"}',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: OnSuccessrrd,
                   failure: function (response) {
                       alert(response.d);
                   }
               });

               function OnSuccessrrd(response) {
                   $(".file-upload-image").attr("src", "");
                   $("#txtcno").val('');
                   $("#hiden").val('');
                   $("#hidden").val('');
                   $(".loading").hide();
                   $("#alertdvd1").show();

                   // alert("You have Submited Fir Copy with respective case number successfully!"); txtcno

                   // window.location.reload(); 
               }
           }
           function print() {
            
                   const { jsPDF } = window.jspdf;
                   const doc = new jsPDF();

                   // Title and Header
                   doc.setFontSize(16);
                   doc.setFont("times", "bold");
                   doc.text("FOREST DEPARTMENT, ODISHA", 60, 15);

                   doc.setFontSize(14);
                   doc.text("CASE DIARY", 85, 25);

                   // Underlined Section
                   doc.setFontSize(12);
                   doc.text("UNDER SECTION 192 OF THE BHARATIYA NAGARIK SURAKSHA SANHITA, 2024", 20, 35);
                   doc.line(20, 36, 190, 36); // Underline
                   doc.setFontSize(12);
                   doc.text("2(b)CC 01/2024-25", 85, 45);

                   // Case Information

               doc.text("Forest Range Office- ", 20, 60);
               doc.setFont("Times", "bold");
               doc.text($('#froma').val(), 35, 59);



               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Division-  ", 20, 67);
               doc.setFont("Times", "bold");
               doc.text($('#fromb').val(), 28, 66);



               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("WLOR No- OR Case No- ", 20, 74);
               doc.setFont("Times", "bold");
               doc.text($('#fromc').val(), 40, 73);


               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Case Diary No.  ", 20, 81);
               doc.setFont("Times", "bold");
               doc.text($('#fromd').val(), 32, 80);

               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("place- ", 20, 88);
               doc.setFont("Times", "bold");
               doc.text($('#place').val(), 27, 87);


               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Species involved –  ", 20, 95);
               doc.setFont("Times", "bold");
               doc.text($('#frome').val(), 28, 94);



               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Description of article seized- ", 20, 102);
               doc.setFont("Times", "bold");
               doc.text($('#address').val(), 40, 101);



               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Name and address of Suspected /accused-", 20, 109);
               doc.setFont("Times", "bold");
               doc.text($('#addressx').val(), 45, 108);


               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Sections of Law -  ", 20, 116);
               doc.setFont("Times", "bold");
               doc.text($('#fromf').val(), 28, 115);


               doc.setFont("times", "normal");
               doc.setFontSize(12);
               doc.text("Name and designation if Investigating Officer- ", 20, 123);
               doc.setFont("Times", "bold");
               doc.text($('#fromg').val(), 45, 122);



                   // Table Header
                   const startY = 125;
                   const marginBottom = 20; // Add margin at the bottom of the table
                   doc.setFont("times", "bold");
                   doc.text("Date", 25, startY);
                   doc.text("Time", 60, startY);
                   doc.text("Description", 90, startY);

                   // Draw table header and initial lines
                   doc.line(20, startY - 5, 190, startY - 5); // Top border
                   doc.line(20, startY + 2, 190, startY + 2); // Bottom border of header
                   doc.line(20, startY - 5, 20, startY + 2 + 10 * 20); // Left border
                   doc.line(190, startY - 5, 190, startY + 2 + 10 * 20); // Right border
                   doc.line(55, startY - 5, 55, startY + 2 + 10 * 20); // Column 1 separator
                   doc.line(85, startY - 5, 85, startY + 2 + 10 * 20); // Column 2 separator

                   // Table Data
                 

                   // Populate Table Data
                   let rowY = startY + 10;
                   doc.setFont("times", "normal");




                   tableData.forEach((row, rowIndex) => {
                       doc.text(row[0], 25, rowY);
                       doc.text(row[1], 60, rowY);

                       // Handle multiline text for justified description
                       const descriptionLines = doc.splitTextToSize(row[2], 95);
                       descriptionLines.forEach((line, i) => {
                           // Check if the current position exceeds the page height
                           if (rowY + i * 6 >= doc.internal.pageSize.height - 20) { // Adjust the margin as needed
                               doc.addPage();
                               rowY = 20; // Reset rowY to the top margin on the new page
                           }

                           const textWidth = doc.getTextWidth(line);
                           const spaceToFill = 95 - textWidth;
                           const words = line.split(" ");
                           const spaceCount = words.length - 1;
                           const extraSpace = spaceCount > 0 ? spaceToFill / spaceCount : 0;

                           let justifiedLine = "";
                           words.forEach((word, index) => {
                               justifiedLine += word;
                               if (index < spaceCount) {
                                   justifiedLine += " ";
                               }
                           });

                           doc.text(justifiedLine, 90, rowY + i * 6, { maxWidth: 100, align: "justify", lineHeightFactor: 1.5 });
                       });

                       // Update rowY for the next row
                       rowY += descriptionLines.length * 6 + 4;

                       // Check if rowY exceeds the page height, add a new page if needed
                       if (rowY >= doc.internal.pageSize.height - 20) { // Adjust the margin as needed
                           doc.addPage();
                           rowY = 20; // Reset rowY for the new page
                           // doc.line(20, 20, 190, 20); // Top border
                           //   doc.line(20, startY + 2, 190, startY + 2); // Bottom border of header
                           doc.line(20, 10, 20, startY + 2 + 10 * 20); // Left border
                           doc.line(190, 10, 190, startY + 2 + 10 * 20); // Right border
                           doc.line(55, 10, 55, startY + 2 + 10 * 20); // Column 1 separator
                           doc.line(85, 10, 85, startY + 2 + 10 * 20); // Column 2 separator
                       }
                   });


                   // Extend the bottom border to the last row and add bottom margin
                   //  doc.line(20, rowY - 4, 290, rowY - 4); // Bottom border of table


          


              

               // Set margins
               const margin = 10; // Increased margin
               const pageWidth = doc.internal.pageSize.getWidth();
               const pageHeight = doc.internal.pageSize.getHeight();
               const maxContentWidth = pageWidth - 2 * margin; // Maximum content width

               // Add background color
               doc.setFillColor(255, 255, 255); // Light lavender color
               doc.rect(0, 0, pageWidth, pageHeight, 'F');

               // Add header section
               const logoWidth = 60;  // Adjust logo width
               const logoHeight = 40; // Adjust logo height
               const logoX = (pageWidth - logoWidth) / 2; // Center logo horizontally
               //  doc.addImage(imgData, 'PNG', logoX, margin, logoWidth, logoHeight); // Position and size of the logo

               // Add address text
               doc.setFontSize(16); // Increase font size for the company name
               doc.setTextColor(40, 40, 40);
               doc.text('', pageWidth / 2, margin + 55, { align: 'center' }); // Center and adjust y position

               doc.setFontSize(12); // Slightly larger font size for the address
               doc.text('', pageWidth / 2, margin + 65, { align: 'center' }); // Center and adjust y position
               doc.text('', pageWidth / 2, margin + 80, { align: 'center' });
               // doc.text('Phone: (123) 456-7890', pageWidth / 2, margin + 95, { align: 'center' });

               // Add a heading
               doc.setFontSize(24);
               doc.setTextColor(0, 51, 102); // Dark blue color
               doc.text('', pageWidth / 2, 130, { align: 'center' }); // Adjusted y position for heading
               const caseNumber = 'Case No:' + localStorage.getItem('caseno');
               doc.setFontSize(12);
               doc.setTextColor(0, 0, 0); // Black color
            //   doc.text(caseNumber, margin, margin + 10); // Top left corner

               //// Add date to top right corner
               //const currentDate = new Date().toLocaleDateString(); // Format the date as needed
               //doc.text(`Date: ${currentDate}`, pageWidth - margin, margin + 10, { align: 'right' });



              


               const pdfWidth = doc.internal.pageSize.getWidth();
               const topMargin = 10;
               const gradientHeight = 30; // Height of the gradient
               const stepCount = 50; // Number of gradient steps

               // Gradient Header Settings
               const startColor = [0, 102, 204]; // Dark Blue RGB
               const endColor = [0, 153, 102];   // Dark Green RGB

               // Draw Gradient Header starting after the margin
               // GRADIENT 

               for (let i = 0; i <= stepCount; i++) {
                   const ratio = i / stepCount;
                   const red = Math.round(startColor[0] * (1 - ratio) + endColor[0] * ratio);
                   const green = Math.round(startColor[1] * (1 - ratio) + endColor[1] * ratio);
                   const blue = Math.round(startColor[2] * (1 - ratio) + endColor[2] * ratio);

                   doc.setFillColor(red, green, blue);
                   // doc.rect(0, topMargin + i * (gradientHeight / stepCount), pdfWidth, (gradientHeight / stepCount), 'F');
               }

               // Add Text Above Gradient
               //doc.setFontSize(16);
               //doc.setTextColor(0); // White text color
               //doc.text("Case Diary", pdfWidth / 2, topMargin + 15, { align: "center" });

               // Set initial y position below the gradient header
               let yPosition = topMargin + gradientHeight + 10;
               doc.setFontSize(12);



               const contentHeight = pageHeight - margin; // Usable content height per page

               // let yPosition = margin; // Initial y position for content

               function addTextToPDF(doc, text, x, y, fontSize = 12, color = 'black') {
                   doc.setTextColor(color);
                   doc.setFontSize(fontSize);
                   doc.text(text, x, y);
                   yPosition = y + fontSize * 1.5; // Update yPosition after adding text
                   if (yPosition > contentHeight) {
                       doc.addPage();
                       yPosition = margin; // Reset yPosition after adding a new page
                   }
               }

               function addHTMLToPDF(doc, htmlContent, x, y, fontSize = 12, color = 'black') {
                   const lines = doc.splitTextToSize(htmlContent, doc.internal.pageSize.width - 20);
                   lines.forEach((line, index) => {
                       if (yPosition > contentHeight) {
                           doc.addPage();
                           yPosition = margin; // Reset yPosition after adding a new page
                       }
                       addTextToPDF(doc, line, x, y + (index * fontSize * 1.5), fontSize, color);
                   });
               }

               var spx = 0;
               var spn = "na";
               // Extract and format content from HTML
               //$('.appended-section').each(function () {
               //    if (spx > 0) {


               //        const sectionTitle = $(this).find('h5').text();
               //        addTextToPDF(doc, sectionTitle, 10, yPosition, 14, 'black'); // Section title with size 14

               //        $(this).find('.appended-item').each(function (index) {
               //            if (index < 11) return;

               //            const label = $(this).find('strong').text();
               //            const value = $(this).find('span').text();

               //            // Split the label text to fit within 150px and make it bold
               //            const wrappedLabel = doc.splitTextToSize(label, 125);
               //            doc.setFontSize(14);
               //            doc.setFont('helvetica', 'bold'); // Set the font to bold for the label
               //            doc.text(wrappedLabel, 10, yPosition); // Position the label at the left (10px margin)

               //            // Move yPosition for each line of label text
               //            yPosition += wrappedLabel.length * 14 + 1; // Add extra space between lines (5px)

               //            // Split the value text to fit within 200px
               //            const wrappedValue = doc.splitTextToSize(value, 300);
               //            doc.setFontSize(12);
               //            doc.setFont('helvetica', 'normal'); // Set the font to normal for the value
               //            doc.text(wrappedValue, 130, yPosition); // Position the value at 120px from the left

               //            // Move yPosition for each line of value text
               //            yPosition += wrappedValue.length * 12; // Add extra space between lines (10px)

               //            if (yPosition > 580) {
               //                doc.addPage();
               //                yPosition = 20; // Reset yPosition after adding a new page
               //            }
               //        });

               //        // Add space between sections and check again for page overflow
               //        yPosition += 20;
               //        if (yPosition > 580) {
               //            doc.addPage();
               //            yPosition = 20; // Reset yPosition after adding a new page
               //        }
               //    }
               //    else {
               //        const sectionTitle = $(this).find('h5').text();
               //        addTextToPDF(doc, sectionTitle, 10, yPosition, 14, 'black'); // Section title with size 14

               //        $(this).find('.appended-item').each(function () {
               //            const label = $(this).find('strong').text();
               //            const value = $(this).find('span').text();

               //            // Split the label text to fit within 150px and make it bold
               //            const wrappedLabel = doc.splitTextToSize(label, 125);
               //            doc.setFontSize(14);
               //            doc.setFont('helvetica', 'bold'); // Set the font to bold for the label
               //            doc.text(wrappedLabel, 10, yPosition); // Position the label at the left (10px margin)

               //            // Move yPosition for each line of label text
               //            yPosition += wrappedLabel.length * 14 + 1; // Add extra space between lines (5px)

               //            // Split the value text to fit within 200px
               //            const wrappedValue = doc.splitTextToSize(value, 300);
               //            doc.setFontSize(12);
               //            doc.setFont('helvetica', 'normal'); // Set the font to normal for the value
               //            doc.text(wrappedValue, 130, yPosition); // Position the value at 120px from the left

               //            // Move yPosition for each line of value text
               //            yPosition += wrappedValue.length * 12; // Add extra space between lines (10px)

               //            if (yPosition > 580) {
               //                doc.addPage();
               //                yPosition = 20; // Reset yPosition after adding a new page
               //            }
               //        });

               //        // Add space between sections and check again for page overflow
               //        yPosition += 20;
               //        if (yPosition > 580) {
               //            doc.addPage();
               //            yPosition = 20; // Reset yPosition after adding a new page
               //        }
               //    }
                  
               //    spx = 11;
               //});


               doc.addPage();
               yPosition = 20;
                rqtn.forEach((item, index) => {
                  // Center "Document Uploaded" Text
                  doc.setTextColor(0, 0, 0);
                  doc.text(`Document Uploaded:-  ${item.caseno}`, pdfWidth / 2, yPosition, { align: "center" });
                  yPosition += 20; // Increase spacing between text and image

                  // Calculate center position for the image
                  const imgWidth = pdfWidth * 0.8; // Adjust image width to 80% of the page width
                  const imgHeight = imgWidth * 0.75; // Maintain a fixed aspect ratio for the image
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
                  const isLastItem = index === rqtn.length - 1; // Check if this is the last item
                  if (!isLastItem && yPosition + imgHeight + 20 > doc.internal.pageSize.getHeight()) {
                      doc.addPage(); // Add new page if not the last item
                      yPosition = 20; // Reset y position for the new page
                  }
              });

               doc.save('case-document-casediary.pdf');

               const pdfBase64 = doc.output('datauristring').split(',')[1];
               var caseNo = localStorage.getItem('caseno');
               var pageName = window.location.pathname.split('/').pop();
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
	
	.appended-section {
    background-color: #f9f9f9;
}

.appended-item {
    margin-bottom: 15px;
}

.appended-item strong {
    display: inline-block;
    font-weight: bold;
    margin-right: 10px;
}

.appended-item span {
    display: inline-block;
    color: #555;
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
                      <div class="row asd d-flex">
                       
                        <div>
                            <h3 class="text-center" style="color: #000; margin-top: 30px;">Case Diary </h3>
                    
                        </div>


             
                <div class="row pt-4">
                    <div class="col-md-6" style="display:none;">
                        <label for="refNumber">Command Certificate No:</label>
                        <input type="text" class="form-control" id="fromz" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime" style="display:none;">FIR No:</label>
                        <input type="text" class="form-control" id="fromy" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="refNumber">Forest Range Office:</label>
                        <input type="text" class="form-control" id="froma" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Division:</label>
                        <input type="text" class="form-control" id="fromb" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="refNumber">WLOR No- OR Case No.:</label>
                        <input type="text" class="form-control" id="fromc" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Case Diary No.:</label>
                        <input type="text" class="form-control" id="fromd" placeholder="">
                    </div>
                </div> 

                

                <div class="row pt-4 pb-4"> 
                     <h6 class="" style="color: #000;">(Occurrence) </h6>

                  
                </div> 

                
                 <div class="form-group form-section">
                     <label for="from">Species Involved:</label>
                     <input type="text" class="form-control" id="frome" placeholder="">
                 </div>

                 <div class="form-group form-section">
                     <label for="address">Description of Article Seized :</label>
                     <textarea class="form-control" id="address" rows="3" placeholder=""></textarea>
                 </div>

                 <div class="form-group form-section">
                    <label for="address">Name and Address of Suspected / Accused :</label>
                    <textarea class="form-control" id="addressx" rows="3" placeholder=""></textarea>
                </div>


                <div class="row pb-4"> 
                    <h6 class="" style="color: #000;">Sections of LAW- </h6>

                   <div class="col-md-6">
                       <label for="refNumber">Name of Investigation Officer :</label>
                       <input type="text" class="form-control" id="fromf" placeholder="">
                   </div>
                   
                   <div class="col-md-6">
                       <label for="dateTime">Designation of Investigation Officer :</label>
                       <input type="text" class="form-control" id="fromg" placeholder="">
                   </div>
               </div> 



               <div class="row pb-4"> 

               <div class="col-md-6">
                   <label for="refNumber">Place, Date and Time Visited for the Purpose of Investigation :</label>
                     <div class="col-md-12">
                        <label for="dateTime">Place:</label>
                        <input type="text" class="form-control" id="place" placeholder="">
                    </div>
                    <div class="col-md-12">
                        <label for="refNumber">Date:</label>
                        <input type="date" class="form-control" id="dateInput" placeholder="">
                    </div>
                    <div class="col-md-12">
                        <label for="dateTime">Time:</label>
                        <input type="time" class="form-control" id="timeInput" placeholder="">
                    </div>
                  
                </div>
               
               <div class="col-md-6">
                   <label for="dateTime">Record of Investigation :</label>
                   <textarea class="form-control" id="descriptionInput" rows="7" placeholder=""></textarea>
                </div>
           </div> 

    
                    
            
            </div>
					   <button id="appendButton" type="button" class="btn btn-primary mt-3">+ ADD</button>  
        </div>
    </div>
</div>
<div id="appendArea" class="container mt-5"></div>

            
         
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
                                <button class="prnt" type="button" onclick="print()" ><i class="fa fa-print"></i>&nbsp;&nbsp;Print</button>
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