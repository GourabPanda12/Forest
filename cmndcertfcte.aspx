﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cmndcertfcte.aspx.cs" Inherits="cmndcertfcte" %>


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

	<title>Command Certificate</title>


    <script>


        var patroling = [];
        var other = [];
        var cmdct = [];
        var rqtn = [];
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



            $('#txtcaseno').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "cmndcertfcte.aspx/GetAutoCompleteData",
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
            // Add input field on button click
            $('.add1').click(function () {
                // Get the value of the input field
                var inputValue = $('#txto').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#cmndCrtfcte').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the cmndCrtfcte div
                $('#cmndCrtfcte').append(newInput);

                // Clear the input field
                $('#txto').val('');

                // Remove input field on close button click
                $('#cmndCrtfcte').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                // Collect JSON data
                var patrolingdata = [];
                $('#cmndCrtfcte').find('.input-container').each(function () {
                    var value = $(this).find('input').val();
                    patrolingdata.push({ value: value });
                });

                var to = $("#txto").val();
                patroling.push({

                    to: to

                });
            });

            // Add input field on button click
            $('.add2').click(function () {
                // Get the value of the input field
                var inputValue = $('#txtoo').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#cmndCrtfctex').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the cmndCrtfcte div
                $('#cmndCrtfctex').append(newInput);

                // Clear the input field
                $('#txtoo').val('');

                // Remove input field on close button click
                $('#cmndCrtfctex').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                // Collect JSON data
                var oherprpose = [];
                $('#cmndCrtfctex').find('.input-container').each(function () {
                    var value = $(this).find('input').val();
                    oherprpose.push({ value: value });
                });

                var tox = $("#txtoo").val();
                other.push({

                    tox: tox

                });

            });

            $('#slctcrfcte').change(function () {
                var selectedValue = $(this).val();
                $('.section').hide();
                if (selectedValue) {
                    $('#' + selectedValue).show();
                }
            });


        });




        function sub() {
            var caseNo = localStorage.getItem('caseno');
            console.log(caseNo);

            $(".loading").show();

            $.ajax({
                type: "POST",
                url: "cmndcertfcte.aspx/Insert",
                data: JSON.stringify({
                    pic: $("#hiden").val(),
                    path: $("#hidden").val(),
                    caseno: caseNo
                }),
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



        // Save form data to local storage
        function restoredt() {
            $('.savedt').each(function (index) {
                localStorage.setItem('field' + index, $(this).val());
            });

            // Save the count of filled fields
            var filledFieldsCount = $('.savedt').filter(function () {
                return $(this).val() !== '';
            }).length;
            localStorage.setItem('filledFieldsCount', filledFieldsCount);
        }

        // Restore form data from local storage
        function restoreData() {
            $('.savedt').each(function (index) {
                if (localStorage.getItem('field' + index) !== null) {
                    $(this).val(localStorage.getItem('field' + index));
                }
            });

            // Set focus to the next unfilled field
            var filledFieldsCount = localStorage.getItem('filledFieldsCount') || 0;
            if ($('.savedt').eq(filledFieldsCount).length) {
                $('.savedt').eq(filledFieldsCount).focus();
            }
        }

        function print() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            // HEADER SECTION

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

         


            const pdfWidth = doc.internal.pageSize.getWidth();
            const topMargin = 10;
            const gradientHeight = 30; // Height of the gradient
            const stepCount = 50; // Number of gradient steps

            // Gradient Header Settings
          

            // Draw Gradient Header starting after the margin
            // GRADIENT 

         

            // Add Text Above Gradient
            doc.setFont("times", "bold");
            doc.setFontSize(20);
            doc.text("Form of Direction to Sub-ordinate staffs for", 35, 20);
            doc.line(35, 21, 170, 21);  // Draws a line under the text

            doc.text("Patrolling duty", 80, 28);
            doc.line(80, 29, 125, 29);

            // Command Certificate Title
            doc.setFont("times", "bold");
            doc.setFontSize(16);
            doc.text("COMMAND CERTIFICATE", 75, 50);
            doc.line(75, 51, 145, 51);



            // Initial Y position for "To" label
            let yPosition = 60;

            // Add "To" field to the PDF
            doc.setFont("times", "bold");
            doc.setFontSize(14);
            doc.text("To", 20, yPosition);

            // Increase Y position for the list of recipients
            yPosition += 10; // Adjust spacing after the "To" label

            // Extract and add each input value to the PDF
            $('#cmndCrtfcte .input-container input').each(function (index) {
                let value = $(this).val();
                if (value) { // Ensure only non-empty values are added
                    doc.setFont("times", "bold");
                    doc.setFontSize(14);
                    doc.text(`${index + 1}. ${value}`, 20, yPosition);
                    yPosition += 10; // Move down for the next field, adjust as necessary for spacing
                }
            });
            const areaField = $('#txtof').val();
            const datax = $('#abcd').val();
            // Add the directive text or any subsequent content after the list
            yPosition += 20; // Adjust for spacing after the last item in the list

            // Example for adding directive text after the dynamic list
          

            doc.setFont("times", "normal");
            const directiveText = `You the above noted persons are hereby directed to make patrolling duty inside / outside of '${areaField}' area as '${datax}'.`;
            doc.text(directiveText, 20, 115, { maxWidth: 170, align: "justify", lineHeightFactor: 1.5 });

            // Signature
            // Set font properties for the "Range Officer" label
            doc.setFont("times", "normal");
            doc.setFontSize(16);

            // Replace this with your image base64 string
            const imgDatax = $("#hidenx").val();

          
           

           
            doc.addImage(
                imgDatax,
                'JPEG',
                150,
                150,
                35,
                15
            );

            // Add "Range Officer" label below the image
            doc.setFont("times", "normal");
            doc.text("Range Officer", 155, 170);


            // Add a new page
            doc.addPage();


         

            // Calculate the width of the rectangle based on the text width
            doc.setFont("times", "bold");
            doc.setFontSize(20);
            doc.text("Form of Written Order to subordinate staff", 35, 20);
            doc.line(35, 21, 170, 21);

            doc.text("for duty or for any other purpose", 55, 28);
            doc.line(55, 29, 155, 29);

            // Command Certificate Title
            doc.setFont("times", "bold");
            doc.setFontSize(16);
            doc.text("COMMAND CERTIFICATE", 65, 45);
            doc.line(65, 46, 140, 46);

            // Recipient List
             yPosition = 55; // Starting position for "To"

            // Add "To" field to the PDF
            doc.setFont("times", "bold");
            doc.setFontSize(14);
            doc.text("To", 20, yPosition);

            // Increase Y position for the start of the recipient list
            yPosition += 10; // Adjust spacing after the "To" label

            // Extract and add each input value to the PDF
            $('#cmndCrtfctex .input-container input').each(function (index) {
                let value = $(this).val();
                if (value) { // Ensure only non-empty values are added
                    doc.setFont("times", "bold");
                    doc.setFontSize(14);
                    doc.text(`${index + 1}. ${value}`, 20, yPosition);
                    yPosition += 10; // Move down for the next entry, adjust as necessary for spacing
                }
            });

            // Example for adding subsequent content, if needed
            yPosition += 20;
            const data = $('#abcd2').val();
            // Directive Text on Page 2
            doc.setFont("times", "normal");
            const directiveTextPage2 = `You the above noted persons are hereby directed to'${data}'.`;
            doc.text(directiveTextPage2, 20, 105, { maxWidth: 170, align: "justify", lineHeightFactor: 1.5 });

            // Signature on Page 2
            doc.setFont("times", "normal");
            doc.setFontSize(16);

            // Replace this with your image base64 string
            const imgData = $("#hiden").val();

            // Calculate page width for positioning
            //   const pageWidth = doc.internal.pageSize.getWidth();
          

            // Add the image to the PDF at the specified position
            doc.addImage(
                imgData,
                'JPEG',
                150,
              150,
                35,
                15
            );

            // Add "Range Officer" label below the image
            doc.setFont("times", "normal");
            doc.text("Range Officer", 155, 170);



           

          
            doc.addPage();
            yPosition = 20;

            rqtn.forEach(item => {
                // Center "Document Uploaded" Text
                doc.setTextColor(0, 0, 0);
                doc.text(`Document Uploaded: ${item.caseno}`, pdfWidth / 2, yPosition, { align: "center" });
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

            doc.save('case-document-cmndcrt.pdf');
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



        $(document).ready(function () {
            restoreData();
        });

    </script>

   

<style>

    #abcd2{
            height: 150px;
    width: 55%;
    margin-left: 33px;
    }
     #abcd{
            height: 150px;
    width: 55%;
    margin-left: 33px;
    }
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

 .alert {
  padding: 20px;
  background-color: #f44336;
  color: white;
  opacity: 1;
  transition: opacity 0.6s;
  margin-bottom: 15px;
  position:absolute;
  z-index:99999;
  top:20%;
  left:30%;
}

.alert.success {background-color: #04AA6D;}
.alert.info {background-color: #2196F3;}
.alert.warning {background-color: #ff9800;}

.closebtn {
  margin-left: 15px;
  color: white;
  font-weight: bold;
  float: right;
  font-size: 22px;
  line-height: 20px;
  cursor: pointer;
  transition: 0.3s;
}

.closebtn:hover {
  color: black;
}
    /* Absolute Center Spinner */
.loading {
  position: fixed;
  z-index: 99999;
  height: 2em;
  width: 2em;
  overflow: show;
  margin: auto;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
}

/* Transparent Overlay */
.loading:before {
  content: '';
  display: block;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
    background: radial-gradient(rgba(20, 20, 20,.8), rgba(0, 0, 0, .8));

  background: -webkit-radial-gradient(rgba(20, 20, 20,.8), rgba(0, 0, 0,.8));
}

/* :not(:required) hides these rules from IE9 and below */
.loading:not(:required) {
  /* hide "loading..." text */
  font: 0/0 a;
  color: transparent;
  text-shadow: none;
  background-color: transparent;
  border: 0;
}

.loading:not(:required):after {
  content: '';
  display: block;
  font-size: 10px;
  width: 1em;
  height: 1em;
  margin-top: -0.5em;
  -webkit-animation: spinner 150ms infinite linear;
  -moz-animation: spinner 150ms infinite linear;
  -ms-animation: spinner 150ms infinite linear;
  -o-animation: spinner 150ms infinite linear;
  animation: spinner 150ms infinite linear;
  border-radius: 0.5em;
  -webkit-box-shadow: rgba(255,255,255, 0.75) 1.5em 0 0 0, rgba(255,255,255, 0.75) 1.1em 1.1em 0 0, rgba(255,255,255, 0.75) 0 1.5em 0 0, rgba(255,255,255, 0.75) -1.1em 1.1em 0 0, rgba(255,255,255, 0.75) -1.5em 0 0 0, rgba(255,255,255, 0.75) -1.1em -1.1em 0 0, rgba(255,255,255, 0.75) 0 -1.5em 0 0, rgba(255,255,255, 0.75) 1.1em -1.1em 0 0;
box-shadow: rgba(255,255,255, 0.75) 1.5em 0 0 0, rgba(255,255,255, 0.75) 1.1em 1.1em 0 0, rgba(255,255,255, 0.75) 0 1.5em 0 0, rgba(255,255,255, 0.75) -1.1em 1.1em 0 0, rgba(255,255,255, 0.75) -1.5em 0 0 0, rgba(255,255,255, 0.75) -1.1em -1.1em 0 0, rgba(255,255,255, 0.75) 0 -1.5em 0 0, rgba(255,255,255, 0.75) 1.1em -1.1em 0 0;
}

/* Animation */

@-webkit-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-moz-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-o-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
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

   .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 1000 !important;
        }
        .ui-menu-item-wrapper {
            font-size: 14px;
        }
        .ui-widget.ui-widget-content {
    border: 1px solid #c5c5c5;
    width: 185px;
    top: 48.5px;
    left: 109.484px;
    display: block;
    background-color: #422f86;
    color: white;
}

 .form p{
            color: #fff;
    font-size: 20px;

        }
        .form input{
            height: 25px;
    border-radius: 5px;
        }
        .frsm{
            margin-left: 5%;
            width: 95%;
        }
        .fr p{
            text-align: center;
    color: #000;
    font-weight: bold;
    margin: 0 0;

        }
        .note p{
            color: #000;
    padding: 5px;
    margin: 5px;

        }
        .note span{
            font-weight: bold;
        }

.section {
            display: none;
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
</style>

</head>
<body>

      <form id="form1" runat="server">

       
       
<div class="alert success" id="alertdvd1" style="display:none;">
  <span class="closebtn">&times;</span>  
  <strong>Success!</strong> You have Submited Fir Copy with respective case number successfully!
</div>
<script>
    var close = document.getElementsByClassName("closebtn");
    var i;

    for (i = 0; i < close.length; i++) {
        close[i].onclick = function () {
            var div = this.parentElement;
            div.style.opacity = "0";
            setTimeout(function () {
                div.style.display = "none";
                window.location.reload(); // Reload the page
            }, 600);
        }
    }
</script>

        
          <input type="hidden" value="" id="hiden" runat="server" /> <input type="hidden" value="" runat="server" id="hidden"  />


          <aside id="sidebar">
            <!--
                <li>
                    <a href="" style="font-weight: 500; font-size: 10px;"><i class="fa fa-dashboard"></i><span>BLACK TIGER</span></a>
                  </li>
            
                -->
                    <h3 class="for"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>
            
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

            <h2 class="text-center" style="color: #fff;">Command Certificate</h2>
                        <div class="login-form">
            
                          <div class="row asd d-flex">

                            <div class="col-lg-12 col-sm-6 col-xs-6 text-center pb-4">
       <h6>Choose Offence</h6>
         <select id="slctcrfcte" class="form-control">
            <option value="">Select an option</option>
            <option value="patroling">A. Form of Direction to Sub-ordinate staffs for Patrolling duty</option>
            <option value="Purpose">B.Form of Written Order to Subordinate Staff For Duty Or For Any Other Purpose</option>
               
        </select>
    </div>
            
                          
                        </div>
                      </div>
                    </div>
            
                  </div>
            </div>
            
             <div id="patroling" class="row section" style="margin-top:50px;">
            
                                        <div class="col-md-10  col-12 mx- auto offset-md-1">
    
    
                                          <div class="login-form">
    
                                            <h5 class="text-center mb-2 val"></h5>
                                            <div class="row asd d-flex">
              <h5 class="text-center mb-3" style="color:#000;">Form of Direction to Sub-ordinate staffs for Patrolling duty</h5>
                                             <div class="col-lg-12 col-sm-12 col-xs-12">  
    <p style="color:#000;">The Range Officer of the Range or the forester of the Section when ever necessary should direct their sub-ordinate staff with written direction for patrolling or for any other duty as like command certificate issued by the Police Officer to his sub-ordinate staff while deputing them for any duty. The direction should be like under-</p>
     </div>
 <div class="col-lg-12 col-sm-12 col-xs-12">
 <h6 style="color:#000; text-align:center">COMMAND CERTIFICATE</h6>

       </div>

<div class="col-lg-6 col-sm-6 col-xs-6">
 
    <label class="lebl">To</label>
   <input type="text" id="txto" class="form-control console">

       </div>


<div class="col-lg-6 col-sm-6 col-xs-6">
     <p class="button-container mt-4">
    <button class="bt11 add1" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                   </p>
    </div>

                                                         <div id="cmndCrtfcte"></div>
                                                              
                                                
                                                <div class="col-lg-12 col-sm-12 col-xs-12 mb-4">
 <p  style="color:#000;">You the above noted persons are hereby directed to make patrolling duty inside /outside of <input type="text" id="txtof" /> area as <textarea id="abcd"></textarea></p>
                                                                   </div>

 <div class="col-lg-6 col-sm-6 col-xs-6">
   
</div>

                      <div class="col-lg-6 col-sm-6 col-xs-6 mb-3 mt-2">
                      <img class="file-upload-imagex" src="#" alt="your image" />
    <input type="file" id="txtsign" class="form-control console"  onchange="readURLx(this);" accept="image/*">
    <label class="lebl">Range Officer</label>
</div>
                                                <script type="text/javascript" id="rendered-js">
                                                   

                                                    function removeUpload() {
                                                   
                                                    }
                                                   


                                                </script>



                              <div>
    
   
    <h5 style="color:#000;text-align:right;" class="mb-3 mt-3">(K) Proforma of Zimanama</h5>
</div>

                                                </div>
                                                                    </div>
                                                                    </div>

                                                                  </div>
                                                             
                      
       <div id="Purpose" class="row section" style="margin-top:50px;">
                                <div class="form-card">
    
                                 
    
                                       <div class="row ">
                                        <div class="col-md-10  col-12 mx- auto offset-md-1">
    
    
                                          <div class="login-form">
    
                                            <h5 class="text-center mb-2 val"></h5>
                                            <div class="row asd d-flex">
              
                                                
                                              

                                                   <h5 class="text-center mt-4" style="color:#000;font-size:18px;">Form of Written Order to  Subordinate Staff For Duty Or For Any Other Purpose</h5>
                                                 <h5 class="text-center" style="color:#000;">Command Certificate</h5>
                                                
                                                
<div class="col-lg-6 col-sm-6 col-xs-6">
 
    <label class="lebl">To</label>
   <input type="text" id="txtoo" class="form-control console">

       </div>


<div class="col-lg-6 col-sm-6 col-xs-6">
     <p class="button-container mt-4">
    <button class="bt11 add2" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                   </p>
    </div>
                                                         <div id="cmndCrtfctex"></div>

                                                <p style="color:#000;">You the above noted persons are here by directed to <textarea id="abcd2"></textarea></p>

                                      
                                  <div class="col-lg-6 col-sm-6 col-xs-6">
   
</div>               

  <div class="col-lg-6 col-sm-6 col-xs-6 mb-3 mt-2">
                      <img class="file-upload-image" src="#" alt="your image" />
    <input type="file" id="txtsn" class="form-control console"  onchange="readURL(this);" accept="image/*">
    <label class="lebl">Range Officer</label>
</div>
                                                <%--<script type="text/javascript" id="renderedx-js">
                                                    function readURL(input) {
                                                        if (input.files && input.files[0]) {
                                                            //alert($('.file-upload-input').val());
                                                            var reader = new FileReader();

                                                            reader.onload = function (e) {
                                                                //  $('.image-upload-wrap').show();
                                                                //  $('.file-upload-content').show();
                                                                $('.file-upload-image').attr('src', e.target.result);
                                                                document.getElementById('hdnfl1').value = e.target.result;
                                                                document.getElementById('hdnflty1').value = input.files[0].name;


                                                                // $('.image-title').html(input.files[0].name);
                                                            };

                                                            reader.readAsDataURL(input.files[0]);

                                                        } else {
                                                            removeUpload();
                                                        }
                                                    }

                                                    function removeUpload() {
                                                        //    $('.file-upload-input').replaceWith($('.file-upload-input').clone());
                                                        //    $('.file-upload-content').hide();
                                                        // $('.image-upload-wrap').show();
                                                    }
                                                    //$('.image-upload-wrap1').bind('dragover', function () {
                                                    // //   $('.image-upload-wrap1').addClass('image-dropping');
                                                    //});
                                                    //$('.image-upload-wrap1').bind('dragleave', function () {
                                                    //  //  $('.image-upload-wrap1').removeClass('image-dropping');
                                                    //});


                                                </script>--%>

                                                <div>
    
   
    <h5 style="color:#000;text-align:right;" class="mb-3 mt-3">(K) Proforma of Zimanama</h5>
</div>


                                                </div>
                                                                    </div>
                                                                    </div>

                                                                  </div>
                                                                 </div>
           </div>

           

           
             <div id="officers" class="row section" style="margin-top:50px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
				   
				  
      <div class="row">
          <h3  style="font-size:20px; color:#000; text-align:center;">command certificate to be carried by forest officers on duty[Rule_1]</h3>
						
          <div class="col-md-12 fr">		
    <label class="lebl">Respective Case Number</label>
    <input type="text" id="txtcaseno"  class="form-control console savedt" placeholder="">	
 </div>
             <div class="col-md-12 fr">
                <label class="lebl">1. Forest Division/Range</label>
                <input type="text" id="txtdvsn"  class="form-control console savedt" placeholder="">	
             </div>
        </div>
        <div class="row">
											
            <div class="col-md-12 fr">
               <label class="lebl">2. Details of Forest personnel with name</label>
               <input type="text" id="txtdtls"  class="form-control console savedt" placeholder="">	
            </div>
      
    <div class="row">									
        <div class="col-md-12 fr">
           <label class="lebl">3.Where Proceeding</label>
           <input type="text" id="txtwpcdng"  class="form-control console savedt" placeholder="">	
        </div>
   </div>
   <div class="row">
											
        <div class="col-md-12 fr">
            <label class="lebl">4. Description of duty and number of escort requisitions</label>
            <input type="text" id="txtrqtns"  class="form-control console savedt" placeholder="">	
        </div>
    </div>

    <div class="row">								
        <div class="col-md-12 fr">
            <p>DATE AND HOUR OF</p>
        </div>
    </div>
            <input type="hidden" id="hidenx" />
    <div class="row">									
        <div class="col-md-12 frsm">
           <label class="lebl">5. Departure</label>
           <input type="text" id="txtdprtr"  class="form-control console savedt" placeholder="">	
        </div>
   </div>
   <div class="row">									
    <div class="col-md-12 frsm">
        <label class="lebl">6. Arrival</label>
       <input type="text" id="txtarvl"  class="form-control console savedt" placeholder="">	
    </div>
</div>
<div class="row">									
    <div class="col-md-12 frsm">
        <label class="lebl">7. Receiving permission to return with signature of officer giving permission</label>
       <input type="text" id="txtrcv"  class="form-control console savedt" placeholder="">	
    </div>
</div>
<div class="row">
											
    <div class="col-md-12 fr">
        <label class="lebl">8. Date and hour of return to be noted etc.</label>
        <input type="text" id="txtdthr"  class="form-control console savedt" placeholder="">	
    </div>
</div>

    <div class="note">
        <div class="row">
            <div class="col-md-12">
                <p><span>NOTE:</span> If any delay occurs,it will at once be detected from the entries in the last four columns,the delinquent brought to tasks and his explanation taken by the enquiry officer and recorded on the book of the certificate which should then be sent for orders to the divisional Forest officer</p>
            </div>
        </div>
    </div>
   </div>
        </div>
    </div>
 </div>
 </div>
           
             

             
            <div class="row" style="margin-top:-20px;">
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
                                	 <div class="col-lg-3  col-sm-3 col-xs-3 abc d-none">

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


                              <div class="col-lg-3  col-sm-3 col-xs-3 abc d-none">

                               
            
                             <button class="btnz mt-4" type="button">Save</button>
            
                            </div>


                             <div class="col-lg-3 col-sm-3 col-xs-3 abc" style="display:none;">

                               
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                          
                          
 <div class="col-lg-3 col-sm-3 col-xs-3 d-none">

   
            
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
