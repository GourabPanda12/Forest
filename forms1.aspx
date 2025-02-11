<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forms1.aspx.cs" Inherits="forms1" %>

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

    <title>FIR Form</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 <script>


     // jQuery code to append input field on button click
     $(document).ready(function () {

         $('.add1').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtprpsze').val();

             // Check if input value is empty or already exists
             if (inputValue.trim() === '') {
                 alert("Please enter a value.");
                 return;
             }
              if ($('#output').find('input[value="' + inputValue + '"]').length > 0) {
                  alert("Value already exists.");
                   return;
              }

             // Create a new input element with close button
             var newInput = $('<div class="input-container"><input type="text" class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output').append(newInput);

             // Clear the input field
             $('#txtprpsze').val('');

             // Remove input field on close button click
             $('#output').on('click', '.close-button', function () {
                 $(this).closest('.input-container').remove();
             });

         });

        

         $('.add2').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtnm').val();

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
             var newInput = $('<div class="input-container"><input type="text" class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output2').append(newInput);

             // Clear the input field
             $('#txtnm').val('');

             // Remove input field on close button click
             $('#output2').on('click', '.close-button', function () {
                 $(this).closest('.input-container').remove();
             });
         });
         

         $('.add3').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtprnt').val();

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
             var newInput = $('<div class="input-container"><input type="text"class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output3').append(newInput);

             // Clear the input field
             $('#txtprnt').val('');

             // Remove input field on close button click
             $('#output3').on('click', '.close-button', function () {
                 $(this).closest('.input-container').remove();
             });

         });

         


         $('.add4').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtresd').val();

             // Check if input value is empty or already exists
             if (inputValue.trim() === '') {
                 alert("Please enter a value.");
                 return;
             }
             if ($('#output4').find('input[value="' + inputValue + '"]').length > 0) {
                 alert("Value already exists.");
                 return;
             }

             // Create a new input element with close button
             var newInput = $('<div class="input-container"><input type="text"class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output4').append(newInput);

             // Clear the input field
             $('#txtresd').val('');

             // Remove input field on close button click
             $('#output4').on('click', '.close-button', function () {
                 $(this).closest('.input-container').remove();
             });
         });

       

         $('.add5').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtcstdy').val();

             // Check if input value is empty or already exists
             if (inputValue.trim() === '') {
                 alert("Please enter a value.");
                 return;
             }
             if ($('#output5').find('input[value="' + inputValue + '"]').length > 0) {
                 alert("Value already exists.");
                 return;
             }

             // Create a new input element with close button
             var newInput = $('<div class="input-container"><input type="text"class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output5').append(newInput);

             // Clear the input field
             $('#txtcstdy').val('');

             // Remove input field on close button click
             $('#output5').on('click', '.close-button', function () {
                 $(this).closest('.input-container').remove();
             });
         });

       
        

      


         $(".add7").click(function () {
             var name = $("#txtnmcstdn").val().trim(),
                 address = $("#txtcstadrs").val().trim(),
                 contact = $("#txtcscnt").val().trim();

             if (name && address && contact) {
                 var exists = $("#output7 .custodian-info").filter(function () {
                     return $(this).find(".name").text().trim() === name &&
                         $(this).find(".address").text().trim() === address &&
                         $(this).find(".contact").text().trim() === contact;
                 }).length > 0;

                 if (!exists) {
                     var html = '<div class="custodian-info">' +
                         '<span class="name"><strong>Name Of The Custodian:</strong> ' + name + '</span><br>' +
                         '<span class="address"><strong>Address Of The Custodian:</strong> ' + address + '</span><br>' +
                         '<span class="contact"><strong>Contact Detail:</strong> ' + contact + '</span>' +
                         '<span class="delete-button">x</span>' +
                         '</div>';
                     $("#output7").append(html);
                     $("#txtnmcstdn, #txtcstadrs, #txtcscnt").val("");
                 } else {
                     alert("Duplicate entry! The combination of Name, Address, and Contact already exists.");
                 }
             } else {
                 alert("Please fill in all fields.");
             }

             // Add event listener for delete button
             $("#output7").on("click", ".delete-button", function () {
                 $(this).parent().remove();
             });
         });


        
       
         $('.add8').click(function () {
             // Get the value of the input field
             var inputValue = $('#txtidntmrk').val();

             // Check if input value is empty or already exists
             if (inputValue.trim() === '') {
                 alert("Please enter a value.");
                 return;
             }
             if ($('#output8').find('input[value="' + inputValue + '"]').length > 0) {
                 alert("Value already exists.");
                 return;
             }

             // Create a new input element with close button
             var newInput = $('<div class="input-container"><input type="text" class="form-control console frst" value="' + inputValue + '"><span class="close-button"><i class="fa fa-times" aria-hidden="true"></i></span></div>');

             // Append the new input element to the output div
             $('#output8').append(newInput);

             // Clear the input field
             $('#txtidntmrk').val('');

             // Add click event to close button
             newInput.find('.close-button').click(function () {
                 $(this).parent().remove();
             });

             // Add event listener for delete button
             $("#output8").on("click", ".delete-button", function () {
                 $(this).parent().remove();
             });
         });


        
         

         // Add event listener for add button
         $('.add23').on('click', function () {
           
             var name = $('#txtnmw').val();
             var id = $('#txtidw').val();
             var contactDetails = $('#txtcdtlw').val();

             // Check if all fields are filled
             if (name && id && contactDetails) {
                 // Check if any entry already exists with the same values
                 var exists = $('.frst').filter(function () {
                     var entry = $(this);
                     return
                         entry.find('.name').text() === name &&
                         entry.find('.id').text() === id &&
                         entry.find('.contact').text() === contactDetails;
                 }).length > 0;

                 // If the entry doesn't exist, append the new entry
                 if (!exists) {
                     var newEntry = '<p class="frst" style="color: #000; padding: 10px;">' +
                         '<strong>Name:</strong> <span class="name">' + name + '</span><br>' +
                         '<strong>ID:</strong> <span class="id">' + id + '</span><br>' +
                         '<strong>Contact Details:</strong> <span class="contact">' + contactDetails + '</span>' +
                         '<span class="delete-button witnescls">x</span>' +
                         '</p>';

                     $('#output9').append(newEntry);

                     // Clear all input fields
                    
                     $('#txtnmw').val('');
                     $('#txtidw').val('');
                     $('#txtcdtlw').val('');
                 } else {
                     alert('Entry already exists! Duplicate values are not allowed.');
                 }
             } else {
                 alert('Please fill in all fields.');
             }

             // Add event listener for delete button
             $("#output9").on("click", ".delete-button", function () {
                 $(this).parent().remove();
             });
         });
    


       
         $(".add56").click(function () {
             var sectionValue = $("#txtsect").val().trim();
             var actValue = $("#txtact").val().trim();

             // Construct the value to check for duplicacy
             var inputValue = "Section/s: " + sectionValue + ", Under Act: " + actValue;

             // Check if the constructed value already exists within the container
             if ($('#appendedValues').find(':contains("' + inputValue + '")').length > 0) {
                 alert("Value already exists.");
                 return;
             }

             // If the value doesn't exist, proceed with appending
             // Construct the new paragraph with labels
             var newParagraph = $("<p>Section/s: " + sectionValue + ", Under Act: " + actValue + "<span class='closeBtn'>x</span></p>");

             // Append the new paragraph to the container
             $("#appendedValues").append(newParagraph);

             // Clear input fields
             $("#txtsect").val("");
             $("#txtact").val("");

             $(document).on('click', '.closeBtn', function () {
                 $(this).parent().remove();
             });
         });


         

         $(".add57").click(function () {
             var fileInput = document.getElementById('txtvalidid');
             var file = fileInput.files[0];

             if (file) {
                 var fileName = file.name;

                 // Check if the file name already exists
                 var exists = $("#appendedValuesz").find("div[data-filename='" + fileName + "']").length > 0;

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

                     // Create a container for the image and close button
                     var imageView = $("<div>").attr("data-filename", fileName).css({
                         "display": "inline-block",
                         "margin": "5px"
                     }).append(newImage, closeButton);

                     // Append the new image view to the appropriate location
                     $("#appendedValuesz").append(imageView);

                     // Clear input field
                     $("#txtvalidid").val("");
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

         });

         
         $(".add60").click(function () {
             // Cache jQuery selectors for input fields
             var $name = $("#txtsnm");
             var $parent = $("#txtpge");
             var $address = $("#txtadrs");
             var $bodyMark = $("#txtbdymrk");
             var $mobileNo = $("#txtsmbl");
             var $idNo = $("#txtscptid");
             var $sideFacePath = $("#tctfls");
             var $frontFacePath = $("#tctflf");

             // Retrieve values entered by the user
             var name = $name.val().trim();
             var parent = $parent.val().trim();
             var address = $address.val().trim();
             var bodyMark = $bodyMark.val().trim();
             var mobileNo = $mobileNo.val().trim();
             var idNo = $idNo.val().trim();
             var sideFaceFile = $sideFacePath[0].files[0];
             var frontFaceFile = $frontFacePath[0].files[0];

             // Check if any input fields are empty
             if (name === "" || parent === "" || address === "" || bodyMark === "" || mobileNo === "" || idNo === "" || !sideFaceFile || !frontFaceFile) {
                 alert("Please fill in all the fields and select both side face and front face files.");
                 return; // Stop execution if any field is empty
             }

             // Check if the files with the same names have already been appended
             var sideFaceFileName = sideFaceFile.name;
             var frontFaceFileName = frontFaceFile.name;
             var fileExists = $("#ouput60").find("p:contains('" + sideFaceFileName + "')").length > 0 || $("#ouput60").find("p:contains('" + frontFaceFileName + "')").length > 0;

             if (fileExists) {
                 alert("File with the same name already exists.");
                 return; // Stop execution if files with the same names exist
             }

             // Create a new paragraph to contain all the data
             var dataParagraph = $("<p>").css({
                 "border": "1px solid #000",
                 "color": "#000"
             }).html(
                 "<strong>Name:</strong> " + name + "<br>" +
                 "<strong>Parentage:</strong> " + parent + "<br>" +
                 "<strong>Address:</strong> " + address + "<br>" +
                 "<strong>Body Mark for Identification:</strong> " + bodyMark + "<br>" +
                 "<strong>Mobile No:</strong> " + mobileNo + "<br>" +
                 "<strong>ID Card No:</strong> " + idNo + "<br>"
             );

             // Append the new paragraph to the output div
             $("#ouput60").append(dataParagraph);

             // Create and append side face image
             if (sideFaceFile) {
                 var sideFaceLabel = $("<p>").text("Side Face Image").css({
                     "text-decoration": "underline",
                     "font-weight": "bold"
                 });
                 dataParagraph.append(sideFaceLabel);

                 var sideFaceImage = $("<img>").css({
                     "max-width": "100px",
                     "max-height": "100px",
                     "display": "block",
                     "margin-top": "10px",
                     "margin-left": "5px"
                     
                 });
                 var sideReader = new FileReader();
                 sideReader.onload = function (e) {
                     sideFaceImage.attr("src", e.target.result);
                     dataParagraph.append(sideFaceImage);

                     // Create a paragraph for front face label
                     var frontFaceLabel = $("<p>").text("Front Face Image").css({
                         "text-decoration": "underline",
                         "font-weight": "bold"
                     });
                     dataParagraph.append("<br>", frontFaceLabel);

                     // Create and append front face image
                     if (frontFaceFile) {
                         var frontFaceImage = $("<img>").css({
                             "max-width": "100px",
                             "max-height": "100px",
                             "display": "block",
                             "margin-top": "10px",
                             "margin-left": "5px",
                             "margin-bottom": "20px"
                         });
                         var frontReader = new FileReader();
                         frontReader.onload = function (e) {
                             frontFaceImage.attr("src", e.target.result);
                             dataParagraph.append(frontFaceImage);

                             // Create a close button
                             var closeButton = $("<span>").addClass("closeBtn").text("x").css({
                                 "margin-top": "-100px",
                                 "display": "block"
                                
                             });

                             // Append the close button to the data paragraph
                             dataParagraph.append(closeButton);

                             // Clear input fields after appending all content
                             $name.val("");
                             $parent.val("");
                             $address.val("");
                             $bodyMark.val("");
                             $mobileNo.val("");
                             $idNo.val("");
                             $sideFacePath.val("");
                             $frontFacePath.val("");
                         };
                         frontReader.readAsDataURL(frontFaceFile);
                     }
                 };
                 sideReader.readAsDataURL(sideFaceFile);
             }
             // Event handler for close button click using event delegation
             $(document).on("click", ".closeBtn", function () {
                 // Remove the parent paragraph containing the data
                 $(this).parent().remove();
             });
         });

      });

     

         
     //submit code 

     function sub() {


         // Get form input values
         var ofrptno = $("#txtrptno").val();
         var dt = $("#txtdt").val();
         var poc = $("#txtplc").val();
         var dth = $("#txtdte").val();
         var hour = $("#txtme").val();
         var nm = $("#txtnm").val();
         var parntge = $("#txtprnt").val();
         var resd = $("#txtresd").val();
         var prptysz = $("#txtprpsze").val();
         var cstdyszp = $("#txtcstdy").val();
         var ntrofence = $("#txtofnse").val();
         var refofrepon = $("#txtrno").val();
         var divn = $("#txtdvsn").val();
         var rangeof = $("#txtrngeofc").val();
         var time = $("#txttime").val();
         var date = $("#txtdtx").val();
         var sec = $("#txtsect").val();
         var act = $("#txtact").val();
         var gpsco = $("#txtplce").val();
         var ladmrk = $("#txtlndmrk").val();
         var pht = $("#txtphoto").val();
         var informdtl = $("#txtinfdtl").val();
         var mode = $("#txtmde").val();
         var party = $("#txtcdtl").val();
         var dno = $("#txtdno").val();
         var dtx = $("#txtdx").val();
         var timex = $("#txtmec").val();
         var adlt = $("#txtadlt").val();
         var minr = $("#txtminor").val();
         var snm = $("#txtsnm").val();
         var bdenti = $("#txtbdymrk").val();
         var mob = $("#txtsmbl").val();
         var idno = $("#txtscptid").val();
         var sznmp = $("#txtnmprprt").val();
         var szidn = $("#txtidntmrk").val();
         var nmofcstd = $("#txtnmcstdn").val();
         var adrscstd = $("#txtcstadrs").val();
         var contctdtl = $("#txtcscnt").val();
         var rsn = $("#txtwnfnd").val();
         var wtnsdtl = $("#txtidtl").val();
         var nmidno = $("#txtdidno").val();
         var contct = $("#txtcntno").val();

         var reportlist = [];
         // Create and push user object to users array
         reportlist.push({
             ofrptno: ofrptno,
             dt: dt,
             poc: poc,
             dth: dth,
             hour: hour,
             nm: nm,
             parntge: parntge,
             resd: resd,
             prptysz: prptysz,
             cstdyszp: cstdyszp,
             ntrofence: ntrofence,
             refofrepon: refofrepon,
             divn: divn,
             rangeof: rangeof,
             time: time,
             date: date,
             sec: sec,
             act: act,
             gpsco: gpsco,
             ladmrk: ladmrk,
             informdtl: informdtl,
             mode: mode,
             party: party,
             dno: dno,
             dtx: dtx,
             timex: timex,
             adlt: adlt,
             minr: minr,
             snm: snm,
             bdenti: bdenti,
             mob: mob,
             idno: idno,
             sznmp: sznmp,
             szidn: szidn,
             nmofcstd: nmofcstd,
             adrscstd: adrscstd,
             contctdtl: contctdtl,
             rsn: rsn,
             wtnsdtl: wtnsdtl,
             nmidno: nmidno,
             contct: contct
           
         });

        

       



         $.ajax({
             type: "POST",
             url: "forms1.aspx/Insert",
             data: "{reportlist:" + JSON.stringify(reportlist) + "}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: OnSuccessrrd,
             error: function (xhr, status, error) {
                 alert("Error: " + error);
             }
         });

         function OnSuccessrrd(response) {
             alert("Record Submitted Successfully!");
             window.location.reload();
         }
     }


//code for refresh

     function refreshPage() {
         location.reload();
     }


 </script>

  
   <style>
        .button-container {
  text-align: right;
}
        @media(max-width:480px) {}

   
#appendedValues p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
   
}


#appendedValues input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}



#appendedValuesx input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
#appendedValuesx p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}
#appendedValuesy p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}


#appendedValuesy input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
#appendedValuesz p {
    color: #000;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #000; 
    border-radius: 5px; 
}


#appendedValuesz input[type="text"] {
    background-color:#fff; 
    border: 1px solid #ccc; 
    padding: 5px; 
}
.closeBtn {
    cursor: pointer;
    float: right; 
    margin-left: 10px; 
    color: red;
      font-weight: 700;
    font-size: 20px;
    
}

/*button*/


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

.btny{

    width: 66%;
    height: 33px;
    background-color: #0dcaf0;
    color: #fff;
    border: none;
    letter-spacing: 1px;
    border-radius: 6px;

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




 /* Add CSS styles here */
    .frst {
      border: 1px solid #ccc;
      margin-bottom: 10px;
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


    .custodian-info {
    font-size: 14px; 
    margin-bottom: 10px; 
    border: 1px solid black; 
    padding: 10px; 
    color:black;

}

.custodian-info .delete-button {
    position: relative;
     bottom: 53px;
    left:587px;
    color: red;
    cursor: pointer;
    margin-left: 5px;
    font-weight: 700;
    font-size: 20px;
}




.witnescls {
    position: relative;
    bottom: 59px;
    left: 551px;
    cursor: pointer;
    margin-left: 10px;
    color: red;
     font-weight: 700;
    font-size: 20px;
}

    </style>
  
  
</head>

<body>

    

     <form id="form1" runat="server">
   

	<!-- SIDEBAR -->
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

	<!-- SIDEBAR -->


   <section id="content">

        <nav>
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>


<h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>





        <main>

            <div class="container-fluid" style="margin-top: 40px;">
                <div class="row justify-content-center">
                    <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                        <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                            <div class="text-center">
                                <h3 id="heading">FORM-(I)</h3>
                                <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
                                <p style="color: #fff;" id="heading1"> [Vide Sub-rule (2) of Rule 31] </p>
                                <p style="color: #fff;" id="heading1"> Note- This report to be submitted within
                                    twenty-four hours of the detection. </p>
                            </div>

                            <form id="msform">
                                <fieldset>
                                    <div class="form-card">
                                        <div class="row">
                                            <div class="col-7">
                                                <h2 class="fs-title"></h2>
                                            </div>

                                            <div class="col-5">
                                            </div>
                                        </div>

                                        <div class="row ">
                                            <div class="col-md-10  col-12 mx- auto offset-md-1">

                                                <div class="login-form">
                                                    <h5 class="text-center mb-2 val"></h5>
                                                     <!--
                                                    <div class="row asd d-flex">
                                                       <div class="col-lg-6  col-sm-6 col-xs-6 abc">
														   
														    <label class="lebl">Ro Details</label>
														   <input type="text" id="txtrno"  class="form-control console"
                                                                    placeholder="">
														   

														   <label class="lebl">Offence Report No.</label>
														   <input type="text" id="txtrptno"  class="form-control console"
                                                                    placeholder="">


														     <label class="lebl">Place of occurrence</label>

													 <input type="text" id="txtplc"  class="form-control console"
                                                                    placeholder="">
														
									 
														     <label class="lebl"> Date  of Detection</label>

													 <input type="date" id="txtdte"  class="form-control console"
                                                                    placeholder="">
														 
														     <label class="lebl">Time of detection</label>

													 <input type="time" id="txtme"  class="form-control console"
                                                                    placeholder="">
														   
														   <label class="lebl"> Property seized, if any</label>

													 <input type="text" id="txtprpsze"  class="form-control console"
                                                                    placeholder="">

														
                                                                   
														   </div>
														
														
														
														
														 <div class="col-lg-6  col-sm-6 col-xs-6 abc">
									  
														    <label class="lebl">Division </label>
														   <input type="text" id="txtdvsn"  class="form-control console"
                                                                    placeholder="">
															 

														     <label class="lebl">Dated</label>
										<input type="date" id="txtdt" class="form-control console" placeholder="">
															 

														     <label class="lebl">Name</label>

													 <input type="text" id="txtnm"  class="form-control console"
                                                                    placeholder="">


														

														     <label class="lebl">Parentage</label>
														   
													 <input type="text" id="txtprnt"  class="form-control console"
                                                                    placeholder="">



															  
									
                                                         <label class="lebl">Residence</label>

													 <input type="text" id="txtresd"  class="form-control console"
                                                                    placeholder="">



															 <label class="lebl">Custody of seized property</label>

													 <input type="text" id="txtcstdy"  class="form-control console"
                                                                    placeholder="">


															 
														     </div>
														 <div class="col-lg-12  col-sm-12 col-xs-12">
															 
															 <label class="lebl">Nature of Offence and facts of the case</label>
                                                                <input type="text" id="txtofnse"  class="form-control console" placeholder="">


														</div>

															


                                                            <p class="button-container">
                             <button class="bt11 add55" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                                                            <div id="newDiv">
    
                                                             </div>
                                                          
                                                        </div>
                                                        -->


                                                        <div class="row asd d-flex">
                                                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          <label class="lebl">Command Certificate No</label>
                                                           <input type="text" id="txtcno" class="form-control console" placeholder="">
                                                               
                                                               </div>

                                                             <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          <label class="lebl">FIR No</label>
                                                         <input type="text" id="txtfir" class="form-control console" placeholder="">
                                                               
                                                               </div>
                                                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          
                                                                <label class="lebl">RO Details</label>
                                                                <input type="text" id="txtrno"  class="form-control console"
                                                                         placeholder="">


                                                            </div>

                                                          <div class="col-lg-6  col-sm-6 col-xs-6 abc">

														   <label class="lebl">Offence Report No</label>
														   <input type="text" id="txtrptno"  class="form-control console"
                                                                    placeholder="">


                                                            </div>


                                                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                                                                <label class="lebl">Place Of Occurrence</label>

                                                                <input type="text" id="txtplc"  class="form-control console"
                                                                               placeholder="">

                                                                </div>




                                                                <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          
                                                                    <label class="lebl"> Date  Of Detection</label>

                                                                    <input type="date" id="txtdte"  class="form-control console"
                                                                                   placeholder="">
                                                                    </div>




                                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          
                                                                        <label class="lebl">Time Of Detection</label>

                                                                        <input type="time" id="txtme"  class="form-control console"
                                                                                       placeholder="">


                                                                        </div>




                                                                        <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          
                                                                            <label class="lebl"> Property Seized, If Any</label>

                                                                            <input type="text" id="txtprpsze"  class="form-control console pszed"
                                                                                           placeholder="">

                                                                                           <p class="button-container">
                                                                                            <button class="bt11 add1" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                                                                           </p>
                                                                                                                                                     <div id="output"></div>



                                                                            </div>



                                                                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                                <label class="lebl">Division </label>
                                                                                <input type="text" id="txtdvsn"  class="form-control console"
                                                                                         placeholder="">

                                                                                </div>



                                                                                <div class="col-lg-6  col-sm-6 col-xs-6 abc">


                                                                                    <label class="lebl">Dated</label>
                                                                                    <input type="date" id="txtdt" class="form-control console" placeholder="">


                                                                                    </div>




                                                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          
														     <label class="lebl">Name</label>

                                                             <input type="text" id="txtnm"  class="form-control console"
                                                                            placeholder="">


                                                                            <p class="button-container">
                                                                                <button class="bt11 add2" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                                                               </p>
                                                                                                                                       <div id="output2"></div>


                                                                                        </div>



                                                                                        <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          

                                                                                            <label class="lebl">Parentage</label>
														   
                                                                                            <input type="text" id="txtprnt"  class="form-control console"
                                                                                                           placeholder="">

                                                                                                           <p class="button-container">
                                                                                                            <button class="bt11 add3" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                                                                                           </p>
                                                                                                                                                                     <div id="output3"></div>


                                                                                            </div>








                                                            <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                          

															  
                                                                <label class="lebl">Residence</label>

                                                                <input type="text" id="txtresd"  class="form-control console"
                                                                               placeholder="">


                                                                               <p class="button-container">
                                                                                <button class="bt11 add4" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                                                               </p>
                                                                                                                                         <div id="output4"></div>
                                                                </div>



    
                                                              <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                                                                <label class="lebl">Custody Of Seized Property</label>

                                                                <input type="text" id="txtcstdy"  class="form-control console"
                                                                               placeholder="">

                                                                               <p class="button-container">
                                                                                <button class="bt11 add5" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                                                               </p>
                                                                                                                                         <div id="output5"></div>

                                                                </div>


                                                                <div class="col-lg-12  col-sm-12 col-xs-12 mb-5" >
                                                                    <label class="lebl">Nature Of Offence And Facts Of The Case</label>
                                                                    <input type="text" id="txtofnse"  class="form-control console" placeholder="">


                                                                    </div>



                                                            </div>









													
                                                    </div>
                                                </div>
                                            </div>
									</div>
                                </fieldset>
                            </form>



                            <div class="text-center">

                                <h3 id="heading"> FORM-(I) FOREST DEPARTMENT,ODISHA</h3>
                                <p id="heading1">[Vide Sub -Rule(2) of Rule 3]</p>
                                <p id="heading1">(Note: This report is to be submitted within 24 hours of Detection)</p>




                            </div>




                            <form id="msform">
                                <fieldset>
                                    <div class="form-card">
                                        <div class="row">
                                            <div class="col-7">
                                                <h2 class="fs-title"></h2>
                                            </div>

                                            <div class="col-5">
                                            </div>
                                        </div>




                                        <div class="row ">
                                            <div class="col-md-10  col-12 mx- auto offset-md-1">

                                                <div class="login-form">
                                                    <h5 class="text-center mb-2 val"></h5>
                                                    <div class="row asd d-flex">
                                                        <div class="col-lg-12  col-sm-12 col-xs-12 abc1">



															<div class="row">
															 <div class="col-lg-4  col-sm-4 col-xs-4 abc">



															 <label class="lebl">Range Office</label>
                                                                <input type="text" id="txtrngeofc"  class="form-control console" placeholder="">
															</div> 



															 <div class="col-lg-4  col-sm-4 col-xs-4 abc">

															 <label class="lebl">Time</label>
                                                                <input type="time" id="txttime"  class="form-control console" placeholder="">
															</div>



															 <div class="col-lg-4  col-sm-4 col-xs-4 abc">
																 
															 <label class="lebl">Date</label>
                                                                <input type="date" id="txtdtx"  class="form-control console" placeholder="">
															</div>
															
															</div>

                                                            <br>


                                                           




                                                           


                                                     


<br><br>


                                                            <p class="to34" style="font-size: 16px; font-weight: 500;">
                                                                A. Prior Information</p>

                                                                <div class="row">
                                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">

                                                                    <label class="lebl">Informant Details</label>
                                                                     <input type="text" id="txtinfdtl"  class="form-control console" placeholder="">
                                                                    </div>
                                                                  
                                                                  <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                  
                                                                    <label class="lebl">Mode</label>
                                                                     <input type="text" id="txtmde"  class="form-control console" placeholder="">
                                                                    </div>
                                                                    </div>
                                                             <!--
                                                            <p class="to34">(a) Informant Details <input type="text"
                                                                    id="txtinfdtl" class="inp" placeholder=""></p>
                                                            <p class="to34">Mode <input type="text" id="txtmde" class="inp"
                                                                    placeholder=""></p>
                                                                    -->


                                                            <p class="to34" style="font-size: 16px; font-weight: 500;">
                                                                Detection While Patrolling  </p>

                                                              <!--
                                                            <p class="to34">(b) Contact details of Receiver/ Patrolling
                                                                Party <input type="text" id="txtcdtl" class="inp"
                                                                    placeholder=""></p>

-->
                                                                    <div class="row mb-4">
                                                                        <div class="col-lg-6  col-sm-6 col-xs-6" style="margin: 0 auto;">

                                                                        <label class="lebl">Contact details of Receiver/ Patrolling</label>
                                                                         <input type="text" id="txtcdtl"  class="form-control console" placeholder="">
                                                                        </div>
                                                                        </div>




                                                                    <!--
                                                            <p class="to34">(c) Reference: (can be filled after entry of
                                                                such reports)</p>

                                                            <p class="to34">Range Diary No.
                                                                <input type="number" id="txtdno" class="inp" placeholder="">
                                                                Date <input type="date" id="txtdx" class="inp"
                                                                    placeholder="">Time <input type="time" id="txtmec"
                                                                    class="inp" placeholder="">
                                                            </p>
-->

                                                            <p class="to34" style="font-size: 16px; font-weight: 500;">
                                                                B. Details of Accused </p>

                                                              <!--
                                                            <p class="to34" style=" font-weight: 600;">If checked
                                                                ticks Unknown Accused (no proceeding further in Details
                                                                of Accused)</p>
                                                            <p class="to34" style=" font-weight: 600;">If checked
                                                                ticks Known Accused then proceeding further in details
                                                                of the Accused</p>
                                                                -->

                                                            <p class="to34">(a) Number of Suspects:</p>


                                                            <!--
                                                            <p class="to34">Adults : <input type="text" id="txtadlt"
                                                                    class="inp" placeholder=""></p>
                                                            <p class="to34">Minors : <input type="text" id="txtminor"
                                                                    class="inp" placeholder=""></p>
                                                                    -->

                                                                    <div class="row mb-3">
                                                                        <div class="col-lg-6  col-sm-6 col-xs-6">
                                                                      
                                                                        <label class="lebl">Adults</label>
                                                                         <input type="text" id="txtadlt"  class="form-control console" placeholder="">
                                                                        </div>
                                                                      
                                                                      <div class="col-lg-6  col-sm-6 col-xs-6">
                                                                      
                                                                        <label class="lebl">Minors</label>
                                                                         <input type="text" id="txtminor"  class="form-control console" placeholder="">
                                                                        </div>
                                                                      </div>

                                                                <div class="row">

                                                                       <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                        <label class="lebl">Name</label>
                                                                         <input type="text" id="txtsnm"  class="form-control console" placeholder="">
                                                                        </div>
                                                                    <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                    <label class="lebl">Parentage</label>
                                                                     <input type="text" id="txtpge"  class="form-control console" placeholder="">
                                                                    </div>

                                                                       
                                                                     <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                    <label class="lebl">Address</label>
                                                                     <input type="text" id="txtadrs"  class="form-control console" placeholder="">
                                                                    </div>



                                                                    <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                        <label class="lebl">Body Mark For Identification </label>
                                                                         <input type="text" id="txtbdymrk"  class="form-control console" placeholder="">
                                                                        </div>
                                                                        <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                            <label class="lebl">Mobile No</label>
                                                                             <input type="number" id="txtsmbl"  class="form-control console" placeholder="">
                                                                            </div>
                                                                           <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                                <label class="lebl">ID Card No (Aadhar /Voter ID/ any other ID</label>
                                                                                 <input type="text" id="txtscptid"  class="form-control console" placeholder="">
                                                                                </div>



                                                                  <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                  
                                                                    <label class="lebl">(Upload Side Face Of Accused)</label>
                                                                     <input type="file" id="tctfls"  class="form-control console" placeholder="">
                                                                    </div>

                                                            
                                                                  <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                  
                                                                    <label class="lebl">(Upload Front Face Of Accused)</label>
                                                                     <input type="file" id="tctflf"  class="form-control console" placeholder="">
                                                                    </div>

                                                                    </div>


                                                                    
                                                            <p class="button-container">
                                                                <button class="bt11 add60" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                                <div id="ouput60"></div>


                                                            
                                                            <p style="color:#000;font-size: 17px;">Property Seized (if any) with all details
                                                                for identification mentioning the location:</p>



                                                                <div class="row">
                                                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                  
                                                                    <label class="lebl">(a) Name Of The Property </label>
                                                                     <input type="text" id="txtnmprprt"  class="form-control console" placeholder="">
                                                                    </div>
                                                                  
                                                                  <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                                                  
                                                                    <label class="lebl">(b)
                                                                        Identification Mark</label>
                                                                     <input type="text" id="txtidntmrk"  class="form-control console" placeholder="">
                                                                    </div>




                                                            <p class="button-container">
                             <button class="bt11 add8" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                                                             <div id="output8"></div>




                                                            <p style="color:#000;font-size: 17px;">
                                                                Custodian of the Seized Property (with all details
                                                                including contact and ID reference)
                                                                (UPLOAD ID & PHOTO) </p>

                                                                <div class="row">
                                                                    <div class="col-lg-4  col-sm-4 col-xs-4 ">

                                                                    <label class="lebl">Name Of The Custodian</label>
                                                                     <input type="text" id="txtnmcstdn"  class="form-control console" placeholder="">
                                                                    </div>
                                                                    <div class="col-lg-4  col-sm-4 col-xs-4 ">

                                                                        <label class="lebl">Address Of
                                                                            The Custodian</label>
                                                                         <input type="text" id="txtcstadrs"  class="form-control console" placeholder="">
                                                                        </div>

                                                                  <div class="col-lg-4  col-sm-4 col-xs-4">
                                                                  
                                                                    <label class="lebl">Contact
                                                                        Detail</label>
                                                                     <input type="text" id="txtcscnt"  class="form-control console" placeholder="">
                                                                    </div>



                                                                    </div>


                                                                    <p class="button-container">
                                                                        <button class="bt11 add7" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                               </p>
                                                                                                       <div id="output7"></div>



                                                                    <p style="color:#000;font-size: 17px;">C. Independent Witness (Valid ID reference)
                                                                        (Copies of the ID to be attached- optional)</p>

                                                                        <div class="row">
                                                                            <div class="col-lg-6  col-sm-6 col-xs-6" style="margin:0 auto;">
                                                                          
                                                                            <label class="lebl"></label>
                                                                             <input type="file" id="txtvalidid"  class="form-control console" placeholder="">
                                                                            </div>

                                                                            </div>
                                                             


                                                             <p class="button-container">
                             <button class="bt11 add57" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                    </p>
                                                            <div id="appendedValuesz"></div>



                                                            <div class="row mb-3">
                                                                <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                <label class="lebl">Reasons If Independent Witness Not Found</label>
                                                                 <input type="text" id="txtwnfnd" class="form-control console" placeholder="">
                                                                </div>
                                                              </div>


                                                              <div class="row mb-3">
                                                                <div class="col-lg-6  col-sm-6 col-xs-6">

                                                                <label class="lebl">Name</label>
                                                                 <input type="text" id="txtnmw" class="form-control console" placeholder="">
                                                                </div>
                                                                <div class="col-lg-6  col-sm-6 col-xs-6">

                                                                    <label class="lebl">Id</label>
                                                                     <input type="text" id="txtidw" class="form-control console" placeholder="">
                                                                    </div>
                                                                    <div class="col-lg-12  col-sm-12 col-xs-12 mt-2">

                                                                        <label class="lebl">Contact Details</label>
                                                                         <input type="text" id="txtcdtlw" class="form-control console" placeholder="">
                                                                        </div>
                                                              </div>

                                                              <p class="button-container">
                                                                <button class="bt11 add23" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                                                                               <div id="output9"></div>






                                                            

                                                               <div class="row">
                                                                <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                <label class="lebl">D. Further Action Taken</label>
                                                                 <input type="text" id="txact" class="form-control console" placeholder="">
                                                                </div>
                                                              </div>

                                                              <div class="row mt-3 mb-3">
                                                                <div class="col-lg-12  col-sm-12 col-xs-12">

                                                                <label class="lebl">Prepared By</label>
                                                                 <input type="file" id="" class="form-control console" placeholder="">
                                                                </div>
                                                              </div>

                                                            <!--  <p class="to34 mt-5" style="font-size:17px;font-weight: 700;letter-spacing: 1px;text-decoration: underline;">Prepared By:</p>-->

                                                              <div class="row mb-3">
                                                                <div class="col-lg-6  col-sm-6 col-xs-6">
                                                              
                                                                <label class="lebl">Name with Designation ID No</label>
                                                                 <input type="text" id="txtdidno" class="form-control console" placeholder="">
                                                                </div>
                                                                <div class="col-lg-6  col-sm-6 col-xs-6">
                                                              
                                                                    <label class="lebl">Contact No</label>
                                                                     <input type="text" id="txtcntno" class="form-control console" placeholder="">
                                                                    </div>

                                                              </div>



                                                           


                                                        </div>
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
            
                                <div class="col-lg-4  col-sm-4 col-xs-4 abc">

                                    <label class="lebl" style="color:#228B22;">Manually Upload File</label>
            
                                     <input id="txtmupld" type="file">
            
                                </div>


                              <div class="col-lg-4  col-sm-4 col-xs-4 abc">

                               
            
                             <button class="btnz mt-4" type="button" onclick="restoredt()">Save</button>
            
                            </div>


                             <div class="col-lg-4  col-sm-4 col-xs-4">

                               
            
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
   
            
                          </div>
                        </div>
            
                      </div>
                    </div>
 
								
                            </form>
                        </div>
                    </div>
                </div>
            </div>





        </main>

    </section>


          <script src="js/script.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
    integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>

  
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