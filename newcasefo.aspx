<%@ Page Language="C#" AutoEventWireup="true" CodeFile="newcasefo.aspx.cs" Inherits="newcasefo" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Case Form</title>
    <link rel="icon" type="image/x-icon" href="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/style.css">

	<script>

        $(function () {

 $.ajax({
                    type: "POST",
                    url: "newcasefo.aspx/Getdesp",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessddlx,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

                function OnSuccessddlx(response) {
                    //$(".addsr").closest('form').find("input[type=text], textarea").val("");
                    //alert("Created Service Successfully");

                    $('#myDropdown').html("");
                    $('#myDropdown').append('<option value="ND">Choose Dist</option>');

                    $.each(response, function (index, item) {
                        for (var i in item) {
                            $('#myDropdown').append('<option value="' + item[i].split('*')[0] + '">' + item[i].split('*')[1] + '</option>');

                        }

                    });
					
					
                }
			
			
			 $('#myDropdown').on('change', function () {

               $.ajax({
                    type: "POST",
                    url: "newcasefo.aspx/Getdesp1",
                    data: '{name: "' + $("#myDropdown option:selected").val() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessddlx1,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

                function OnSuccessddlx1(response) {
                    //$(".addsr").closest('form').find("input[type=text], textarea").val(""); $("#myDropdown option:selected").text();
                    //alert("Created Service Successfully");

                    $('#myDropdown1').html("");
                    $('#myDropdown1').append('<option value="ND">Choose Divison</option>');

                    $.each(response, function (index, item) {
                        for (var i in item) {
                            $('#myDropdown1').append('<option value="' + item[i].split('*')[0] + '">' + item[i].split('*')[1] + '</option>');

                        }

                    });
					
					
                }
            });
        //    $.ajax({
        //        type: "POST",
        //        url: "newcasefo.aspx/autofillid",
        //        data: '{}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: OnSuccessf,
        //        failure: function (response) {
        //            alert(response.d);
        //        }
            });
        //    function OnSuccessf(response) {
        //        $('#txtcno').val(response.d);

        //        var currentDate = new Date();

        //        // Get the current year
        //        var currentYear = currentDate.getFullYear().toString().slice(-2);

        //        // Calculate the next year and get the last two digits
        //        var nextYear = (currentDate.getFullYear() + 1).toString().slice(-2);

        //        // Get the current month (0-11) and format it to three-letter abbreviation
        //        var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        //        var currentMonth = monthNames[currentDate.getMonth()].toUpperCase();

        //        // Display the current year and month
        //        $("#txtcno").val("OFD" + "/" + currentYear+"-"+ nextYear + "/" + currentMonth + "/" + response.d);
        //        $('#txtcno').css("background-color", "#8097a2");
        //        $('#txtcno').css("border", "1px solid #571A99");
        //        $('#txtcno').css("color", "white");


        //    }

        //});




        function sub() {
            // Get form input values  $("#ddltyp option:selected").text()
            var caseno = $("#txtcno").val();
            var date = $("#txtdt").val();
            var div = $("#myDropdown1 option:selected").text();
            var dist = $("#myDropdown option:selected").text();
            var city = $("#txtcity").val();
            var rangeofcr = $("#txtrngofcr").val();
            var remark = $("#txtremark").val();

            // Validate each field
            if (!caseno) {
                alert("Case number is required");
                return;
            }
            if (!date) {
                alert("Date is required");
                return;
            }
            if (!div) {
                alert("Division is required");
                return;
            }
            if (!dist) {
                alert("District is required");
                return;
            }
            if (!city) {
                alert("City is required");
                return;
            }
            if (!rangeofcr) {
                alert("Range of crime is required");
                return;
            }
            if (!remark) {
                alert("Remark is required");
                return;
            }

            // Create a caselist array with the form data
            var caselist = [{
                caseno: caseno,
                date: date,
                div: div,
                dist: dist,
                city: city,
                rangeofcr: rangeofcr,
                remark: remark
            }];

            $.ajax({
                type: "POST",
                url: "newcasefo.aspx/Insert",
                data: JSON.stringify({ caselist: caselist }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("Record Submitted Successfully!");
                    window.location.reload();
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
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

.form-wrap {
    margin-top: 50px !important;
    margin-bottom: 60px !important;
    background: rgba(255, 255, 255, 1);
    width: 100%;
    max-width: 830px;
    height:800px;
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
	color:#000;
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
	width: 100%;
	height: 35px;
	background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
}

        .btn78 {
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
           background: linear-gradient(to bottom right, rgb(2, 0, 36), rgb(11 93 9));
        }
        .btn79 {
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
           background: linear-gradient(to bottom left, rgb(2, 0, 36), red);

        }

	</style>


</head>

<body>

	 <form id="form1" runat="server">




    <div class="container">
        <div class="text-center">
            <h2 class="cri" style="color: #000;">New Case Form</h2>
        
          </div>

        <div class="form-wrap">	
            <div class="form" id="survey-form">
                <div class="row">
                  <div class="col-md-12">
                        <div class="form-group">
                            <label  for="name">Case No.</label>
                            <input type="text" name="name" id="txtcno"   class="form-control" required>
                        </div>
                    </div>
                   

                     <div class="col-md-12">
                        <div class="form-group">
                            <label  for="name">Date</label>
                            <input type="date" name="name" id="txtdt" class="form-control" required>

                        </div>
                    </div>
                </div>

                <div class="row">
                    

                     <div class="col-md-12">
                        <div class="form-group">
                            <label  for="name">District</label>
							 <select id="myDropdown" style="width: 100%;" class="form-control" runat="server">
       
    </select>
                          

                        </div>
                    </div>

                  <div class="col-md-12">
                           <div class="form-group">
                            <label for="name">Divison</label>
                           <select id="myDropdown1" style="width: 100%;" class="form-control" runat="server">
       
    </select>

                        </div>
    
                        </div>
                     <div class="col-md-12">
                           <div class="form-group">
                            <label for="name">Range Office</label>
                            <input type="text" name="name" id="txtcity" class="form-control" required>

                        </div>
    
                        </div>
                     
                   <div class="col-md-12">
                        <div class="form-group">
                            <label>Range Officer</label>
                            <input type="text" name="name" id="txtrngofcr" class="form-control" required>

                        </div>
                    </div>
                 
                    <div class="col-md-12">
                        <div class="form-group">
                            <label  for="name">Remark</label>
                            <input type="text" name="name" id="txtremark" class="form-control" required>

                        </div>
                    </div>
                 
                    
                </div>
                 <div class="row">
                     <div class="col-md-4">
                        <div class="form-group">
                            <button type="button" id=""  class="btn78">Refresh</button>

                        </div>
                    </div>

                     <div class="col-md-4">
                        <div class="form-group">
                            <button type="button"  onclick="sub()" class="btn77">Save</button>

                        </div>
                    </div>

                      
                      <div class="col-md-4">
                        <div class="form-group">
                           
   <a  class="btn79" style="padding:7.5px;" href="srchwildlife.aspx"> <i class="fa fa-sign-out"></i></a>
                        </div>
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


