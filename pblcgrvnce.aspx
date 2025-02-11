<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pblcgrvnce.aspx.cs" Inherits="pblcgrvnce" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offence Information</title>
    <link rel="icon" type="image/x-icon" href="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
           <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <link rel="stylesheet" href="css/style.css">

<script>
    $(document).ready(function () {
        // File upload handling
        $('.btn-upload').on('click', function () {
            $(this).next('.file-input').trigger('click');
        });

        $('.file-input').on('change', function () {
            const inputId = $(this).attr('id');
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const base64Data = e.target.result;
                    const fileName = file.name;

                    // Map to hidden fields
                    if (inputId === 'fileInputPhoto') {
                        $('#hidenz').val(base64Data);
                        $('#hiddenz').val(fileName);

                        // Show preview
                        $('#imgPreview').attr('src', base64Data).show();
                        $('#removeImg').show();
                    }
                };
                reader.readAsDataURL(file);
            }
        });

        // Remove image
        $('#removeImg').on('click', function () {
            $('#imgPreview').hide();
            $(this).hide();
            $('#fileInputPhoto').val(''); // Reset input
            $('#hidenz').val('');
            $('#hiddenz').val('');
        });

        // Submit form data via AJAX
        $("#btn").on("click", function () {
            $.ajax({
                type: "POST",
                url: "pblcgrvnce.aspx/Insert",
                data: JSON.stringify({
                    clientName: $("#clientName").val(),
                    mobileNo: $("#mobileNo").val(),
                    district: $("#district").val(),
                    division: $("#division").val(),
                    description: $("#description").val(),
                    picz: $("#hidenz").val(),
                    pathz: $("#hiddenz").val(),
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("Successfully submitted!");
                    window.location.reload();
                },
                failure: function (response) {
                    alert("Error: " + response.d);
                }
            });
        });
    });
</script>

    <style>

@media(max-width:480px){

    .form-wrap {
    margin-top: 60px!important;
    margin-bottom: 60px!important;
    background: rgba(255,255,255,1);
    width: 100%;
    max-width: 830px;
    height: 600px!important;
}

}

.form-wrap {
    margin-top: 50px !important;
    margin-bottom: 60px !important;
    background: rgba(255, 255, 255, 1);
    width: 100%;
    max-width: 830px;
    height: 515px;
    padding: 50px;
    margin: 0 auto;
    position: relative;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    border-radius: 10px;
    -webkit-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
    -moz-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
    box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
}


.form-wrap:before{
	content: "";
	width: 90%;
	height: calc(100% + 60px);
	left: 0;
	right: 0;
	margin: 0 auto;
	position: absolute;
	top: -30px;
	background: #228B22;
	z-index: -1;
	opacity: 0.8;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
	box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
}
.form-group{
	margin-bottom: 25px;
}
.form-group > label{
	display: block;
	font-size: 15px;
	color:#228B22;
	letter-spacing: 2px;
	font-weight: 600;
}
.custom-control-label{
	color: #228B22;
	font-size: 16px;
}
.form-control{
	height: 50px;
	background: #ecf0f4;
	border-color: transparent;
	padding: 0 15px;
	font-size: 16px;
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	-o-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
}
.form-control:focus{
	border-color: #228B22;
	-webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
	-moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
	box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
}
textarea.form-control{
	height: 160px;
	padding-top: 15px;
	resize: none;
}



	.btn77{
	font-size: 18px;
	letter-spacing: 2px;
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	-o-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
	border: none;
	color: #fff;
	height: 35px;
	background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
}


 #imgPreview {
  display: none;
  width:49%;
  max-width: 300px;
  margin-top: 10px;
  position: relative;
 }
    .remove-img {
    display: none;
    position: absolute;
    top: 15px;
    right: 13px;
    background-color: rgba(0, 0, 0, .2);
    color: red;
    border: none;
    border-radius: 18%;
    width: 25px;
    height: 25px;
    text-align: center;
    cursor: pointer;
}


	</style>


</head>

<body>

	 <form id="form1" runat="server">




<div class="container">
    <div class="text-center">
        <h2 class="cri" style="color: #000;">Offence Information</h2>
    </div>

    <div class="form-wrap">
        <div class="form" id="survey-form">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label id="name-label" for="name">Name</label>
                        <input type="text" name="name" id="clientName" class="form-control" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label id="name-label" for="name">Phone</label>
                        <input type="tel" name="phone" id="mobileNo" class="form-control" required>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label id="name-label" for="name">District</label>
                        <input type="text" name="district" id="district" class="form-control" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label id="name-label" for="division">Division</label>
                        <input type="text" name="division" id="division" class="form-control" required>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <label id="email-label" for="photo">Upload Photo</label>
                        <button type="button" class="btn-upload">Choose File</button>
                        <input type="file" id="fileInputPhoto" class="file-input" style="display:none;">
                        <div id="imgContainer" style="position: relative;">
                            <img id="imgPreview" src="#" alt="Image Preview" style="display:none;">
                            <button class="remove-img" id="removeImg" style="display:none;">&times;</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <label id="email-label" for="description">Description Of Grievance</label>
                        <textarea id="description" class="form-control" required></textarea>
                    </div>
                </div>
            </div>

            <!-- Hidden fields for file upload data -->
            <input type="hidden" id="hidenz">
            <input type="hidden" id="hiddenz">

            <div class="row">
                <div class="col-md-12 text-center">
                    <button type="button" id="btn" class="btn77 w-50">Submit</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
  integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
  crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script src="js/main.js"></script>


</form>





</body>
</html>

