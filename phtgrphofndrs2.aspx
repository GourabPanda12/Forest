<%@ Page Language="C#" AutoEventWireup="true" CodeFile="phtgrphofndrs2.aspx.cs" Inherits="phtgrphofndrs2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Update jsPDF to version 3.2.1 -->
      <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
     integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
     crossorigin="anonymous" referrerpolicy="no-referrer" />

	<link rel="stylesheet" href="css/styles.css">
 <link rel="stylesheet" href="css/style.css">  
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>>--%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <!-- Custom CSS -->

    <style>
    /* Table Container Styling */
.table-responsive {
    margin: 20px auto;
    overflow-x: auto;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Table Styling */
.table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 8px;
    overflow: hidden;
}

/* Table Header Styling */
.table thead th {
    background-color: #004d40; /* Dark Green */
    color: #ffffff; /* White text */
    text-transform: uppercase;
    font-size: 14px;
    font-weight: bold;
    padding: 12px 8px;
    border: none;
    text-align: center;

}

/* Table Body Styling */
.table tbody tr {
    transition: background-color 0.3s ease;
}

.table tbody tr:nth-child(even) {
    background-color: #f1f8f6; /* Light greenish-gray for alternate rows */
}

.table tbody tr:nth-child(odd) {
    background-color: #ffffff; /* White for odd rows */
}

.table tbody tr:hover {
    background-color: #c8e6c9; /* Light green hover effect */
    cursor: pointer;
}

/* Table Cells */
.table td {
    padding: 10px 8px;
    text-align: center;
    font-size: 14px;
    color: #333333; /* Dark gray text */
    border: 1px solid #e0e0e0; /* Light gray borders */
}

/* Images */
.table img {
    max-width: 60px;
    max-height: 60px;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Action Buttons */
.table .action-buttons a {
    text-decoration: none;
    padding: 6px 12px;
    background-color: #00796b; /* Teal Green */
    color: #ffffff;
    border-radius: 4px;
    font-size: 12px;
    transition: all 0.3s ease;
}

.table .action-buttons a:hover {
    background-color: #004d40; /* Darker Green */
}

/* Table Footer or Submit Date Styling */
.table tfoot td {
    background-color: #004d40; /* Footer styling */
    color: #ffffff;
    font-weight: bold;
    text-align: center;
    padding: 10px;
}

/* Responsive Table Adjustments */
@media (max-width: 768px) {
    .table th, 
    .table td {
        font-size: 12px;
        padding: 6px;
    }

    .table img {
        max-width: 40px;
        max-height: 40px;
    }
}

</style>

       <script>
           $(document).ready(function () {
               // Perform AJAX call to fetch data when page loads
               $.ajax({
                   type: "POST",
                   url: 'phtgrphofndrs2.aspx/GetOffenderData',
                   contentType: 'application/json',
                   dataType: 'json',
                   success: function (response) {
                       console.log('Data fetched successfully:', response);

                       // Empty the table before populating with new data
                       $('#submissionTableBody').empty();

                       // Iterate over the response data and append rows to the table
                       $.each(response.d, function (index, item) {
                           const formattedDOB = item.DOB ? new Date(item.DOB).toLocaleDateString('en-GB') : 'N/A'; // Format DOB

                           // Create the row with dynamic data
                           const row = `<tr>
                <td>${index + 1}</td>
                <td>${item.ChooseOne}</td>
                <td>${item.CaseNo}</td>
                <td>${item.Name}</td>
                <td>${item.Aliases}</td>
                <td>${formattedDOB}</td>
                <td>${item.PlaceOfBirth}</td>
                <td>${item.Sex}</td>
                <td>${item.Hair}</td>
                <td>${item.EyeColor}</td>
                <td>${item.Complexion}</td>
                <td>${item.Height}</td>
                <td>${item.Weight}</td>
                <td>${item.Citizenship}</td>
                <td>${item.PhoneNumber}</td>
                <td>${item.Email}</td>
                <td>${item.Passport}</td>
                <td>${item.BankAccount}</td>
                <td>${item.Adhaar}</td>
                <td>${item.Occupation}</td>
                <td>${item.Associates}</td>
                <td>${item.CrimeHistory}</td>
                <td>${item.ModusOperandi}</td>
                <td>${item.AreaActivities}</td>
                <td>${item.Acquittals}</td>
                <td>${item.ProclaimedOffenderDetails}</td>
                <td>${item.OtherRemarks}</td>
                
                <!-- Display signature and photo as clickable links -->
                <td>${item.SignaturePath ? `<a href="${item.SignaturePath}" target="_blank"><img src="${item.SignaturePath}" alt="Offender Image" width="50" height="50" /></a>` : 'No Image'}</td>
                <td>${item.ImagePath ? `<a href="${item.ImagePath}" target="_blank"><img src="${item.ImagePath}" alt="Offender Image" width="50" height="50" /></a>` : 'No Image'}</td>
                
                <td>${item.SubmissionDate}</td>
                <td><button type="button" class="btn btn-info btn-sm" onclick="generatePDF(${index}, '${item.SignaturePath64}', '${item.ImagePath64}')">Print</button></td>
            </tr>`;
                           // Append the row to the table body
                           $('#submissionTableBody').append(row);
                       });
                   },
                   error: function (error) {
                       console.log('Error fetching data:', error);
                   }
               });
           });


           function generatePDF(index,f,s) {
               const row = $('#submissionTableBody tr').eq(index);

               const data = {
                   ChooseOne: row.find('td').eq(1).text(),
                   CaseNo: row.find('td').eq(2).text(),
                   Name: row.find('td').eq(3).text(),
                   Aliases: row.find('td').eq(4).text(),
                   Dob: row.find('td').eq(5).text(),
                   PlaceOfBirth: row.find('td').eq(6).text(),
                   Sex: row.find('td').eq(7).text(),
                   Hair: row.find('td').eq(8).text(),
                   EyeColor: row.find('td').eq(9).text(),
                   Complexion: row.find('td').eq(10).text(),
                   Height: row.find('td').eq(11).text(),
                   Weight: row.find('td').eq(12).text(),
                   Citizenship: row.find('td').eq(13).text(),
                   PhoneNumber: row.find('td').eq(14).text(),
                   Email: row.find('td').eq(15).text(),
                   Passport: row.find('td').eq(16).text(),
                   BankAccount: row.find('td').eq(17).text(),
                   Adhaar: row.find('td').eq(18).text(),
                   Occupation: row.find('td').eq(19).text(),
                   Associates: row.find('td').eq(20).text(),
                   CrimeHistory: row.find('td').eq(21).text(),
                   ModusOperandi: row.find('td').eq(22).text(),
                   AreaActivities: row.find('td').eq(23).text(),
                   Acquittals: row.find('td').eq(24).text(),
                   ProclaimedOffenderDetails: row.find('td').eq(25).text(),
                   OtherRemarks: row.find('td').eq(26).text(),
                 
                   submissionDate: row.find('td').eq(29).text()
               };

               const { jsPDF } = window.jspdf;
               const doc = new jsPDF();

               // Add Title
               doc.setFont("times", "bold");
               doc.setFontSize(14);
               doc.text("Personal File (Dossier) of Offender", 100, 10, { align: "center" });
               doc.setFontSize(10);

               const Image = f;
               // Add a placeholder for the photograph
               doc.setFont("times", "normal");
               doc.text("Photograph", 90, 30); // Position the text within the rectangle
               doc.rect(85, 20, 40, 40); // Draw a rectangle (x, y, width, height)
               doc.addImage(Image, 'JPEG', 86, 21, 37, 37);



               // Prepare data for autoTable
               const tableData = Object.entries(data).map(([key, value]) => [
                   key.replace(/([A-Z])/g, " $1").trim(), // Format label (convert camelCase to readable)
                   value || "N/A", // Add value or default to "N/A"
               ]);

               // Add the table using autoTable
               doc.autoTable({
                //   head: [["Field", "Value"]], // Table header
                   body: tableData,           // Table content
                   startY: 70,                // Start Y position
                   styles: {
                       font: "times",
                       fontSize: 12,
                       textColor: 0,
                       cellPadding: 6,
                       lineWidth: 0.2,          // Thicker border
                       lineColor: [0, 0, 0],    // Black border
                   },
                   headStyles: {
                       fillColor: [255, 255, 255], // Light gray header
                       textColor: 0,              // Black text
                       fontStyle: "bold",
                       lineWidth: 0.2,            // Thicker border for header
                   },
                   alternateRowStyles: {
                       fillColor: [255, 255, 255], // Light background for alternate rows
                   },
               });

               // Add images below the table
               let finalY = doc.lastAutoTable.finalY + 10; // Get the last position of the table

               // Signature Image
               doc.setFont("times", "bold");
               doc.setFontSize(12);
               doc.text("Signature Image:", 10, finalY);
               doc.setFontSize(10);
               doc.setLineWidth(0.5);
               doc.line(10, finalY + 2, 200, finalY + 2); // Draw a separator line
               finalY += 10; // Add space below the separator

               const signatureImage = row.find('td').eq(27).find('img').attr('src');
               if (signatureImage) {
                   doc.addImage(s, "JPEG", 10, finalY, 50, 50);
                   finalY += 60; // Adjust vertical space for the next image
               } else {
                   doc.text("No signature image provided.", 10, finalY);
                   finalY += 10;
               }



               // Save the PDF
               doc.save("Offender_Report.pdf");
           }
       </script>
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
          <div class="container mt-5">
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped">
                    <thead>
                        <tr>
                            <th>Sl No.</th>
                          
                            <th>Choose One</th>
                            <th>Case No</th>
                            <th>Name</th>
                            <th>Aliases</th>
                            <th>DOB</th>
                            <th>Place of Birth</th>
                            <th>Sex</th>
                            <th>Hair</th>
                            <th>Eye Color</th>
                            <th>Complexion</th>
                            <th>Height</th>
                            <th>Weight</th>
                            <th>Citizenship</th>
                            <th>Phone Number</th>
                            <th>Email</th>
                            <th>Passport</th>
                            <th>Bank Account</th>
                            <th>Adhaar</th>
                            <th>Occupation</th>
                            <th>Associates</th>
                            <th>Crime History</th>
                            <th>Modus Operandi</th>
                            <th>Area Activities</th>
                            <th>Acquittals</th>
                            <th>Proclaimed Offender Details</th>
                            <th>Other Remarks</th>
                            <th>Signature</th>
                            <th>Image</th>
                           <th>Submit Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="submissionTableBody">
                        <!-- Data will be dynamically added here -->
                    </tbody>
                </table>
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
