<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forms3.aspx.cs" Inherits="forms3" %>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Boxicons -->
	<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
	<!-- My CSS -->                   


 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Seizure list (with supporting documents) </title>
    
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>

    <script>
        var Seizure = [];
        var seizrureplace = [];
        var properyszed = [];
        var acsedtl = [];
        var accusedsign = [];
        var witnessign = [];
        var seizuremark = [];
        var wtnsdtl = [];
        var reasoncstdy = [];
        var indenticopies = [];
        var cstodianseized = [];
        var cstodianfile = [];
        var possessor = [];
        var indewitness = [];
        var officialwtns = [];
        var idcopies = [];
        var rqtn = [];
        let formData33 = [];
        var add1sec;
        var add2sec;
        var add3sec;
        var add4sec;
        var add5sec;
        var add6sec;
        var add7sec;
        var add8sec;
        var add9sec;
        $(document).ready(function () {


            $('#txtbrf').on('change', function () {


                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result;
                        const fileName = file.name;

                        // Store base64 data and file name in hidden fields
                        // Base64 data
                        $('#Hidden1').val(base64Data);
                        $('#hidden2').val(fileName);     // File name
                    };
                    reader.readAsDataURL(file); // Read file as base64
                }


            });


            $('#txtofcrsign').on('change', function () {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const base64Data = e.target.result;
                        const fileName = file.name;

                        // Store base64 data and file name in hidden fields
                        $('#gourab').val(base64Data);   // Base64 data
                        $('#gourab2').val(fileName);     // File name
                    };
                    reader.readAsDataURL(file); // Read file as base64
                }
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



            $('#txtcaseno').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "forms3.aspx/GetAutoCompleteData",
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


            $(".add23").click(function () {
                // Retrieve the value entered by the user
                var seizedProperty = $("#txtpszd").val().trim();

                // Check if the input field is not empty
                if (seizedProperty === '') {
                    alert("Please enter a value.");
                    return;
                }

                // Check if the value already exists
                if ($("#szdata").find('input[value="' + seizedProperty + '"]').length > 0) {
                    alert("Duplicate value! This value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container">' +
                    '<input type="text" class="form-control console savedt" value="' + seizedProperty + '">' +
                    '<span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span>' +
                    '</div>');

                // Append the new input element to the szdata div
                $("#szdata").append(newInput);

                // Clear input field
                $("#txtpszd").val("");

                // Attach the event handler to the close button dynamically
                $("#szdata").on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                // Push the entered value into the properyszed array
                properyszed.push({
                    property: seizedProperty
                });
            });

            $(".add24").click(function () {
                // Retrieve the file uploaded by the user
                var fileInput = document.getElementById('txtidfcn');
                var file = fileInput.files[0];

                // Check if a file is selected
                if (file) {
                    // Extract the file name
                    var fileName = file.name;

                    // Check if a file with the same name already exists
                    var exists = $("#identification").find("div[data-filename='" + fileName + "']").length > 0;

                    if (!exists) {
                        // Create a new image element
                        var newImage = $("<img>").css({
                            "max-width": "100px",
                            "max-height": "auto",
                            "border": "1px solid #000",
                            "margin-right": "5px"
                        });

                        // Create a close button
                        var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                            "cursor": "pointer",
                            "color": "red",
                            "margin-left": "5px"
                        });

                        // Use FileReader to read the file and set the image source
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            // Ensure the image data is valid before using it
                            if (e.target && e.target.result) {
                                // Add base64 data to the indenticopies array
                                indenticopies.push({
                                    fileName: fileName,
                                    copies: e.target.result // Base64 data
                                });

                                // Set the source of the new image
                                newImage.attr("src", e.target.result);
                            } else {
                                console.error("Failed to read file data.");
                            }
                        };

                        // Handle errors during file reading
                        reader.onerror = function (err) {
                            console.error("Error reading file: ", err);
                        };

                        reader.readAsDataURL(file);

                        // Create a container for the image and close button
                        var imageView = $("<div>").attr("data-filename", fileName).css({
                            "display": "inline-block",
                            "margin": "5px"
                        }).append(newImage, closeButton);

                        // Append the new image view to the appropriate location
                        $("#identification").append(imageView);

                        // Clear the file input field
                        $("#txtidfcn").val("");
                    } else {
                        // Alert the user about the duplicate file
                        alert("Duplicate file! This file is already listed.");
                    }
                } else {
                    // Alert the user if no file is selected
                    alert("Please select a file.");
                }



                var copies = $("#txtidfcn").val();


                // console.log(indenticopies);
                // Function to handle the click event for closing the appended values
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });
            });



            $(".add22").click(function () {
                // Retrieve the value entered by the user
                var seizedProperty = $("#txtcpsz").val().trim();

                // Check if the input field is not empty
                if (seizedProperty === '') {
                    alert("Please enter a value.");
                    return;
                }

                // Check if the value already exists
                if ($("#seizedData").find('input[value="' + seizedProperty + '"]').length > 0) {
                    alert("Duplicate value! This property is already listed.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container">' +
                    '<input type="text" class="form-control console savedt" value="' + seizedProperty + '">' +
                    '<span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span>' +
                    '</div>');

                // Append the new input element to the seizedData container
                $("#seizedData").append(newInput);

                // Clear the input field
                $("#txtcpsz").val("");

                // Attach the event handler to the close button dynamically
                $("#seizedData").on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                // Push the entered value into the cstodianseized array
                cstodianseized.push({
                    cstdnproperty: seizedProperty
                });




                // Function to handle the click event for closing the appended values 
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });

            });




            $(".add30").click(function () {
                // Retrieve the file uploaded by the user
                var fileInput = document.getElementById('txtcpes');
                var file = fileInput.files[0];

                // Check if a file is selected
                if (file) {
                    // Extract the file name
                    var fileName = file.name;

                    // Check if a file with the same name already exists
                    var exists = $("#copiesFile").find("div[data-filename='" + fileName + "']").length > 0;

                    if (!exists) {
                        // Create a new image element
                        var newImage = $("<img>").css({
                            "max-width": "100px",
                            "max-height": "auto",
                            "border": "1px solid #000",
                            "margin-right": "5px"
                        });

                        // Create a close button
                        var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                            "cursor": "pointer",
                            "color": "red",
                            "margin-left": "5px"
                        });

                        // Use FileReader to read the file and set the image source
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            if (e.target && e.target.result) {
                                // Add base64 data to the idcopies array
                                idcopies.push({
                                    fileName: fileName,
                                    copies: e.target.result // Base64 data
                                });

                                // Set the source of the new image
                                newImage.attr("src", e.target.result);
                            } else {
                                console.error("Failed to read image data.");
                            }
                        };
                        reader.readAsDataURL(file); // Ensure this is outside of the if block

                        // Create a container for the image and close button
                        var imageView = $("<div>").attr("data-filename", fileName).css({
                            "display": "inline-block",
                            "margin": "5px"
                        }).append(newImage, closeButton);

                        // Append the new image view to the appropriate location
                        $("#copiesFile").append(imageView);

                        // Clear the file input field
                        $("#txtcpes").val("");
                    } else {
                        // Alert the user about the duplicate file
                        alert("Duplicate file! This file is already listed.");
                    }
                } else {
                    // Alert the user if no file is selected
                    alert("Please select a file.");
                }

                var copies = $("#txtcpsz").val();

                // Function to handle the click event for closing the appended values
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });
            });



            $(".add31").click(function () {
                // Cache jQuery selectors
                var $name = $("#txtsrnm");
                var $bodyMark = $("#txtbident");
                var $mobileNo = $("#txtmbl");
                var $idCardNo = $("#txtidcard");
                var $idupload = $("#txtadhar"); // Input for the ID upload file
                var $signatureInput = $("#txtsigndt"); // Input for the signature image

                // Retrieve values entered by the user
                var name = $name.val().trim();
                var bodyMark = $bodyMark.val().trim();
                var mobileNo = $mobileNo.val().trim();
                var idCardNo = $idCardNo.val().trim();
                var iduploadFile = $idupload[0].files[0]; // Get the ID upload file object
                var idfileName = iduploadFile ? iduploadFile.name : "No file chosen";
                var signatureFile = $signatureInput[0].files[0]; // Get the signature file object
                var signatureFileName = signatureFile ? signatureFile.name : "No file chosen";

                // Validation for required fields
                if (!name || !bodyMark || !mobileNo || !idCardNo || !iduploadFile || !signatureFile) {
                    alert("Please fill in all fields and choose both ID and signature files.");
                    return;
                }

                // Create a container for the data
                var dataContainer = $('<div class="data-container">');

                // Define headers and values
                var fields = [
                    { header: "Name: ", value: name },
                    { header: "Body Mark for Identification: ", value: bodyMark },
                    { header: "Mobile No: ", value: mobileNo },
                    { header: "ID Card No: ", value: idCardNo },
                    { header: "ID Upload: ", value: idfileName },
                    { header: "Signature: ", value: signatureFileName }
                ];

                // Loop through the fields and create the corresponding input containers
                fields.forEach(function (field) {
                    dataContainer.append(
                        $('<div class="input-container">').append(
                            $('<input type="text" class="form-control savedt" readonly>').val(field.header + field.value),
                            $('<span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span>')
                        )
                    );
                });

                // Append the data container to the #viewData div
                $("#viewData").append(dataContainer);

                // Create an image element and read the ID upload file if available
                if (iduploadFile) {
                    var idImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader1 = new FileReader();
                    reader1.onload = function (e) {
                        idImage.attr("src", e.target.result);

                        // Append the ID image to the data container
                        dataContainer.append(idImage);
                    };
                    reader1.readAsDataURL(iduploadFile);
                }

                // Create an image element and read the signature file if available
                if (signatureFile) {
                    var signatureImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader2 = new FileReader();
                    reader2.onload = function (e) {
                        signatureImage.attr("src", e.target.result);

                        // Add the data to the possessor array
                        possessor.push({
                            namepssr: name,
                            bodymarkpssr: bodyMark,
                            mobilepssr: mobileNo,
                            idcardnopssr: idCardNo,
                            idupload: e.target.result, // Store the ID upload data
                            signwithdtpssr: e.target.result
                        });

                        // Append the signature image to the data container
                        dataContainer.append(signatureImage);
                    };
                    reader2.readAsDataURL(signatureFile);
                }

                // Clear input fields after processing
                $name.val("");
                $bodyMark.val("");
                $mobileNo.val("");
                $idCardNo.val("");
                $idupload.val("");
                $signatureInput.val("");

                // Event handler for close button click using event delegation
                $("#viewData").on("click", ".close-button", function () {
                    $(this).closest('.data-container').remove();
                });
            });




            $(".add32").click(function () {
                // Cache jQuery selectors
                var $name = $("#txtwtnsnm");
                var $bodyMark = $("#txtbdymrkidwt");
                var $mobileNo = $("#txtwmblwt");
                var $idCardNo = $("#txtwidwt");
                var $idupload = $("#txtadhar2");
                var $signatureInput = $("#txtswdtwt");

                // Retrieve values entered by the user
                var name = $name.val().trim();
                var bodyMark = $bodyMark.val().trim();
                var mobileNo = $mobileNo.val().trim();
                var idCardNo = $idCardNo.val().trim();
                var iduploadFile = $idupload[0].files[0]; // Get the ID upload file object
                var iduploadFileName = iduploadFile ? iduploadFile.name : "No file chosen";
                var signatureFile = $signatureInput[0].files[0]; // Get the signature file object
                var signatureFileName = signatureFile ? signatureFile.name : "No file chosen";

                if (!name || !bodyMark || !mobileNo || !idCardNo || !iduploadFile || !signatureFile) {
                    alert("Please fill in all fields and choose both ID and signature files.");
                    return;
                }

                // Create a container for the data
                var dataContainer = $('<div class="data-container">');

                // Define headers and values
                var fields = [
                    { header: "Name: ", value: name },
                    { header: "Body Mark for Identification: ", value: bodyMark },
                    { header: "Mobile No: ", value: mobileNo },
                    { header: "ID Card No: ", value: idCardNo },
                    { header: "ID Upload: ", value: iduploadFileName },
                    { header: "Signature: ", value: signatureFileName }
                ];

                // Loop through the fields and create the corresponding input containers
                fields.forEach(function (field) {
                    dataContainer.append(
                        $('<div class="input-container">').append(
                            $('<input type="text" class="form-control savedt" readonly>').val(field.header + field.value),
                            $('<span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span>')
                        )
                    );
                });

                // Append the data container to the #viewDatax div
                $("#viewDatax").append(dataContainer);

                // Create an image element and read the ID upload file if available
                if (iduploadFile) {
                    var idImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader1 = new FileReader();
                    reader1.onload = function (e) {
                        idImage.attr("src", e.target.result);

                        // Append the ID image to the data container
                        dataContainer.append(idImage);
                    };
                    reader1.readAsDataURL(iduploadFile);
                }

                // Create an image element and read the signature file if available
                if (signatureFile) {
                    var signatureImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader2 = new FileReader();
                    reader2.onload = function (e) {
                        signatureImage.attr("src", e.target.result);

                        // Add the data to the indewitness array
                        indewitness.push({
                            namein: name,
                            bodymarkin: bodyMark,
                            mobilein: mobileNo,
                            idcardnoin: idCardNo,
                            idupload: e.target.result, // Store the ID upload data
                            signwithdtin: e.target.result
                        });

                        // Append the signature image to the data container
                        dataContainer.append(signatureImage);
                    };
                    reader2.readAsDataURL(signatureFile);
                }

                // Clear input fields after processing
                $name.val("");
                $bodyMark.val("");
                $mobileNo.val("");
                $idCardNo.val("");
                $idupload.val("");
                $signatureInput.val("");

                // Event handler for close button click using event delegation
                $("#viewDatax").on("click", ".close-button", function () {
                    $(this).closest('.data-container').remove();
                });
            });




            $(".add33").click(function () {
                // Retrieve values entered by the user
                var name = $("#txtofwtnm").val().trim();
                var bodyMark = $("#txtbdymrkidowt").val().trim();
                var mobileNo = $("#txtwmblowt").val().trim();
                var idCardNo = $("#txtwidowt").val().trim();
                var iduploadInput = $("#txtadhar3")[0]; // ID upload input element
                var iduploadFile = iduploadInput.files[0]; // Get the ID upload file
                var signatureInput = $("#txtswdtowt")[0]; // Signature input element
                var signatureFile = signatureInput.files[0]; // Get the signature file

                // Check if any input fields are empty
                if (!name || !bodyMark || !mobileNo || !idCardNo || !iduploadFile || !signatureFile) {
                    alert("Please fill in all the fields and select both ID and signature files.");
                    return;
                }

                // Extract the file names
                var idfileFileName = iduploadFile.name;
                var signatureFileName = signatureFile.name;

                // Check if the signature file with the same name has already been appended
                var fileExists = $("#viewDatay").find("p:contains('" + signatureFileName + "')").length > 0;
                if (fileExists) {
                    alert("File with the same name already exists.");
                    return;
                }

                // Create a container for the data
                var dataContainer = $('<div class="data-container">');

                // Define headers and values
                var fields = [
                    { header: "Name: ", value: name },
                    { header: "Body Mark for Identification: ", value: bodyMark },
                    { header: "Mobile No: ", value: mobileNo },
                    { header: "ID Card No: ", value: idCardNo },
                    { header: "ID Upload: ", value: idfileFileName },
                    { header: "Signature: ", value: signatureFileName }
                ];

                // Loop through the fields and create the corresponding input containers
                fields.forEach(function (field) {
                    dataContainer.append(
                        $('<div class="input-container">').append(
                            $('<input type="text" class="form-control savedt" readonly>').val(field.header + field.value),
                            $('<span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span>')
                        )
                    );
                });

                // Append the data container to the #viewDatay div
                $("#viewDatay").append(dataContainer);

                // Create and read the ID upload image
                if (iduploadFile) {
                    var idImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader1 = new FileReader();
                    reader1.onload = function (e) {
                        idImage.attr("src", e.target.result);
                        dataContainer.append(idImage);
                    };
                    reader1.readAsDataURL(iduploadFile);
                }

                // Create and read the signature image
                if (signatureFile) {
                    var signatureImage = $("<img>").css({
                        "max-width": "100px",
                        "max-height": "100px",
                        "display": "block",
                        "margin-top": "10px"
                    });

                    var reader2 = new FileReader();
                    reader2.onload = function (e) {
                        signatureImage.attr("src", e.target.result);

                        // Add the data to the officialwtns array
                        officialwtns.push({
                            nameofi: name,
                            bodymarkofi: bodyMark,
                            mobileofi: mobileNo,
                            idcardnoofi: idCardNo,
                            iduploadofi: e.target.result, // Store the ID upload data
                            signwithdtofi: e.target.result // Store the signature data
                        });

                        // Append the signature image to the data container
                        dataContainer.append(signatureImage);
                    };
                    reader2.readAsDataURL(signatureFile);
                }

                // Clear input fields after processing
                $("#txtofwtnm").val("");
                $("#txtbdymrkidowt").val("");
                $("#txtwmblowt").val("");
                $("#txtwidowt").val("");
                $("#txtadhar3").val(""); // Clear ID upload input
                $("#txtswdtowt").val(""); // Clear signature input

                // Event handler for close button click using event delegation
                $("#viewDatay").on("click", ".close-button", function () {
                    $(this).closest('.data-container').remove();
                });
            });





            $('.add1').click(function () {
                // Get the value of the input field
                var inputValue = $('#txtnmadrsx').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#output1').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console  savedt" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the output div
                $('#output1').append(newInput);

                // Clear the input field
                $('#txtnmadrsx').val('');

                // Attach the event handler to the close button dynamically
                $('#output1').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });


                var accused = $("#txtnmadrsx").val();

                acsedtl.push({

                    accused: accused
                });
                var jsonArray = [];
                $('#output1 .input-container input').each(function () {
                    jsonArray.push($(this).val());
                });

                var jsonObject = {
                    "header": "Name And Address Of The Accused Person (s)",
                    "contents": jsonArray
                };

                console.log(JSON.stringify(jsonObject));
                add3sec = jsonObject;

            });

            $('.add2').click(function () {
                // Get the value of the input field
                var inputValue = $('#txtpsze').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#output2').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console  savedt" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the output div
                $('#output2').append(newInput);

                // Clear the input field
                $('#txtpsze').val('');

                // Attach the event handler to the close button dynamically
                $('#output2').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                var property = $("#txtpsze").val();

                properyszed.push({

                    property: property
                });

                var jsonArray = [];
                $('#output2 .input-container input').each(function () {
                    jsonArray.push($(this).val());
                });

                var jsonObject = {
                    "header": "Particulars Of The Property Seized",
                    "contents": jsonArray
                };

                console.log(JSON.stringify(jsonObject));
                add2sec = jsonObject;

            });


            $('.add3').click(function () {
                // Get the value of the input field
                var inputValue = $('#txtszurep').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#output3').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console  savedt" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the output div
                $('#output3').append(newInput);

                // Clear the input field
                $('#txtszurep').val('');

                // Attach the event handler to the close button dynamically
                $('#output3').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                var seizure = $("#txtszurep").val();

                seizrureplace.push({

                    seizure: seizure
                });
                var jsonArray = [];
                $('#output3 .input-container input').each(function () {
                    jsonArray.push($(this).val());
                });

                var jsonObject = {
                    "header": "Places Of Seizure",
                    "contents": jsonArray
                };

                console.log(JSON.stringify(jsonObject));
                add1sec = jsonObject;
            });


            $(".add4").click(function () {
                var fileInput = document.getElementById('txtszremrk');
                var file = fileInput.files[0];

                if (file) {
                    var fileName = file.name;

                    // Check if the file name already exists
                    var exists = $("#output4").find("div[data-filename='" + fileName + "']").length > 0;

                    if (!exists) {
                        // Create a new image element
                        var newImage = $("<img>").attr("src", URL.createObjectURL(file)).css({
                            "max-width": "100px",
                            "max-height": "auto",
                            "border": "1px solid #000",
                            "margin-right": "5px"
                        });

                        // Create a close button
                        var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                            "cursor": "pointer",
                            "color": "red",
                            "margin-left": "5px"
                        });

                        var reader = new FileReader();
                        reader.onload = function (e) {
                            newImage.attr("src", e.target.result);
                            //    bas64 = e.target.result;

                            seizuremark.push({

                                szuremark: e.target.result
                            });

                        }
                        console.log(seizuremark)
                        reader.readAsDataURL(file);

                        // Create a container for the image and close button
                        var imageView = $("<div>").attr("data-filename", fileName).css({
                            "display": "inline-block",
                            "margin": "5px"

                        }).append(newImage, closeButton);

                        // Append the new image view to the appropriate location 
                        $("#output4").append(imageView);

                        // Clear input field

                        $("#txtszremrk").val("");
                    } else {
                        // Alert the user about the duplicate value
                        alert("Duplicate file name! This file is already listed.");
                    }
                } else {
                    alert("Please select a file.");
                }

                // Event listener for the close button
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });

                var szuremark = $("#txtszremrk").val();



            });



            $(".add5").click(function () {
                var fileInput = document.getElementById('txtacsign');
                var file = fileInput.files[0];

                if (file) {
                    var fileName = file.name;
                    var exists = $("#output5").find("div[data-filename='" + fileName + "']").length > 0;

                    if (!exists) {
                        var newImage = $("<img>").attr("src", URL.createObjectURL(file)).css({
                            "max-width": "100px",
                            "max-height": "auto",
                            "border": "1px solid #000",
                            "margin-right": "5px"
                        });

                        var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                            "cursor": "pointer",
                            "color": "red",
                            "margin-left": "5px"
                        });

                        var imageView = $("<div>").attr("data-filename", fileName).css({
                            "display": "inline-block",
                            "margin": "5px"
                        }).append(newImage, closeButton);

                        var reader = new FileReader();
                        reader.onload = function (e) {
                            accusedsign.push({
                                fileName: fileName,
                                acsdsign: e.target.result // Base64 data
                            });
                        };
                        reader.readAsDataURL(file);

                        $("#output5").append(imageView);
                        $("#txtacsign").val("");
                    } else {
                        alert("Duplicate file name! This file is already listed.");
                    }
                } else {
                    alert("Please select a file.");
                }

                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });

                console.log(accusedsign);
            });

            $('.add6').click(function () {
                // Get the value of the input field
                var inputValue = $('#txtnmadrs').val();

                // Check if input value is empty or already exists
                if (inputValue.trim() === '') {
                    alert("Please enter a value.");
                    return;
                }
                if ($('#output6').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Value already exists.");
                    return;
                }

                // Create a new input element with close button
                var newInput = $('<div class="input-container"><input type="text" class="form-control console  savedt" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

                // Append the new input element to the output div
                $('#output6').append(newInput);

                // Clear the input field
                $('#txtnmadrs').val('');

                // Attach the event handler to the close button dynamically
                $('#output6').on('click', '.close-button', function () {
                    $(this).closest('.input-container').remove();
                });

                var witness = $("#txtnmadrs").val();

                wtnsdtl.push({

                    witness: witness
                });


            });


            $(".add7").click(function () {
                var fileInput = document.getElementById('txtsignw');
                var file = fileInput.files[0];

                if (file) {
                    var fileName = file.name;

                    // Check if the file name already exists
                    var exists = $("#output7").find("div[data-filename='" + fileName + "']").length > 0;

                    if (!exists) {
                        // Create a new image element
                        var newImage = $("<img>").attr("src", URL.createObjectURL(file)).css({
                            "max-width": "100px",
                            "max-height": "auto",
                            "border": "1px solid #000",
                            "margin-right": "5px"
                        });

                        // Create a close button
                        var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                            "cursor": "pointer",
                            "color": "red",
                            "margin-left": "5px"
                        });

                        var reader = new FileReader();
                        reader.onload = function (e) {
                            // Store the base64 data in the witnessign array
                            witnessign.push({
                                fileName: fileName,
                                wtnsign: e.target.result // Base64 data
                            });

                            // Add the image to the newImage element
                            newImage.attr("src", e.target.result);
                        };
                        reader.readAsDataURL(file);

                        // Create a container for the image and close button
                        var imageView = $("<div>").attr("data-filename", fileName).css({
                            "display": "inline-block",
                            "margin": "5px"
                        }).append(newImage, closeButton);

                        // Append the new image view to the appropriate location
                        $("#output7").append(imageView);

                        // Clear input field
                        $("#txtsignw").val("");
                    } else {
                        alert("Duplicate file name! This file is already listed.");
                    }
                } else {
                    alert("Please select a file.");
                }

                // Event listener for the close button
                $(document).on('click', '.closeBtn', function () {
                    $(this).parent().remove();
                });


                var wtnsign = $("#txtsignw").val();




            });


            console.log(formData33);
        });





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

        $(document).ready(function () {
            restoreData();
        });




        //submit code 

        function sub() {
            $(".loading").show();

            // Get form input values
            var caseno = $("#txtcaseno").val();
            var dtofszure = $("#txtszre").val();
            var szuretime = $("#txtszretme").val();
            var circumst = $("#txtbrf").val();
            var signoficer = $("#txtofcrsign").val();
            var division = $("#txtdivsion").val();
            /*   var szrelndmark = $("#txtlndmrksz").val();*/
            var rangeofc = $("#txtrngeofc").val();
            /*   var gpscordintes = $("#txtgps").val();*/
            var date = $("#txtdt").val();
            /* var time = $("#txtme").val();*/
            /*   var reasonsz = $("#txtrszre").val();*/
            ///*   var bfrespno = $("#txtbfresrch").val();*/
            //   var dated = $("#txtdtx").val();
            //   var timed = $("#txtime").val();
            //   var reasonsz = $("#txtrszre").val();
            //   var aftrsprtcl = $("#txtatersrch").val();
            //   var datex = $("#txtdtxx").val();
            //   var timex = $("#txtmex").val();
            //   var formnoi = $("#txtfomo").val();
            //   var datex = $("#txtdty").val();
            //   var timex = $("#txtimex").val();
            var dte = $("#txtdty").val();
            var tme = $("#txtimex").val();
            var anyremark = $("#txtrmrks").val();
            var ofcrname = $("#txtnm").val();
            var ofcrdesig = $("#txtdesig").val();
            var ofidno = $("#txtidn").val();
            var ofcrcontct = $("#txtcntct").val();


            var seizurelist = [];
            // Create and push user object to users array
            seizurelist.push({
                caseno: caseno,
                dtofszure: dtofszure,
                szuretime: szuretime,
                circumst: circumst,
                signoficer: signoficer,
                division: division,
                szrelndmark: szrelndmark,
                rangeofc: rangeofc,
                //  gpscordintes: gpscordintes,
                //  date: date,
                //  time: time,
                //  reasonsz: reasonsz,
                ///*  bfrespno: bfrespno,*/
                //dated: dated,
                //timed: timed,
                //aftrsprtcl: aftrsprtcl,
                //datex: datex,
                //timex: timex,
                //formnoi: formnoi,
                //dte: dte,
                //tme: tme,
                anyremark: anyremark,
                ofcrname: ofcrname,
                ofcrdesig: ofcrdesig,
                ofidno: ofidno,
                ofcrcontct: ofcrcontct


            });


            $.ajax({
                type: "POST",
                url: "forms3.aspx/Insert",
                data: JSON.stringify({
                    seizurelist: seizurelist,
                    seizrureplace: seizrureplace,
                    properyszed: properyszed,
                    acsedtl: acsedtl,
                    accusedsign: accusedsign,
                    witnessign: witnessign,
                    seizuremark: seizuremark,
                    wtnsdtl: wtnsdtl,
                    reasoncstdy: reasoncstdy,
                    indenticopies: indenticopies,
                    idcopies: idcopies,
                    cstodianseized: cstodianseized,
                    cstodianfile: cstodianfile,
                    possessor: possessor,
                    indewitness: indewitness,
                    officialwtns: officialwtns,
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


        function print() {
            $('.login-form').each(function () {
                let formSection = {};
                $(this).find('.console').each(function () {
                    let label = $(this).siblings('label').text().trim();  // Get the label text
                    let value = $(this).val();  // Get the input value
                    formSection[label] = value;  // Store it in the object
                });
                formData33.push(formSection);
            });
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const pdfWidth = doc.internal.pageSize.getWidth();



            // Initial Title and Section
            doc.setFontSize(12);
            doc.setFont("times", "bold");
            doc.text("FORM NO.2", 85, 20);
            doc.setFont("times", "normal");
            doc.text("[Vide Sub-rule (3) of Rule-3]", 70, 26);
            doc.setFont("times", "bold");
            doc.text("SEIZURE LIST", 82, 32);

            // Setting initial yPosition
            let yPosition = 45;

            // Seizure Date and Time
            doc.setFontSize(10);
            doc.setFont("times", "normal");
            doc.text("1. Date and time of Seizure", 20, yPosition);
            doc.setFont("times", "bold");
            let seizureDate = document.getElementById("txtszre").value;
            let seizureTime = document.getElementById("txtszretme").value;
            let seizureDateTime = ": " + seizureDate + " at " + seizureTime;
            doc.text(seizureDateTime, 90, yPosition);
            yPosition += 10;

            // Place of Seizure
            doc.setFont("times", "normal");
            doc.text("2. Place of Seizure", 20, yPosition);
            doc.setFont("times", "bold");
            const seizureLocations = $("#output3 .input-container .savedt").map(function () {
                return $(this).val();
            }).get();
            seizureLocations.forEach((location, index) => {
                const splitText = doc.splitTextToSize(`${index + 1}. ${location}`, 100);
                const textHeight = splitText.length * 6; // 7 points per line
                if (yPosition > 280) { // Check if yPosition exceeds page limit
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }
                doc.text(`${index + 1}. ${location}`, 90, yPosition, {
                    maxWidth: 100,

                    lineHeightFactor: 1.5
                });
                yPosition += textHeight;  // Move down for each entry
            });

            // Seized Items Section
            //  yPosition += 10; // Additional spacing before the next section
            doc.setFont("times", "normal");
            doc.text("3. List of Seized Items", 20, yPosition);
            doc.setFont("times", "bold");


            const seizedItems = $("#output2 .input-container .savedt").map(function () {
                return $(this).val();
            }).get();

            seizedItems.forEach((item, index) => {

                const splitText = doc.splitTextToSize(`${index + 1}. ${item}`, 100);
                const textHeight = splitText.length * 6; // 7 points per line

                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }
                doc.text(`${index + 1}. ${item}`, 90, yPosition, {

                    maxWidth: 100,
                    lineHeightFactor: 1.5
                });
                yPosition += textHeight; // Move down for the next entry
            });


            // Name & address of the accused persons
            // yPosition += 10; // Additional spacing before the next section
            doc.setFont("times", "normal");
            doc.text("4. Name & address of the accused person(s)", 20, yPosition);
            doc.setFont("times", "bold");
            //  doc.text(":", 90, yPosition);
            //   yPosition += 10;

            doc.setFont("times", "bold");
            const accusedPersons = $("#output1 .input-container .savedt").map(function () {
                return $(this).val();
            }).get();

            accusedPersons.forEach((person, index) => {
                const splitText = doc.splitTextToSize(`${index + 1}. ${person}`, 100);
                const textHeight = splitText.length * 6;


                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }
                doc.text(`${index + 1}. ${person}`, 90, yPosition, {

                    maxWidth: 100,
                    lineHeightFactor: 1.5
                });
                yPosition += textHeight; // Move down for the next entry
            });





            doc.setFont("times", "normal");
            doc.text("5. Signature of the accused person", 20, yPosition);
            // Iterate over accused signatures and add them to the PDF
            accusedsign.forEach((entry, index) => {
                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }

                // Check if the image fits on the current page, add a new page if needed
                const imageHeight = 15; // Adjust image height as needed
                const imageWidth = 50;  // Adjust image width as needed

                if (yPosition + imageHeight > 280) {
                    doc.addPage();
                    yPosition = 20; // Reset yPosition for new page
                }

                // Add only the image to the PDF, no text
                doc.addImage(entry.acsdsign, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                yPosition += imageHeight + 5; // Move down after the image
            });


            yPosition += 10; // Adjust as needed for spacing
            doc.setFont("times", "normal");
            doc.text("6. Name & address of the witness(es)", 20, yPosition);
            //  yPosition += 10; // Move down after the heading

            // Get witness details from #output6 and add them to the PDF
            const witnessDetails = $("#output6 .input-container .savedt").map(function () {
                return $(this).val();
            }).get();

            witnessDetails.forEach((witness, index) => {
                const splitText = doc.splitTextToSize(`${index + 1}. ${witness}`, 100);
                const textHeight = splitText.length * 6;
                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }

                // Add witness details to the PDF
                doc.setFont("times", "bold");
                doc.text(`${index + 1}. ${witness}`, 90, yPosition, {
                    maxWidth: 100,
                    lineHeightFactor: 1.5
                });
                yPosition += textHeight; // Move down for the next entry
            });





            // 7. Signature of witness(es)
            doc.setFont("times", "normal");
            doc.text("7. Signature of witness(es)", 20, yPosition);
            //  yPosition += 10; // Move down after the heading

            // Iterate over accused signatures and add them to the PDF
            witnessign.forEach((entry, index) => {

                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }

                // Set image dimensions
                const imageHeight = 15; // Adjust as needed
                const imageWidth = 50;  // Adjust as needed

                if (yPosition + imageHeight > 280) {
                    doc.addPage();
                    yPosition = 20; // Reset yPosition for new page
                }

                // Add the image to the PDF at specified position
                doc.addImage(entry.wtnsign, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                yPosition += imageHeight + 5; // Move down after the image
            });

            // 8. Seizure Mark
            doc.setFont("times", "normal");
            doc.text("8. Seizure Mark", 20, yPosition);
            //  yPosition += 10; // Move down after the heading
            const imageHeight = 25; // Adjust as needed
            const imageWidth = 50;
            seizuremark.forEach(function (entry, index) {
                if (yPosition + imageHeight > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }

                // Adjust image width

                if (yPosition + imageHeight > 280) {
                    doc.addPage();
                    yPosition = 20; // Reset yPosition for new page
                }

                // Add the image to the PDF at the specified position
                doc.addImage(entry.szuremark, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                yPosition += imageHeight + 10; // Move down after the image
            });

            // 9. Circumstances Of Seizure In Brief
            doc.setFont("times", "normal");
            doc.text("9. Circumstances Of Seizure In Brief", 20, yPosition);
            const imgData = $("#Hidden1").val();
            doc.addImage(imgData, 'JPEG', 90, yPosition, 50, 25);

            yPosition += imageHeight + 5;




            // 10. Signature Of The Officer
            doc.setFont("times", "normal");
            doc.text("10. Signature Of The Officer", 20, yPosition);

            const imgDatax = $("#gourab").val();
            doc.addImage(imgDatax, 'JPEG', 90, yPosition, 50, 25);





            doc.addPage();
            yPosition = 20;
            doc.setFontSize(10);
            doc.setFont("times", "normal");
            if (yPosition > 280) { // Checks only if yPosition exceeds the page height
                doc.addPage(); // Add a new page
                yPosition = 20; // Reset yPosition for the new page   
            }







            // Particulars of the property seized section
            doc.setFont("times", "normal");
            doc.text("Particulars of the property seized", 20, yPosition);
            doc.setFont("times", "bold");

            const seizureLocationsx = $("#szdata .input-container .savedt").map(function () {
                return $(this).val();
            }).get();

            seizureLocationsx.forEach((location, index) => {
                // Split the text and calculate height
                const splitLocation = doc.splitTextToSize(location, 100);
                const textHeight = splitLocation.length * 6; // 7 points per line

                if (yPosition + textHeight > 280) {
                    doc.addPage();
                    yPosition = 20;
                }

                doc.text(splitLocation, 92, yPosition, {
                    maxWidth: 100,
                    align: "left",
                    lineHeightFactor: 1.5
                });

                // Increment position based on actual text height plus padding
                yPosition += textHeight;
            });






            doc.setFont("times", "normal");
            doc.text("Identification Copies To be Uploaded", 20, yPosition);
            // Iterate over accused signatures and add them to the PDF
            indenticopies.forEach((entry, index) => {
                if (yPosition > 280) { // Check for page overflow
                    doc.addPage(); // Add a new page
                    yPosition = 20; // Reset yPosition for new page
                }

                // Check if the image fits on the current page, add a new page if needed
                const imageHeight = 25; // Adjust image height as needed
                const imageWidth = 50;  // Adjust image width as needed

                if (yPosition + imageHeight > 280) {
                    doc.addPage();
                    yPosition = 20; // Reset yPosition for new page
                }

                // Add only the image to the PDF, no text
                doc.addImage(entry.copies, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                yPosition += imageHeight + 15; // Move down after the image
            });















            doc.setFont("times", "normal");
            doc.text("Custodian of the Seized Property", 20, yPosition);
            doc.setFont("times", "bold");

            const seizureLocationsy = $("#seizedData .input-container .savedt").map(function () {
                return $(this).val();
            }).get();

            seizureLocationsy.forEach((location, index) => {
                // Split the text and calculate height
                const splitLocation = doc.splitTextToSize(location, 100);
                const textHeight = splitLocation.length * 6; // 7 points per line

                if (yPosition + textHeight > 280) {
                    doc.addPage();
                    yPosition = 20;
                }

                doc.text(splitLocation, 92, yPosition, {
                    maxWidth: 100,
                    align: "left",
                    lineHeightFactor: 1.5
                });

                // Increment position based on actual text height plus padding
                yPosition += textHeight;
            });







            // Identification Copies Section
            doc.setFont("times", "normal");
            doc.text("Identification Copies To be Uploaded", 20, yPosition);
            yPosition += 10; // Add some spacing after the header

            // Handle ID copies images
            idcopies.forEach((entry, index) => {
                const imageHeight = 25;
                const imageWidth = 50;

                // Check if image will fit on current page
                if (yPosition + imageHeight + 5 > 280) {
                    doc.addPage();
                    yPosition = 20;
                }
                yPosition -= 5;
                doc.addImage(entry.copies, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                yPosition += imageHeight + 10; // Add spacing after image
            });

            // Possessor Details Section
            // Add spacing before the section header
            yPosition += 5;

            if (yPosition > 280) {
                doc.addPage();
                yPosition = 20;
            }

            // Add section header
            doc.setFontSize(13);
            doc.setFont("times", "bold");
            const headerText = "Possessor Details";
            const splitHeader = doc.splitTextToSize(headerText, 100);
            doc.text(splitHeader, 20, yPosition);
            yPosition += 10;
            doc.setFontSize(10);

            // Process each possessor detail
            $("#viewData .data-container").each(function (index) {
                var zi = 0;
                $(this).find(".input-container").each(function () {



                    const inputValue = $(this).find("input").val();
                    const parts = inputValue.split(":");
                    const header = parts[0] + ":";
                    const value = parts[1] ? parts[1].trim() : "No Value";

                    // Split both header and value for proper wrapping
                    const splitHeader = doc.splitTextToSize(header, 60); // Smaller width for header
                    const splitValue = doc.splitTextToSize(value, 100);

                    // Calculate total height needed
                    const headerHeight = splitHeader.length * 7;
                    const valueHeight = splitValue.length * 7;
                    const totalHeight = Math.max(headerHeight, valueHeight);

                    // Check if content fits on current page
                    if (yPosition + totalHeight + 3 > 280) {
                        doc.addPage();
                        yPosition = 20;
                    }

                    let currentYPosition = yPosition;
                    if (header.trim() === "Signature:") {
                        currentYPosition += 20; // Offset the header text by 20px
                    }


                    // Add header and value
                    doc.setFont("times", "normal");
                    doc.text(splitHeader, 20, currentYPosition);
                    if (zi <= 3) {
                        doc.setFont("times", "bold");
                        doc.text(splitValue, 90, yPosition, {
                            align: "left",
                            maxWidth: 100,
                            lineHeightFactor: 1.5
                        });
                    }
                    yPosition += totalHeight + 3;
                    // Add spacing after entry
                    zi++;
                });
                yPosition -= 25;
                // Handle images within each data container
                $(this).find("img").each(function () {
                    const imgSrc = $(this).attr("src");
                    if (imgSrc) {
                        const imageHeight = 25;
                        const imageWidth = 50;

                        // Ensure enough space for image
                        if (yPosition + imageHeight + 5 > 280) {
                            doc.addPage();
                            yPosition = 20;
                        }

                        // Add image with proper spacing
                        doc.addImage(imgSrc, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                        yPosition += imageHeight + 5; // Add spacing after the image
                    }
                });
            });
            // Add section header for Independent Witness
            doc.setFontSize(13);
            doc.setFont("times", "bold");
            doc.text("Independent Witness", 20, yPosition);
            yPosition += 10;

            doc.setFontSize(10);

            // First Data Section (viewDatax)
            $("#viewDatax .data-container").each(function () {
                var zix = 0;
                $(this).find(".input-container").each(function () {
                    const inputValue = $(this).find("input").val();
                    const parts = inputValue.split(":");
                    const header = parts[0] + ":";
                    const value = parts[1] ? parts[1].trim() : "No Value";

                    // Split both header and value for proper wrapping
                    const splitHeader = doc.splitTextToSize(header, 60);
                    const splitValue = doc.splitTextToSize(value, 100);

                    // Calculate total height needed
                    const headerHeight = splitHeader.length * 7;
                    const valueHeight = splitValue.length * 7;
                    const totalHeight = Math.max(headerHeight, valueHeight);

                    // Check if content fits on current page
                    if (yPosition + totalHeight + 3 > 280) {
                        doc.addPage();
                        yPosition = 20;
                    }

                    let currentYPosition = yPosition;
                    if (header.trim() === "Signature:") {
                        currentYPosition += 20; // Offset the header text by 20px
                    }


                    // Add header and value
                    doc.setFont("times", "normal");
                    doc.text(splitHeader, 20, currentYPosition);

                    if (zix <= 3) {
                        doc.setFont("times", "bold");
                        doc.text(splitValue, 90, yPosition, {
                            align: "left",
                            maxWidth: 100,
                            lineHeightFactor: 1.5
                        });
                    }
                    zix++;
                    yPosition += totalHeight + 3;
                });
                yPosition -= 25;
                // Handle all images within this data container
                $(this).find("img").each(function () {
                    const imgSrc = $(this).attr("src");
                    if (imgSrc) {
                        const imageHeight = 25;
                        const imageWidth = 50;

                        if (yPosition + imageHeight + 5 > 280) {
                            doc.addPage();
                            yPosition = 20;
                        }

                        // Add image with proper spacing
                        doc.addImage(imgSrc, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                        yPosition += imageHeight + 5;
                    }
                });
            });

            // Add section header for Official Witness
            doc.setFontSize(13);
            doc.setFont("times", "bold");
            doc.text("Official Witness", 20, yPosition);
            yPosition += 10;

            doc.setFontSize(10);

            // Second Data Section (viewDatay)
            $("#viewDatay .data-container").each(function () {
                var ziy = 0;
                $(this).find(".input-container").each(function () {
                    const inputValue = $(this).find("input").val();
                    const parts = inputValue.split(":");
                    const header = parts[0] + ":";
                    const value = parts[1] ? parts[1].trim() : "No Value";

                    // Split both header and value for proper wrapping
                    const splitHeader = doc.splitTextToSize(header, 60);
                    const splitValue = doc.splitTextToSize(value, 100);

                    // Calculate total height needed
                    const headerHeight = splitHeader.length * 7;
                    const valueHeight = splitValue.length * 7;
                    const totalHeight = Math.max(headerHeight, valueHeight);

                    // Check if content fits on current page
                    if (yPosition + totalHeight + 3 > 280) {
                        doc.addPage();
                        yPosition = 20;
                    }

                    let currentYPosition = yPosition;
                    if (header.trim() === "Signature:") {
                        currentYPosition += 20; // Offset the header text by 20px
                    }


                    // Add header and value
                    doc.setFont("times", "normal");
                    doc.text(splitHeader, 20, currentYPosition);

                 
                    if (ziy <= 3) {
                        doc.setFont("times", "bold");
                        doc.text(splitValue, 90, yPosition, {
                            align: "left",
                            maxWidth: 100,
                            lineHeightFactor: 1.5
                        });
                    }
                    ziy++;
                    yPosition += totalHeight + 3;
                });
                yPosition -= 25;
                // Handle all images within this data container
                $(this).find("img").each(function () {
                    const imgSrc = $(this).attr("src");
                    if (imgSrc) {
                        const imageHeight = 25;
                        const imageWidth = 50;

                        if (yPosition + imageHeight + 5 > 280) {
                            doc.addPage();
                            yPosition = 20;
                        }

                        // Add image with proper spacing
                        doc.addImage(imgSrc, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                        yPosition += imageHeight + 5;
                    }
                });
            });





            doc.setFont("times", "normal");
            doc.text("Any remarks by the seizing party", 20, yPosition);
            doc.setFont("times", "bold");
            doc.setFontSize(10);

            // Get remarks text and split it
            const remarksText = $("#txtrmrks").val();
            const splitRemarksText = doc.splitTextToSize(remarksText, 100);
            const remarksHeight = splitRemarksText.length * 6;

            if (yPosition + remarksHeight > 280) {
                doc.addPage();
                yPosition = 20;
            }

            doc.text(splitRemarksText, 90, yPosition, {
                align: "left",
                maxWidth: 100,
                lineHeightFactor: 1.5
            });
            yPosition += remarksHeight;



            doc.setFontSize(13);
            doc.setFont("times", "bold");
            doc.text("Prepared By", 20, yPosition);
            yPosition += 10;

            doc.setFontSize(10);
            // Name field
            doc.setFont("times", "normal");
            doc.text("Name", 20, yPosition);
            doc.setFont("times", "bold");

            const nameText = $("#txtnm").val();
            const splitNameText = doc.splitTextToSize(nameText, 100);
            const nameHeight = splitNameText.length * 6;

            if (yPosition + nameHeight > 280) {
                doc.addPage();
                yPosition = 20;
            }

            doc.text(splitNameText, 90, yPosition, {
                align: "left",
                maxWidth: 100,
                lineHeightFactor: 1.5
            });
            yPosition += nameHeight;

            // Designation field
            doc.setFont("times", "normal");
            doc.text("Designation", 20, yPosition);
            doc.setFont("times", "bold");

            const designationText = $("#txtdesig").val();
            const splitDesignationText = doc.splitTextToSize(designationText, 100);
            const designationHeight = splitDesignationText.length * 6;

            if (yPosition + designationHeight > 280) {
                doc.addPage();
                yPosition = 20;
            }

            doc.text(splitDesignationText, 90, yPosition, {
                align: "left",
                maxWidth: 100,
                lineHeightFactor: 1.5
            });
            yPosition += designationHeight;




            // Id No field
            doc.setFont("times", "normal");
            doc.text("Id No", 20, yPosition);
            doc.setFont("times", "bold");

            const idText = $("#txtidn").val();
            const splitIdText = doc.splitTextToSize(idText, 100);
            const idHeight = splitIdText.length * 6;

            if (yPosition + idHeight > 280) {
                doc.addPage();
                yPosition = 20;
            }

            doc.text(splitIdText, 90, yPosition, {
                align: "left",
                maxWidth: 100,
                lineHeightFactor: 1.5
            });
            yPosition += idHeight;



            doc.setFont("times", "normal");
            doc.text("Contact No", 20, yPosition);
            doc.setFont("times", "bold");

            const contactText = $("#txtcntct").val();
            const splitContactText = doc.splitTextToSize(contactText, 100);
            const contactHeight = splitContactText.length * 6;

            if (yPosition + contactHeight > 280) {
                doc.addPage();
                yPosition = 20;
            }

            doc.text(splitContactText, 90, yPosition, {
                align: "left",
                maxWidth: 100,
                lineHeightFactor: 1.5
            });
            yPosition += contactHeight;















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

            doc.save('case-document-siezure.pdf');
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
        function getBase64Image(file, callback) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
                callback(reader.result);
            };
            reader.onerror = function (error) {
                console.log('Error: ', error);
            };
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


#szdata p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
   
}


#szdata input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
#identification p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#identification input[type="text"] {
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
#seizedData p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

 
#seizedData input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}


 #copiesFile p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}

#copiesFile input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}


#viewData p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000;
    border-radius: 5px;
}
#viewDatax p{

    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000;
    border-radius: 5px;

}

#viewDatay p{

    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000;
    border-radius: 5px;

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
            var div = this.parentElement;p
            div.style.opacity = "0";
            setTimeout(function () {
                div.style.display = "none";
                window.location.reload(); // Reload the page
            }, 600);
        }
    }
</script>

        
          <input type="hidden" value="" id="hiden" runat="server" /> <input type="hidden" value="" runat="server" id="hidden"  />
           <input type="hidden" value="" id="Hidden1" runat="server" /> <input type="hidden" value="" runat="server" id="hidden2"  />

          <input type="hidden" value="" id="gourab" runat="server" /> <input type="hidden" value="" runat="server" id="gourab2"  />


        <input type="hidden" value="" id="signacs" runat="server" /> <input type="hidden" value="" runat="server" id="signacsx"  />
         <input type="hidden" value="" id="signwtn" runat="server" /> <input type="hidden" value="" runat="server" id="signwtnx"  />
        <input type="hidden" value="" id="szure" runat="server" /> <input type="hidden" value="" runat="server" id="szurex"  />
         <input type="hidden" value="" id="pidcopies" runat="server" /> <input type="hidden" value="" runat="server" id="pidcopiesx"  />
          <input type="hidden" value="" id="cstcopies" runat="server" /> <input type="hidden" value="" runat="server" id="cstcopiesx"  />
         <input type="hidden" value="" id="pssesor" runat="server" /> <input type="hidden" value="" runat="server" id="pssesorx"  />
            <input type="hidden" value="" id="pssesor2" runat="server" /> <input type="hidden" value="" runat="server" id="pssesorx2"  />
        <input type="hidden" value="" id="imdwitness" runat="server" /> <input type="hidden" value="" runat="server" id="imdwitnessx"  />
           <input type="hidden" value="" id="imdwitness2" runat="server" /> <input type="hidden" value="" runat="server" id="imdwitnessx2"  />
          <input type="hidden" value="" id="officialwtn" runat="server" /> <input type="hidden" value="" runat="server" id="officialwtnx"  />
            <input type="hidden" value="" id="officialwtn2" runat="server" /> <input type="hidden" value="" runat="server" id="officialwtnx2"  />

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
			<i class='bx bx-menu'  style="font-size: 30px;color: #fff;font-weight:600;"></i>
         <a href="#" class="nav-link"></a>

		</nav>


    <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;Black Tiger</h3>






		<main>


        <div class="container-fluid" style="margin-top: 40px;" >
                <div class="row left-content-center">
                  <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                    <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                      <div class="text-center">
                        <p id="heading1">Form II</p>
            
                        <h2 id="heading">FOREST DEPARTMENT, ODISHA</h2>
                        <p id="heading1">[ Vide Sub-Rule(3) Of Rule 3 ]</p>
                          <h2 class="text-center" id="heading1" style="color: #fff;"> Seizure List</h2>

                       <%-- <p id="heading1">
                         Seizure List
                        </p>--%>
                       </div>

            
                        <form id="msform">
                             <fieldset>
            
                          <div class="form-card">
            
            
            
                            <div class="row ">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            

                                <div class="login-form">
            
                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
                                    

                                    
                                           <div class="col-lg-12  col-sm-12 col-xs-12">		
                                               <label class="lebl">Date Of Seizure</label>
                                      <input type="date" id="txtszre" class="form-control console savedt" placeholder="">
                                      </div>
                                          <div class="col-lg-12  col-sm-12 col-xs-12">		
										 <label class="lebl">Time Of Seizure</label>
            
                                      <input type="time" id="txtszretme" class="form-control console savedt" placeholder="">

										</div>

                                              
                                   <div class="col-lg-12  col-sm-12 col-xs-12">
            
                                      <label class="lebl">Place Of Seizure</label>
            
                                      <input type="text" id="txtszurep" class="form-control console savedt"
                                        placeholder="">
                                       </div>

                                       <p class="button-container">
                                                                <button class="bt11 add3" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output3"></div>
                                      
                                        
                                      <div class="col-lg-12  col-sm-12 col-xs-12">
                                      <label class="lebl"> Particulars Of The Property Seized</label>
                                         
                                      <input type="text" id="txtpsze" class="form-control console savedt" placeholder="">
                                              </div>
                                       <p class="button-container">
                                                                <button class="bt11 add2" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output2"></div>

                                      <div class="col-lg-12  col-sm-12 col-xs-12">
                                        <label class="lebl">Name And Address Of The Accused Person (s)</label>
            
                                        <input type="text" id="txtnmadrsx" class="form-control console savedt" placeholder="">
                                         
                                          </div>
                                       <p class="button-container" >

                                                                <button class="bt11 add1" type="button"><i class="fa fa-plus" aria-hidden="true" ></i></button>
                                                                                                       </p>
                                                                                               <div id="output1"></div>
                                       

                                        <div class="col-lg-12  col-sm-12 col-xs-12">

                                      <label class="lebl">Signature Of The Accused person (s)</label>
            
                                             <img class="file-upload-imagexx" src="#" alt="your image" />

                                      <input type="file" id="txtacsign" class="form-control console" onchange="acsUpload(this);" accept="image/*">
                                            
                                    


                                         </div>
                                       <p class="button-container">
                                                                <button class="bt11 add5" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output5"></div>


                                       <div class="col-lg-12  col-sm-12 col-xs-12">
            
                                      <label class="lebl">Name And Address Of The Witness (es)</label>
            
                                      <input type="text" id="txtnmadrs" class="form-control console savedt" placeholder="">
                                             </div>

                                       <p class="button-container">
                                                                <button class="bt11 add6" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output6"></div>

                                         <div class="col-lg-12  col-sm-12 col-xs-12">
            
                                        <label class="lebl">Signature Of The Witness (es)</label>

                                       <img class="file-upload-imagew" src="#" alt="your image" />
                                        <input type="file" id="txtsignw" class="form-control console" onchange="wtnsUpl(this);" accept="image/*">

                                          </div>

                                       <p class="button-container">
                                                                <button class="bt11 add7" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output7"></div>


                                       <div class="col-lg-12  col-sm-12 col-xs-12">
                                         
                                        <label class="lebl">Seizure Mark</label>

                                            <img class="file-upload-imagex" src="#" alt="your image" />
            
                                        <input type="file" id="txtszremrk" class="form-control console" onchange="szUpl(this);" accept="image/*">

                                      </div>

                                       <p class="button-container">
                                                                <button class="bt11 add4" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output4"></div>


                                      <div class="col-lg-12  col-sm-12 col-xs-12">
                                         
                                        <label class="lebl">Circumstances Of Seizure In Brief</label>
            
                                        <input type="file" id="txtbrf"  class="form-control console savedt" placeholder="">


                                      </div>


                                 
            
            
                                      <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                        <label class="lebl">Signature Of The Officer</label>
            
                                        <input type="file" id="txtofcrsign" class="form-control console savedt" placeholder="">
                                        </div>
            
            
            
                                  </div>
                                </div>
            
                              </div>
                            </div>
            
            
            
            
            
            
            
<%--            
                            <div class="text-center">


                              <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
                              <p id="heading1">FORM -II</p>
            
                              <p id="heading1">
                                Seizure List
                              </p>
                             </div>
            
            
            
                             <div class="row " style="margin-top: 30px;">
                              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                                <div class="login-form">

                                  <h5 class="text-center mb-2 val"></h5>
                                  <div class="row asd d-flex">
            
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc d-none">
                                      <h3 class="pp"> </h3>
            
                                      <label class="lebl">Division</label>
            
                                      <input type="text" id="txtdivsion" class="form-control console savedt" placeholder="">
                                      <label class="lebl">Range Office</label>
            
                                      <input type="text" id="txtrngeofc" class="form-control console savedt" placeholder="">
                                      <label class="lebl">Date</label>
            
                                      <input type="date" id="txtdt" class="form-control console savedt" placeholder="">
            
            
                                    </div>

            
            
            
                                    <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                      <h3 class="pp"></h3>
            
                                      <label class="lebl">Landmark Place of seizure </label>
            
                                      <input type="text" id="txtlndmrksz" class="form-control console savedt"
                                        placeholder="">
                                        <label class="lebl">GPS co-ordinates</label>
            
                                        <input type="text" id="txtgps" class="form-control console savedt" placeholder="">
            
            
                                        <label class="lebl">Time</label>
            
                                        <input type="time" id="txtme" class="form-control console savedt" placeholder="">
            
            
            
                                      </div>
            
            
                                      <div class="col-lg-12 col-sm-12 col-xs-12 abc">
                                        <label class="lebl">Reasons for seizure</label>
            
                                        <input type="text" id="txtrszre" class="form-control console savedt" placeholder="">
                                        </div>
            
            
            
                                  </div>
                                </div>
            
                              </div>
                            </div>
            --%>

            
            
<%--                            <div class="text-center">
                              <h2 id="heading">References</h2>
                    </div>
            
            

            
                    <div class="row " style="margin-top: 30px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                          <h5 class="text-center mb-2 val"></h5>
                          <div class="row asd d-flex">
            
                            <div class="col-lg-4  col-sm-4 col-xs-4 abc">
                              <h3 class="pp"> </h3>
            
                              <label class="lebl">Before Search Protocol No</label>
            
                              <input type="text" id="txtbfresrch" class="form-control console savedt" placeholder="">
                              <label class="lebl">After Search Protocol No</label>
            
                              <input type="text" id="txtatersrch" class="form-control console savedt" placeholder="">
                              <label class="lebl">Form – I No</label>
            
                              <input type="text" id="txtfomo" class="form-control console savedt" placeholder="">
            
            
                            </div>
            
                            <div class="col-lg-4  col-sm-4 col-xs-4 abc">
                              <h3 class="pp"> </h3>
            
                              <label class="lebl">Date</label>
            
                              <input type="date" id="txtdtx" class="form-control console savedt" placeholder="">
                              <label class="lebl">Date</label>
            
                              <input type="date" id="txtdtxx" class="form-control console savedt" placeholder="">
                              <label class="lebl">Date</label>
            
                              <input type="date" id="txtdty" class="form-control console savedt" placeholder="">
            
            
                            </div>
            

            
            
                            <div class="col-lg-4 col-sm-4 col-xs-4 abc">
                              <h3 class="pp"></h3>
            
                              <label class="lebl">Time</label>
            
                              <input type="time" id="txtime" class="form-control console savedt"
                                placeholder="">
                                <label class="lebl">Time</label>
            
                                <input type="time" id="txtmex" class="form-control console savedt" placeholder="">
            
            
                                <label class="lebl">Time</label>
            
                                <input type="time" id="txtimex" class="form-control console savedt" placeholder="">
            
            
            
                              </div>
            
            
            
            
                          </div>
                        </div>
            
                      </div>
                    </div>
            --%>
            

            
                    <div class="text-center">
                      <h2 id="heading">Reasons for Custody </h2>
            </div>
            


            <div class="text-center">
              <p id="heading1">Particulars of the property seized (with all details for accurate identification) </p>
            </div>
            
            
             <div class="row " style="margin-top: 30px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                          <h5 class="text-center mb-2 val"></h5>
                          <div class="row asd d-flex">
            
                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                              <h3 class="pp"> </h3>
            
                              <label class="lebl">Particulars of the property seized</label>
            
                              <input type="text" id="txtpszd" class="form-control console  savedt" placeholder="">
                             
            <div class="button-container">
                             <button class="bt11 add23" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </div>
                                <div id="szdata"> 

                                </div>

                              
            
                            </div>
            
                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                              <h3 class="pp"> </h3>
            
                              <label class="lebl">Identification Copies To be Uploaded</label>

                                <img class="file-upload-imageid" src="#" alt="your image" />
            
                              <input type="file" id="txtidfcn" class="form-control console" onchange="idUpload(this);" accept="image/*">
                             
                            <p class="button-container">
                             <button class="bt11 add24" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
            
                                <div id="identification">  </div>

                            </div>
            
            
            
            
                            
            

            
            
                          </div>
                        </div>
            
                      </div>
                    </div>
            
            
            
            
            <div class="text-center">
              <p id="heading1"> Custodian of the Seized Property (with all details including contact and ID reference) </p>
            </div>
            
           <div class="row " style="margin-top: 30px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                          <h5 class="text-center mb-2 val"></h5>
                          <div class="row asd d-flex">
            
                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                              <h3 class="pp"></h3>
            
                              <label class="lebl">Custodian of the Seized Property </label>
            
                              <input type="text" id="txtcpsz" class="form-control console  savedt" placeholder="">
                             
            <p class="button-container">
                             <button class="bt11 add22" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>

                                <div id="seizedData">  </div>
            
                            </div>
            
                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                              <h3 class="pp"> </h3>
            
                              <label class="lebl">Identification Copies To be Uploaded</label>

                                <img class="file-upload-images" src="#" alt="your image" />
            
                              <input type="file" id="txtcpes" class="form-control console" onchange="cstUpload(this);" accept="image/*">
                             
             <p class="button-container">
                             <button class="bt11 add30" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>

                               <div id="copiesFile">  </div>


                            </div>
            
            
            
            
                            
            
            
            
            
                          </div>
                        </div>
            
                      </div>
                    </div>
            
            
            
            <div class="text-center"  style="margin-top: 50px;">
              <p id="heading1"></p>
            </div>
            
            
            
            
            <div class="row " style="margin-top: 30px;">
              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                <div class="login-form">
            
                  <h5 class="text-center mb-2 val"></h5>
                  <div class="row asd d-flex">
            
                    <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                      <h3 class="pp"> A. Possessor Details  (Attach copies of ID proof and address proof)</h3>
            
                      <label class="lebl">Name</label>
            
                      <input type="text" id="txtsrnm" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">Body Mark for identification</label>
            
                      <input type="text" id="txtbident" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">Mobile No</label>
            
                      <input type="number" id="txtmbl" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">ID Card No (Aadhar /Voter ID/ any other ID if not available) </label>
            
                      <input type="text" id="txtidcard" class="form-control console  savedt" placeholder="">

                        
                         <img class="file-upload-imagerx" src="#" alt="your image" />

                      <input type="file" id="txtadhar" class="form-control console" onchange="pssrUpl2(this);" accept="image/*">


                      <label class="lebl">Signature with date</label>
            
                         <img class="file-upload-imager" src="#" alt="your image" />

                      <input type="file" id="txtsigndt" class="form-control console" onchange="pssrUpl(this);" accept="image/*">







                     <p class="button-container">
                      <button class="bt11 add31" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                     <div id="viewData">  </div>


                    </div>
            
            
            
            
            
                  </div>
                </div>
            
              </div>
            </div>
            

            
            
            
            
            
            
            <div class="text-center"  style="margin-top: 50px;">
              <p id="heading1"></p>
            </div>
            
            <div class="row " style="margin-top: 30px;">
              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                <div class="login-form">
            
                  <h5 class="text-center mb-2 val"></h5>
                  <div class="row asd d-flex">
            
                    <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                      <h3 class="pp">B.Independent Witness ( Name, Address Contact details and Valid ID reference) </h3>
            
                      <label class="lebl">Name</label>
            
                      <input type="text" id="txtwtnsnm" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">Body Mark for identification</label>
            
                      <input type="text" id="txtbdymrkidwt" class="form-control console  savedt" placeholder="">

                      <label class="lebl">Mobile No</label>
            
                      <input type="number" id="txtwmblwt" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">ID Card No (Aadhar /Voter ID/ any other ID if not available) </label>
            
                      <input type="text" id="txtwidwt" class="form-control console  savedt" placeholder="">


                    
                        <img class="file-upload-imagetx" src="#" alt="your image" />           
                      <input type="file" id="txtadhar2" class="form-control console" onchange="indUpl2(this);" accept="image/*">


                      <label class="lebl">Signature with date</label>

                        <img class="file-upload-imaget" src="#" alt="your image" />

            
                      <input type="file" id="txtswdtwt" class="form-control console" onchange="indUpl(this);" accept="image/*">

                        <p class="button-container">
                             <button class="bt11 add32" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                                <div id="viewDatax">  </div>

            
            
                    </div>
            
            
            
            
                  </div>
                </div>
            
              </div>
            </div>
            

        <div class="text-center" >
              <p id="heading1"></p>
            </div>
            

              <div class="row " style="margin-top: 30px;">
              <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                <div class="login-form">

                  <h5 class="text-center mb-2 val"></h5>
                  <div class="row asd d-flex">
            
                    <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                      <h3 class="pp">Official Witness ( Name, Address Contact details and Valid ID reference) </h3>
            
                      <label class="lebl">Name</label>

                      <input type="text" id="txtofwtnm" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">Body Mark for identification</label>
            
                      <input type="text" id="txtbdymrkidowt" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">Mobile No</label>
            
                      <input type="number" id="txtwmblowt" class="form-control console  savedt" placeholder="">
            
                      <label class="lebl">ID Card No (Aadhar /Voter ID/ any other ID if not available) </label>
            
                      <input type="text" id="txtwidowt" class="form-control console  savedt" placeholder="">


                          <img class="file-upload-imagessx" src="#" alt="your image" />
                      <input type="file" id="txtadhar3" class="form-control console" onchange="ofwtUpl2(this);" accept="image/*" >




                      <label class="lebl">Signature with date</label>
            
                        <img class="file-upload-imagess" src="#" alt="your image" />
                      <input type="file" id="txtswdtowt" class="form-control console" onchange="ofwtUpl(this);" accept="image/*" >
                       <p class="button-container">
                       <button class="bt11 add33" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button></p>
                       <div id="viewDatay">  </div>

            
                    </div>
            
            
            
            
                  </div>
                </div>
            
              </div>
            </div>
            

            
            <div style="margin-top: 50px;">
             
                <div class="row " style="margin-top: 30px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                          <h5 class="text-center mb-2 val"></h5>
                          <div class="row asd d-flex">
            
                            <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                              <h3 class="pp"> Any remarks by the seizing party</h3>
     
                              <label class="lebl">Any remarks by the seizing party</label>
            
                                
                                <input type="text" id="txtrmrks" class="form-control console  savedt" placeholder="">
                               
                            </div>
            
                          </div>
                        </div>
            
                      </div>
                    </div>
            </div>

            
            
           
            
            <div style="margin-top: 50px;margin-bottom: 20px;">
            
            </div>
            
            
            <div style="margin-bottom: 30px;">
                  <div class="row " style="margin-top: 30px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">
            
                          <h5 class="text-center mb-2 val"></h5>
                          <div class="row asd d-flex">
            
                            <div class="col-lg-12  col-sm-12 col-xs-12 abc">
                              <h3 class="pp">Prepared By </h3>
                           
          
                              <label class="lebl">Name</label>
            
                              <input type="text" id="txtnm" class="form-control console  savedt" placeholder="" />

                                <label class="lebl">Designation</label>
            
                              <input type="text" id="txtdesig" class="form-control console  savedt" placeholder="" />
                                <label class="lebl"> Id No</label>
            
                              <input type="text" id="txtidn" class="form-control console  savedt" placeholder="">
                             
            
                                <label class="lebl">Contact No</label>
            
                              <input type="text" id="txtcntct" class="form-control console  savedt" placeholder="">
            
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


                                        function szUpl(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagex').attr('src', e.target.result);
                                                    document.getElementById('szure').value = e.target.result;
                                                    document.getElementById('szurex').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function acsUpload(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagexx').attr('src', e.target.result);
                                                    document.getElementById('signacs').value = e.target.result;
                                                    document.getElementById('signacsx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function wtnsUpl(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagew').attr('src', e.target.result);
                                                    document.getElementById('signwtn').value = e.target.result;
                                                    document.getElementById('signwtn').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function idUpload(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imageid').attr('src', e.target.result);
                                                    document.getElementById('pidcopies').value = e.target.result;
                                                    document.getElementById('pidcopiesx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function cstUpload(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-images').attr('src', e.target.result);
                                                    document.getElementById('cstcopies').value = e.target.result;
                                                    document.getElementById('cstcopiesx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function pssrUpl(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imager').attr('src', e.target.result);
                                                    document.getElementById('pssesor').value = e.target.result;
                                                    document.getElementById('pssesorx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function pssrUpl2(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagerx').attr('src', e.target.result);
                                                    document.getElementById('pssesor2').value = e.target.result;
                                                    document.getElementById('pssesorx2').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }




                                        function indUpl(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imaget').attr('src', e.target.result);
                                                    document.getElementById('imdwitness').value = e.target.result;
                                                    document.getElementById('imdwitnessx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function indUpl2(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagetx').attr('src', e.target.result);
                                                    document.getElementById('imdwitness2').value = e.target.result;
                                                    document.getElementById('imdwitnessx2').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }



                                        function ofwtUpl(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagess').attr('src', e.target.result);
                                                    document.getElementById('officialwtn').value = e.target.result;
                                                    document.getElementById('officialwtnx').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                        function ofwtUpl2(input) {
                                            if (input.files && input.files[0]) {
                                                //alert($('.file-upload-input').val());
                                                var reader = new FileReader();

                                                reader.onload = function (e) {
                                                    //  $('.image-upload-wrap').show();
                                                    //  $('.file-upload-content').show();
                                                    $('.file-upload-imagessx').attr('src', e.target.result);
                                                    document.getElementById('officialwtn2').value = e.target.result;
                                                    document.getElementById('officialwtnx2').value = input.files[0].name;


                                                    // $('.image-title').html(input.files[0].name);
                                                };

                                                reader.readAsDataURL(input.files[0]);

                                            } else {
                                                removeUpload();
                                            }
                                        }

                                    </script>
            
                                </div>


                              <div class="col-lg-3  col-sm-3 col-xs-3 abc d-none">

                               
            
                             <button class="btnz mt-4" type="button">Save</button>
            
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
                         

</fieldset>
            </form>

            
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
