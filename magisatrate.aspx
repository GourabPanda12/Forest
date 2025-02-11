<%@ Page Language="C#" AutoEventWireup="true" CodeFile="magisatrate.aspx.cs" Inherits="magisatrate" %>






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

	<title>Requisition For Independent Witness</title>

 
    <script type="text/javascript">
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





            //$('#txtcno').autocomplete({
            //    source: function (request, response) {
            //        $.ajax({
            //            type: "POST",
            //            url: "rqtnwtns.aspx/GetAutoCompleteData",
            //            data: JSON.stringify({ prefix: request.term }),
            //            contentType: "application/json; charset=utf-8",
            //            dataType: "json",
            //            success: function (data) {
            //                response($.map(data.d, function (item) {
            //                    return {
            //                        label: item.ServiceName,
            //                        value: item.ServiceName,
            //                        id: item.Id,
            //                        categoryId: item.CategoryId,
            //                        subCategoryId: item.SubCategoryId
            //                    };
            //                }));
            //            },
            //            error: function (error) {
            //                console.log("Error:", error);
            //            }
            //        });
            //    },
            //    select: function (event, ui) {
            //        // Set the selected item ID, category ID, and subcategory ID in hidden fields
            //        //$('#selectedServiceId').val(ui.item.id);
            //        //$('#selectedServiceCategoryId').val(ui.item.categoryId);
            //        //$('#selectedServiceSubCategoryId').val(ui.item.subCategoryId);
            //        // location.href = "catgry.aspx?cubd=" + ui.item.categoryId + "&cnnm=" + ui.item.label;

            //    },
            //    minLength: 2 // Set the minimum length of input to trigger autocomplete
            //});
        });



        function print() {
            const { jsPDF } = window.jspdf;

            // Create new jsPDF instance with portrait orientation, A4 size, and units in px
            const doc = new jsPDF({
                orientation: 'portrait',
                unit: 'px',
                format: 'a4'
            });

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
            const imgData = 'data:image/png;base64,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AAAAAAAAAAAAQmwgIGRvdWJAb+AAAAAAAAAAAABCcmRUVW50RiNSbHQAAAAAAAAAAAAAAABCbGQgVW50RiNSbHQAAAAAAAAAAAAAAABSc2x0VW50RiNQeGxAUgAAAAAAAAAAAAp2ZWN0b3JEYXRhYm9vbAEAAAAAUGdQc2VudW0AAAAAUGdQcwAAAABQZ1BDAAAAAExlZnRVbnRGI1JsdAAAAAAAAAAAAAAAAFRvcCBVbnRGI1JsdAAAAAAAAAAAAAAAAFNjbCBVbnRGI1ByY0BZAAAAAAAAAAAAEGNyb3BXaGVuUHJpbnRpbmdib29sAAAAAA5jcm9wUmVjdEJvdHRvbWxvbmcAAAAAAAAADGNyb3BSZWN0TGVmdGxvbmcAAAAAAAAADWNyb3BSZWN0UmlnaHRsb25nAAAAAAAAAAtjcm9wUmVjdFRvcGxvbmcAAAAAADhCSU0D7QAAAAAAEABIAAAAAQABAEgAAAABAAE4QklNBCYAAAAAAA4AAAAAAAAAAAAAP4AAADhCSU0EDQAAAAAABAAAAHg4QklNBBkAAAAAAAQAAAAeOEJJTQPzAAAAAAAJAAAAAAAAAAABADhCSU0nEAAAAAAACgABAAAAAAAAAAE4QklNA/UAAAAAAEgAL2ZmAAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYAAAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAOEJJTQQAAAAAAAACAAE4QklNBAIAAAAAAAQAAAAAOEJJTQQwAAAAAAACAQE4QklNBC0AAAAAAAYAAQAAAAI4QklNBAgAAAAAABAAAAABAAACQAAAAkAAAAAAOEJJTQQeAAAAAAAEAAAAADhCSU0EGgAAAAADSQAAAAYAAAAAAAAAAAAAAQIAAADjAAAACgBVAG4AdABpAHQAbABlAGQALQAxAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAADjAAABAgAAAAAAAAAAAAAAAAAAAAABAAAA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OEJJTQQhAAAAAABVAAAAAQEAAAAPAEEAZABvAGIAZQAgAFAAaABvAHQAbwBzAGgAbwBwAAAAEwBBAGQAbwBiAGUAIABQAGgAbwB0AG8AcwBoAG8AcAAgAEMAUwA2AAAAAQA4QklNBAYAAAAAAAcACAEBAAMBAP/hDa1odHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDI0LTA5LTA1VDA4OjA0OjIwKzA1OjMwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDI0LTA5LTA1VDA4OjA0OjIwKzA1OjMwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyNC0wOS0wNVQwODowNDoyMCswNTozMCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCQTIyMjg1QjJGNkJFRjExODcwRDhDRkYyQUZERTc4RSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCOTIyMjg1QjJGNkJFRjExODcwRDhDRkYyQUZERTc4RSIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOkI5MjIyODVCMkY2QkVGMTE4NzBEOENGRjJBRkRFNzhFIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOkI5MjIyODVCMkY2QkVGMTE4NzBEOENGRjJBRkRFNzhFIiBzdEV2dDp3aGVuPSIyMDI0LTA5LTA1VDA4OjA0OjIwKzA1OjMwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6QkEyMjI4NUIyRjZCRUYxMTg3MEQ4Q0ZGMkFGREU3OEUiIHN0RXZ0OndoZW49IjIwMjQtMDktMDVUMDg6MDQ6MjArMDU6MzAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIiBzdEV2dDpjaGFuZ2VkPSIvIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg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'; // Replace with your logo's base64-encoded data
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
      //      doc.text('Phone: (123) 456-7890', pageWidth / 2, margin + 95, { align: 'center' });

            // Add a heading
            doc.setFontSize(24);
            doc.setTextColor(0, 51, 102); // Dark blue color
            doc.text('', pageWidth / 2, 130, { align: 'center' }); // Adjusted y position for heading
            const caseNumber = 'Case No:' + localStorage.getItem('caseno');
            doc.setFontSize(12);
            doc.setTextColor(0, 0, 0); // Black color
            doc.text(caseNumber, margin, margin + 10); // Top left corner

            // Add date to top right corner
            const currentDate = new Date().toLocaleDateString(); // Format the date as needed
            doc.text(`Date: ${currentDate}`, pageWidth - margin, margin + 10, { align: 'right' });



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

            for (let i = 0; i <= stepCount; i++) {
                const ratio = i / stepCount;
                const red = Math.round(startColor[0] * (1 - ratio) + endColor[0] * ratio);
                const green = Math.round(startColor[1] * (1 - ratio) + endColor[1] * ratio);
                const blue = Math.round(startColor[2] * (1 - ratio) + endColor[2] * ratio);

                doc.setFillColor(red, green, blue);
               // doc.rect(0, topMargin + i * (gradientHeight / stepCount), pdfWidth, (gradientHeight / stepCount), 'F');
            }

            // Add Text Above Gradient
            doc.setFontSize(16);
            doc.setTextColor(0); // White text color
            doc.text("Magistrate Intimation", pdfWidth / 2, topMargin + 15, { align: "center" });

            // Set initial y position below the gradient header
            let yPosition = topMargin + gradientHeight + 10;
            doc.setFontSize(12);

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
            doc.save('case-document-rquistion.pdf');
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

<h2 class="text-center" style="color: #fff;text-transform:uppercase;">magisatrate intimation</h2>


            </div>
            

             <div class="row " style="margin-top:50px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                         
                          <div class="row asd d-flex">
                             <%-- <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                              <label class="lebl">Case Number</label>
                          <input type="text" id="txtcno" class="form-control console" placeholder="">
                                   </div>--%>


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




                                <div class="col-lg-6  col-sm-6 col-xs-6 abc d-none">

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

                              

                            <div class="col-lg-6  col-sm-6 col-xs-6 abc" style="display:none;">

                               
            
                             <button class="btnx mt-4" type="button"  >Submit</button>
            
                            </div>
            
                          
                       
            

                         
   
            
                          </div>
                        </div>
            
                      </div>
                    </div>





		</main>

	</section>








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
