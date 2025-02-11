﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="icon" type="image/x-icon" href="">


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/style.css">



 <style>

body{
	background: linear-gradient(9deg, rgb(0, 0, 0, .3), rgb(0, 0, 0, 1)) fixed, url(https://www.drishtiias.com/images/uploads/1703675712_Black%20Tiger.png) fixed;
    background-size: cover;
    background-repeat: no-repeat;
    height: 100%;
	width:100%;
}


		.form-wrap{
   margin-top: 10px!important;
margin-bottom: 120px!important;
	background: rgba(255,255,255,1);
	width: 100%;
	max-width: 430px;
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
	top: -40px;
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
	height: 35px;
}
.btn88{
	font-size: 18px;
	letter-spacing: 2px;
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	-o-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
	border: none;
	
	color: #fff;
	width: 100%;
	height: 35px;
	background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
}
.cri {
    color: #fff;
    letter-spacing: 2px;
    font-size: 25px;
    font-weight: 600;
    text-transform: uppercase;
    padding-top: 0px; 
    /* padding-bottom: 2px; */
}
	</style>

</head>

<body>
 <form id="form1" runat="server">

    <div class="container">

  <div class="text-center mb-5">
	  <img style="    width: 200px;
    margin: 25px;
    border-radius: 60%;
    border: solid 3px #c3f4c3;
    box-shadow: 1px 0px 20px 5px #adb749;" src="https://pics.craiyon.com/2023-07-31/c3d32a1036c84168aa0647dc178ee2e7.webp"/>
    <h2 class="cri">BLACK TIGER</h2>

  </div>

        <div class="form-wrap">
            <form id="survey-form">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label id="name-label" for="name">Name</label>
                            <input type="text" name="name" id="txtusrnm" runat="server" placeholder="Enter your name" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label id="email-label" for="email">Password</label>
                            <input type="password" name="email" id="txtpwd" runat="server" placeholder="Password" class="form-control" required>
                        </div>
                    </div>
                </div>





                <div class="row">
                    <div class="col-md-12">
                        <button type="button" id="login" class="btn77" runat="server" onserverclick="login_ServerClick">Login</button>
                    </div>
					<div class="col-md-12">
                        <button type="button" id="Button2" class="btn88 mt-3" onclick="window.location.href='pblcgrvnce.aspx'">Offence Information</button>
                    </div>

                    <p style="margin-top: 15px;margin-bottom: 1px;">Don't have an account? <a href="signup.aspx">Sign Up</a></p>

                     <a href="">Forgot password?</a>
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


