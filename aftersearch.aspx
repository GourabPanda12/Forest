<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aftersearch.aspx.cs" Inherits="aftersearch" %>

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
	<title>after Search Protocol</title>
         <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
    
      <script>

          var places = [];
          var partys = [];
          var posses = [];
          var undertaken = [];
          var rqtn = [];
          var fields = [];
          var accusedsign = [];
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
              //            url: "beforesearch.aspx/GetAutoCompleteData",
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


              $(".add24").click(function () {
                  // Cache input field selectors
                  var $name = $("#txtnm");
                  var $address = $("#txtadrs");
                  var $contact = $("#txtcntct");
                  var $idUpload = $("#txtadhar2");

                  // Retrieve values entered by the user
                  var name = $name.val().trim();
                  var address = $address.val().trim();
                  var contact = $contact.val().trim();
                  var idUploadFile = $idUpload[0].files[0]; // Get the ID upload file object
                  var idUploadFileName = idUploadFile ? idUploadFile.name : "No file chosen";

                  // Validate that all fields are filled
                  if (!name || !address || !contact || !idUploadFile) {
                      alert("Please fill in all fields and choose an ID file.");
                      return;
                  }

                  // Check for duplicate entry
                  var exists = $("#newFile .custodian-info").filter(function () {
                      return $(this).find("input").eq(0).val() === "Name: " + name &&
                          $(this).find("input").eq(1).val() === "Address: " + address &&
                          $(this).find("input").eq(2).val() === "Contact: " + contact;
                  }).length > 0;

                  if (!exists) {
                      // Create a container for the data
                      var dataContainer = $('<div class="custodian-info">');

                      // Define headers and values
                      var fields = [
                          { header: "Name: ", value: name },
                          { header: "Address: ", value: address },
                          { header: "Contact: ", value: contact },
                          { header: "Signature With Date: ", value: idUploadFileName }
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

                      // Create an image element and read the ID upload file if available
                      if (idUploadFile) {
                          var idImage = $("<img>").css({
                              "max-width": "100px",
                              "max-height": "100px",
                              "display": "block",
                              "margin-top": "10px"
                          });

                          var reader = new FileReader();
                          reader.onload = function (e) {
                              idImage.attr("src", e.target.result);

                              // Add the data to the undertaken array
                              undertaken.push({
                                  name: name,
                                  address: address,
                                  mobile: contact,
                                  idUpload: e.target.result // Store the ID upload data as base64
                              });

                              // Append the ID image to the data container
                              dataContainer.append(idImage);
                          };
                          reader.readAsDataURL(idUploadFile);
                      }

                      // Append the data container to the #newFile div
                      $("#newFile").append(dataContainer);

                      // Clear input fields after processing
                      $name.val("");
                      $address.val("");
                      $contact.val("");
                      $idUpload.val("");

                      // Event handler for close button click using event delegation
                      $("#newFile").on("click", ".close-button", function () {
                          $(this).closest('.custodian-info').remove();
                      });
                  } else {
                      alert("Duplicate entry! The combination of Name, Address, and Contact already exists.");
                  }
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


              $(".add10").click(function () {
                  // Retrieve the value entered by the user
                  var itemValue = $("#txtadtl").val().trim();
                  var parentP = $(this).closest('p');
                  //console.log('Parent <p>:', parentP.html());
                  // Find the previous <p> tag before the parent <p> tag
                  var prevP = parentP.prevAll('p').first();
                  // Get the HTML of the previous <p> tag
                  var htmlContent = prevP.html();
                  // Check if the input field is not empty
                  if (itemValue !== "") {
                      // Check if the value already exists
                      var exists = $("#accusedDetail").find("p:contains('" + itemValue + "')").length > 0;

                      if (!exists) {
                          // Create a new paragraph element with the item value prefixed with "Items Recovered: "
                          var newParagraph = $("<p>").text("Possession found from the search party: " + itemValue);

                          // Create a close button
                          var closeButton = $("<span>").addClass("closeBtn").text("x");
                          newParagraph.append(closeButton);

                          // Append the new paragraph to the itemRecovered div
                          $("#accusedDetail").append(newParagraph);

                          // Clear the input field
                          $("#txtadtl").val("");
                      } else {
                          alert("Duplicate value! This value already exists.");
                      }
                  }
                  // Click event for closing the appended items
                  $(document).on('click', '.closeBtn', function () {
                      $(this).parent().remove();
                  });

                  //     var possession = $("#txtadtl").val();
                  posses.push({

                      possession: itemValue,
                      htmlContent: htmlContent

                  });
                  console.log(posses);
              });



              $(".add11").click(function () {
                  // Retrieve the value entered by the user
                  var partyInvolve = $("#txtprty").val().trim();
                  var parentP = $(this).closest('p');
                  //console.log('Parent <p>:', parentP.html());
                  // Find the previous <p> tag before the parent <p> tag
                  var prevP = parentP.prevAll('p').first();
                  // Get the HTML of the previous <p> tag
                  var htmlContent = prevP.html();
                  // Check if the input field is not empty
                  if (partyInvolve !== "") {
                      // Check if the value already exists
                      var exists = $("#searchParty").find("p:contains('Search Party involved: " + partyInvolve + "')").length > 0;

                      if (!exists) {
                          // Construct the new paragraph with the entered property and close button
                          var newParagraph = $("<p>").text("Search Party involved: " + partyInvolve);
                          var closeButton = $("<span>").addClass("closeBtn").text("x");
                          newParagraph.append(closeButton);

                          // Append the new paragraph to the appropriate location
                          $("#searchParty").append(newParagraph);

                          // Clear input field
                          $("#txtprty").val("");
                      } else {
                          // Alert the user about the duplicate value
                          alert("Duplicate value! This value already exists.");
                      }
                  }

                  // Function to handle the click event for closing the appended values
                  $(document).on('click', '.closeBtn', function () {
                      $(this).parent().remove();
                  });

                  // var party = $("#txtprty").val();
                  partys.push({

                      party: partyInvolve,
                      htmlContent: htmlContent

                  });
                  console.log(partys);
              });


              $(".add12").click(function () {
                  // Retrieve the value entered by the user
                  var place = $("#txtlnd").val().trim();
                  var parentP = $(this).closest('p');
                  //console.log('Parent <p>:', parentP.html());
                  // Find the previous <p> tag before the parent <p> tag
                  var prevP = parentP.prevAll('p').first();
                  // Get the HTML of the previous <p> tag
                  var htmlContent = prevP.html();
                  // Check if the input field is not empty
                  if (place !== "") {
                      // Check if the value already exists
                      var exists = $("#showLandmark").find("p:contains('Place/s (with GPS co-ordinates & landmark): " + place + "')").length > 0;

                      if (!exists) {
                          // Construct the new paragraph with the entered property and close button
                          var newParagraph = $("<p>").text("Place/s (with GPS co-ordinates & landmark): " + place);
                          var closeButton = $("<span>").addClass("closeBtn").text("x");
                          newParagraph.append(closeButton);

                          // Append the new paragraph to the appropriate location
                          $("#showLandmark").append(newParagraph);

                          // Clear input field
                          $("#txtlnd").val("");
                      } else {
                          // Alert the user about the duplicate value
                          alert("Duplicate value! This value already exists.");
                      }
                  }
                  // Function to handle the click event for closing the appended values
                  $(document).on('click', '.closeBtn', function () {
                      $(this).parent().remove();
                  });

                  // var place = $("#txtlnd").val();

                  places.push({

                      place: place,
                      htmlContent: htmlContent
                  });
                  console.log(places);
              });

          });



          //submit code



          function sub() {
              var caseNo = localStorage.getItem('caseno');

              // Show loading indicator
              $(".loading").show();

              $.ajax({
                  type: "POST",
                  url: "beforesearch.aspx/Insert",
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




          //function sub() {
          //    $(".loading").show();

          //    // Get form input values
          //    var caseno = $("#txtcaseno").val();
          //    var prtno = $("#txtrno").val();
          //    var divsn = $("#txtdvsn").val();
          //    var rangeofc = $("#txtrngeofc").val();
          //    var datc = $("#txtdt").val();
          //    var ptime = $("#txtm").val();
          //    var rformiino = $("#txtfrmiino").val();
          //    var dtx = $("#txtdte").val();
          //    var tmex = $("#txtme").val();
          //    var gpscdtnts = $("#txtlnd").val();
          //    var srchprtydtl = $("#txtprty").val();
          //    var pssnfnd = $("#txtadtl").val();
          //    var rmrk = $("#txtrmk").val();
          //    var name = $("#txtnm").val();
          //    var address = $("#txtadrs").val();
          //    var mobile = $("#txtcntct").val();

          //    var beforelist = [];
          //    // Create and push user object to users array
          //    beforelist.push({
          //        caseno:caseno,
          //        prtno: prtno,
          //        divsn: divsn,
          //        rangeofc: rangeofc,
          //        datc: datc,
          //        ptime: ptime,
          //        rformiino: rformiino,
          //        dtx: dtx,
          //        tmex: tmex

          //    });




          //    $.ajax({
          //        type: "POST",
          //        url: "beforesearch.aspx/Insert",
          //        data: JSON.stringify({
          //            beforelist: beforelist,
          //            places: places,
          //            partys: partys,
          //            posses: posses,
          //            undertaken: undertaken,
          //            pic: $("#hiden").val(),
          //            path: $("#hidden").val()
          //        }),
          //        contentType: "application/json; charset=utf-8",
          //        dataType: "json",
          //        success: OnSuccessrrd,
          //        error: function (xhr, status, error) {
          //            alert("Error: " + error);
          //        }
          //    });


          //    function OnSuccessrrd(response) {
          //        $("#alertdvd1").show();
          //        $(".loading").hide();
          //    }
          //}



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


              // Title and Header
              doc.setFontSize(14);
              doc.setFont("times", "bold");
              doc.text("FOREST DEPARTMENT, ODISHA", 71, 20);
              doc.text("AFTER SEARCH", 90, 30);


              doc.setFontSize(12);
              doc.setFont("times", "normal");
              const caseNumber = 'NO:................................................';
              doc.text(caseNumber, 50, 40);
              doc.text(localStorage.getItem('caseno') ? localStorage.getItem('caseno') : 'N/A', 60, 39);




              //     doc.text(caseNumber, margin, margin + 10);

              // Add date to top right corner







              doc.text("Division: ...........................................................", 50, 47);
              doc.setFont("Times", "bold");
              doc.text($('#txtdvsn').val(), 70, 46);



              doc.setFont("Times", "normal");
              doc.text("Range Office: ......................................................", 50, 54);
              //    doc.text('Range Office:', 200, yPos);
              doc.setFont("Times", "bold");
              doc.text($('#txtrngeofc').val(), 80, 53);

              doc.setFont("Times", "normal");
              doc.text("Date: ....................................... Time: .........................", 50, 61);
              doc.setFont("Times", "bold");
              doc.text($('#txtdt').val(), 65, 60);
              doc.setFont("Times", "bold");
              doc.text($('#txtm').val(), 118, 60);


              doc.setFont("Times", "Normal");
              doc.text("(to be filled after Form- II is prepared)", 20, 75);



              //     doc.text("Place/s (with GPS co-ordinates & landmark) or Person/s (with full details) to be searched:", 20, 102);

              const pdfWidth = doc.internal.pageSize.getWidth();
              let addedContent = new Set();
              const lineHeight = 8;

              const margin = 20;
              const pageWidth = doc.internal.pageSize.getWidth();
              const contentWidth = pageWidth - 2 * margin;

              doc.setFont("Times", "normal");
              let serialNo = 1; // Start serial number
              let yPosition = 85; // Initial y position

              places.forEach((item) => {
                  if (!addedContent.has(item.htmlContent)) {
                      // Calculate the height of the content area including extra spacing
                      const textHeight = doc.splitTextToSize(item.htmlContent, contentWidth).length * lineHeight;

                      // Add grey background
                      const backgroundHeight = textHeight + 10; // including extra spacing
                      doc.setFillColor(200, 200, 200); // grey color
                      // Uncomment to draw the background rectangle if needed:
                      // doc.rect(margin - 5, yPosition - 15, contentWidth + 10, backgroundHeight, 'F');

                      // Set text color to black
                      doc.setTextColor(0, 0, 0);

                      // Add text on top of the grey background
                      const wrappedText = doc.splitTextToSize(item.htmlContent, contentWidth);
                      wrappedText.forEach((line) => {
                          if (yPosition + lineHeight > doc.internal.pageSize.height) {
                              doc.addPage();
                              yPosition = 20; // reset Y position after adding a new page
                          }
                          doc.text(line, margin, yPosition + 1);
                          yPosition += lineHeight;
                      });

                      yPosition + 3; // extra spacing after the htmlContent
                      addedContent.add(item.htmlContent);
                  }

                  // Add serial number at a fixed position
                  if (yPosition + lineHeight > doc.internal.pageSize.height) {
                      doc.addPage();
                      yPosition = 20; // reset Y position after adding a new page
                  }

                  // Add serial number
                  doc.setFont("Times", "bold");
                  doc.setTextColor(0, 0, 0);
                  doc.text(`${serialNo}. `, 22, yPosition); // Add serial number at x=22

                  // Split and wrap the place information
                  const wrappedPlace = doc.splitTextToSize(`Place:-  ${item.place}`, contentWidth - margin);
                  wrappedPlace.forEach((line) => {
                      if (yPosition + lineHeight > doc.internal.pageSize.height) {
                          doc.addPage();
                          yPosition = 20; // reset Y position after adding a new page
                      }
                      doc.text(line, margin + 7, yPosition);
                      yPosition += lineHeight;
                  });

                  yPosition += 1; // Additional spacing after place information

                  serialNo++; // Increment serial number for the next record
              });

              doc.setFont("Times", "normal");
              serialNo = 1; // Start serial number for partys

              partys.forEach((item) => {
                  if (!addedContent.has(item.htmlContent)) {
                      // Calculate the height of the content area including extra spacing
                      const textHeight = doc.splitTextToSize(item.htmlContent, contentWidth).length * lineHeight;

                      // Add grey background
                      const backgroundHeight = textHeight + 10; // including extra spacing
                      doc.setFillColor(200, 200, 200); // grey color
                      // Uncomment to draw the background rectangle if needed:
                      //doc.rect(margin - 5, yPosition - 15, contentWidth + 10, backgroundHeight, 'F');

                      // Set text color to black
                      doc.setTextColor(0, 0, 0);

                      // Add text on top of the grey background
                      const wrappedText = doc.splitTextToSize(item.htmlContent, contentWidth);
                      wrappedText.forEach((line) => {
                          if (yPosition + lineHeight > doc.internal.pageSize.height) {
                              doc.addPage();
                              yPosition = margin; // reset Y position after adding a new page
                          }
                          doc.text(line, margin, yPosition + 1);
                          yPosition += lineHeight;
                      });

                      yPosition += 3; // extra spacing after the htmlContent
                      addedContent.add(item.htmlContent);
                  }

                  // Add serial number at a fixed position
                  if (yPosition + lineHeight > doc.internal.pageSize.height) {
                      doc.addPage();
                      yPosition = margin; // reset Y position after adding a new page
                  }

                  // Add serial number and wrap the party information text
                  doc.setFont("Times", "bold");
                  doc.setTextColor(0, 0, 0);
                  doc.text(`${serialNo}. `, 22, yPosition); // Add serial number at x=22

                  // Split and wrap the party text
                  const wrappedParty = doc.splitTextToSize(`Party:-  ${item.party}`, contentWidth - margin);
                  wrappedParty.forEach((line) => {
                      if (yPosition + lineHeight > doc.internal.pageSize.height) {
                          doc.addPage();
                          yPosition = margin; // reset Y position after adding a new page
                      }
                      doc.text(line, margin + 7, yPosition);
                      yPosition += lineHeight;
                  });

                  yPosition += 1; // Additional spacing after party information

                  serialNo++; // Increment serial number for the next record
              });

              doc.setFont("Times", "normal");
              serialNo = 1; // Start serial number


              posses.forEach((item) => {
                  if (!addedContent.has(item.htmlContent)) {
                      // Calculate the height of the content area including extra spacing
                      const textHeight = doc.splitTextToSize(item.htmlContent, contentWidth).length * lineHeight;

                      // Add grey background
                      const backgroundHeight = textHeight + 5; // Adjust extra spacing as needed
                      doc.setFillColor(200, 200, 200); // grey color
                      // Uncomment to draw the background rectangle if needed:
                      // doc.rect(margin - 5, yPosition - 10, contentWidth + 10, backgroundHeight, 'F');

                      // Set text color to black
                      doc.setTextColor(0, 0, 0);

                      // Add text on top of the grey background
                      const wrappedText = doc.splitTextToSize(item.htmlContent, contentWidth);
                      wrappedText.forEach((line) => {
                          if (yPosition + lineHeight > doc.internal.pageSize.height) {
                              doc.addPage();
                              yPosition = 10; // reset Y position after adding a new page
                          }
                          doc.text(line, margin, yPosition + 1);
                          yPosition += lineHeight;
                      });

                      addedContent.add(item.htmlContent);
                  }

                  // Add serial number at a fixed position
                  if (yPosition + lineHeight > doc.internal.pageSize.height) {
                      doc.addPage();
                      yPosition = 20; // reset Y position after adding a new page
                  }

                  // Add serial number
                  doc.setFont("Times", "bold");
                  doc.setTextColor(0, 0, 0);
                  doc.text(`${serialNo}. `, 22, yPosition); // Add serial number at x=22

                  // Add "possession:-" text in bold, followed by the possession content
                  doc.text("Possession:-", margin + 7, yPosition);

                  // Wrap and display the possession details
                  doc.setFont("Times", "bold"); // Switch back to normal font for the actual content
                  const wrappedPossession = doc.splitTextToSize(item.possession, contentWidth - margin - 40); // Adjust width for wrapping
                  wrappedPossession.forEach((line) => {
                      if (yPosition + lineHeight > doc.internal.pageSize.height) {
                          doc.addPage();
                          yPosition = 20; // reset Y position after adding a new page
                      }
                      doc.text(line, margin + 31, yPosition); // Indent content slightly
                      yPosition += lineHeight;
                  });

                  serialNo++; // Increment serial number for the next record
              });

              if (yPosition + lineHeight > doc.internal.pageSize.height) {
                  doc.addPage();
                  yPosition = margin; // Reset yPosition after adding a new page
              }

              doc.setFont("Times", "normal");
              doc.text("REMARKS: ", margin, yPosition + 1);
              doc.setFont("Times", "bold");

              // Split the text content into an array of lines that fit within 200 units
              const splitText = doc.splitTextToSize($('#txtrmk').val(), 160);

              // Calculate the height based on the number of lines and line height factor
              const remarksHeight = splitText.length * lineHeight * 1.5; // lineHeightFactor used in the text rendering

              // Render the split text with a line spacing factor
              doc.text(splitText, margin + 2, yPosition + 10, {
                  maxWidth: 200,
                  lineHeightFactor: 1.5
              });

              // Update yPosition after adding the remarks to prevent overlap
              yPosition += remarksHeight + 7; // Add 10 for extra spacing after remarks

              // Check if a new page is needed
              if (yPosition + lineHeight > doc.internal.pageSize.height) {
                  doc.addPage();
                  yPosition = margin; // Reset yPosition after adding a new page
              }


              doc.setFont("Times", "normal");

              doc.text("Name, Address, Contact, Signature with date of Independent Witnesses/Others who ", margin, yPosition + 1);
              doc.text("conducted search of search party towards satisfaction before actual search is undertaken", margin, yPosition + 6);


              yPosition += 15;

              undertaken.forEach(function (entry) {
                  // Modify field loop
                  var fields = [
                      { header: "Name: ", value: entry.name },
                      { header: "Address: ", value: entry.address },
                      { header: "Contact: ", value: entry.mobile },
                      { header: "Signature With Date: ", value: "Image Attached" } // Set custom value for ID image
                  ];

                  fields.forEach(function (field) {
                      var header = field.header + ": ";
                      var value = field.value || "No Value";

                      // Split text for proper wrapping
                      var splitHeader = doc.splitTextToSize(header, 60);
                      var splitValue = doc.splitTextToSize(value, 100);

                      // Calculate heights for header and value for vertical alignment
                      var headerHeight = splitHeader.length * 7;
                      var valueHeight = splitValue.length * 7;
                      var totalHeight = Math.max(headerHeight, valueHeight);

                      // Check if content fits on the current page; add a new page if necessary
                      if (yPosition + totalHeight + 3 > 280) {
                          doc.addPage();
                          yPosition = 20; // Reset Y position for the new page
                      }

                      // Add header and value to the PDF
                      doc.setFont("times", "normal");
                      doc.text(splitHeader, 20, yPosition);

                      doc.setFont("times", "bold");
                      doc.text(splitValue, 90, yPosition, {
                          align: "justify",
                          maxWidth: 100,
                          lineHeightFactor: 1.5
                      });

                      // Increment yPosition for the next entry
                      yPosition += totalHeight + 3;
                  });
                  yPosition -= 8;
                  // Add ID upload image (if available) to the PDF
                  if (entry.idUpload) {
                      var imageHeight = 25;
                      var imageWidth = 50;

                      // Check if the image fits on the current page; add a new page if necessary
                      if (yPosition + imageHeight + 5 > 280) {
                          doc.addPage();
                          yPosition = 20; // Reset Y position for the new page
                      }

                      // Add the ID image to the PDF (this will be the base64 string stored in idUpload)
                      doc.addImage(entry.idUpload, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                      yPosition += imageHeight + 10; // Move yPosition below the image
                  }
              });




              if (yPosition + lineHeight > doc.internal.pageSize.height) {
                  doc.addPage();
                  yPosition = margin; // reset Y position after adding a new page
              }

              doc.setFont("times", "normal");
              doc.text(" Signature of the accused person", 20, yPosition);
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
                  yPosition -= 5;
                  // Add only the image to the PDF, no text
                  doc.addImage(entry.acsdsign, 'JPEG', 90, yPosition, imageWidth, imageHeight);
                  yPosition += imageHeight + 10; // Move down after the image
              });



              doc.setFontSize(12);
              doc.addPage();
              yPosition = 20;
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
                     // doc.addPage(); // Add new page
                      yPosition = 20; // Reset y position for the new page
                  }
              });

              doc.save('case-document-aftersearch.pdf');


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
	
<input type="hidden" value="" id="Hidden1" runat="server" /> <input type="hidden" value="" runat="server" id="hidden2"  />
       
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

    <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>



       <main>



        <div class="container-fluid" style="margin-top: 40px;">

            <div class="row justify-content-center">
            <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
            <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
             <div class="text-center">

               <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
               <%--<p id="heading1">AFTER SEARCH PROTOCOL</p>--%>
                 <h2 class="text-center" id="heading1" style="color: #fff;">AFTER SEARCH PROTOCOL</h2>
             </div>
        
             <div id="msform">
                <fieldset>
              
                 
                       
               <div class="row ">
               <div class="col-md-10  col-12 mx- auto offset-md-1">    
                   
             <div class="login-form">
               <h5 class="text-center mb-2 val"></h5>
               <div class="row asd d-flex">     
               <div class="col-lg-12  col-sm-12 col-xs-12 abc1">
				   
				  
      <div class="row">
<%--<div class="col-lg-6  col-sm-6 col-xs-6 abc">		
    <label class="lebl">Respective Case Number</label>
    <input type="text" id="txtcno"  class="form-control console savedt" placeholder="">	
 </div>--%>


											
   <div class="col-lg-4  col-sm-4 col-xs-4 abc" style="display:none;">		
    <label class="lebl">NO </label>
    <input type="text" id="txtrno"  class="form-control console savedt" placeholder="">	
 </div>
 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">Division   </label>
      <input type="text" id="txtdvsn"  class="form-control console savedt" placeholder="">	
	</div>

	 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">Range Office  </label>
              <input type="text" id="txtrngeofc"  class="form-control console savedt" placeholder="">	
		</div>
	</div>
				   
       	
      <div class="row">
											
   <div class="col-lg-6  col-sm-6 col-xs-6 abc">		
    <label class="lebl"> Date</label>
    <input type="date" id="txtdt"  class="form-control console savedt" placeholder="">	
 </div>
 <div class="col-lg-6  col-sm-6 col-xs-6 abc">		
              <label class="lebl"> Time   </label>
      <input type="time" id="txtm"  class="form-control console savedt" placeholder="">	
	</div>

	 
	</div>		 
				   
        
<br>
            <h5 class="text-center" style="color:#000;">Reference</h5>
			
      <div class="row mb-4">
											
   <div class="col-lg-4  col-sm-4 col-xs-4 abc">
    <label class="lebl">Form -II No </label>
    <input type="number" id="txtfrmiino"  class="form-control console savedt" placeholder="">	
 </div>
		  
 <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">  Date  </label>
      <input type="date" id="txtdte"  class="form-control console savedt" placeholder="">	
	</div>
		  
		  <div class="col-lg-4  col-sm-4 col-xs-4 abc">		
              <label class="lebl">  Time </label>
      <input type="time" id="txtme"  class="form-control console savedt" placeholder="">	
	</div>

	
	</div>
       			   
				   
				<!--   
            <p class="to34">Form -II No <input type="number" id="txtfrmiino" class="inp" placeholder=""><span> Date <input type="date" id="txtdte" class="inp" placeholder=""></span> <span> Time  <input type="time" id="txtme" class="inp" placeholder=""> </span></p>
           
-->
         <p  style="color: #000; font-size: 17px;" class="text-center">(To be filled after Form- II is prepared)</p>
				   
            <P  style="color: #000; font-size: 16px;" class="text-center">Place/s (with GPS co-ordinates & landmark) or Person/s (with full details) searched</P>

            <div class="row">
              <div class="col-lg-12  col-sm-12 col-xs-12 ">
                <input type="text" id="txtlnd" class="form-control console savedt" placeholder="">
            </div>
            </div>



            <!--
             <p class="to34">1. <input type="text" id="txtlnd" class="inp" placeholder=""></p>-->


            <p class="button-container" style="text-align:right;">
             <button class="bt11 add12" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
             <div id="showLandmark">  </div>




        
            <P style="color: #000; font-size: 16px;" class="text-center">Search Party involved to conduct actual search of person/s or place/s (with designation and ID)</P>

            <div class="row">
              <div class="col-lg-12  col-sm-12 col-xs-12 ">
                <input type="text" id="txtprty" class="form-control console savedt" placeholder="">
            </div>
            </div>


           <!--
            <p class="to34">1. <input type="text" id="txtprty" class="inp" placeholder=""></p>-->


            <p class="button-container" style="text-align:right;">
             <button class="bt11 add11" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                      </p>
              <div id="searchParty">  </div>




        
            <P style="color: #000; font-size: 16px;" class="text-center">Possession found from the search party after conducting the search of the place or person(as searched by the independent witness infront of accused)</P>


            <div class="row">
              <div class="col-lg-12  col-sm-12 col-xs-12 ">
                <input type="text" id="txtadtl" class="form-control console savedt" placeholder="">
            </div>
            </div>


           <!--
            <p class="to34">1. <input type="text" id="txtadtl" class="inp" placeholder=""></p>-->


            <p class="button-container" style="text-align:right;">
         <button class="bt11 add10" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
         <div id="accusedDetail">  </div>




            <p style="color: #000; font-size: 16px;">Remarks</p>

            <div class="row mb-4">
              <div class="col-lg-12  col-sm-12 col-xs-12 ">
                <input type="text" id="txtrmk" class="form-control console savedt" placeholder="">
            </div>
            </div>

               <input type="hidden" value="" id="imdwitness2" runat="server" /> <input type="hidden" value="" runat="server" id="imdwitnessx2"  />

            <P style="color: #000; font-size: 16px;" class="text-center">Name, Address, Contact, Signature with date of Independent Witnesses/ Others who conducted searchof search party towards satisfaction after actual search is undertaken</P>
            <div class="row mb-3">
              <div class="col-lg-4  col-sm-4 col-xs-4 abc">
                <label class="lebl">Name</label>
                <input type="text" id="txtnm" class="form-control console savedt" placeholder="">
            </div>
            <div class="col-lg-4  col-sm-4 col-xs-4 abc">
              <label class="lebl">Address</label>
              <input type="text" id="txtadrs" class="form-control console savedt" placeholder="">
          </div>
          <div class="col-lg-4  col-sm-4 col-xs-4 abc">
            <label class="lebl">Contact</label>
            <input type="text" id="txtcntct" class="form-control console savedt" placeholder="">
        </div>
                 <div class="col-lg-4  col-sm-4 col-xs-4 abc">
                       <label class="lebl">Signature with date</label>
          <img class="file-upload-imagetx" src="#" alt="your image" />           
                      <input type="file" id="txtadhar2" class="form-control console" onchange="indUpl2(this);" accept="image/*">
        </div>
            </div>

           <script>
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

           </script>
           <p class="button-container" style="text-align:right;">


                             <button class="bt11 add24" type="button" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
            
                                <div id="newFile">  </div>


          <!--
            <p class="to34">This search is conducted in the presence and to the satisfaction of the accused/ occupier
               <div class="to34">(with signature)<input type="file" id="" class="inp" placeholder=""></div> </p>

               -->

                         <input type="hidden" value="" id="signacs" runat="server" /> <input type="hidden" value="" runat="server" id="signacsx"  />
               <p style="color: #000; font-size: 16px;" class="text-center">This search is conducted in the presence and to the satisfaction of the accused/ occupier (with signature)</p>


<div class="col-lg-12  col-sm-12 col-xs-12">

                                      <label class="lebl">Signature Of The Accused person (s)</label>
            
                                             <img class="file-upload-imagexx" src="#" alt="your image" />

                                      <input type="file" id="txtacsign" class="form-control console" onchange="acsUpload(this);" accept="image/*">
                                            
                                    


                                         </div>
                    <p class="button-container">
                                                                <button class="bt11 add5" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output5"></div>
                   
                   <script>
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

                   </script>

        <p style="color: #000; font-size: 16px;" class="text-center">* Try to describe each item as minutely as possible to avoid any ambiguity at later stage</p>
        <p style="color: #000; font-size: 16px;" class="text-center">** May add annexure if space provided is insufficient.</p>

        </div>
        </div>
        </div>
        </div>
        </div>
        
     
        </fieldset>
				
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

                               
            
                             <button class="btnz mt-4" type="button">Save</button>
            
                            </div>


                             <div class="col-lg-4  col-sm-4 col-xs-4 d-none">

                               
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                          
                          
                                 <div class="col-lg-3 col-sm-3 col-xs-3 d-none">

   
            
 <button class="btnx mt-4" type="button" onclick="print()" >Print</button>
            
</div>
                         
   
            
                          </div>
                         
   
            
                          </div>
                        </div>
            
                      </div>
                    </div>	  

        </div>
        
        


        </div>
        </div>
        </div>
   
        
     </main>

	</section>



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

