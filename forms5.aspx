<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forms5.aspx.cs" Inherits="forms5" %>


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

	<title>Arrest Memo</title>

   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
    
    <script>
        var rqtn = [];
        $(document).ready(function () {
            var witnessCount = 0;

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
                        url: "beforesearch.aspx/GetAutoCompleteData",
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




        //submit code 

        function sub() {
            $(".loading").show();

            // Get form input values
            var caseno = $("#txtcaseno").val();
            var identification = $("#txtidn").val();
            var arrested = $("#txtarst").val();
            var notification = $("#txtntfcn").val();
            var dist = $("#txtdist").val();
            var right = $("#txtright").val();
            var inspection = $("#txtinspc").val();
            var medicalexm = $("#txtmedical").val();
            var documentcpy = $("#txtdoc").val();
            var prsnrltnacsd = $("#txtlegal").val();
            var arstybmrk = $("#txtnesc").val();
            var arstbidnt = $("#txtrec").val();



            var arrestlist = [];
            // Create and push user object to users array
            arrestlist.push({
                caseno: caseno,
                identification: identification,
                arrested: arrested,
                notification: notification,
                dist: dist,
                right: right,
                inspection: inspection,
                medicalexm: medicalexm,
                documentcpy: documentcpy,
                prsnrltnacsd: prsnrltnacsd,
                arstybmrk: arstybmrk,
                arstbidnt: arstbidnt

            });







            $.ajax({
                type: "POST",
                url: "forms5.aspx/Insert",
                data: JSON.stringify({
                    arrestlist: arrestlist,
                    pic: $("#hiden").val(),
                    path: $("#hidden").val()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessrrd,
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });

            function OnSuccessrrd(response) {
                $("#alertdvd1").show();
                $(".loading").hide();
            }
        }


        //code for refresh

        function refreshPage() {
            location.reload();
        }

        function print() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            // HEADER SECTION

            // Set margins
            const margin = 10;
            const pageWidth = doc.internal.pageSize.getWidth();
            const pageHeight = doc.internal.pageSize.getHeight();
            const maxContentWidth = pageWidth - 2 * margin; // Maximum content width

            // Get all section divs
            const sections = $('.login-form .row.asd > div');
            const maxPageHeight = 275; // A4 paper height in mm
            let yPosition = 20; // Starting Y position

            doc.setFontSize(16); // Slightly larger font size for the main heading
            doc.setFont("times", "bold");
            doc.text("Arrest Checklist", margin+75, yPosition);
            yPosition += 15; // Space below the heading
            // Loop through section divs using a standard for loop
            for (let i = 0; i < sections.length; i++) {
                const section = $(sections[i]);

                // Extract and add the section header to the PDF
                const sectionHeader = section.find('h5').text();
                doc.setFontSize(14);
                doc.setFont("times", "bold");
                doc.text(sectionHeader, margin, yPosition);
                yPosition += 8; // Reduced spacing
                doc.setFontSize(12);
                doc.setFont("times", "normal");

                // Process checkboxes manually
                const checkboxes = section.find('input[type="checkbox"]');
                for (let j = 0; j < checkboxes.length; j++) {
                    const checkbox = $(checkboxes[j]);

                    // Skip unchecked checkboxes
                    if (!checkbox.is(':checked')) continue;

                    const labelText = checkbox.parent().text().trim(); // Get the text from the label
                    const fullText = `${labelText}`;

                    // Add a checkmark image next to the label if checked
                    const img = new Image();

                    img.src = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gAfQ29tcHJlc3NlZCBieSBqcGVnLXJlY29tcHJlc3P/2wCEAAQEBAQEBAQEBAQGBgUGBggHBwcHCAwJCQkJCQwTDA4MDA4MExEUEA8QFBEeFxUVFx4iHRsdIiolJSo0MjRERFwBBAQEBAQEBAQEBAYGBQYGCAcHBwcIDAkJCQkJDBMMDgwMDgwTERQQDxAUER4XFRUXHiIdGx0iKiUlKjQyNEREXP/CABEIAgACAAMBIgACEQEDEQH/xAAdAAEBAQACAwEBAAAAAAAAAAAACQgGBwECBQQD/9oACAEBAAAAAN/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA6+zB1T8UAAAAAB9rtnT/PgAAcLm1l30AAAAAAB7ajpTzAAA6gkXxQAAAAAAAcrrx22ABwuMHFAAAAAAAAcrtRysAEpstAAAAAAAANVVUADr6InqHb3Z/kAAAAAHr1j1CHvb3nwAw/OEKSbaAAAAAAGJZthSDbwAmTjcdvWgAAAAAABF/qEbJpqAJYZQGraogAAAAAAlblMavqeAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAHXnAO7vqAlflEauqgAJX5RGrqoAAAAAeJyYe8cjrv3IEr8ojV1UABK/KI1dVAAAAACeWDhoGvoSvyiNXVQAEr8ojV1UAAAAAYQngHYluglflEauqgAJX5RGrqoAAAABi6afgNt0jCV+URq6qAAlflEauqgAAAAMmy3/mHe9ff1BK/KI1dVAASvyiNXVQAAAAMyyk/MHcNhvrglflEauqgAJX5RGrqoAAAAOgJH/gDs+xnIwJX5RGrqoACV+URq6qAAAAHS0gvjhz2x3MwEr8ojV1UABK/KI1dVAAAAHVUeeOBy+x3YIBK/KI1dVAASvyiNXVQAAADr2OXEA5FYbtYASvyiNXVQAEr8ojV1UAAABw2OHAg+vX7ukAJX5RGrqoACV+URq6qAAABx2OXWAfvrboIAEr8ojV1UABK/KI1dVAAAB8aPfTwfoqzp0ACV+URq6qAAlflEauqgD4nS3ZXOgB+eQHRAe9RtagAJX5RGrqoACV+URq6qAZ9k58b3oFvkB/CSmcw80t2gAASvyiNXVQAEr8ojV1UAiH16KL7nB4lRlkFDt4AACV+URq6qAAlflEauqgPWAvqPNM9lDxMDIIN20RAACV+URq6qAAlflEauqgEfegw/pU3VrxN7EYNo0s8gABK/KI1dVAASvyiNXVQDhUbuDh+msGlZ84HBrWpHkAAEr8ojV1UABK/KI1dVAHW0ceMB9DXWNQabrGAAAlflEauqgAJX5RGrqoAdPx6+MAGgq7f2AAASvyiNXVQAEr8ojV1UAHQcjPwAHdtgPogAAEr8ojV1UABK/KI1dVAAzJKP+AHbNivtgAACV+URq6qAAlflEauqgAMiS+9Q7HsZysAAAJX5RGrqoACV+URq6qAAYgnAOb2L54AAACV+URq6qAAlflEauqgADCs9/wAfZtZOzQAAAJX5RGrqoACV+URq6qAAHyeJ9g+QAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABLDKA1bVEAAAAAAErspDV9TwBMnG47etAAAAAAACL3UQ2TTUAYim8FI9tgAAAAADEc3QpBt4AdfRE9Q7d7Q8gAAAAA8dX9RB7W57DACVGWAAAAAAAAGp6rgA4lFnigAAAAAAAOWWj5eAB1LIfiYAAAAAAA5XXHuIAA4pNfK/oAAAAAAD21LSnlwAAOAZh6n+IAAAAAA+32zpvsEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//xAAUAQEAAAAAAAAAAAAAAAAAAAAA/9oACAECEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/EAE8QAAAEAwMIBQkDCgQEBwAAAAECAwQFBgcACLIRGCA3ZYWU0iEwMUFCEhQiMkBQUVJhEzRxEBUjJDNDY4Ghw0R0kZIXJYCzNWSCo7HBwv/aAAgBAQABPwD/AKSp0rHTSnYKIzPNTRF4XtZIiLh3/NJIDCW0wX4YA1E6MqSS9e/Bd+4I1D/YmCtn99qpy4iDCAS60T+qK6x/6qhbPKrFsLgTc9s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8usWwuBNz2YX2amoGD84QCXHZPoguif/UFRtLl+OALnInNckvmXcKzBwR0H+xQErSTWSmtQvISliami7wwfclhFu7/kkqBRN7HP1SJRprBhjM1xQjZMcoINyem5cnDwIp+IbVQvWT7O53EMlpY8uQEREoJtT/rqxfiquGEljnOqc6ihzHOcwmMYw5RER7REfdZDmTMU5DCU5RASmAcggId4WpZesnyRToQ6Y1TzJAgyFFN0p+uIk/hLjhPantR5QqZBvzzKcUK4IXIVduf0HDU4+BVPtAfYKz1ngVH4CR06KDyOPCmCGw4DAAnEO1VT5Ui2nOdpkn+PO5jmmIndvlx6O5NFPuSSJ4CF93yZOsySBHmkxyvETtHyA/imqn3pKk7DkNaitaoFWCAnctylZxxkUgRKHCbKJBH96l8yRuuqRP0GpnKMUmuMmAxG5fIQbgOQ7lyf1ESfjadpzj0/zJEppmN2K752fLk8CKYeokkHhIQOwPeMlTlHZBmSGzRLroUXrQ/Z4Fkh9dJQO8hwtTmf4NU2UYZNcDUyJOC+Q4QEcqjZwT10T/UvW3rKpHnqfVpchzgRgUuHO1TAB9BZ52LqjgD3ndPqkpJE+IyvEXOSBTIoRscDj0IvexBUMA9ZWOdP+HtNZqmdI4EdoNBRY/5twIJJD/IR8qxznUOZRQwmOYRMYxhyiIj2iOlJ1B6rz0gk9gMoOvMFOkjt2JGiBg+JBWEonD6lsW5vWMQ7IHxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8ljXN6xlARyQPjh5LTjQeq8ioKvY9KDrzBPpO7aCR2gUPicURMJA+ptIhzpHIqmcxDkMBimKOQQEOkBAbUcnf/AIg01lWaFlAM7XaAi9+jtAfslf8AcYMvV34ZhM1l+SZTSU+/PnEQXD6NSAmTHpXbLtcMYwyHT/UGGkdRJ0Qi8NhrgmVJqkPSRVYg9qo+6byl22Gv4bEqgU/hpGsSakM4iUNbkyJOkg6TrIkDsVDSuOzELqXp2lNY4iDF83iCIfR0QUz/ANUurvtPxXqdAGHgaS6gP/rWXV0aDychPVV5QgL1IFGHnQu3ZB7DINCCsJB+hxKBfddd5OQkSq03wBkkCbDzoHbQgdhUHZAWAgfQnlCXRuSvxQqbMEO8DuXFjfidFdLq75WuLcTHEfRubAA1jKOxHw4Pdd8gACsZx2IxHHo3NNcW4n2InV3ytce42OI+jc11x7jfYie675WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE913ytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7rvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET3XfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuKb62UskVZRpMk5MUXhPXaoeU6XKPwOmgBxJZpezog6XBE8zOW4CPrrMHIEwDaXptlia2ARGV44xijXsFRosVUCD8DgHSUfoOnfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuARAoCYwgBQDKIj2AFrwl5x9FXbySqaxMyEKREUn0XbmEFXZ+wSIH8KOOwiJhExhEREcoiP5JWm6ZJJi7eOytF3EPfoj0KImyAcvyKF7DkHvKNqD1mZVglc7tVJNtMEOEiMUak9XKb1Fk/4amlfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuC85eM/Ogv6bSE+yMAEUYvEUR/bj3tkR+T5x0bsc3uJTrDK5CKiDSMq/mh0TuODroT/wBFQLpXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7febvGeaA/prIL7IuIChGIkiPqfM1RHGOlSJmu/qnTlq2ARUGZIYf8AAqbgpzD/ACANK+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPbrzF4oJYSe08kR8AxxQopROIIj9xIPail/HwWEREREREREcoiOlc1pk6i00L1JiLYQhkIIq3YGP2LPVS+QYS/RIg6V8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYie23k7wqMgs15Jk50U81OUsjlcnSENSP/fNZVVVdVRddQyiqhhOc5xExjGMOURER7RHSoXRGMVfj/pgq0llioUYk/8A7CPxVNaAwGEStB2ECgjJJnDmSIIoIJBkKQof/Ij2iI9IjpXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7ZeIr+0pfDjy3LS6S84PEfockPSP2LHD5x8BbO3bqIOnL584UcOnCp1VllTCdRRQ45TGMYekREdKjVHo3V2Yyw9p5bWDNRKeJxES5Sopj4CfFU/hC0ryxApJgEPlqWmJGkNZJ+QkQvaYfEc4+I5h6RHTvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET2uv1d4dSOC/m2GGSdTc/SEWbbtK2IP+IWDAHitFIpEY3EXsXi7xV2/eLGWcOFjeUdRQ45RMI6VKKVTDVmZ0YDBSCk1TyKRB+coik0Q+YficfAW0jSVLtPJbYyxLLQEGTYPSOPSquqPrKqm8RzdRfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432IntVca2Qij8Ayk+zdTI9TMENYf31vgkW0fj8YmiMxCPx5+o8iT1YVV11B6TGH+gAHYAB0AGlTinUw1OmZpLUvIekb03Tk4D9i1Q8Sqlqc06l2l0stZZl1D0Sem5dHAPtnK49qqn1Hqb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE9prJV+A0hlsYi+ArmLOQMSGQ0DZDuFA8Z/gkTxDabJrjs7R+ITLMb4zqIvFPKOcegpQ7iEL4SFDoANKRZGmGokyMZXlpmKz1wOUxx6EkEg9ZVU3hIW1KaWS7SOWEYHByAq7VyKP35igCrtfkDwF6q+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPaKqVTl6kssLR6NHBV2p5ScPYEMAKul/lD4FDxmtPM8TDUOZH0zzK8Fd44HIUgZQSQSD1Ukg8JC6UqSpHZ2j8OlqXGRnUReKARMgdBSh3nOPhIUOkRtRuj0BpFLZYe08lzFnQEPE4gJch11Q8JfgkTwl6u+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPZ6i1Clyl8sOpmmNxkIT0GzYgh9s7XH1UkwtUeo0xVPmZ1Mkwr+kb0GrYgj9i1QDsST0oBAYvNEYh8AgLFV5EnqwIoIJBlExh/oAB2iI9ABahtEYPSCAfpfsncyPkyjEn39hH4JF6y+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPZp4naXadS2+miZnYItGxchCB0qrqj6qSRfEc1qr1UmCrEzKxyMHFFollTh7AhhFJohzj4z6UMhkQjURZQmEs1XT92sVFBBEvlHUUOOQCgFqBUIh9JIOERiYJOpufpADxyHSVqmP+HQHGbrb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE9lmmaoHJkBiMyTG+IzhjJPy1VDesYfCQgeI5h6AC1ZawxyrsyGiLzy20HaickMhwGylQTHxn+Kp/EOk0aOn7psxYt1HDpwqRJFFIonUUUOOQpSlDpERHsC13agDWmUPJMsyIprze8R+hyQ9I/aimPeoPjP118rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYiacyznKMkMwezXMTCFpH9QXKwEOpk7kyescfwCy97Wh6K4okmR2sUP3qcOc+RgAbSfWCmk+qEbytODF27MGUGpxMg5H8ElgIcerj8fg8rweIR+PP0mcNZJCquuqPQUof1ER7AAOkRtXSt8Xq/H/Q+1aSyxUMENYCP/AL63xVNpJJKrqpoopmUVUMBCEIAmMYxhyAAAHaI2u3Xek5AaoTtOLQh5qcpZWrY/SENSP/fHr75WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0rw1eEKRwhCGQYqTia4kkJmiR+lNqj2C4VDAFo/MMcmmKOY3MUVcRCIuDZVF3BxOYfoHwKHcAdAfkTUURUTWRUMRQhgMQ5REDFMHSAgIdgha7jecdrPGUh1Lif2oLCVGGRhc3pgfuRcnwqdTEolD4PDXsWirxJnD2iJlnDhYwFImmQMoiI2vAV4iFWYwMNhZlWsosFR8zbdhnJw/xCwYQ0gAREAAMoja7Nd1LLCTOok+Mg/PahQVhcPWD7kQexZUB/f4PYL5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0qqzo5qBUGaJpXVE6Tp6oVoHcRokPkIlD8CBo3Yrxvn4MKbT8/wD1wABCDxNc37b4NlhHx/IbTdOmzBq5fPnCaDZukdVZVUwEImmQMpjGEegAAO0bXi7wTqp8RPLUtrKISezW+pDxBUnYsoHyB4Cad2O7p5oVhUufWH6foXgsMXD1O8rpYMBfYb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0YgiqvD3yCHQoo3UIT6GMUQCxyGTMYhyiUxREBAe0BDRKIlEDFEQEBygIdoDa7NeLCa0mdPZ6e5I8kUE4a/VH7+QOxJT+Pj0VFE0U1FllCkTIUTHOcQApSlDKIiI9gBa8leFUnt04kmTXYllZurkcuSdAxJUn9gNO7Nd1/OfmFSJ9Y/qACC0HhqwfeB7nKwD+6+QPYr5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0rx9OHNPKlxgCICEHjKykShyng8lY2VRL8Uj6SKyrdVJdBU6SyRynTUIYSmIYo5QMUQ7BC12y8OlUBohJc3uiJzY1SyILm6AiSRP74eIPyiIAAiI5AC15i8UMxneU7kR7kghBFOKRBEfvxw7UUhD9xj07tN3YZtVaz/PDIQl1E4HhzFUPv6hfGf8AgY7FKUhQKUAAoAAAAdAAAexXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJpVNpnLtUpXcy1HkcnaozdkD9M0X7lCDiC1QqfTFTSZnssTG28hdL00Fy/sXKA+qqkPeUdJm8dw522fsHKjd23VIsiskYSKJqEHKUxRDpAQG13a8E0qhDSS3MiySE3s0fT7CkfpE7Vkw+cPGT8l5u8T5yL+m0hvv0ACZCMRJEfX7jNURxjp3b7va1RHqM4Ta2OlKLRX9GkboGJKk8AfwQ8Y2QRRbIotm6JEkEiFTTTIUCkIQoZAKUA6AAA7A9jvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ETTrBSaX6tywrB4qAIRFDylIbEALlUbLDiTN4y2nGT4/IkwxGWJlZC2iDQ+QwdpFCD6qiZvEQ/aA6UKisSgcSZRiEPVWj9msVZuuibyTpqEHKAgNp3vezHM1OmMtwtkeGzE6SOhGYikIAUU/8AyveQVdO7xQB7VSKFjseSVbyexWAFj+od8qX9wiOM9mLFnDGTWHQ5qk2ZtkiIoIIlAiaaZAyFKUA7AAPZL5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE6iuFFYPV+XhRHyGsxMiGGGP/7KvxSPaYZejEqxqIS/H2CjOJMlRSXQU7QEO8B7yiHSAh0CHWUGoZE6tRrzt6CrWVGCoefOw6BWN2+boD8+G0JhULl6FMYLBWSTOHMkSoN0ES5CEIXuD/7H2W+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsROpr/QeHVagov4WRJrNrBIfMnPYVyTt82WHCPhG0UhcQgsRewmLM1Wj9osZFwgsXyTpqEHIICHVURotGqwTCDdPy2kvsjlGJxDJ6gdySXxVPaW5dgspwOHy9AGCbKFsUgTQRJiMPeYR6REekR9mvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ETqrxt31CpkOUmeWUEkZvZI/QhYiiTsRP8AxA8BrOmrlk5cM3iCiDlBQySySpRIdM5ByGKYo9ICA9odRSCkcfq5MycHhgChDUBKpEogJcqbZEcShvAW0oShAZClyHyvLTMGzBoTIHedQ4+soobxHOPaPs98rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYidXeYu7knZs6nuS2YBMzdPK9aJh/4ikT++WxyHTOZNQolOURKYohkEBDtAdKl9MJjqtMyEvQFLyEwyKPXpwEUWiHec/1+UtpCkKXKbS0ylaWmv2bZH01ljZBVcrD6yqo95ze0Xytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ1l567p+dyPqkyGw/5kQBWi8OQL95DvcogH735w0afSBMVSplZyxLbby11fTWWN+xbIB6yyo9xQtTKmkvUslltLsBSym6FHjs4ACzpfvUP/APkvcHtN8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYidbeDusuYq9ezvTFmQXK4is/gpMhPLP3rNeSz+Hv4U7Xh8TZLtHiJhIqg4TMkqQwdximABAfyU6pFPNT36bWWYOoLPywBeIrgKbNAO8TKd4h8pco2pNSeXqSy0SDQgv271fyVIjEDkAFXSoYSF8BPar5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE66YZSlOZ0wSmWWoXFQAMhfPmqS4l/ATgIhZpRikcPXBy2pzAAVAQMAnYpKYwGyKCDZJNu2RIkimUCkTTKBSlAOwAAOgA9rvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET3XfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432Inuu+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPdd8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYie675WuPcbHEfRua649xvsROrvla4txMcR9G5sIBWMobEfBg913yRAaxmDYjEMejc01xbifYidXfaYGQqdAH/gdy6iX8Torq6NB5xQkWq0oR56qCbDzoWjs49hUHZBRE4/QgmA3uuu84oT3Vabo+yVBRj50DRocOw6DQgIgcPofyRNo3JYedepswRDwNJdWJ+B1l0urvxy4dxAJJmtIn3J84YLD9HRAUJg0rtl5SGPYZDpAqFEiNYi1IVCGxNyfIk5SDoIkscexULdvSHui8leShjCFxGntPoiR1EXJDNolEkDAKTZIeg6KRw7VTaVx6Xhay9O01rE+/PkGCA/RoQVD/1V6usMkBUGmk1ywgmB3a7QVmX+bbj9ql/qJfJsch0znTUKJTlESmKYMggIdoCGlJ1dqqyKgkygM3OfMUwACNHYEdoEAO4gLAbyA+hbFvkVjAAATQTgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57GvkVjEO2B8CPPacq71WntBVlH5vdeYKBkOzaARogYPgcEQL5YfQ2kQh1DkTTIJjnEClKUMoiI9gAFqPSYFPaaSrK5yAR2g0BZ7/AJpcRVVD+RjZOsvW0tPI0+qzJDW4hApkOd0mJfVRedq6Q4w953U6WnnaekpoiTfLApbUI5MJw9Fd72oJBjN1tSKfQepcnxOUowUCJrk8tuuAZTtnJP2axPqFp2kuPU/mSIytMbQUHzQ/b4Fkx9RVIfEQ/vGSJLj1QJlhsrS41FZ67UABHwIpB66qo9xCWp3IcFppKUMlKBF/Qti+W4cCAAdy4P66x/qbrq00VgNYYEVq6ODOOMwOMOiIEARTEf3SnzJGtOkkTLT+PO5cmmGqNHqI9Aj0pLJ9yqR+w5B93yXJMyz/AB5pLkrQ07t6sPT3Jop96ip+whAtRijECpBATtWxivI48KQYlERLkFQQ7E0/lSL7BUGnUo1JgZ4HNkMK4S6TILk9Bw3U+dE/hG1Ubp8+SUq4iMqpKTJAgymAzYn66iHwUR8f4ksomdI50lSGIoQwlMUwCAlEOgQEB7BD3WQhlDFIQomOYQApQDKIiPcFqV3Up7no6ESmVJSW4EIgIndJ/rqxf4SA4j2kGnco00gpILKUMI2R6BXcG9Ny6UDxrKdpvY52o3TWoP2q00yqzWdnD76iAt3X81UhATWmO45L7g51ZUnZ8x+CL9uR2H+9MUrP7ktTUBEYfH5ddp/VZdE//aG2ZpWLYXHG5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmlYthccbktDrktTVxAYhH5daJ/RZdY//aC0uXHJebnIrNc7Pn3eKLBAjQP96gq2kyjtNqegmpK8qtEHZQ++rALh3/JVUTCX/pL/AP/EABQRAQAAAAAAAAAAAAAAAAAAAKD/2gAIAQIBAT8AAB//xAAUEQEAAAAAAAAAAAAAAAAAAACg/9oACAEDAQE/AAAf/9k=';

                    doc.addImage(img, 'JPEG', margin+7 , yPosition-3 , 4, 4);

                    // Use splitTextToSize to wrap the text to fit within 170px
                    const wrappedText = doc.splitTextToSize(fullText, 170);

                    // Render each line of wrapped text in the PDF
                    for (let line of wrappedText) {
                        if (yPosition + 8 > maxPageHeight) { // Reduced spacing
                            doc.addPage();
                            yPosition = 20;
                        }
                        doc.text(line, margin+15, yPosition);
                        yPosition += 8; // Reduced spacing
                    }
                    yPosition += 8; // Space between checkboxes
                }

                // Handle Remarks
                const remarksInput = section.find('input[type="text"]');
                if (remarksInput.length > 0) {
                    const remarksText = remarksInput.map(function () { return $(this).val().trim(); }).get().join(', ');
                    if (remarksText) {
                        const wrappedRemarksText = doc.splitTextToSize("Remarks: " + remarksText, 170);
                        wrappedRemarksText.forEach(function (line, index) {
                            if (yPosition + 8 > maxPageHeight) {
                                doc.addPage();
                                yPosition = 20;
                            }
                            if (index === 0) {
                                doc.text(line, margin, yPosition);
                            } else {
                                doc.text(line, margin + 15, yPosition); // Indent subsequent lines
                            }
                            yPosition += 8; // Reduced spacing
                        });
                    }
                }

                // Add space between sections
                yPosition += 5; // Reduced spacing between sections
            }
            const pdfWidth = doc.internal.pageSize.getWidth();

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
            // Save the document
            doc.save('case-document-forms5.pdf');

            const pdfBase64 = doc.output('datauristring').split(',')[1];
            const caseNo = localStorage.getItem('caseno');
            const pageName = window.location.pathname.split('/').pop();

            // AJAX request to save the PDF
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

	<!-- SIDEBAR -->

    <aside id="sidebar">
        <!--
            <li>
                <a href="" style="font-weight: 500; font-size: 10px;"><i class="fa fa-dashboard"></i><span>Black Tiger</span></a>
              </li>
        
            -->
                <h3 class="for"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;Black Tiger</h3>
        
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


	<!-- CONTENT -->


	<section id="content">

		<nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>


<h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;Black Tiger</h3>

      <main>

         <div class="container" style="margin-top: 80px;">
             <h2 class="text-center" style="color: #fff;">Arrest Checklist</h2>

        

         </div>


             <div class="row " style="margin-top:50px;">
                <div class="col-md-10  col-12 mx- auto offset-md-1">
             <div class="login-form">
             <div class="row asd d-flex pt-4 pb-4">

                <div>

                   

                <h5 class="head1" style="color: #000;">1. Identification::</h5>
                <p>
                    <label>
                        <input type="checkbox" name="Forensic" value="Forensic">
                      Are all Forest Officers involved in the arrest and interrogation displaying accurate, visible, and clear identification and name tags with their designations?
                    </label>
                </p>

                    <p>


                        <label>
                            <input type="checkbox" name="Forensic" value="Forensic">

                            Have the particulars of all Forest Officers handling the arrestee's interrogation been recorded?
                        </label>



                    </p>
                     <label>Remarks</label>
        <input type="text" id="txtidn" class="form-control">
               </div>
                          
               
               <div>
                 <h5 class="head1" style="color: #000;">2. Arrest Memo:</h5>

                <p>
                    <label>
                        <input type="checkbox" name="Forensic" value="Forensic">
                       Has an arrest memo been prepared at the time of arrest?
                    </label>
                </p>

        <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic"> 
               Is the memo attested by at least one witness, either a family member of the arrestee or a respectable person from the locality where the arrest is made?
            </label>
        </p>  


                   <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic"> 
               Does the memo include the time and date of arrest, and is it counter-signed by the arrestee?
            </label>
        </p>  
        
        <label>Remarks</label>
        <input type="text" id="txtarst" class="form-control">

      </div>

    
     <div>
        <h5 class="head1" style="color: #000;">3. Notification of Arrest:</h5>

        <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic">
                Has a friend, relative, or other interested person been informed that the arrestee has been detained as soon as practicable?
            </label>
        </p>
        <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic">
               If the witness attesting the arrest memo is a friend or relative of the arrestee, have they been informed of the arrest and place of detention?
            </label>
        </p>

          <label>Remarks</label>
        <input type="text" id="txtntfcn" class="form-control">
      </div>

      <div>
        <h5 class="head1" style="color: #000;">4. District Notification:</h5>

        <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic">
               Has the arrestee’s next friend or relative been notified about the time, place of arrest, and venue of custody if they reside outside the district or town?
        
                 </label>
                
                </p>
        <p>
            <label>
                <input type="checkbox" name="Forensic" value="Forensic">
                Was this notification sent within 8 to 12 hours after the arrest through the Legal Aid Organisation in the District and the concerned Range Office?
            </label>
        </p>
         <label>Remarks</label>
        <input type="text" id="txtdist" class="form-control">

      </div> 


      <div>
        <h5 class="head1" style="color: #000;">5. Right to Information:</h5>
        <p>
            <label>
                <input type="checkbox" name="Documentary" value="Documentary"> Has the arrestee been informed of their right to have someone notified of their arrest or detention as soon as they were taken into custody?
            </label>
        </p>
        <label>Remarks</label>
        <input type="text" id="txtright" class="form-control">
     </div>


     <div>
        <h5 class="head1" style="color: #000;">6. Inspection Memo:</h5>
        <p>
            <label>
                <input type="checkbox" name="Documentary" value="Documentary"> Has the arrestee been examined for major and minor injuries at the time of arrest, especially if they requested it?
            </label>
        <p>
            <label>
                <input type="checkbox" name="Documentary" value="Documentary"> Are any injuries recorded in the 'Inspection Memo,' and is this memo signed by both the arrestee and the arresting officer?
            </label>
        </p>
          <p>
            <label>
                <input type="checkbox" name="Documentary" value="Documentary"> Has a copy been provided to the arrestee?
            </label>
        </p>
        <label>Remarks</label>
        <input type="text" id="txtinspc" class="form-control">
    </div>
 
    <div>
        <h5 class="head1" style="color: #000;">7. Medical Examination:</h5>
        <p>
            <label>
                <input type="checkbox" name="Material" value="Material"> Is the arrestee subjected to a medical examination by a trained doctor every 48 hours during detention?
            </label>
        </p>  
        <p>
            <label>
               <input type="checkbox" name="Documentary" value="Documentary"> Is this examination performed by a doctor from the approved panel appointed by the Director, Health Services of the concerned State or Union Territory?
                </label>
            <label>Remarks</label>
            <input type="text" id="txtmedical" class="form-control">
    </div>

            

    <div>
        <h5 class="head1" style="color: #000;">8. Document Copies:</h5>
        

        <p>
            <label>
                <input type="checkbox" name="Material" value="Material"> Have copies of all documents, including the arrest memo, been sent to the Magistrate for record-keeping?
            </label>
        </p>  
        
            <label>Remarks</label>
            <input type="text" id="txtdoc" class="form-control">

              
    </div>

    <div>
        <h5 class="head1" style="color: #000;">9. Legal Access:</h5>
        <p>
            <label>
                <input type="checkbox" name="Material" value="Material"> Is the arrestee allowed to meet with their lawyer during interrogation, though not continuously throughout the interrogation?
            </label>
        </p>  

         <label>Remarks</label>
            <input type="text" id="txtlegal" class="form-control">

    </div>
  

 <div>
        <h5 class="head1" style="color: #000;">10. Reason to Believe:</h5>
        <p>
            <label>
                <input type="checkbox" name="Material" value="Material"> Does the forest officer have valid grounds, based on a complaint, information, or suspicion, to believe that the person has committed the said offence?
            </label>
        </p>  

         <label>Remarks</label>
            <input type="text" id="txtrson" class="form-control">

    </div>

<div>
        <h5 class="head1" style="color: #000;">11.  Necessity of Arrest:</h5>
        <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Is the forest officer convinced that the arrest is necessary to prevent the person from committing any further offence?
            </label>
        </p>  

     <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Does the forest officer believe that the arrest is required for a proper investigation of the offence?
            </label>
        </p>  

    <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Is there a concern that the person might cause the evidence of the offence to disappear or tamper with it?
            </label>
        </p>

    <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Is there a risk that the person could make an inducement, threat, or promise to someone acquainted with the case facts to dissuade them from sharing those facts with the Court or the forest officer?
            </label>
        </p>

    <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Is the arrest necessary to ensure the person’s presence in Court whenever required, and can this not be ensured without making the arrest?
            </label>
        </p>

         <label>Remarks</label>
            <input type="text" id="txtnesc" class="form-control">

    </div>

                 <div>
        <h5 class="head1" style="color: #000;">12.  Recording of Reasons:</h5>
        <p>
            <label>
                <input type="checkbox" name="Material" value="Material">Has the forest officer documented the specific reasons for the arrest in writing?
            </label>
        </p>  

         <label>Remarks</label>
            <input type="text" id="txtrec" class="form-control">

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
<input id="name-designation" name="name-designation" pattern="[A-Za-z\s]+" title="Only letters and spaces are allowed" required />
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