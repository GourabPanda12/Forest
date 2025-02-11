<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchwrnt2.aspx.cs" Inherits="searchwrnt2" %>


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

	<title>Search warrant by ACF</title>
       <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
    <script>
        var srwnt = [];
        var docx = [];
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

            var caseNo = localStorage.getItem('caseno');
            $(".bt11.add12").on("click", function () {
                // Retrieve values from input fields
                var name = $("#name").val();
                var designation = $("#designation").val();
                var personName = $("#person_name").val();
                var fatherName = $("#father_name").val();
                var village = $("#village").val();
                var policeStation = $("#police_station").val();
                var district = $("#district").val();

                // Create a new formatted data entry
                var newEntry = `
      <div class="entry">
        <h6>Name: ${name}</h6>
        <h6>Designation: ${designation}</h6>
        <p style="color:black;">Person: ${personName} S/o ${fatherName}, Village: ${village}, PS: ${policeStation}</p>
        <hr />
      </div>
    `;

                // Append the new entry to the display div
                $("#data-display").append(newEntry);


                var newData = {
                    "pic": $("#hiden").val(), // Assuming this is for an image or other base64 data
                    "paths": $("#hidden").val(), // Assuming this is for file path or name
                    "caseno": caseNo, // Assuming caseNo is defined elsewhere in your code
                    "name": name,
                    "designation": designation,
                    "personName": personName,
                    "fatherName": fatherName,
                    "village": village,
                    "policeStation": policeStation,
                    

                };

                // Push the newData object to the deput array
                srwnt.push(newData);
                console.log(srwnt);
            });

            
        });


        function sub() {
            var caseNo = localStorage.getItem('caseno');

            // Show loading indicator
            $(".loading").show();
            var newData = {
                "pic": $("#hiden").val(),
                "paths": $("#hidden").val(),
                "caseno": caseNo

            };
            docx.push(newData);
            console.log(docx);
            $.ajax({
                type: "POST",
                url: "searchwrnt.aspx/Insert",
                data: JSON.stringify({
                    caseno: caseNo,
                    pic: $("#hiden").val(),
                    path: $("#hidden").val()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessrrd,
                error: function (response) {
                    alert("Error: " + response.responseText);
                }
            });

            function OnSuccessrrd(response) {
                // Hide loading indicator
                $(".loading").hide();

                // Show success message
                alert("You have Successfully Registered, Thank You");

                // Reload the page
                //  window.location.reload();
            }
        }



        function print() {
           

            // Create new jsPDF instance with portrait orientation, A4 size, and units in px
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

        

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
            // doc.addImage(imgData, 'PNG', logoX, margin, logoWidth, logoHeight); // Position and size of the logo

            // Add address text
            const memoNo = $("#txtmem").val();
            const date = $("#dtx").val();
            const name = $("#namex").val();
            const designation = $("#designationx").val();
            const division = $("#Division").val();
            const house = $("#cdef").val();
            const sriSmtName = $("#person_name").val();
            const fatherName = $("#father_name").val();
            const villageName = $("#village").val();
            const policeStation = $("#police_station").val();
            const districtName = $("#district").val();
            const used = $("#abcd").val();
            const divisionName = $("#xyz").val();

            // Set titleabcd
            doc.setFontSize(16);
            doc.setFont("times", "bold");
            doc.text("Warrant to search suspected place of deposit", 50, 20);
            doc.setFontSize(12);
            doc.setFont("times", "normal");
            doc.text("[section 77 of odisha forest act, 1972]", 55, 28);

            // Centered Memo No. field with dynamic data
       //     const pageWidth = doc.internal.pageSize.getWidth();
            const memoText = `Memo No ${memoNo} dated ${date}`;
            const memoTextWidth = doc.getTextWidth(memoText);
            doc.text(memoText, (pageWidth - memoTextWidth) / 2, 40);

            // Add "To" field
            doc.setFontSize(12);
            doc.setFont("times", "bold");
            doc.text("To", 20, 50);
            doc.setFont("times", "normal");
            doc.setFontSize(11);
            doc.text(name, 20, 60);
            doc.text(designation, 20, 65);
            doc.text(division, 20, 70);


            // Main body text - WHEREAS section
            const whereasText = `WHEREAS information has been laid before me, and on due enquiry thereupon had, I have been led to believe that ${house} of Sri / Smt. ${sriSmtName} S/o ${fatherName} Vil ${villageName} PS ${policeStation} in the district of ${districtName} is used ${used}.`;

            doc.setFont("times", "normal");
            doc.setFontSize(11);
            doc.text(whereasText, 20, 80, { maxWidth: 170, align: "justify", lineHeightFactor: 1.5 });

            // Authorization paragraph
            const authorizationText = `This is to authorize and require you to enter the said house (or other place) with such assistance (if police help required) as shall be required, and to use, if necessary reasonable force for that purpose, and to search every part of the said house (or other place or if the search is to be confined to part specify the part clearly), and to seize and take possession of any such property or (add, when the case requires it) and any instruments and materials which you may reasonably believe to be kept in connection with such property and forthwith to bring before undersigned / Forest Range Office such of the said things as may be taken possession of, returning this warrant, with an endorsement certifying what you have done under it, immediately upon execution.`;

            doc.text(authorizationText, 20, 120, { maxWidth: 170, align: "justify", lineHeightFactor: 1.5 });

            // Date and signature area
            doc.text(`Dated ${date}`, 20, 190);

            // Right-align for signature fields
            const text1 = "Asst. Conservator of Forests";
            const text2 = `${divisionName} Division`;
            const text1Width = doc.getTextWidth(text1);
            const text2Width = doc.getTextWidth(text2);

            doc.text(text1, pageWidth - text1Width - 20, 210);
            doc.text(text2, pageWidth - text2Width - 20, 220);

            const imgDatax = $("#hidenx").val();



            doc.addImage(
                imgDatax,
                'JPEG',
                pageWidth - text1Width - 20,
                190,
                50,
                15
            );


            // END


            //  INTERNAL SECTION


            const pdfWidth = doc.internal.pageSize.getWidth();
            const topMargin = 10;
            const gradientHeight = 30; // Height of the gradient
            const stepCount = 50; // Number of gradient steps

            // Gradient Header Settings
            const startColor = [0, 102, 204]; // Dark Blue RGB
            const endColor = [0, 153, 102];   // Dark Green RGB

            // Draw Gradient Header starting after the margin
            // GRADIENT 

           
            // Add Text Above Gradient


            doc.addPage();

            let yPosition = 20;

            // IMAGE
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


            // DOWNLOAD
            doc.save('case-document-search.pdf');


            // DATABASE SAVE
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

    #abcd{
        width: 50%;
    height: 100px;
    }
    .nicely-styled-div {
  border: 1px solid #ddd;
  padding: 15px;
  margin-top: 20px;
  background-color: #f9f9f9;
}

.entry {
  margin-bottom: 10px;
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


</style>

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


#newFile p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#newFile input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}

#accusedDetail p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#accusedDetail input[type="text"] {
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

#showLandmark p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#showLandmark input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}

 #searchParty p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#searchParty input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
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

.custodian-info {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
            position: relative;
            color:#000;
        }
        .delete-button {
            position: absolute;
            top: 5px;
            right: 10px;
            cursor: pointer;
            color: red;
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

            <input type="hidden" value="" id="hiden" runat="server" /> <input type="hidden" value="" runat="server" id="hidden"  />

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


	<!-- CONTENT -->


	<section id="content">

		<nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>
        </nav>

        <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>

	<main>

         <div class="container" style="margin-top: 80px;">

            <h2 class="text-center" style="color: #fff;"></h2>

         </div>

             <div class="row " style="margin-top:50px;">
                <div class="col-md-10  col-12 mx- auto offset-md-1">
                   <div class="login-form">
                      <div class="row asd d-flex pt-5">
                        <h3 class="text-center" style="color: #000;">Search warrant</h3>
                        <h6 class="text-center" style="color: #000;">[section 77 of odisha forest act, 1972]</h6>

                        <div class="row memo" style="margin:0 212px">

                           <%--<div class="col-lg-6  col-sm-6 col-xs-6">
    <label class="lebl">Case Number</label>
<input type="text" id="txtcno" class="form-control console" placeholder="">
         </div>--%>
                            
                            </div>
                        <div class="row memo" style="margin:0 212px">
                            

                            <div class="col-md-3">
                                <label for="refNumber">Memo No : </label>
                                <input type="text" id="txtmem" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <label for="refNumber">Dated : </label>
                                <input type="datetime-local" id="dtx" class="form-control">
                            </div>
                        </div>


                       <div class="row aplctn" style="color: #000;">
  <h6>To</h6>
  <br />
  <h6 style="margin-left: 30px;">
    (Name and designation of officer who is to execute the warrant)
  </h6>

  <div class="col-md-4">
    <label for="refNumber">Name :</label>
    <input type="text" id="namex" class="form-control" />
  </div>
  <div class="col-md-4">
    <label for="designation">Designation of officer :</label>
    <input type="text" id="designationx" class="form-control" />
  </div>
 <div class="col-md-4">
    <label for="designation">Division :</label>
    <input type="text" id="Division" class="form-control" />
  </div>
  <p style="margin: 0 13px; line-height: 30px;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHEREAS information has been
    laid before me, and on due enquiry there upon had, I have been laid to
    believe that  <input type="text" id="cdef" style="height: 25px" /> of Sri/ Smt.
    <input type="text" id="person_name" style="height: 25px" />
    S/o
    <input type="text" id="father_name" style="height: 25px" />
    Vil
    <input type="text" id="village" style="height: 25px" />
    PS
    <input type="text" id="police_station" style="height: 25px" /> in the
    district of <input type="text" id="district" style="height: 25px" /> in used <textarea id="abcd"></textarea><br />&nbsp;<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is to authorize and require
    you to enter the said house/(or other place) with such assistance (if police
    help required) as shall be required, and to use, if necessary reasonable
    force for that purpose, and to search every part to the said house(or other
    place or if the search is to be confined to part specify the part clearly),
    and to seize and take possession of any such property or(add, when the case
    requires it) and any instruments and materials which you may reasonably
    believe to be kept in connection with such property and forth with to bring
    before under signed / Forest Range Office such of the said things as my be
    taken possession of, returning this warrant, with an endorsement certifying
    what you have done under it, immediately upon execution.
  </p>
  <button style="width: fit-content" class="bt11 add12" type="button">
    <i class="fa fa-plus" aria-hidden="true"></i>
  </button>
</div>
                            <input type="hidden" id="hidenx" />
<!-- Div to append data -->
<div id="data-display" class="nicely-styled-div"></div>

                        <div class="row" style="color: #000;">
                            <div class="col-md-5" style="margin: 44px 21px 5px 21px;">
                                <p> <input  type="date" id="dtxx" name="" style="height:25px"/>Dated day of</p>
                            </div>
                            <div class="col-md-7" style="width:35%; margin: 65px 20px 10px 104px;">
                                <p> Asst. Conservator of forest Division : <br><input type="text" id="xyz" name="" style="height:25px">


                                                                      <input type="file" id="txtsign" class="form-control console"  onchange="readURLx(this);" accept="image/*">

                                      <script type="text/javascript" id="rendered-js">
                                          function readURLx(input) {
                                              if (input.files && input.files[0]) {

                                                  var reader = new FileReader();

                                                  reader.onload = function (e) {

                                                      $('.file-upload-imagex').attr('src', e.target.result);
                                                      document.getElementById('hidenx').value = e.target.result;

                                                  };

                                                  reader.readAsDataURL(input.files[0]);

                                              } else {
                                                  removeUpload();
                                              }
                                          }

                                          function removeUpload() {

                                          }



                                      </script>

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

                               
            
                             <button class="btnz mt-4" type="button" onclick="restoredt()">Save</button>
            
                            </div>


                             <div class="col-lg-3  col-sm-3 col-xs-3 d-none">

                               
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
   

                               <div class="col-lg-3  col-sm-3 col-xs-3 d-none">

   
            
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