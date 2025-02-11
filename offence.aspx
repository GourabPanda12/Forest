<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Offence.aspx.cs" Inherits="Offence" %>

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
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">

	<title>Compounding Receipt</title>


    <script>

     
        $(function () {

            $('.add1').click(function () {
                var inputValue = $('#txtprpszd').val().trim();
                if (inputValue === '') {
                    alert("Please Enter Particulars Of The Property Seized.");
                    return;
                }
                if ($('#prptySeized').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Data Already Exists.");
                    return;
                }
                $('#prptySeized').append('<div class="input-container"><input type="text" class="form-control console" value="' + inputValue + '"> <span class="close-button">X</span></div>');
                $('#txtprpszd').val('');
            });

            $('.add2').click(function () {
                var inputValue = $('#txtszrplc').val().trim();
                if (inputValue === '') {
                    alert("Please Enter Place of seizure.");
                    return;
                }
                if ($('#plceSzre').find('input[value="' + inputValue + '"]').length > 0) {
                    alert("Data Already Exists.");
                    return;
                }
                $('#plceSzre').append('<div class="input-container"><input type="text" class="form-control console" value="' + inputValue + '"> <span class="close-button">X</span></div>');
                $('#txtszrplc').val('');
            });

            $(document).on('click', '.close-button', function () {
                $(this).closest('.input-container').remove();
            });
        });



    //submit code 

        function sub() {


            // Get form input values
            var no = $("#txtnos").val();
            var fdept = $("#txtfdmnt").val();
            var divsn = $("#txtdvson").val();
            var depot = $("#txtdpt").val();
            var rcvfrm = $("#txtrcvfrm").val();
            var sumrs = $("#txtsumrs").val();
            var prtclrpszd = $("#txtprpszd").val();
            var szrplace = $("#txtszrplc").val();
            var date = $("#txtdt").val();
            var time = $("#txtm").val();
            var theara = $("#txtunk").val();
            var yrdd = $("#txtyr").val();
            var nummber = $("#txtno").val();
            var fdeptmt = $("#txtfdprtmnt").val();
            var divisnd = $("#txtdvsn").val();
            var formi = $("#txtfomni").val();
            var formii = $("#txtfomnii").val();
            var rcvdfrm = $("#txtrcvd").val();
            var sumrswrd = $("#txtsum").val();
            var thrgh = $("#txtdta").val();
            var day = $("#txthrgh").val();
            var twrdsd = $("#txton").val();
            var violtnof = $("#txvlnof").val();
            var byff = $("#txtby").val();
            var cmpndngamnt = $("#txtrsn").val();
            var prtcltpszed = $("#txtprtpszd").val();
            var plceszre = $("#txtszreplc").val();
            var dte = $("#txtdte").val();
            var tme = $("#txtme").val();
            var mnth = $("#txtar").val();
            var year = $("#txtyear").val();


            var departmentlist = [];
            // Create and push user object to users array 
            departmentlist.push({
                no: no,
                fdept: fdept,
                divsn: divsn,
                depot: depot,
                rcvfrm: rcvfrm,
                sumrs: sumrs,
                prtclrpszd: prtclrpszd,
                szrplace: szrplace,
                date: date,
                time: time,
                theara: theara,
                yrdd: yrdd,
                nummber: nummber,
                fdeptmt: fdeptmt,
                divisnd: divisnd,
                formi: formi,
                formii: formii,
                rcvdfrm: rcvdfrm,
                sumrswrd: sumrswrd,
                thrgh: thrgh,
                day: day,
                twrdsd: twrdsd,
                violtnof: violtnof,
                byff: byff,
                cmpndngamnt: cmpndngamnt,
                prtcltpszed: prtcltpszed,
                plceszre: plceszre,
                dte: dte,
                tme: tme,
                mnth: mnth,
                year: year

            });


            $.ajax({
                type: "POST",
                url: "Offence.aspx/Insert",
                data: "{departmentlist:" + JSON.stringify(departmentlist) + "}",
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

    /*button*/


.btnx{

    width: 66%;
    height: 33px;
    background-color:#101357;
    color: #fff;
    border: none;
    letter-spacing: 1px;

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

}
.btny:hover {
    background-color: #08a0e9;
    color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}
.btnz{

    width: 66%;
    height: 33px;
    background-color:#c235dcfc;
    color: #fff;
    border: none;
    letter-spacing: 1px;

}
.btnz:hover {
    background-color: #a61fb2;
    color: #fff;
    box-shadow: 0 0 8px rgba(194, 53, 220, 0.7);
}

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

  

  
</style>
</head>
<body>
     <form id="form1" runat="server">

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


	<section id="content">

		<nav>
			<i class='bx bx-menu'  style="font-size: 30px;color: #fff;font-weight:600;"></i>
         <a href="#" class="nav-link"></a>

		</nav>

    <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>



       <main>
        <div class="container-fluid" style="margin-top: 100px;">

            <div class="row justify-content-center">
              <div class="col-11 col-sm-10 col-md-10 col-lg-11 col-xl-11 text-center p-0 mt-3 mb-2">
                <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                  <div class="text-center">

                    <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
                    <p id="heading1">UNDER SECTION 72 OF THE ORISSA FOREST ACT, 1972 &</p>

                    <p id="heading1">UNDER SECTION 68 OF THE INDIAN FOREST ACT, 1927</p>

                    <p id="heading1"> FORM V </p>
                    <p id="heading1">[Vide Rule 5]</p>

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
										   <div class="col-lg-6  col-sm-6 col-xs-6 abc"> 
											    <label class="lebl"> No </label>
                             <input type="text" id="txtnos"  class="form-control console" placeholder="">	
       					
										  </div>
										     <div class="col-lg-6  col-sm-6 col-xs-6 abc">
												   <label class="lebl">Forest Department  </label>
                             <input type="text" id="txtfdmnt"  class="form-control console" placeholder="">	
										  </div>
										  
										     <div class="col-lg-6  col-sm-6 col-xs-6 abc"> 
												   <label class="lebl">Division  </label>
                             <input type="text" id="txtdvson"  class="form-control console" placeholder="">	
										  </div>
										  
										     <div class="col-lg-6  col-sm-6 col-xs-6 abc">
												   <label class="lebl"> Depot </label>
                             <input type="text" id="txtdpt"  class="form-control console" placeholder="">	
										  </div>
									  </div>
									  
									<br>  
									  
									  <!--

                                    <p style="text-align: center; margin-top: 25px;" class="to34">NO. <input type="number" id="txtnos"
                                        class="inp" placeholder=""></p>
                                    <p style="text-align: center;" class="to34">FOREST DEPARTMENT <input type="text" id="txtfdmnt" class="inp"
                                        placeholder=""></p>
                                    <p style="text-align: center;" class="to34">DIVISION <input type="text" id="txtdvson" class="inp"
                                        placeholder=""></p>

                                        <p style="text-align: center;" class="to34">DEPOT <input type="text" id="txtdpt" class="inp"
                                            placeholder=""></p>

-->

                                    <p  class="to34">
                                      Received from <input type="text" id="txtrcvfrm" class="inp" placeholder="">
                                      the sum of Rupees <input type="number" id="txtsumrs" class="inp" placeholder=""> towards the
                                      probable compensation for compounding the Offence under Section 72 of the Odisha Forest
                                      Act, 1972 without prejudice to an decision that may be taken by the Forest Officer
                                      empowered under Section 72 of the said Act.
                                    </p>

                                    <div class="row mt-2 mb-4">
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                    
                                      <label class="lebl">Particulars Of The Property Seized</label>
                                       <input type="text" id="txtprpszd"  class="form-control console" placeholder="">


                                       <p class="button-container">
                                        <button class="bt11 add1" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                                                                       </p>
                                             <div id="prptySeized"></div>
                                                                                                
                                      </div>

                                         
                                    
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                    
                                      <label class="lebl"> Place of seizure</label>
                                       <input type="text" id="txtszrplc"  class="form-control console" placeholder="">

                                      
                                         <div class="button-container" style="text-align: right;">
                  <button class="bt11 add2" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                    </div>
                                                                                                       
                                                                                                 <div id="plceSzre"></div>
                                      </div>


                                      </div>



                                    <!--

                                    <div class="to34">Particulars of the property seized <input type="text" id="txtprpszd" class="inp" placeholder="">
                                    </div>
                                    <div class="to34"> Place of seizure<input type="text" id="txtszrplc" class="inp" placeholder=""></div><br>
-->



<div class="row mb-4">

  <div class="col-lg-6  col-sm-6 col-xs-6" style="display: hidden;">
    <label class="lebl"></label>
</div>

<div class="col-lg-6  col-sm-6 col-xs-6 ">
  <label class="lebl">Forester-In-Charge Of The Dept</label>
  <input type="text" id=""  class="form-control console" placeholder="">
</div>


</div>


<div class="row">
  <div class="col-lg-6  col-sm-6 col-xs-6 abc">

  <label class="lebl">Date </label>
   <input type="date" id="txtdt"  class="form-control console" placeholder="">
  </div>

<div class="col-lg-6  col-sm-6 col-xs-6 abc">

  <label class="lebl">Time</label>
   <input type="time" id="txtm"  class="form-control console" placeholder="">
  </div>

  </div>





                                   <!--
                                    <div class="row  d-flex">
        
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc1">
                                        <p class="to34">Date <input type="date" id="txtdt" class="inp" placeholder="">Time<input type="time" id="txtm" class="inp" placeholder=""></p>
                                      </div>
        
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc1">
                                        <p style="float: right;" class="to34">Forester-in-charge of the Dept</p>
                                      </div>
                                    </div>
                                    -->

                         <!--
                                    <div class="to34">The <input type="text" id="txtunk" class="inp" placeholder="">
                                      <span>20<input type="text" id="txtyr" class="inp" placeholder=""></span>
                                    </div>

                                    -->

                                    <div class="row">
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                    
                                      <label class="lebl">The</label>
                                       <input type="text" id="txtunk"  class="form-control console" placeholder="">
                                      </div>
                                    
                                    <div class="col-lg-6  col-sm-6 col-xs-6 abc">
                                    
                                      <label class="lebl">20</label>
                                       <input type="text" id="txtyr"  class="form-control console" placeholder="">
                                      </div>
                                      </div>


                                    <br><br><br>
        
                                    <p style="font-style: italic; text-align: center;" class="to34"><u>N.B.- When required this Form may be
                                        in triplicate as Form No.VII. This Form may be utilized for simple receipts</u></p>
                                  </div>
        
                                </div>
                              </div>
                            </div>
                          </div>
        	           </div>
                      </fieldset>
                    </form>




        
                    <div class="text-center">
                      <p id="heading1">ADDITIONAL INFORMATION</p>
                      <h3 id="heading">FOREST DEPARTMENT, ODISHA</h3>
                      <p id="heading1">FORM -V </p>
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


                         <!--
									  <div class="row">
										    <div class="col-lg-4  col-sm-4 col-xs-4 abc"> 
											    <label class="lebl"> No </label>
                             <input type="text" id="txtno"  class="form-control console" placeholder="">	
       					
										  </div>
										  
										    <div class="col-lg-4  col-sm-4 col-xs-4 abc"> 
											    <label class="lebl">Forest Department </label>
                             <input type="text" id="txtfdprtmnt"  class="form-control console" placeholder="">	
       					
										  </div>
										    <div class="col-lg-4  col-sm-4 col-xs-4 abc"> 
											    <label class="lebl"> Division </label>
                             <input type="text" id="txtdvsn"  class="form-control console" placeholder="">	
       					
										  </div>
										  
										 
									  </div>
       
									  
									  
									   <h5 class="text-center"  style="color:#000;">Reference</h5>
									  <div class="row">
										    <div class="col-lg-6  col-sm-6 col-xs-6 abc"> 
												<label class="lebl"> Form -I </label>
                             <input type="text" id="txtfomni"  class="form-control console" placeholder="">	
										  </div>
										   <div class="col-lg-6  col-sm-6 col-xs-6 abc"> 
											   <label class="lebl"> Form -II  </label>
                             <input type="text" id="txtfomnii"  class="form-control console" placeholder="">	
										  </div>
									  </div>
									  
                                   <br>

                                   -->
									  
									  <!--
                                    <p style="text-align: center; margin-top: 25px;" class="to34">NO. <input type="number" id="txtno"
                                        class="inp" placeholder=""></p>
                                    <p style="text-align: center;" class="to34">FOREST DEPARTMENT <input type="text" id="txtfdprtmnt" class="inp"
                                        placeholder=""></p>
                                    <p style="text-align: center;" class="to34">DIVISION <input type="text" id="txtdvsn" class="inp"
                                        placeholder=""></p><br>

 <p class="to34">Form -I <input type="text" id="txtfomni" class="inp" placeholder=""></p>
                                    <p class="to34">Form -II <input type="text" id="txtfomnii" class="inp" placeholder=""></p><br>
                                   
        -->


          <!--
                                    <P class="to34"> DEPOT RECEIVED from <input type="text" id="txtrcvd" class="inp" placeholder=""> the sum of
                                      Rupees <input type="text" id="txtsum" class="inp" placeholder="">(in words) <input
                                        type="text" id="txtdta" class="inp" placeholder=""> through <input type="text" id="txthrgh"
                                        class="inp" placeholder=""> on <input type="text" id="txton" class="inp" placeholder="">
                                      towards the probable compensation for violation of <input type="text" id="txvlnof" class="inp"
                                        placeholder=""> by <input type="text" id="txtby" class="inp" placeholder=""> which has been
                                      subjected to compounding the Offence under Section 72 of the Orissa Forest Act, 1972 /
                                      Section –54 of Wildlife Protection Act 1972 without prejudice to any decision that may
                                      be taken by the Forest Officer empowered under the mentioned provisions of the said Act.
                                    </P>
        
                                    <p class="to34">Reasons for determination of compounding amount <input type="text" id="txtrsn" class="inp"
                                        placeholder=""></p>
                                    <p class="to34">Particulars of the property seized <input type="text" id="txtprtpszd" class="inp" placeholder="">
                                    </p><br>
        
                                    <p class="to34">Place of Seizure <input type="text" id="txtszreplc" class="inp" placeholder=""></p><br>
        
                                    <div class="row  d-flex">
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc1">
                                        <p class="to34">Date <input type="date" id="txtdte" class="inp" placeholder="">Time <input type="time" id="txtme" class="inp" placeholder=""></p>
                                          <p class="to34"></p>
                                      </div>
                                      <div class="col-lg-6  col-sm-6 col-xs-6 abc1">
                                        <p style="float: right;" class="to34">Authorised Forest Officer</p>
                                      </div>
                                    </div>
        
                                    <div class="to34">The <input type="text" id="txtar" class="inp" placeholder="">
                                      <span>20<input type="number" id="txtyear" class="inp" placeholder=""></span>
                                    </div><br>
                                    <p class="to34">N.B.- When required, this Form may be in triplicate as Form No. VII. This Form may be
                                      utilized for simple
                                      receipts.</p>

                                    -->



                                    <p class="to34" style="font-weight: 600; font-size: 18px;">N.B: Strike - off whichever is not
                                      applicable.</p>

                                    <p class="to34">Received By (with Name and signature mentioning date and time)
                                      <input type="file" id="" class="inp" placeholder="">
                                    </p>
        
                                  </div>
                                </div>
                              </div>
                            </div>
							  </div>
							
							  </div>
                      </fieldset>

                        <div class="row " style="margin-top:-31px;">
                      <div class="col-md-10  col-12 mx- auto offset-md-1">
            
            
                        <div class="login-form">

                         
                          <div class="row asd d-flex">

                               <div class="col-lg-4  col-sm-4 col-xs-4 abc">

                             <label class="lebl" style="color:#228B22;">Manually Upload File</label>
            
                             <input id="txtmupld" type="file">
            
                            </div>
            
                            <div class="col-lg-4  col-sm-4 col-xs-4 abc">
							
                             <button class="btnx mt-4" type="button" onclick="sub()" >Submit</button>
            
                            </div>
            
                           
              
                           <div class="col-lg-4  col-sm-4 col-xs-4 abc">
						   
                            <button class="btny mt-4" type="button" onclick="window.location.href='Offencepdf.aspx'">Download Pdf</button>
                              
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

