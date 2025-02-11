<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link rel="icon" type="image/x-icon" href="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/style.css">

	<script>

       

        function sub() {
            // Get form input values
            var firstnm = $("#txtfnm").val().trim();
            var lastnm = $("#txtlnm").val().trim();
            var phone = $("#txtphn").val().trim();
            var email = $("#txteml").val().trim();

            // Validation
            if (firstnm === '' || lastnm === '' || phone === '' || email === '') {
                alert("Please fill in all fields.");
                return;
            }


            // Validate mobile phone number (exactly 10 digits)
            var phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phone)) {
                alert("Please enter a valid 10-digit mobile number.");
                return;
            }

            // Validate email format
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address.");
                return;
            }

            // Create user object
            var userslist = [];
            userslist.push({
                firstnm: firstnm,
                lastnm: lastnm,
                phone: phone,
                email: email
            });

            $.ajax({
                type: "POST",
                url: "signup.aspx/Insert",
                data: "{userslist:" + JSON.stringify(userslist) + "}",
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

.form-wrap{
   margin-top: 50px!important;
   margin-bottom: 60px!important;
	background: rgba(255,255,255,1);
	width: 100%;
	max-width: 830px;
    height: 380px;
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
	background-color: #228B22;
	color: #fff;
	width: 100%;
	height: 40px;

}


	</style>


</head>

<body>

	 <form id="form1" runat="server">




    <div class="container">
        <div class="text-center">
            <h2 class="cri" style="color: #000;">Forest And WildLife Crime</h2>
        
          </div>

        <div class="form-wrap">	
            <form id="survey-form">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label id="name-label" for="name"> First Name</label>
                            <input type="text" name="name" id="txtfnm" placeholder="First Name" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label id="email-label" for="email">Last Name</label>
                            <input type="text" name="email" id="txtlnm" placeholder="Last Name" class="form-control" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label id="name-label" for="name">Phone</label>
                            <input type="number" name="name" id="txtphn" placeholder="Phone" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label id="email-label" for="email">Email</label>
                            <input type="email" name="email" id="txteml" placeholder="Email" class="form-control" required>
                        </div>
                    </div>
                </div>





                <div class="row">
                    <div class="col-md-12">
                        <button type="button" id="txtbtn" onclick="sub()" class="btn77">SignUp</button>
                    </div>

                    <p style="margin-top: 15px;margin-bottom: 1px; text-align: center;">Already have an account ?<a href="index.aspx"> Log In</a></p>


                </div>

            </form>
            </div>

        </div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
  integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
  crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script src="js/main.js"></script>


</form>





</body>
</html>

