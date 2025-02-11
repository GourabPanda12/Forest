﻿﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prosectnrepo.aspx.cs" Inherits="prosectnrepo" %>



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

	<title>Complaint In A Wildlife Offence</title>

    <script>
        var fnprrpt = [];
        var rqtn = [];
        const properties = [];
        const properties19 = [];
        $(document).ready(function () {

            $(".login-form").find("div").each(function () {
                // Check if the div contains a label starting with specified numbersv  tableData.push([date, time, description]); properties
                var labelText = $(this).find("label, h6").first().text();
                if (/^\d+\./.test(labelText)) {
                    var labelNumber = parseInt(labelText.split('.')[0], 10);
                    var numbersWithButtons = [5, 6, 7, 8, 9, 10, 13, 17, 18, 19];
                    if (numbersWithButtons.includes(labelNumber)) {

                        if (labelNumber == 5 || labelNumber == 17) {
                            $(this).next().next().next().after('<button class="bt11 add12" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>');
                        }
                        else {
                            $(this).after('<button class="bt11 add12" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>');
                        }
                        // Add plus button after the div

                    }
                }
            });

            // Handle plus button click
            $(".login-form").on("click", ".add12", function () {
                let previousH6 = null;

                // Loop up through up to 5 ancestor divs
                $(this).parents("div").each(function (index, element) {
                    // Stop after checking 5 divs
                    if (index >= 7) return false;

                    // Search for an <h6> inside this ancestor div
                    let h6InDiv = $(element).find("h6").first();




                    // If an <h6> is found, assign it to previousH6 and stop the loop
                    if (h6InDiv.length > 0) {
                        previousH6 = h6InDiv.html();
                        
                        return false; // Stop the loop once we find the first <h6>
                    }
                });

                // Check if previousH6 was found
                if (previousH6) {
                    console.log("Found an h6 element within 5 divs above:", previousH6);
                } else {
                    console.log("No h6 element found within 5 divs above the button.");
                }


                let h6Counter = 0;
                let secondH6 = null;

                $(this).parents("div").each(function (index, element) {
                    // Stop after checking 7 divs
                    if (index >= 7) return false;

                    // Search for <h6> elements inside this ancestor div
                    let h6InDiv = $(element).find("h6");

                    // Loop through the found <h6> elements in this div
                    h6InDiv.each(function () {
                        h6Counter++;

                        // If it's the second <h6>, store it and stop further search
                        if (h6Counter === 5) {
                            secondH6 = $(this).html();
                            return false; // Stop this inner loop
                        }
                    });

                    // If we already found the second <h6>, stop the outer loop
                    if (h6Counter >= 5) return false;
                });

                // Output the second <h6> (if found)
                if (secondH6 !== null) {
                    console.log("Second <h6> found:", secondH6);
                } else {
                    console.log("Second <h6> not found.");
                }

                if (previousH6.length > 0) {

                 
                    let fromg = $("#fromg").val();
                    let fromh = $("#fromh").val();
                    let fromi = $("#fromi").val();
                    let fromj = $("#fromj").val();
                    let fromk = $("#fromk").val();

                    // Check if all inputs are non-empty
                    if (fromg && fromh && fromi && fromj && fromk) {
                        // Push to properties only if none of the inputs are blank
                        properties.push([fromg, fromh, fromi, fromj, fromk]);
                    } else {
                        console.log("One or more inputs are blank. Skipping push.");
                    }
                    
                  //  var r = $("#fromg").val();
                   
                 //   console.log(r);
                    // previousH6 exists
                   
                }


                if (secondH6.length>0) {
                    let from6 = $("#from6").val();
                    let from7 = $("#from7").val();
                    let from8 = $("#from8").val();
                    let from9 = $("#from9").val();
                    let from10 = $("#from10").val();
                    let from11 = $("#from11").val();
                    let address1 = $("#address1").val();
                    let address2 = $("#address2").val();

                    // Check if all inputs are non-empty
                    if (from6 && from7 && from8 && from9 && from10 && from11 && address1 && address2) {
                        // Push to properties19 only if none of the inputs are blank
                        properties19.push([from6, from7, from8, from9, from10, from11, address1, address2]);
                    } else {
                        console.log("One or more inputs are blank. Skipping push.");
                    }
                }
                console.log(properties);
                var parentDiv = $(this).prev("div"); // Get the parent div before the button
                var newContentDiv = $("<div></div>").css("color", "black"); // Create a new div to hold the content and set text color to black 

                // Extract content from the parent div
                var contentHtml = parentDiv.find("input, textarea").map(function () {
                    var value = $(this).val(); // Get the value of each input/textarea
                    return value; // Append only the value
                }).get().join("<br>"); // Join values with line breaks

                // Append the extracted content to the new div
                newContentDiv.html(contentHtml);

                // Add the new content div below the parent div
                parentDiv.after(newContentDiv);

                $(".login-form input, .login-form textarea").val("");
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
                //  var rqtn = [];

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

                // Function to make AJAX call after all files are processed
                function submitData() {
                    $.ajax({
                        type: "POST",
                        url: "rqtnwtns.aspx/Insert",
                        data: '{ "jsonDynmxcxx": ' + JSON.stringify(rqtn) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccessrrd,
                        error: function (response) {
                            alert("Error: " + response.responseText);
                        }
                    });
                }

                // Success callback
                function OnSuccessrrd(response) {
                    // Hide loading indicator
                    $(".loading").hide();

                    // Show success message
                    alert("You have Successfully Registered, Thank You");

                    // Optionally reload the page
                    // window.location.reload();
                }

                // Process files and then make AJAX call
                processFiles(submitData);
            });



            $(".bt11").click(function () {
                let content = "";
                var caseNo = localStorage.getItem('caseno');
                // Iterate over input and textarea fields within .login-form
                $(".login-form input, .login-form textarea").each(function () {
                    const label = $(this).prev("label").text();
                    const value = $(this).val();
                    var newData = {
                        "lbl": label,
                        "vll": value,
                        case: caseNo


                    };

                    fnprrpt.push(newData);
                    console.log(fnprrpt);
                    // Only include non-empty values
                    if (value) {
                        content += `<div class="appended-section"><strong>${label}:</strong> ${value}</div>`;
                    }
                });

                // Append content if it's not empty
                if (content) {
                    $("#appended-content").append(`
                <div class="appended-group">
                    ${content}
                    <span class="close-btn">&times;</span>
                </div>
            `);
                    console.log("Data appended successfully."); // Debug statement

                    // Clear form fields within .login-form
                  
                } else {
                    console.log("No data to append."); // Debug statement
                }
            });

            // Event delegation for dynamically added close buttons
            $("#appended-content").on("click", ".close-btn", function () {
                $(this).closest(".appended-group").remove();
            });
        });


        function sub() {
            $(".loading").show();

            var caseNo = localStorage.getItem('caseno') || $("#txtxls").val();

            $.ajax({
                type: "POST",
                url: "prosectnrepo.aspx/Insert",
                data: JSON.stringify({
                    caseno: caseNo,
                    pic: $("#hiden").val(),
                    path: $("#hidden").val()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessrrd,
                error: function (response) {
                    alert("Error occurred: " + response.responseText);
                }
            });

            function OnSuccessrrd(response) {
                $(".file-upload-image").attr("src", "");
                $("#txtxls").val('');
                $("#hiden").val('');
                $("#hidden").val('');
                $(".loading").hide();
                $("#alertdvd1").show();
            }
        }






        function print() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            const pdfWidth = doc.internal.pageSize.getWidth();
            let yPosition = 20;

            const pageWidthxx = doc.internal.pageSize.getWidth();
            const pageHeightxx = doc.internal.pageSize.getHeight();

            // Calculate the x position for the vertical line (center of the page)
            const lineXPosition = pageWidthxx / 2;

            // Draw the vertical line from the top to the bottom of the page
           // doc.line(lineXPosition, 0, lineXPosition, pageHeightxx);
            // Title
            doc.setFontSize(14);
            doc.setFont("times", "bold");
            doc.text("Complaint In A Wildlife Offence", 65, 15);
            doc.text("U/s 55 of Wild Life (Protection) Act 1972", 60, 22);

            // Table Configuration
            doc.setFont("times", "normal");
            doc.setFontSize(11);
            let startY = 30;
            let rowHeight = 10;

            // Row 1
            doc.rect(10, startY, 10, rowHeight); // Serial No. box
            doc.text("1.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight); // Content box
            doc.text("Name of the Range Office / Division", 25, startY + 7);
            doc.rect(90, startY, 110, rowHeight); // Content box
            doc.text("Sumanta barik", 100, startY + 7);
            // Row 2
            startY += rowHeight;
            doc.rect(10, startY, 10, rowHeight); // Serial No. box
            doc.text("2.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight); // Content box
            doc.text("WLOR number and date", 25, startY + 7);
            doc.rect(90, startY, 110, rowHeight); // Content box
            doc.text("WLOR2345 - 24/10/2024", 100, startY + 7);
            // Row 3
            startY += rowHeight;
            doc.rect(10, startY, 10, rowHeight); // Serial No. box
            doc.text("3.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight); // Content box
            doc.text("Place and date of offence", 25, startY + 7);
            doc.rect(90, startY, 110, rowHeight); // Content box
            doc.text("Cuttack - 24/10/2024", 100, startY + 7);
            // Row 4
            startY += rowHeight;
            doc.rect(10, startY, 10, rowHeight); // Serial No. box
            doc.text("4.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight); // Content box
            doc.text("Sections of law", 25, startY + 7);
            doc.rect(90, startY, 110, rowHeight); // Content box
            doc.text("ACT 486 / IPC 23", 100, startY + 7);
            // Row 5 - Details of property seized with improved design
            startY += rowHeight;
            let totalRow5Height = rowHeight; // Start with the height of the first line
            doc.rect(10, startY, 10, totalRow5Height); // Serial No. box
            doc.text("5.", 13, startY + 7);
            doc.rect(20, startY, 180, totalRow5Height); // Main content box
            doc.text("Details of property seized", 25, startY + 7);

            // Adjust starting point for table columns
            const tableStartX = 20; // Start at same X as main content box
            let subHeaderY = startY + rowHeight; // Start after the first line in main content box

            // Define sub-columns for Row 5
            const subColumns = [
                { title: "SL No.", width: 15 },
                { title: "Property description including schedule of seized animal / meat / animal article involved along with serial number in the respective schedule of Wildlife (Protection) Act (Amendment) 2022", width: 80 },
                { title: "Range Office Property Register number                                            ", width: 38 },
                { title: "From whom / where recovered \n or seized                     ", width: 30 },
                { title: "Disposal                        ", width: 17 }
            ];

            // Draw headers for each column in Row 5, starting from tableStartX
            let colX = tableStartX;
            let maxHeaderHeight = 0;
            subColumns.forEach(col => {
                const headerText = doc.splitTextToSize(col.title, col.width);
                const headerHeight = headerText.length * 5; // Approximate line height is 5
                if (headerHeight > maxHeaderHeight) {
                    maxHeaderHeight = headerHeight;
                }
                // Condition to not add rectangle for "SL No."
                if (col.title !== "SL No.") {
                    doc.rect(colX, subHeaderY, col.width, headerHeight); // Header cell
                }

                doc.text(headerText, colX + 2, subHeaderY + 5, { maxWidth: col.width });



                colX += col.width;
            });
            totalRow5Height += maxHeaderHeight;
            subHeaderY += maxHeaderHeight;

            // Dynamic entries for Row 5
            let row5Y = subHeaderY;
           

            properties.forEach((property) => {
                let colX = tableStartX; // Reset colX to start from the beginning for each row
                let maxCellHeight = 0; // Keep track of max cell height for the row
                property.forEach((text, index) => {
                    const cellText = doc.splitTextToSize(text, subColumns[index].width - 4);
                    const cellHeight = cellText.length * 5; // Approximate line height is 5
                    if (cellHeight > maxCellHeight) {
                        maxCellHeight = cellHeight;
                    }
                });
                // Draw the cells with the calculated max height
                colX = tableStartX;
                property.forEach((text, index) => {
                    const cellText = doc.splitTextToSize(text, subColumns[index].width - 4);
                    // Condition to not add rectangle for "SL No." column
                    if (subColumns[index].title !== "SL No.") {
                        doc.rect(colX, row5Y, subColumns[index].width, maxCellHeight); // Cell for each entry
                    }
                    doc.text(cellText, colX + 2, row5Y + 5, { maxWidth: subColumns[index].width - 4 });
                    colX += subColumns[index].width;
                });
                row5Y += maxCellHeight;
                totalRow5Height += maxCellHeight;
            });

            // Update the height of the main content box to match the total content height
            doc.rect(20, startY, 180, totalRow5Height); // Main content box
            doc.rect(10, startY, 10, totalRow5Height); // Serial No. box

            // Continue with the rest of the rows...
           
            // Row 6if(
            startY = row5Y;
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("6.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            doc.text("Whose custody the seized properties are laying, if submitted in the court Property Index number", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Row 7
            startY += rowHeight * 2;
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("7.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            doc.text("Live specimens, if any, seized and subsequently rehabilitated in its natural habitat as per the court order", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Row 8
            startY += rowHeight * 2;
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("8.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            doc.text("Details of perishable or hazardous materials seized and subsequently destroyed as per the court order", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Row 9
            startY += rowHeight * 2;
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("9.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            doc.text("Details of fire arms, if any, seized and handed over to the Police for investigation and the Police FIR number", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Row 10
            startY += rowHeight * 2;
            doc.rect(10, startY, 10, (rowHeight * 2) + 5);
            doc.text("10.", 13, startY + 7);
            doc.rect(20, startY, 180, (rowHeight * 2) + 5);
            doc.text("Whether samples were sent to Wildlife Institute of India, Zoological Survey of India, Botanical Survey of India or any other scientific experts for opinion and the details of the opinion received", 25, startY + 7, { maxWidth: 85, align: 'justify' });


         
            const textDimensions = doc.getTextDimensions("Name, designation and office address of the officer who filed the Offence Report", { maxWidth: 80 });
            startY += (rowHeight * 2) + 5;
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Calculate height based on the lines created by maxWidth
            const heightSpanned = textDimensions.h;
            doc.rect(10, startY, 10, heightSpanned + 10);
            doc.text("11.", 13, startY + 7);
            doc.rect(20, startY, 180, heightSpanned + 10);
            doc.text("Name, designation and office address of the officer who filed the Offence Report", 25, startY + 7, { maxWidth: 85, align: 'justify' });
          
            const textDimensionsz = doc.getTextDimensions("Name, designation and office address of the officer who filed the Offence Report", { maxWidth: 80 });
            startY += heightSpanned + 10;
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            // Calculate height based on the lines created by maxWidth
            const heightSpannedz = textDimensionsz.h;
            doc.rect(10, startY, 10, heightSpannedz + 10);
            doc.text("12.", 13, startY + 7);
            doc.rect(20, startY, 180, heightSpannedz + 10);
            doc.text("Name, designation and office address of the officer filing the Complaint", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            if (startY > pageHeightxx - 10) {
                startY = 20;
                doc.addPage();
            }
            const textDimensions1z = doc.getTextDimensions("Name, designation and office address of the officer who filed the Offence Report", { maxWidth: 80 });
            startY += heightSpannedz + 10;
            // Calculate height based on the lines created by maxWidth
            const heightSpanned1z = textDimensions1z.h;
            doc.rect(10, startY, 10, heightSpanned1z + 10);
            doc.text("13.", 13, startY + 7);
            doc.rect(20, startY, 180, heightSpanned1z + 10);
            doc.text("Name and address of the accused against whom the complaint is filed", 25, startY + 7, { maxWidth: 85, align: 'justify' });



            doc.addPage();

            const pageWidth = doc.internal.pageSize.getWidth();
            const margin = 10;
            const tableWidth = pageWidth - 2 * margin;

            // Calculate cell sizes based on page width
            let cellHeight = 12;
            let cellWidth = tableWidth / 3;

            // Starting coordinates
            startX = margin;
            startY = 20;

            // Draw outer border
            doc.rect(startX, startY, tableWidth, cellHeight * 2);

            // Header Row
            doc.text("Name and age", startX + 3, startY + 8);
            doc.text("Father's name", startX + cellWidth + 3, startY + 8);
            doc.text("Place of Residence", startX + 2 * cellWidth + 3, startY + 5);

            // Sub-header Row for "Place of Residence"
            doc.text("Village", startX + 2 * cellWidth + 3, startY + cellHeight + 8);
            doc.text("Thana", startX + 2 * cellWidth + cellWidth / 3 + 3, startY + cellHeight + 8);
            doc.text("District", startX + 2 * cellWidth + 2 * cellWidth / 3 + 3, startY + cellHeight + 8);

            // Vertical Lines for columns
            doc.line(startX + cellWidth, startY, startX + cellWidth, startY + cellHeight * 2); // after "Name and age"
            doc.line(startX + 2 * cellWidth, startY, startX + 2 * cellWidth, startY + cellHeight * 2); // after "Father's name"
            doc.line(startX + 2 * cellWidth + cellWidth / 3, startY + cellHeight, startX + 2 * cellWidth + cellWidth / 3, startY + cellHeight * 2); // after "Village"
            doc.line(startX + 2 * cellWidth + 2 * cellWidth / 3, startY + cellHeight, startX + 2 * cellWidth + 2 * cellWidth / 3, startY + cellHeight * 2); // after "Thana"

            // Horizontal Line for Sub-headers
            doc.line(startX + 2 * cellWidth, startY + cellHeight, startX + 3 * cellWidth, startY + cellHeight); // below "Place of Residence"


            startY += 24;
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("14.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            //startY += 60;
            doc.text("Date and hour of arrest", 25, startY + 7, { maxWidth: 85, align: 'justify' });


            startY += rowHeight * 2;

            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("15.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("Date on which forwarded to Court", 25, startY + 7, { maxWidth: 85, align: 'justify' });



            startY += rowHeight * 2;

            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("16.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("Date on which forwarded to Court", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            startY += (rowHeight * 2) / 2;

            doc.rect(10, startY, 10, rowHeight * 2);
            //  doc.text("16.", 13, startY + 7); 
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("i. Accused in custody", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            startY += (rowHeight * 2) / 2;

            doc.rect(10, startY, 10, rowHeight * 2);
            //  doc.text("16.", 13, startY + 7); 
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("i. Date of release on bail", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            startY += (rowHeight * 2) / 2;

            doc.rect(10, startY, 10, (rowHeight * 2) + 3);
            //  doc.text("16.", 13, startY + 7); 
            doc.rect(20, startY, 180, (rowHeight * 2) + 3);
            //  startY = 20;
            doc.text("iii. .Accused not arrested / absconding", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            //      startY += (rowHeight * 2) / 2;

            //    doc.rect(10, startY, 10, (rowHeight * 2)+5);
            ////  doc.text("16.", 13, startY + 7); 
            //    doc.rect(20, startY, 180, (rowHeight * 2)+15);
            //  //  startY = 20;
            doc.text("iv. Accused who are habitual / repeated offenders, details of previous cases", 25, startY + 17, { maxWidth: 85, align: 'justify' });

            startY += (rowHeight * 2) + 3;

            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("17.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("Name and address of the witnesses and facts to be provide by the evidence of each witness", 25, startY + 7, { maxWidth: 85, align: 'justify' });

            startY += rowHeight * 2;
            const headers = [
                ["SL No.", "Name", "Father's / Husband", "Age", "Occupation", "Address", "Mobile No.", "Type of evidence be tendered"]
            ];

            // Generate a large sample data array
            const data = Array.from({ length: 30 }, (_, i) => [
                (i + 1).toString(),
                `Name ${i + 1}`,
                `Father/Husband ${i + 1}`,
                `${20 + (i % 30)}`, // Age between 20-50
                "Occupation",
                `Address ${i + 1}, City`,
                `9876543${210 + i}`,
                "Document"
            ]);

            // Set font size
            doc.setFontSize(10);

            // Define starting Y position for the table
            //const startY = 20;

            // Add table header and data with borders, no left or right margin
            doc.autoTable({
                head: headers,
                body: properties19,
                theme: 'plain', // Black & white theme
                headStyles: { fillColor: [255, 255, 255], textColor: [0, 0, 0], fontSize: 10 },
                bodyStyles: { fillColor: [255, 255, 255], textColor: [0, 0, 0], fontSize: 10 },
                margin: { top: 20, left: 10, right: 10 }, // Remove left and right margins
                tableWidth: 'auto', // Adjust to fit full page width if necessary
                styles: { lineColor: [0, 0, 0], lineWidth: 0.5 },
                startY: startY
            });
            doc.setFontSize(12);
            doc.addPage();
            startY = 20;
            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("18.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);
            //  startY = 20;
            doc.text("List of documents, if any, submitted along with complaint", 25, startY + 7, { maxWidth: 85, align: 'justify' });
            startY += rowHeight * 2;

            doc.rect(10, startY, 10, rowHeight * 2);
            doc.text("19.", 13, startY + 7);
            doc.rect(20, startY, 180, rowHeight * 2);


            //  startY = 20;
            doc.text(" Nature of offences and facts of the case / allegation made against each accused.", 25, startY + 7, { maxWidth: 85, align: 'justify' });

            doc.text("Memo No.            dated", 20, 80);
            doc.text("Forwarded to the Magistrate with a request for issue of process against the accused and", 20, 90);
            doc.text("taking further action according to law.", 20, 98);
            doc.text("Divisional Forest Division", 150, 116);
            doc.text("..................... Division", 150, 132);

            // Second Memo Section
            doc.text("Memo No.            dated", 20, 142);
            doc.text("Forwarded to the Conservator of Forests Circle, with a copy of seizure report for", 20, 150);
            doc.text("information.", 20, 160);
            doc.text("Divisional Forest Division", 150, 186);
            doc.text("..................... Division", 150, 192);




            doc.addPage();

            doc.setFontSize(12);
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
            doc.save('case-document-prosectnrepo.pdf');

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


    .container {
    margin: 20px;
}

#appended-content {
    margin-top: 20px;
    color:#000;
}

.appended-group {
    position: relative;
    padding: 10px;
    border: 1px solid #ddd;
    margin-bottom: 10px;
    background-color: #f9f9f9;
}

.close-btn {
    position: absolute;
    top: 5px;
    right: 10px;
    color: red;
    font-size: 18px;
    cursor: pointer;
}

.appended-section {
    padding: 5px 0;
}

.btn {
    margin-top: 20px;
}

label {
    font-weight: bold;
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
.add12{

    width: fit-content;
    float: right!important;
    margin-bottom: 10px;
    margin-top: 13px;
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
                            <h3 class="text-center" style="color: #000; margin-top: 30px;">Complaint In A Wildlife Offence </h3>
                            <h5 class="text-center" style="color: #000;">U/s 55 of WildLife (Protection) Act 1972 </h5>
                        </div>

             <form>

                <div class="form-group form-section pt-4">
                    <label for="from">1. Name of the Range Office / Division :</label>
                    <input type="text" class="form-control" id="froma" placeholder="">
                </div>

                
                <div class="row ">
                    <div class="col-md-6">
                        <label for="refNumber">2. WLOR Number :</label>
                        <input type="text" class="form-control" id="fromb" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Date :</label>
                        <input type="date" class="form-control" id="fromc" placeholder="">
                    </div>
                </div> 

                <div class="row ">
                    <div class="col-md-6">
                        <label for="refNumber">3. Place of Offence :</label>
                        <input type="text" class="form-control" id="fromd" placeholder="">
                    </div>
                    <div class="col-md-6">
                        <label for="dateTime">Date :</label>
                        <input type="date" class="form-control" id="frome" placeholder="">
                    </div>
                </div> 

                <div class="form-group form-section">
                    <label for="from">4. Sections of Law :</label>
                    <input type="text" class="form-control" id="fromf" placeholder="">
                </div>


                <div class="row"> 
                     <h6 class="" style="color: #000;">5. Details of Property Seized :</h6>

                    <div class="col-md-3">
                        <label for="refNumber"> SL No.:</label>
                        <input type="text" class="form-control" id="fromg" placeholder="">
                    </div>
                   
                </div> 

                <div class="form-group form-section mt-3">
                    <label for="address">Property description including schedule of seized animal /meat/ animal article involved along with serial number in the respective schedule of Wildlife (Protection) Act (Amendment) 2022 :</label>
                    <textarea class="form-control" id="fromh" rows="3" placeholder=""></textarea>
                </div>

                <div class="row"> 
                   <div class="col-md-6">
                       <label for="refNumber">Range Office Property Register Number :</label>
                       <input type="text" class="form-control" id="fromi" placeholder="">
                   </div>
                   <div class="col-md-6">
                    <label for="refNumber">From Whom / Where Recovered or Seized :</label>
                    <textarea class="form-control" id="fromj" rows="1" placeholder=""></textarea>
                </div>
               </div> 

                 <div class="form-group form-section mt-3">
                     <label for="address">Disposal :</label>
                     <textarea class="form-control" id="fromk" rows="2" placeholder=""></textarea>
                 </div>

                 <div class="form-group form-section">
                    <label for="refNumber">6. Whose custody the seized properties are laying, If submitted in the court Property Index Number :</label>
                    <input type="text" class="form-control" id="froml" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="refNumber">7. Live specimens, if any, seized and subsequently rehabilitated in its natural habitat as per the Court Order :</label>
                    <input type="text" class="form-control" id="fromm" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="refNumber">8. Details of perishable or hazardous materials seized and subsequently destroyed as per the Court Order :</label>
                    <input type="text" class="form-control" id="fromn" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="refNumber">9. Details of fire arms, if any, seized and handed over to the Police for investigation and the Police FIR Number :</label>
                    <input type="text" class="form-control" id="fromo" placeholder="">
                </div>
                <div class="form-group form-section">
                    <label for="refNumber">10. Whether samples were sent to Wildlife Institute of India, Zoological Survey of India, Botanical Survey of India or any other scientific experts for opinion and the details of the Opinion Received :</label>
                    <textarea class="form-control" id="fromp" rows="2" placeholder=""></textarea>
                </div>

                <div class="form-group form-section">
                    <label for="refNumber">11. Name, Designation and office Address of the officer who filed
                        the Offence Report :</label>
                    <textarea class="form-control" id="fromq" rows="3" placeholder=""></textarea>
                </div>

                <div class="form-group form-section">
                    <label for="refNumber">12. Name, Designation and Office Address of the officer filing the Complaint :</label>
                    <textarea class="form-control" id="fromr" rows="3" placeholder=""></textarea>
                </div>


                  <div>
                    <h6 class="" style="color: #000;">13. Name and Address of
                        the Accused Against whom the Complaint is Filed :</h6>
                  </div>
                <div class="row pb-4"> 
                   <div class="col-md-5">
                       <label for="refNumber">Name :</label>
                       <input type="text" class="form-control" id="froms" placeholder="">
                   </div>
                   <div class="col-md-2">
                    <label for="dateTime">Age : </label>
                    <input type="number" class="form-control" id="fromt" placeholder="">
                </div>
                   <div class="col-md-5">
                       <label for="dateTime">Father’s Name: </label>
                       <input type="text" class="form-control" id="fromu" placeholder="">
                   </div>
               </div> 

               <div>
                <h6 class="" style="color: #000;">Place of Residence :</h6>
              </div>
            <div class="row pb-4"> 
               <div class="col-md-4">
                   <label for="refNumber">Village </label>
                   <input type="text" class="form-control" id="fromv" placeholder="">
               </div>
               <div class="col-md-4">
                <label for="dateTime">Thana</label>
                <input type="text" class="form-control" id="fromw" placeholder="">
            </div>
               <div class="col-md-4">
                   <label for="dateTime">District </label>
                   <input type="text" class="form-control" id="fromx" placeholder="">
               </div>
           </div> 


           <div class="row pb-4"> 
            <div class="col-md-6">
                <label for="refNumber">14. Arrest Date</label>
                <input type="date" class="form-control" id="fromy" placeholder="">
            </div>
            <div class="col-md-6">
                <label for="dateTime">Time</label>
                <input type="time" class="form-control" id="fromz" placeholder="">
            </div>
          </div> 

          <div class="row pb-4"> 
            <div class="col-md-6">
                <label for="refNumber">15. Date on which Forwarded to Court :</label>
                <input type="date" class="form-control" id="from1" placeholder="">
            </div>
            <div class="col-md-6">
            </div>
          </div> 


          <div>
            <h6 class="" style="color: #000;">16. Status of Accused :</h6>
          </div>
          <div class="form-group form-section">
            <label for="refNumber">i.Accused in Custody :</label>
            <input type="text" class="form-control" id="from2" placeholder="">
          </div>
          <div class="form-group form-section">
            <label for="refNumber">ii.Date of Release on Bail :</label>
            <input type="date" class="form-control" id="from3" placeholder="">
          </div>
          <div class="form-group form-section">
            <label for="refNumber">iii.Accused not Arrested / Absconding :</label>
            <input type="text" class="form-control" id="from4" placeholder="">
          </div>
          <div class="form-group form-section">
            <label for="refNumber">iv.Accused who are Habitual / Repeated
                Offenders, Details of Previous Cases :</label>
            <textarea class="form-control" id="from5" rows="3" placeholder=""></textarea>
          </div>

          
          <div class="row"> 
            <h6 class="" style="color: #000;">17.Name and Address of the witnesses and facts t be provide by the evidence of each witness :</h6>
           <div class="col-md-3">
               <label for="refNumber"> SL No.:</label>
               <input type="text" class="form-control" id="from6" placeholder="">
           </div>
       </div> 
        <div class="row pb-4"> 
           <div class="col-md-5">
               <label for="refNumber">Name :</label>
               <input type="text" class="form-control" id="from7" placeholder="">
           </div>
          
           <div class="col-md-5">
               <label for="dateTime">Father / Husband Name : </label>
               <input type="text" class="form-control" id="from8" placeholder="">
           </div>

           <div class="col-md-2">
            <label for="dateTime">Age : </label>
            <input type="number" class="form-control" id="from9" placeholder="">
          </div>
       </div> 

       <div class="row pb-4"> 
        <div class="col-md-6">
            <label for="refNumber">Occupation :</label>
            <input type="text" class="form-control" id="from10" placeholder="">
        </div>
       
        <div class="col-md-6">
         <label for="dateTime">Mobile No. : </label>
         <input type="number" class="form-control" id="from11" placeholder="">
       </div>
    </div> 

    <div class="row pb-4"> 
        <div class="col-md-6">
            <label for="refNumber">Address :</label>
            <textarea class="form-control" id="address1" rows="3" placeholder=""></textarea>
        </div>
       
        <div class="col-md-6">
         <label for="dateTime">Type of evidence be tendered : </label>
         <textarea class="form-control" id="address2" rows="3" placeholder=""></textarea>
       </div>
    </div> 

    <div class="form-group form-section">
        <label for="refNumber">18. List of Documents, if any , Submitted along with Complaint :</label>
        <textarea class="form-control" id="address3" rows="3" placeholder=""></textarea>
    </div>

    
    <div class="form-group form-section">
        <label for="refNumber">19. Nature of Offences and facts of the case/allegation made against each accused:</label>
        <textarea class="form-control" id="address4" rows="3" placeholder=""></textarea>
    </div>

 
    <div class="form-group form-section">
        <label for="refNumber">Prayer :</label>
        <input type="text" class="form-control" id="from12" placeholder="">
    </div>

               <div class="row pb-4"> 
               <div class="col-md-6">
                   <label for="refNumber">Memo No. :</label>
                   <input type="text" class="form-control" id="from13" placeholder="">
                </div>
               
               <div class="col-md-6">
                   <label for="dateTime">Dated :</label>
                   <input type="date" class="form-control" id="from14" placeholder="">
                </div>
           </div> 

           <h6 class="" style="color: #000;">Forwarded to the Magistrate with a request for issue of process against the accused and taking further action according to law.</h6>

           <div class="row pb-4"> 
            <div class="col-md-6">
                
             </div>
            
            <div class="col-md-6">
                <h6 class="" style="color: #000;">Divisional Forest Division :</h6>
                <label for="dateTime">Division :</label>
                <input type="text" class="form-control" id="from15" placeholder="">
             </div>
        </div> 


        <div class="row pb-4"> 
            <div class="col-md-6">
                <label for="refNumber">Memo No. :</label>
                <input type="text" class="form-control" id="from16" placeholder="">
             </div>
            
            <div class="col-md-6">
                <label for="dateTime">Dated :</label>
                <input type="date" class="form-control" id="from17" placeholder="">
             </div>
        </div> 

        <h6 class="" style="color: #000;">Forwarded to the Conservator of Forests Circle,with a copy of seizure report for information.</h6>

        <div class="row pb-4"> 
         <div class="col-md-6">
             
          </div>
         
         <div class="col-md-6">
             <h6 class="" style="color: #000;">Divisional Forest Division :</h6>
             <label for="dateTime">Division :</label>
             <input type="text" class="form-control" id="from18" placeholder="">
          </div>
     </div> 


  <button class="bt11 add12" type="button">
  <i class="fa fa-plus" aria-hidden="true"></i>
</button>

    <div id="appended-content"></div>
    
                    
             </form>
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


                              <div class="col-lg-3  col-sm-3 col-xs-3 abc d-none">

                               
            
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