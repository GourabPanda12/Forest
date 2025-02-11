<%@ Page Language="C#" AutoEventWireup="true" CodeFile="form4pdf.aspx.cs" Inherits="form4pdf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Generate PDF from Database</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#btnGeneratePDF").click(function (event) {
                event.preventDefault(); // Prevent the default form submission behavior
                $.ajax({
                    type: "POST",
                    url: "GetData.asmx/GetSeizureinfo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        generatePDF(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.log(xhr.responseText);
                    }
                });
            });


            function generatePDF(data) {
                const { jsPDF } = window.jspdf;
                const doc = new jsPDF({
                    orientation: 'landscape'
                });
                var y = 20; // Start y position
                var maxWidth = doc.internal.pageSize.width - 10;
                var jsonArray = JSON.parse(data);
                var organizationName = "FOREST DEPARTMENT, ODISHA";
                var organizationAddress = "Sambalpur";
                // var organizationLogo = "path/to/your/logo.png"; // Update with the path to your logo
                var tableWidth = 0;
                // Set header properties
                var headerHeight = 50; // Height of the header section
                var logoWidth = 50; // Width of the logo (adjust as per your logo size)
                var logoHeight = 50; // Height of the logo (adjust as per your logo size)  doc.internal.pageSize.width * 2;
                var pageWidth = doc.internal.pageSize.getWidth();
                var pageHeight = doc.internal.pageSize.getHeight();
                var cnt = 1;
                // Add header with organization details and logo
                doc.setFontSize(14);
                doc.text(organizationName, pageWidth / 2, headerHeight / 2, { align: "center" });
                doc.setFontSize(10);
                doc.text(organizationAddress, pageWidth / 2, headerHeight / 2 + 10, { align: "center" });
                //  doc.addImage(organizationLogo, "PNG", pageWidth / 2 - logoWidth / 2, 5, logoWidth, logoHeight);

                // Set position for content
                var contentY = headerHeight + 10; // Adjust as per your requirement

                // Add content
                doc.setFontSize(12);
                //   doc.text("Sample Content", 10, contentY);
                y = y + 20;
                // Loop through the JSON array
                //for (var i = 0; i < jsonArray.length; i++) {
                //    // Get current array
                //    var currentArray = jsonArray[i];

                //    // Loop through the elements of the current array
                //    for (var j = 0; j < currentArray.length; j++) {
                //        // Get current element
                //        var currentElement = currentArray[j];

                //        // Check if adding this content will exceed the page height
                //        //if (y > doc.internal.pageSize.height - 10) {
                //        //    doc.addPage(); // Add new page if needed
                //        //    y = 20; // Reset y position
                //        //}

                //        // Check if the current element is an object
                //        if (typeof currentElement === 'object') {
                //            // If it's an object, stringify and add it to the document
                //            var jsonString = JSON.stringify(currentElement);
                //            doc.text(20, y, "details" + ": " + jsonString);
                //            y += 10; // Increment y position
                //        } else {
                //            // Otherwise, add the element directly
                //            doc.text(20, y, "details" + ": " + currentElement);
                //            y += 10; // Increment y position
                //        }
                //    }
                //}










                var inc = 1;










                /* For table Pdf*/

                //var headers = Object.keys(jsonArray[0]); // Assuming jsonArray is not empty
                //var dtxa = [];

                //jsonArray.forEach(function (obj) {
                //    var row = [];
                //    headers.forEach(function (header) {
                //        row.push(obj[header]);
                //    });
                //    dtxa.push(row);
                //});

                ////dtxa.forEach(function (row) {

                ////    y = doc.autoTable.previous.finalY + 10;
                ////});

                //headers.forEach(function (header) {
                //    var cellWidth = doc.getStringUnitWidth(header) * 5; // You may adjust the multiplier for proper width
                //    tableWidth += cellWidth;
                //});
                //// Set table headers

                //doc.autoTable({
                //    startY: y, // Start table at current y position
                //    head: [headers], // Set headers
                //    body: [], // Initialize empty body
                //    styles: {
                //        cellWidth: 'wrap', // Horizontally align content within cells
                //    }

                //});
                //// Calculate y position for next iteration
                //y = doc.autoTable.previous.finalY + 5; // 10 units spacing between tables

                //// Iterate over each object
                //$.each(jsonArray, function (index, obj) {
                //    if (y > doc.internal.pageSize.height - 10) {
                //        doc.addPage(); // Add new page if needed
                //        y = 20; // Reset y position
                //    }
                //    var data = [];
                //    data.push(Object.values(obj));
                //    // Iterate over each key-value pair in the object
                //    //$.each(obj, function (key, value) {
                //    //    // Push key-value pair as an array to the data array
                //    //    data.push([key, value]);
                //    //});

                //    // Add data to the table
                //    doc.autoTable({
                //        startY: y, // Start table at current y position
                //        body: data,
                //        didDrawRow: function (data) {
                //            // Apply different styles to alternate rows
                //            if (data.row.index % 2 === 0) {
                //                // Light gray for even rows
                //                doc.setFillColor(240, 240, 240); // Light gray
                //                doc.rect(data.table.width, data.row.y, data.table.width, data.row.height, 'F');
                //            }
                //        },
                //        styles: {
                //            cellWidth: 'wrap', // Horizontally align content within cells
                //        }// Set data
                //    });

                //    // Calculate y position for next iteration
                //    y = doc.autoTable.previous.finalY + 2; // 10 units spacing between tables
                //    cnt++;
                //});
                var img = new Image();
                img.onload = function () {
                    // Adjust the image dimensions and position as needed
                    doc.addImage(img, 'PNG', 70, 1, 160, 40); // (image, format, x, y, width, height)

                    // Add text below the image
                    var textArray = [
                        "Sentence 1",
                        "Sentence 2",
                        "Sentence 3",
                        "Sentence 4",
                        "Sentence 5"
                    ];

                    var yPosition = 10; // Initial y position for text

                    // Loop through the textArray and add each sentence to the PDF
                    //textArray.forEach(function (sentence) {
                    //    doc.text(15, yPosition, sentence);
                    //    yPosition += 10; // Increment y position for the next sentence
                    //});



                    $.each(jsonArray, function (index, obj) {
                        // Iterate over each key-value pair in the object
                        $.each(obj, function (key, value) {
                            if (inc == 1) {
                                doc.text(90, 27, value);
                                doc.setFont("helvetica", "bold");
                                y += 10;
                            }
                            if (inc == 2) {
                                doc.text(70, 35, value);
                                doc.setFont("helvetica", "bold");
                                y += 10;
                            }
                            if (inc == 3) {
                                doc.text(74, 42, value);
                                doc.setFont("helvetica", "bold");
                                y += 10;
                            }
                            if (inc == 4) {
                                doc.text(77, 51, value);
                                doc.setFont("helvetica", "bold");
                                y += 10;
                            }
                            if (inc == 5) {
                                doc.text(185, 51, value);
                                doc.setFont("helvetica", "bold");
                                y += 10;
                            }
                            //if (y > doc.internal.pageSize.height - 10) {
                            //    doc.addPage(); // Add new page if needed
                            //    y = 20; // Reset y position
                            //}

                            //doc.text(20, y, key + ": " + value);
                            //y += 10; // Increment y position

                            //// Add a line after the text
                            //y += 5; // Increase y position by 5 units for the line

                            //// Draw a line
                            //doc.setLineWidth(0.1);
                            //doc.line(20, y, doc.internal.pageSize.width - 20, y); // Draw line from left to right margin

                            // Increment y position for next iteration
                            y += 5; // In
                            inc++;
                        });
                    });


                    // Save the PDF<img src="" />
                    var img2 = new Image();
                    var yPosition2 = 80;
                    img2.onload = function () {
                        // Add second image below the first image and its associated text
                        doc.addImage(img2, 'PNG', 1, 65, 290, 10); // Adjust position as needed

                        // Add text below the second image
                        var textArray2 = [
                            "Additional sentence 1",
                            "Additional sentence 2",
                            "Additional sentence 3"
                        ];

                        // Initial y position for text below the second image

                        textArray2.forEach(function (sentence) {
                            doc.text(15, yPosition2, sentence);
                            yPosition2 += 10; // Increment y position for the next sentence
                        });

                        // Save the PDF after both images and associated text have been added
                        var img3 = new Image();
                        //  yPosition2 += 5; 
                        img3.onload = function () {
                            // Add third image below the second image and its associated text
                            doc.addImage(img3, 'PNG', 1, yPosition2, 290, 20); // Adjust position as needed

                            // Add text below the third image
                            var textArray3 = [
                                "Additional sentence A",
                                "Additional sentence B",
                                "Additional sentence C"
                            ];

                            var yPosition3 = 290; // Initial y position for text below the third image

                            textArray3.forEach(function (sentence) {
                                doc.text(15, yPosition3, sentence);
                                yPosition3 += 10; // Increment y position for the next sentence
                            });

                            // Save the PDF after all images and associated text have been added
                            doc.save('example.pdf');
                        };

                        img3.src = 'pdfimages/AFTER SEARCH PROTOCOL_page-0001 (2).jpg';
                    };

                    img2.src = 'pdfimages/AFTER SEARCH PROTOCOL_page-0001 (7).jpg';




                };
                img.src = 'pdfimages/FORM-III-SEIZURE-INFORMATION-TO-MAGISTRATE_Header.jpg';



                // doc.save('Aftersearch.pdf');
            }
            //function generatePDF(data) {
            //    const { jsPDF } = window.jspdf;
            //    const doc = new jsPDF({
            //        orientation: 'landscape'
            //    });
            //    var y = 20; // Start y position
            //    var maxWidth = doc.internal.pageSize.width - 10;
            //    var jsonArray = JSON.parse(data);
            //    var organizationName = "FOREST DEPARTMENT, ODISHA";
            //    var organizationAddress = "Sambalpur";
            //    // var organizationLogo = "path/to/your/logo.png"; // Update with the path to your logo
            //    var tableWidth = 0;
            //    // Set header properties
            //    var headerHeight = 50; // Height of the header section
            //    var logoWidth = 50; // Width of the logo (adjust as per your logo size)
            //    var logoHeight = 50; // Height of the logo (adjust as per your logo size)  doc.internal.pageSize.width * 2;
            //    var pageWidth = doc.internal.pageSize.getWidth();
            //    var pageHeight = doc.internal.pageSize.getHeight();
            //    var cnt = 1;
            //    // Add header with organization details and logo
            //    doc.setFontSize(14);
            //    doc.text(organizationName, pageWidth / 2, headerHeight / 2, { align: "center" });
            //    doc.setFontSize(10);
            //    doc.text(organizationAddress, pageWidth / 2, headerHeight / 2 + 10, { align: "center" });
            //    //  doc.addImage(organizationLogo, "PNG", pageWidth / 2 - logoWidth / 2, 5, logoWidth, logoHeight);

            //    // Set position for content
            //    var contentY = headerHeight + 10; // Adjust as per your requirement

            //    // Add content
            //    doc.setFontSize(12);
            //    //   doc.text("Sample Content", 10, contentY);
            //    y = y + 20;
            //    // Loop through the JSON array
            //    //for (var i = 0; i < jsonArray.length; i++) {
            //    //    // Get current array
            //    //    var currentArray = jsonArray[i];

            //    //    // Loop through the elements of the current array
            //    //    for (var j = 0; j < currentArray.length; j++) {
            //    //        // Get current element
            //    //        var currentElement = currentArray[j];

            //    //        // Check if adding this content will exceed the page height
            //    //        //if (y > doc.internal.pageSize.height - 10) {
            //    //        //    doc.addPage(); // Add new page if needed
            //    //        //    y = 20; // Reset y position
            //    //        //}

            //    //        // Check if the current element is an object
            //    //        if (typeof currentElement === 'object') {
            //    //            // If it's an object, stringify and add it to the document
            //    //            var jsonString = JSON.stringify(currentElement);
            //    //            doc.text(20, y, "details" + ": " + jsonString);
            //    //            y += 10; // Increment y position
            //    //        } else {
            //    //            // Otherwise, add the element directly
            //    //            doc.text(20, y, "details" + ": " + currentElement);
            //    //            y += 10; // Increment y position
            //    //        }
            //    //    }
            //    //}












            //    //$.each(jsonArray, function (index, obj) {
            //    //    // Iterate over each key-value pair in the object
            //    //    $.each(obj, function (key, value) {
            //    //        if (y > doc.internal.pageSize.height - 10) {
            //    //            doc.addPage(); // Add new page if needed
            //    //            y = 20; // Reset y position
            //    //        }

            //    //        doc.text(20, y, key + ": " + value);
            //    //        y += 10; // Increment y position

            //    //        // Add a line after the text
            //    //        y += 5; // Increase y position by 5 units for the line

            //    //        // Draw a line
            //    //        doc.setLineWidth(0.1);
            //    //        doc.line(20, y, doc.internal.pageSize.width - 20, y); // Draw line from left to right margin

            //    //        // Increment y position for next iteration
            //    //        y += 5; // In
            //    //    });
            //    //});








            //    /* For table Pdf*/

            //    //var headers = Object.keys(jsonArray[0]); // Assuming jsonArray is not empty
            //    //var dtxa = [];

            //    //jsonArray.forEach(function (obj) {
            //    //    var row = [];
            //    //    headers.forEach(function (header) {
            //    //        row.push(obj[header]);
            //    //    });
            //    //    dtxa.push(row);
            //    //});

            //    ////dtxa.forEach(function (row) {

            //    ////    y = doc.autoTable.previous.finalY + 10;
            //    ////});

            //    //headers.forEach(function (header) {
            //    //    var cellWidth = doc.getStringUnitWidth(header) * 5; // You may adjust the multiplier for proper width
            //    //    tableWidth += cellWidth;
            //    //});
            //    //// Set table headers

            //    //doc.autoTable({
            //    //    startY: y, // Start table at current y position
            //    //    head: [headers], // Set headers
            //    //    body: [], // Initialize empty body
            //    //    styles: {
            //    //        cellWidth: 'wrap', // Horizontally align content within cells
            //    //    }

            //    //});
            //    //// Calculate y position for next iteration
            //    //y = doc.autoTable.previous.finalY + 5; // 10 units spacing between tables

            //    //// Iterate over each object
            //    //$.each(jsonArray, function (index, obj) {
            //    //    if (y > doc.internal.pageSize.height - 10) {
            //    //        doc.addPage(); // Add new page if needed
            //    //        y = 20; // Reset y position
            //    //    }
            //    //    var data = [];
            //    //    data.push(Object.values(obj));
            //    //    // Iterate over each key-value pair in the object
            //    //    //$.each(obj, function (key, value) {
            //    //    //    // Push key-value pair as an array to the data array
            //    //    //    data.push([key, value]);
            //    //    //});

            //    //    // Add data to the table
            //    //    doc.autoTable({
            //    //        startY: y, // Start table at current y position
            //    //        body: data,
            //    //        didDrawRow: function (data) {
            //    //            // Apply different styles to alternate rows
            //    //            if (data.row.index % 2 === 0) {
            //    //                // Light gray for even rows
            //    //                doc.setFillColor(240, 240, 240); // Light gray
            //    //                doc.rect(data.table.width, data.row.y, data.table.width, data.row.height, 'F');
            //    //            }
            //    //        },
            //    //        styles: {
            //    //            cellWidth: 'wrap', // Horizontally align content within cells
            //    //        }// Set data
            //    //    });

            //    //    // Calculate y position for next iteration
            //    //    y = doc.autoTable.previous.finalY + 2; // 10 units spacing between tables
            //    //    cnt++;
            //    //});
            //    var img = new Image();
            //    img.onload = function () {
            //        // Adjust the image dimensions and position as needed
            //        doc.addImage(img, 'PNG', 1, 1, 290, 70); // (image, format, x, y, width, height)

            //        // Add text below the image
            //        //var textArray = [
            //        //    "Sentence 1",
            //        //    "Sentence 2",
            //        //    "Sentence 3",
            //        //    "Sentence 4",
            //        //    "Sentence 5"
            //        //];

            //        //var yPosition = 10; // Initial y position for text

            //        //// Loop through the textArray and add each sentence to the PDF
            //        //textArray.forEach(function (sentence) {
            //        //    doc.text(15, yPosition, sentence);
            //        //    yPosition += 10; // Increment y position for the next sentence
            //        //});



            //        //$.each(jsonArray, function (index, obj) {
            //        //    // Iterate over each key-value pair in the object
            //        //    $.each(obj, function (key, value) {
            //        //        if (yPosition > doc.internal.pageSize.height - 10) {
            //        //            doc.addPage(); // Add new page if needed
            //        //            yPosition = 20; // Reset y position
            //        //        }

            //        //        doc.text(20, yPosition, key + ": " + value);
            //        //        yPosition += 4; // Increment y position

            //        //        // Add a line after the text
            //        //        yPosition += 5; // Increase y position by 5 units for the line

            //        //        // Draw a line
            //        //        doc.setLineWidth(0.1);
            //        //        doc.line(20, yPosition, doc.internal.pageSize.width - 20, yPosition); // Draw line from left to right margin

            //        //        // Increment y position for next iteration
            //        //        yPosition += 5; // In
            //        //    });
            //        //});
            //        // Save the PDF<img src="" />
            //        doc.save('example.pdf');
            //    };
            //    img.src = 'pdfimages/FORM-III-SEIZURE-INFORMATION-TO-MAGISTRATE_Header.jpg';
            



            //    // doc.save('Aftersearch.pdf');
            //}

        });



    </script>
 <style>
 .mybtn {
        
        letter-spacing:1px;
        background-color:#d4148ff7; 
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        transition-duration: 0.4s;
        cursor: pointer;
        border-radius: 8px;
    }

    .mybtn:hover {
        background-color:#d4148ff7; 
        color: white;
    }


</style>
</head>
<body>
   <button class="mybtn" id="btnGeneratePDF">Generate PDF</button>
</body>
</html>
