<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Log.aspx.cs" Inherits="Log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
        crossorigin="anonymous" referrerpolicy"no-referrer" />
=

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
       <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">



    <script>
        $(document).ready(function () {


            var formNameMapping = {
                "rqtnwtns": "Requisition For Independent Witness",
                "deputationoder": "Deputation Order Of Witness By Concerned Authority",
                "cmndcertfcte": "Command Certificate",
                "searchwrnt": "Search warrant by ACF",
                "beforesearch": "BEFORE SEARCH",
                "forms3": "Seizure List",
                "aftersearch": "AFTER SEARCH PROTOCOL",
                "pregno": "Property Registration",
                "fircopy": "FIR COPY",
                "forms5": "Arrest Checklist",
                "ckwildlifeofnc": "Checklist For Wildlife Offence",
                "reportingdfo": "Reporting to DFO cum wildlife warden by Range officer regarding registration of case",
                "appointmntinvofcr": "Appointment Of Investing Officer",
                "carcassmemo": "Carcass Inspection Memo",
                "dforprt": "Dfo/Jtf/Other Experts",
                "rqstnfrpmortem": "Requistion From For Post-Mortem Examination",
                "dispsalcarcs": "Disposal Of Carcass",
                "statemntwitns": "Statement Of Witness",
                "statemntacsed": "Statement Of Accused",
                "crimerecrtnmemo": "Crime Scene recreation memo by accused and statements of independent witnesses",
                "szrememospot": "Seizure memo of spot/weapon/trap led to discovery by accused",
                "prlimnarypstmrtmrepo": "Preliminary post mortem report by the concerned veterinary authority",
                "rqsnchemex": "Requisition for chemical examination in concerned scientific lab",
                "exhibitfrdingcncrninsn": "Exhibit forwarding letter by concerned magistrate to Concerned institution such as SFSL/ZSI/WII for chemical/biological/ballistic examination u/s 293 CrPC",
                "exhibtnfrnsicexmn": "Exhibit forwarding letter by concerned magistrate for Forensic Examination for Identification of Species/sex etc by concerned institution such as ZSI/WII.",
                "rqtnmdexm": "Confession statement SEC-77 of OFA 1972",
                "rwtnmdclexmacsd": "Inspection Memo of the accused by Medical officer",
                "acusedfrwding": "Accused Forwarding",
                "finalpmstemrepo": "Final Postmortem Report",
                "crimedtlspotmp": "Crime Details Form along with Spot map",
                "chemicalexrepo": "Chemical Examination Report",
                "frnscexmnrepo": "Forensic Examination Report",
                "rqstntosp": "Requisition to SP for Forensic examination of digital evidence such as photography and videography during seizure/crime scene recreation/ discovery of spot/weapon/trap by accused",
                "sec65b": "Sectin 65B Certificate Compliance by DFSL",
                "cdrepotrqsn": "CDR report requisition letter to RCCF concerned",
                "cdrepo65b": "CDR report along with 65 B certificate by concerned Nodal officer through Superintendent of Police concerned",
                "bailacsed": "Bail Order Of The Accused If Any",
                "casediary": "FOREST DEPARTMENT, ODISHA",
                "cwhrepot": "CWH Report",
                "electricalinsreo": "Electrical Inspector report",
                "revenueinsprepo": "Revenue Inspector Report",
                "characteranteced": "Character Antecedents",
                "corrobortngevd": "Corroborating Evidence-Summary",
                "prosectnrepo": "FOREST DEPARTMENT, ODISHA",
                "cwhrepot2": "Any Other Report"
              
            };
            var allFormNames = Object.keys(formNameMapping); // List of all form keys

            $('#myDropdown').change(function () {
                var selectedCaseNo = $('#myDropdown option:selected').text();

                if (selectedCaseNo) {
                    // Fetch log report data
                    $.ajax({
                        type: "POST",
                        url: "Log.aspx/GetLogReports",
                        data: JSON.stringify({ caseNo: selectedCaseNo }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $('#tablebody').empty();
                            var data = response.d;

                            var fetchedForms = data.map(item => item.FormName);

                            // Populate the table with fetched data
                            for (var i = 0; i < data.length; i++) {
                                var formNameKey = data[i].FormName;
                                var formNameValue = formNameMapping[formNameKey] || formNameKey;

                                var row = `
                            <tr>
                                <td>${i + 1}</td>
                                <td>${formNameValue}</td>
                                <td>${data[i].Name}</td>
                                <td>${data[i].Dates}</td>
                                <td>${data[i].Status}</td>
                                <td>
                                    <button type='button' class="btn btn-primary print-btn" data-id="${i + 1}" onclick="handlePrint( '${formNameKey}', '${selectedCaseNo}');">Print</button>
                                </td>
                            </tr>
                        `;
                                $('#tablebody').append(row);

                                // Attach click event securely using event delegation
                                //$('.print-btn').on('click', function (event) {
                                //    event.preventDefault();  // Prevent default behavior
                                //    event.stopPropagation(); 
                                //    const id = $(this).data('id'); // Retrieve data-id from the button
                                //    handlePrint(id);
                                //});

                                // Define the secure print function
                              
                            }

                            // Calculate pending forms
                            var pendingForms = allFormNames.filter(form => !fetchedForms.includes(form));
                            $('#pendingCount').text(pendingForms.length);
                            $('#completedCount').text(fetchedForms.length);

                            // Display pending forms on button click
                            $('#showPendingForms').off('click').on('click', function () {
                                $('#pendingFormsTable').empty();
                                if (pendingForms.length > 0) {
                                    pendingForms.forEach((formKey, index) => {
                                        var formNameValue = formNameMapping[formKey] || formKey;
                                        var row = `
                                    <tr>
                                        <td>${index + 1}</td>
                                        <td>${formNameValue}</td>
                                    </tr>
                                `;
                                        $('#pendingFormsTable').append(row);
                                    });
                                } else {
                                    $('#pendingFormsTable').html('<tr><td colspan="2">No pending forms</td></tr>');
                                }
                                $('#pendingFormsModal').modal('show'); // Assuming Bootstrap modal
                            });
                        },
                        error: function (err) {
                            console.error("Error fetching log data: ", err);
                        }
                    });
                } else {
                    // Reset table and counts if no case is selected
                    $('#tablebody').empty();
                    $('#completedCount').text(0);
                    $('#pendingCount').text(0);
                }
            });

          

            // Trigger the AJAX call based on dropdown selection
            $('#logCategory').change(function () {
                var selectedCategory = $(this).val(); // Get the selected value (forest or wildlife)
                var url = '';

                // Set the appropriate URL based on the selected category
                if (selectedCategory === 'wildlife') {
                    url = "oldcase.aspx/Getdesp";  // For wildlife
                } else if (selectedCategory === 'forest') {
                    url = "oldcasefo.aspx/Getdesp";  // For forest
                }

                // Make the AJAX call
                $.ajax({
                    type: "POST",
                    url: url,  // Use the dynamic URL
                    data: '{name: "' + $("#hdnbookx").val() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessddlx7,
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            });

            function OnSuccessddlx7(response) {
                $('#myDropdown').html("");
                $('#myDropdown').append('<option value="ND">Choose Case</option>');

                $.each(response, function (index, item) {
                    for (var i in item) {
                        $('#myDropdown').append('<option value="' + item[i].split('*')[0] + '">' + item[i].split('*')[1] + '</option>');
                    }
                });

                $('#myDropdown').select2({
                    placeholder: 'Select an option',
                    allowClear: true
                });
            }



        $('#myDropdown').on('change', function () {
            localStorage.setItem('caseno', $("#myDropdown option:selected").text());

            if ($("#myDropdown option:selected").text() != "Choose Case") {
                $(".loading").show();
                $("#divpnlx").show();
                $("#csdtl").show();
                $("#csdtl").html('');

                $.ajax({
                    type: "POST",
                    url: "oldcase.aspx/Getdespp3",
                    data: '{name: "' + $("#myDropdown option:selected").text() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessddlx3,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

                function OnSuccessddlx3(response) {
                    //$(".addsr").closest('form').find("input[type=text], textarea").val("");
                    //alert("Created Service Successfully");

                    // $('#myDropdown').html("");
                    // $('#myDropdown').append('<option value="ND">Choose Case</option>');

                    $.each(response, function (index, item) {
                        for (var i in item) {
                            $('#csdtl').append('<span>Divison : ' + item[i].split('*')[0] + '</span><span>District : ' + item[i].split('*')[1] + '</span><span>City : ' + item[i].split('*')[2] + '</span><span>Range Officer : ' + item[i].split('*')[3] + '</span><span>Description : ' + item[i].split('*')[4] + '</span><span>Date Of Initiation : ' + item[i].split('*')[5] + '</span>');

                        }

                    });

                    $('#myDropdown').select2({
                        placeholder: 'Select an option',
                        allowClear: true
                    });
                    $(".loading").hide();
                }

            }

            else {
                $("#divpnlx").hide();
                $("#csdtl").hide();
                alert("Please Choose a valid entry");
            }

        });

        });
        function handlePrint(e, y) {
            var x = e + y;
            window.open('https://msksoftware.co.in/forestdoc/'+x+'.pdf', '', `width=${screen.availWidth},height=${screen.availHeight},fullscreen=yes,scrollbars=no,toolbar=no,menubar=no,location=no,status=no,resizable=no`);
        }
    </script>

    <style>
                .col-md-8 {
            background-color: #fff;
            padding: 20px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: auto;
        }

        label {
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
            display: block;
			    color: white;
        }

.form-group {
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
}

        #myDropdown {
            width: 55%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .btn {
            font-size: 14px;
            padding: 8px 15px;
            margin-right: 10px;
            border-radius: 5px;
        }

        .btn-outline-secondary {
            color: #087a9f;
            border: 1px solid #087a9f;
            background-color: transparent;
            transition: all 0.3s ease-in-out;
        }

        .btn-outline-secondary:hover {
            background-color: #087a9f;
            color: #fff;
        }

        .btn-primary {
            background-color: #087a9f;
            border: none;
            transition: all 0.3s ease-in-out;
        }

        .btn-primary:hover {
            background-color: #065d73;
        }

        .input-group {
            display: flex;
            align-items: center;
        }

        .input-group .form-control {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
        }

        .input-group-append button {
            background-color: #087a9f;
            border: none;
            color: #fff;
            padding: 10px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

        .input-group-append button:hover {
            background-color: #065d73;
        }




table {
    width: 85%;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid #ccc;
    margin: 0 auto;
    margin-top: 35px;
}
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background-color: #087a9f;
            color: #fff;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f8ff;
        }
        td {
            font-size: 14px;
            color: #333;
        }
        .status {
            font-weight: bold;
            text-transform: capitalize;
        }
        .status.pending {
            color: #f39c12;
        }
        .status.approved {
            color: #27ae60;
        }
        .status.rejected {
            color: #e74c3c;
        }



                .status-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-direction: column;

        }

        .status-box {
            background-color: #e9f7fe;
            color: #087a9f;
            padding: 10px 20px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 50%;
        }

        .status-box.completed {
            background-color: #eafde4;
            color: #27ae60;
        }
        .selection > span:nth-child(2) span {
    padding: 20px; /* Adjust the value as needed */
}
        .select2-container {
    box-sizing: border-box;
    display: inline-block;
    margin: 0;
    position: relative;
    vertical-align: middle;
    width: 100% !important;
    /* height: 40px; */
}
    </style>

</head>
<body>
    <form id="form1" runat="server">

        
               <aside id="sidebar">
   
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

  



   <section id="content">
       		<nav>
          <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
          <a href="#" class="nav-link"></a>

      </nav>
       <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>

       <main>



        <div>
            <h2 style="text-align: center; padding: 15px;">Log Report</h2>
<div class="row" style="max-width:80%;margin:auto;">
                 <div class="col-md-6" style="padding-left: 25px;">
        <label for="logCategory">Choose Category</label>
        <div class="form-group">
            <select id="logCategory" class="form-control">
                <option value="forest">Forest</option>
                <option value="wildlife">Wildlife</option>
            </select>
        </div>
                     <div class="form-group">     <label for="txtcno">Case No.</label>      <select id="myDropdown"  runat="server">
   
</select></div>
    </div>
                <div class="col-md-6" style="padding-left: 25px;">

       
        <div class="form-group">
         
           
            <div class="input-group" style="display:none;">
                <input type="text" name="caseNo" id="autocomplete" class="form-control" required>
                <div class="input-group-append">
                  
                </div>
            </div>
        </div>


                                                <div class="status-container">
      <div class="status-box">
      Pending Forms: <span id="pendingCount" class="btn btn-danger">0</span>
</div>

            <div class="status-box completed">
                Completed Forms: <span id="completedCount" class="btn btn-info">0</span>
            </div>
        </div>
    </div>
</div>
          


    <table>
        <thead>
            <tr>
                <th>SL No</th>
                <th>Form Name</th>
                <th>Authority Name & Designation</th>
                <th>Time and Date</th>
                <th>Status</th>
                 <th>Print</th>
            </tr>
        </thead>
        <tbody id="tablebody">
           
            
        
        </tbody>
    </table>

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
    <div class="modal fade" id="pendingFormsModal" tabindex="-1" role="dialog" aria-labelledby="pendingFormsModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="pendingFormsModalLabel">Pending Forms</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Form Name</th>
                        </tr>
                    </thead>
                    <tbody id="pendingFormsTable">
                        <!-- Pending forms will be added dynamically -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>