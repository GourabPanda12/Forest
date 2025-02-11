<%@ Page Language="C#" AutoEventWireup="true" CodeFile="courtdiry2.aspx.cs" Inherits="courtdiry2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>

     <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

	<link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/style.css">  

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Update jsPDF to version 3.2.1 -->
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>>--%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <!-- jQuery Library -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<style>
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
    white-space:nowrap;
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



        $.ajax({
            type: "POST",
            url: "courtdiry2.aspx/GetCaseDetails", // WebMethod URL
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                const data = response.d; // The returned JSON array
                window.caseDetails = data; // Store data globally for access in generatePDF
                const tableBody = $("#caseDetailsTable tbody");
                tableBody.empty(); // Clear existing rows

                // Loop through the data and append rows to the table
                data.forEach((item, index) => {
                    const row = `
                        <tr>
                            <td>${item.Id}</td>
                            <td>${item.CourtName}</td>
                            <td>${item.At}</td>
                            <td>${item.ForestRangeDivision}</td>
                            <td>${item.District}</td>
                            <td>${item.State}</td>
                            <td>${item.CourtCaseNo}</td>
                            <td>${item.DateOfFiling}</td>
                            <td>${item.CourtDiaryNo}</td>
                            <td>${item.SectionsInvoked}</td>
                            <td>${item.PreviousDate}</td>
                            <td>${item.AccusedDetails}</td>
                            <td>${item.RelativeDetails}</td>
                            <td>${item.AccusedAddress}</td>
                            <td>${item.PinCode}</td>
                            <td>${item.SummonStage}</td>
                            <td>${item.BailStage}</td>
                            <td>${item.PreCharge}</td>
                            <td>${item.PleadGuilty}</td>
                            <td>${item.PostCharge}</td>
                            <td>${item.ProsEvidence}</td>
                            <td>${item.DefenceWitness}</td>
                            <td>${item.Statement}</td>
                            <td>${item.Argument}</td>
                            <td>${item.WitnessType}</td>
                            <td>${item.NameOfWitness}</td>
                            <td>${item.SummonedOrAppeared}</td>
                            <td>${item.FullySupported}</td>
                            <td>${item.PartlySupported}</td>
                            <td>${item.BecameHostile}</td>
                            <td>${item.ReasonsNotExamined}</td>
                            <td>${item.ProceedingsBrief}</td>
                            <td>${item.RemediesSuggested}</td>
                            <td>${item.OfficerNameRank}</td>
                            <td>${item.RangeDivision}</td>
                            <td>${item.DcfDfoComments}</td>
                            <td>${item.SubmissionDate}</td>
                            <td>${item.SignaturePath ? `<a href="${item.SignaturePath}" target="_blank"><img src="${item.SignaturePath}" alt="Signature Image" width="50" height="50" /></a>` : 'No Signature'}</td>
                            <td>${item.ImagePath ? `<a href="${item.ImagePath}" target="_blank"><img src="${item.ImagePath}" alt="Offender Image" width="50" height="50" /></a>` : 'No Image'}</td>
                            <td><button type="button" class="btn btn-info btn-sm" onclick="generatePDF(${index})">Print</button></td>
                        </tr>`;
                    console.log(item.SummonedOrAppeared);
                    tableBody.append(row);
                });
            },
            error: function (xhr, status, error) {
                console.error("Error fetching data: " + error);
            }
        });





    });

    function generatePDF(index) {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const img = new Image();
        img.src = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gAfQ29tcHJlc3NlZCBieSBqcGVnLXJlY29tcHJlc3P/2wCEAAQEBAQEBAQEBAQGBgUGBggHBwcHCAwJCQkJCQwTDA4MDA4MExEUEA8QFBEeFxUVFx4iHRsdIiolJSo0MjRERFwBBAQEBAQEBAQEBAYGBQYGCAcHBwcIDAkJCQkJDBMMDgwMDgwTERQQDxAUER4XFRUXHiIdGx0iKiUlKjQyNEREXP/CABEIAgACAAMBIgACEQEDEQH/xAAdAAEBAQACAwEBAAAAAAAAAAAACQgGBwECBQQD/9oACAEBAAAAAN/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA6+zB1T8UAAAAAB9rtnT/PgAAcLm1l30AAAAAAB7ajpTzAAA6gkXxQAAAAAAAcrrx22ABwuMHFAAAAAAAAcrtRysAEpstAAAAAAAANVVUADr6InqHb3Z/kAAAAAHr1j1CHvb3nwAw/OEKSbaAAAAAAGJZthSDbwAmTjcdvWgAAAAAABF/qEbJpqAJYZQGraogAAAAAAlblMavqeAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAAAlflEauqgAJX5RGrqoAAAAAHXnAO7vqAlflEauqgAJX5RGrqoAAAAAeJyYe8cjrv3IEr8ojV1UABK/KI1dVAAAAACeWDhoGvoSvyiNXVQAEr8ojV1UAAAAAYQngHYluglflEauqgAJX5RGrqoAAAABi6afgNt0jCV+URq6qAAlflEauqgAAAAMmy3/mHe9ff1BK/KI1dVAASvyiNXVQAAAAMyyk/MHcNhvrglflEauqgAJX5RGrqoAAAAOgJH/gDs+xnIwJX5RGrqoACV+URq6qAAAAHS0gvjhz2x3MwEr8ojV1UABK/KI1dVAAAAHVUeeOBy+x3YIBK/KI1dVAASvyiNXVQAAADr2OXEA5FYbtYASvyiNXVQAEr8ojV1UAAABw2OHAg+vX7ukAJX5RGrqoACV+URq6qAAABx2OXWAfvrboIAEr8ojV1UABK/KI1dVAAAB8aPfTwfoqzp0ACV+URq6qAAlflEauqgD4nS3ZXOgB+eQHRAe9RtagAJX5RGrqoACV+URq6qAZ9k58b3oFvkB/CSmcw80t2gAASvyiNXVQAEr8ojV1UAiH16KL7nB4lRlkFDt4AACV+URq6qAAlflEauqgPWAvqPNM9lDxMDIIN20RAACV+URq6qAAlflEauqgEfegw/pU3VrxN7EYNo0s8gABK/KI1dVAASvyiNXVQDhUbuDh+msGlZ84HBrWpHkAAEr8ojV1UABK/KI1dVAHW0ceMB9DXWNQabrGAAAlflEauqgAJX5RGrqoAdPx6+MAGgq7f2AAASvyiNXVQAEr8ojV1UAHQcjPwAHdtgPogAAEr8ojV1UABK/KI1dVAAzJKP+AHbNivtgAACV+URq6qAAlflEauqgAMiS+9Q7HsZysAAAJX5RGrqoACV+URq6qAAYgnAOb2L54AAACV+URq6qAAlflEauqgADCs9/wAfZtZOzQAAAJX5RGrqoACV+URq6qAAHyeJ9g+QAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABK/KI1dVAAAAAAAEr8ojV1UABLDKA1bVEAAAAAAErspDV9TwBMnG47etAAAAAAACL3UQ2TTUAYim8FI9tgAAAAADEc3QpBt4AdfRE9Q7d7Q8gAAAAA8dX9RB7W57DACVGWAAAAAAAAGp6rgA4lFnigAAAAAAAOWWj5eAB1LIfiYAAAAAAA5XXHuIAA4pNfK/oAAAAAAD21LSnlwAAOAZh6n+IAAAAAA+32zpvsEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//xAAUAQEAAAAAAAAAAAAAAAAAAAAA/9oACAECEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/EAE8QAAAEAwMIBQkDCgQEBwAAAAECAwQFBgcACLIRGCA3ZYWU0iEwMUFCEhQiMkBQUVJhEzRxEBUjJDNDY4Ghw0R0kZIXJYCzNWSCo7HBwv/aAAgBAQABPwD/AKSp0rHTSnYKIzPNTRF4XtZIiLh3/NJIDCW0wX4YA1E6MqSS9e/Bd+4I1D/YmCtn99qpy4iDCAS60T+qK6x/6qhbPKrFsLgTc9s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8qsew+BHntnlVj2HwI89s8usWwuBNz2YX2amoGD84QCXHZPoguif/UFRtLl+OALnInNckvmXcKzBwR0H+xQErSTWSmtQvISliami7wwfclhFu7/kkqBRN7HP1SJRprBhjM1xQjZMcoINyem5cnDwIp+IbVQvWT7O53EMlpY8uQEREoJtT/rqxfiquGEljnOqc6ihzHOcwmMYw5RER7REfdZDmTMU5DCU5RASmAcggId4WpZesnyRToQ6Y1TzJAgyFFN0p+uIk/hLjhPantR5QqZBvzzKcUK4IXIVduf0HDU4+BVPtAfYKz1ngVH4CR06KDyOPCmCGw4DAAnEO1VT5Ui2nOdpkn+PO5jmmIndvlx6O5NFPuSSJ4CF93yZOsySBHmkxyvETtHyA/imqn3pKk7DkNaitaoFWCAnctylZxxkUgRKHCbKJBH96l8yRuuqRP0GpnKMUmuMmAxG5fIQbgOQ7lyf1ESfjadpzj0/zJEppmN2K752fLk8CKYeokkHhIQOwPeMlTlHZBmSGzRLroUXrQ/Z4Fkh9dJQO8hwtTmf4NU2UYZNcDUyJOC+Q4QEcqjZwT10T/UvW3rKpHnqfVpchzgRgUuHO1TAB9BZ52LqjgD3ndPqkpJE+IyvEXOSBTIoRscDj0IvexBUMA9ZWOdP+HtNZqmdI4EdoNBRY/5twIJJD/IR8qxznUOZRQwmOYRMYxhyiIj2iOlJ1B6rz0gk9gMoOvMFOkjt2JGiBg+JBWEonD6lsW5vWMQ7IHxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8lszWsew+OHktma1j2Hxw8ljXN6xlARyQPjh5LTjQeq8ioKvY9KDrzBPpO7aCR2gUPicURMJA+ptIhzpHIqmcxDkMBimKOQQEOkBAbUcnf/AIg01lWaFlAM7XaAi9+jtAfslf8AcYMvV34ZhM1l+SZTSU+/PnEQXD6NSAmTHpXbLtcMYwyHT/UGGkdRJ0Qi8NhrgmVJqkPSRVYg9qo+6byl22Gv4bEqgU/hpGsSakM4iUNbkyJOkg6TrIkDsVDSuOzELqXp2lNY4iDF83iCIfR0QUz/ANUurvtPxXqdAGHgaS6gP/rWXV0aDychPVV5QgL1IFGHnQu3ZB7DINCCsJB+hxKBfddd5OQkSq03wBkkCbDzoHbQgdhUHZAWAgfQnlCXRuSvxQqbMEO8DuXFjfidFdLq75WuLcTHEfRubAA1jKOxHw4Pdd8gACsZx2IxHHo3NNcW4n2InV3ytce42OI+jc11x7jfYie675WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE913ytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7rvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET3XfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuKb62UskVZRpMk5MUXhPXaoeU6XKPwOmgBxJZpezog6XBE8zOW4CPrrMHIEwDaXptlia2ARGV44xijXsFRosVUCD8DgHSUfoOnfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuARAoCYwgBQDKIj2AFrwl5x9FXbySqaxMyEKREUn0XbmEFXZ+wSIH8KOOwiJhExhEREcoiP5JWm6ZJJi7eOytF3EPfoj0KImyAcvyKF7DkHvKNqD1mZVglc7tVJNtMEOEiMUak9XKb1Fk/4amlfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432InuC85eM/Ogv6bSE+yMAEUYvEUR/bj3tkR+T5x0bsc3uJTrDK5CKiDSMq/mh0TuODroT/wBFQLpXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7febvGeaA/prIL7IuIChGIkiPqfM1RHGOlSJmu/qnTlq2ARUGZIYf8AAqbgpzD/ACANK+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPbrzF4oJYSe08kR8AxxQopROIIj9xIPail/HwWEREREREREcoiOlc1pk6i00L1JiLYQhkIIq3YGP2LPVS+QYS/RIg6V8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYie23k7wqMgs15Jk50U81OUsjlcnSENSP/fNZVVVdVRddQyiqhhOc5xExjGMOURER7RHSoXRGMVfj/pgq0llioUYk/8A7CPxVNaAwGEStB2ECgjJJnDmSIIoIJBkKQof/Ij2iI9IjpXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ7ZeIr+0pfDjy3LS6S84PEfockPSP2LHD5x8BbO3bqIOnL584UcOnCp1VllTCdRRQ45TGMYekREdKjVHo3V2Yyw9p5bWDNRKeJxES5Sopj4CfFU/hC0ryxApJgEPlqWmJGkNZJ+QkQvaYfEc4+I5h6RHTvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET2uv1d4dSOC/m2GGSdTc/SEWbbtK2IP+IWDAHitFIpEY3EXsXi7xV2/eLGWcOFjeUdRQ45RMI6VKKVTDVmZ0YDBSCk1TyKRB+coik0Q+YficfAW0jSVLtPJbYyxLLQEGTYPSOPSquqPrKqm8RzdRfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432IntVca2Qij8Ayk+zdTI9TMENYf31vgkW0fj8YmiMxCPx5+o8iT1YVV11B6TGH+gAHYAB0AGlTinUw1OmZpLUvIekb03Tk4D9i1Q8Sqlqc06l2l0stZZl1D0Sem5dHAPtnK49qqn1Hqb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE9prJV+A0hlsYi+ArmLOQMSGQ0DZDuFA8Z/gkTxDabJrjs7R+ITLMb4zqIvFPKOcegpQ7iEL4SFDoANKRZGmGokyMZXlpmKz1wOUxx6EkEg9ZVU3hIW1KaWS7SOWEYHByAq7VyKP35igCrtfkDwF6q+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPaKqVTl6kssLR6NHBV2p5ScPYEMAKul/lD4FDxmtPM8TDUOZH0zzK8Fd44HIUgZQSQSD1Ukg8JC6UqSpHZ2j8OlqXGRnUReKARMgdBSh3nOPhIUOkRtRuj0BpFLZYe08lzFnQEPE4gJch11Q8JfgkTwl6u+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPZ6i1Clyl8sOpmmNxkIT0GzYgh9s7XH1UkwtUeo0xVPmZ1Mkwr+kb0GrYgj9i1QDsST0oBAYvNEYh8AgLFV5EnqwIoIJBlExh/oAB2iI9ABahtEYPSCAfpfsncyPkyjEn39hH4JF6y+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPZp4naXadS2+miZnYItGxchCB0qrqj6qSRfEc1qr1UmCrEzKxyMHFFollTh7AhhFJohzj4z6UMhkQjURZQmEs1XT92sVFBBEvlHUUOOQCgFqBUIh9JIOERiYJOpufpADxyHSVqmP+HQHGbrb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE9lmmaoHJkBiMyTG+IzhjJPy1VDesYfCQgeI5h6AC1ZawxyrsyGiLzy20HaickMhwGylQTHxn+Kp/EOk0aOn7psxYt1HDpwqRJFFIonUUUOOQpSlDpERHsC13agDWmUPJMsyIprze8R+hyQ9I/aimPeoPjP118rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYiacyznKMkMwezXMTCFpH9QXKwEOpk7kyescfwCy97Wh6K4okmR2sUP3qcOc+RgAbSfWCmk+qEbytODF27MGUGpxMg5H8ElgIcerj8fg8rweIR+PP0mcNZJCquuqPQUof1ER7AAOkRtXSt8Xq/H/Q+1aSyxUMENYCP/AL63xVNpJJKrqpoopmUVUMBCEIAmMYxhyAAAHaI2u3Xek5AaoTtOLQh5qcpZWrY/SENSP/fHr75WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0rw1eEKRwhCGQYqTia4kkJmiR+lNqj2C4VDAFo/MMcmmKOY3MUVcRCIuDZVF3BxOYfoHwKHcAdAfkTUURUTWRUMRQhgMQ5REDFMHSAgIdgha7jecdrPGUh1Lif2oLCVGGRhc3pgfuRcnwqdTEolD4PDXsWirxJnD2iJlnDhYwFImmQMoiI2vAV4iFWYwMNhZlWsosFR8zbdhnJw/xCwYQ0gAREAAMoja7Nd1LLCTOok+Mg/PahQVhcPWD7kQexZUB/f4PYL5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0qqzo5qBUGaJpXVE6Tp6oVoHcRokPkIlD8CBo3Yrxvn4MKbT8/wD1wABCDxNc37b4NlhHx/IbTdOmzBq5fPnCaDZukdVZVUwEImmQMpjGEegAAO0bXi7wTqp8RPLUtrKISezW+pDxBUnYsoHyB4Cad2O7p5oVhUufWH6foXgsMXD1O8rpYMBfYb5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0YgiqvD3yCHQoo3UIT6GMUQCxyGTMYhyiUxREBAe0BDRKIlEDFEQEBygIdoDa7NeLCa0mdPZ6e5I8kUE4a/VH7+QOxJT+Pj0VFE0U1FllCkTIUTHOcQApSlDKIiI9gBa8leFUnt04kmTXYllZurkcuSdAxJUn9gNO7Nd1/OfmFSJ9Y/qACC0HhqwfeB7nKwD+6+QPYr5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE0rx9OHNPKlxgCICEHjKykShyng8lY2VRL8Uj6SKyrdVJdBU6SyRynTUIYSmIYo5QMUQ7BC12y8OlUBohJc3uiJzY1SyILm6AiSRP74eIPyiIAAiI5AC15i8UMxneU7kR7kghBFOKRBEfvxw7UUhD9xj07tN3YZtVaz/PDIQl1E4HhzFUPv6hfGf8AgY7FKUhQKUAAoAAAAdAAAexXytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJpVNpnLtUpXcy1HkcnaozdkD9M0X7lCDiC1QqfTFTSZnssTG28hdL00Fy/sXKA+qqkPeUdJm8dw522fsHKjd23VIsiskYSKJqEHKUxRDpAQG13a8E0qhDSS3MiySE3s0fT7CkfpE7Vkw+cPGT8l5u8T5yL+m0hvv0ACZCMRJEfX7jNURxjp3b7va1RHqM4Ta2OlKLRX9GkboGJKk8AfwQ8Y2QRRbIotm6JEkEiFTTTIUCkIQoZAKUA6AAA7A9jvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ETTrBSaX6tywrB4qAIRFDylIbEALlUbLDiTN4y2nGT4/IkwxGWJlZC2iDQ+QwdpFCD6qiZvEQ/aA6UKisSgcSZRiEPVWj9msVZuuibyTpqEHKAgNp3vezHM1OmMtwtkeGzE6SOhGYikIAUU/8AyveQVdO7xQB7VSKFjseSVbyexWAFj+od8qX9wiOM9mLFnDGTWHQ5qk2ZtkiIoIIlAiaaZAyFKUA7AAPZL5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE6iuFFYPV+XhRHyGsxMiGGGP/7KvxSPaYZejEqxqIS/H2CjOJMlRSXQU7QEO8B7yiHSAh0CHWUGoZE6tRrzt6CrWVGCoefOw6BWN2+boD8+G0JhULl6FMYLBWSTOHMkSoN0ES5CEIXuD/7H2W+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsROpr/QeHVagov4WRJrNrBIfMnPYVyTt82WHCPhG0UhcQgsRewmLM1Wj9osZFwgsXyTpqEHIICHVURotGqwTCDdPy2kvsjlGJxDJ6gdySXxVPaW5dgspwOHy9AGCbKFsUgTQRJiMPeYR6REekR9mvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ETqrxt31CpkOUmeWUEkZvZI/QhYiiTsRP8AxA8BrOmrlk5cM3iCiDlBQySySpRIdM5ByGKYo9ICA9odRSCkcfq5MycHhgChDUBKpEogJcqbZEcShvAW0oShAZClyHyvLTMGzBoTIHedQ4+soobxHOPaPs98rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYidXeYu7knZs6nuS2YBMzdPK9aJh/4ikT++WxyHTOZNQolOURKYohkEBDtAdKl9MJjqtMyEvQFLyEwyKPXpwEUWiHec/1+UtpCkKXKbS0ylaWmv2bZH01ljZBVcrD6yqo95ze0Xytce42OI+jc11x7jfYidXfK1x7jY4j6NzXXHuN9iJ1l567p+dyPqkyGw/5kQBWi8OQL95DvcogH735w0afSBMVSplZyxLbby11fTWWN+xbIB6yyo9xQtTKmkvUslltLsBSym6FHjs4ACzpfvUP/APkvcHtN8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYidbeDusuYq9ezvTFmQXK4is/gpMhPLP3rNeSz+Hv4U7Xh8TZLtHiJhIqg4TMkqQwdximABAfyU6pFPNT36bWWYOoLPywBeIrgKbNAO8TKd4h8pco2pNSeXqSy0SDQgv271fyVIjEDkAFXSoYSF8BPar5WuPcbHEfRua649xvsROrvla49xscR9G5rrj3G+xE66YZSlOZ0wSmWWoXFQAMhfPmqS4l/ATgIhZpRikcPXBy2pzAAVAQMAnYpKYwGyKCDZJNu2RIkimUCkTTKBSlAOwAAOgA9rvla49xscR9G5rrj3G+xE6u+Vrj3GxxH0bmuuPcb7ET3XfK1x7jY4j6NzXXHuN9iJ1d8rXHuNjiPo3Ndce432Inuu+Vrj3GxxH0bmuuPcb7ETq75WuPcbHEfRua649xvsRPdd8rXHuNjiPo3Ndce432InV3ytce42OI+jc11x7jfYie675WuPcbHEfRua649xvsROrvla4txMcR9G5sIBWMobEfBg913yRAaxmDYjEMejc01xbifYidXfaYGQqdAH/gdy6iX8Torq6NB5xQkWq0oR56qCbDzoWjs49hUHZBRE4/QgmA3uuu84oT3Vabo+yVBRj50DRocOw6DQgIgcPofyRNo3JYedepswRDwNJdWJ+B1l0urvxy4dxAJJmtIn3J84YLD9HRAUJg0rtl5SGPYZDpAqFEiNYi1IVCGxNyfIk5SDoIkscexULdvSHui8leShjCFxGntPoiR1EXJDNolEkDAKTZIeg6KRw7VTaVx6Xhay9O01rE+/PkGCA/RoQVD/1V6usMkBUGmk1ywgmB3a7QVmX+bbj9ql/qJfJsch0znTUKJTlESmKYMggIdoCGlJ1dqqyKgkygM3OfMUwACNHYEdoEAO4gLAbyA+hbFvkVjAAATQTgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57Z5VY9h8CPPbPKrHsPgR57GvkVjEO2B8CPPacq71WntBVlH5vdeYKBkOzaARogYPgcEQL5YfQ2kQh1DkTTIJjnEClKUMoiI9gAFqPSYFPaaSrK5yAR2g0BZ7/AJpcRVVD+RjZOsvW0tPI0+qzJDW4hApkOd0mJfVRedq6Q4w953U6WnnaekpoiTfLApbUI5MJw9Fd72oJBjN1tSKfQepcnxOUowUCJrk8tuuAZTtnJP2axPqFp2kuPU/mSIytMbQUHzQ/b4Fkx9RVIfEQ/vGSJLj1QJlhsrS41FZ67UABHwIpB66qo9xCWp3IcFppKUMlKBF/Qti+W4cCAAdy4P66x/qbrq00VgNYYEVq6ODOOMwOMOiIEARTEf3SnzJGtOkkTLT+PO5cmmGqNHqI9Aj0pLJ9yqR+w5B93yXJMyz/AB5pLkrQ07t6sPT3Jop96ip+whAtRijECpBATtWxivI48KQYlERLkFQQ7E0/lSL7BUGnUo1JgZ4HNkMK4S6TILk9Bw3U+dE/hG1Ubp8+SUq4iMqpKTJAgymAzYn66iHwUR8f4ksomdI50lSGIoQwlMUwCAlEOgQEB7BD3WQhlDFIQomOYQApQDKIiPcFqV3Up7no6ESmVJSW4EIgIndJ/rqxf4SA4j2kGnco00gpILKUMI2R6BXcG9Ny6UDxrKdpvY52o3TWoP2q00yqzWdnD76iAt3X81UhATWmO45L7g51ZUnZ8x+CL9uR2H+9MUrP7ktTUBEYfH5ddp/VZdE//aG2ZpWLYXHG5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmtY9h8cPJbM1rHsPjh5LZmlYthccbktDrktTVxAYhH5daJ/RZdY//aC0uXHJebnIrNc7Pn3eKLBAjQP96gq2kyjtNqegmpK8qtEHZQ++rALh3/JVUTCX/pL/AP/EABQRAQAAAAAAAAAAAAAAAAAAAKD/2gAIAQIBAT8AAB//xAAUEQEAAAAAAAAAAAAAAAAAAACg/9oACAEDAQE/AAAf/9k=';
        const imgx = new Image();
        imgx.src = 'data: image / jpeg; base64, /9j/4AAQSkZJRgABAQAAAQABAAD / 4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb / 2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD / 2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD / wAARCAIAAgADASIAAhEBAxEB / 8QAHgABAAMAAwEBAQEAAAAAAAAAAAgJCgQFBwIGAwH / xABEEAABBAEDAwIDBAcECQQDAQABAAIDBAUGBxEIEiEJEzFBURQiYXEVIzJCUmKBFzNzkRYlQ4KSk6GiwSRTcoM0Y7Gy / 8QAFAEBAAAAAAAAAAAAAAAAAAAAAP / EABQRAQAAAAAAAAAAAAAAAAAAAAD / 2gAMAwEAAhEDEQA / ALPUREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERARdLqrW2jNC485fW2rcLp + iOebOVvxVIvHx + /I4D/qo4bh + px0d7fPkrM3Il1Pbi55g09Rktg8fSY9sB / pIglSirK1t62WmYHyQ7cbFZO8089lnN5eOqR9CYYWS8 / l7gXhmrvWI6o8697NNYXRWmof3DXx0tmYfm6aVzD / RgQXUIs / eo / UT6ztUOd9u31y9Vrvg3G1KtHtH0BgiYf8AM8rzrNdTHUZqIn9Ob9bhXWu / cl1LcLB + Tfc7R / QINJKLMTkNd63y3P6V1lnLnd8ftGRmk5 / 4nFdTNcuWOfftTSc + D3yE8 / 5oNRiLLjFZswcexYkj4PI7Xkef6LtqOt9aYtwfjNX5uo4fAwZCWMj / AIXBBp4RZtMP1J9ROniP0HvxuFRDf3INTXWNP5tEnB / qF6Rpv1Fes / S / a2jvplrTG / FuSp1L3cPoTPE539eeUGgNFSppT1huqfBuazUOJ0TqOLwHm1jJa8p / J0ErGg / mw / kvc9Fetlp2b24dxdicjT4IEljC5eOzyPmRFMyPj8vcP5oLOEUU9Aep70c689qGbcaxpi3LxxW1Bjpa3b / 8pmB8A / rIpIaS11ojX + OGY0LrDCaionj / ANTir8VuLz / NG4hB3iIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIvEN / es3p76bopK + 4muIX5oM748DjGi3kZPHI5iaeIgfk6VzGn5FB7evyu4e622m0uIOe3L11hNNUeD2SZK4yEykfFsbSe6R38rQT + CqT369X3enXMljD7K4aroHDuLmNuyNZdykrfhz3PHtQ8j5NY5wPwf81BvVmstXa9zc + pdb6nyufy1n + 9u5K3JZnePkC95J4HyHwCC3beH1jtk9JyTY3aHR + Y11aZyG3bDjjKBPyLTIx0zuPoYmc / I / SFG63qjdW25ck9fFaxq6JxkvIFTTlUQyBvy5syd84d + LXtB + gUSEQdpqPVOp9Y5STN6u1HlM5kZv7y5krklmd / 5vkJcf811aIgIiICIiAiIgIiICIiAiIgLscBqTUWlMlHmdL57I4fIQnmO3QtPrzM / J7CHD + hXXIgljtV6n3Vxtk + Kve1xX1pjo + AampawsuI + f / qGFk5P / AMpCOfkfKmxs / wCslsxqcV8dvDovM6Kuv4bJep / 6yoA / Nx7Q2dgP8Ijfx9frTsiDTNtzuztnu7hhqDbLXWF1LQ4HfJjrbJTET8GyMB7o3fyvAP4L9YswWmNWap0TmYNRaN1Jk8FlKx5hu463JWnjP4PYQ4f5qcOwfq8b26AdWwu8mKq7g4ZnDHXPu1MrE34c + 40e3LwPk9gc4 / F4 + KC5xF4XsD1rdO / UfHDV0DriGvnZW8uwGWAqZFp45IbGSWzcDyTE54HzIXuiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIi67UWo8BpHCXNS6pzVLEYnHRGe3duzthggjHxc97iA0fmUHYryXf / AKp9k + mjCjKbpauiq254y + liKo9 / IXeP / bhB5DeRx3vLWA + C4KBvVn6ukj3XNDdLMPY0d0M + r71fyfkfsdd48f4ko + vDB4cqy9Sam1FrLOXNTatzt / M5bISGW1evWHTzzPPzc9xJP + aCZ3Ur6rG9 + 7r7OntqTLtzph / dH3U5u / K2mHxy + yAPZ5HB7Ye0jyC9wUI7Vqzesy3LtiWxYne6SWWV5e + R5PJc5x8kk + SSv5ogIiICIiAiL1nbXpO6kd3hBLt / szqfI1LHHtXpKZq03g / SzP2Rf9yDyZFP3QPo19QmfEVjXutdI6Tgfx3xRyS5C1H9eWMa2I / 0lKkNoz0W9k8Z7cmu91NYZ + RnBc2hFXx0Tz + LXNmdx + TwfxQU + Ir7tL + mV0XaY7JP7I / 0tOz / AG2Uy1yx3fnH7oj / AOxeoYLpS6ZNNBv6F6f9voHt + ErtO1ZJf + N7C7 / qgzgotOWN280BhgG4jQ2n6IHwFbGQRf8A + Whd3BVq1W9latFC36RsDR / 0QZckWo6etWtN7LNeOVv0ewOH / VdJkdvdA5hhjy + h9P3mn4ts4yGUH / iaUGYxFo + zvSl0yala4Znp / wBvp3O + MrdO1Y5f + NjA7 / qvL9U + mV0Xaoa539kYxM7vhNi8tcrlv5M90x / 9iChFFcHrT0XNk8oHyaD3T1fp + V / wbfir5GFh / BrWwv4 / N5P4qPO4Ho19Qen / AHLGgda6S1bXZz2xSSS460 / 6cMeHRD + sqCASL1vc3pK6k9nhLLuDs1qXHVYeTJehq / a6bQPrYgL4h / Vy8kQEREBERB9wTz1Z47NWaSGaF4fHJG4tcxwPIII8gg / NTY6bvVW302gNTTu5pO42mIiGE35i3K14 / h + rtHn3OPjxMHE8AB7QoSIg0bdP / VVsn1L4QZTa / V0Ni7FGJLmGt8QZGn8v1kBJJbyQO9hcwnwHFeuLL / pzUuodH5upqXSmcv4fLUJBLVvUbD4J4Xj95j2EEH8irM + kv1c3x / Y9C9U0Je0dsMGr6Nf7w + QNyuwef8SIc / Dlh8uQWmouu05qTT + r8HT1NpXN0cvicjEJ6l6lO2aCeM / BzHtJBH5LsUBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERARFCXrh9SHSXTxHd222udU1HuN2mOYk + 5SwhI + M5B / WTD5Qg + Pi8jw1we39TnVxtH0r6Y / S + vMr9pzNuJzsVp + m8Ou3nDwCG / 7OLn4yu4aOCB3O4aaUOqHrO3k6qc2ZdZZX9G6brymTH6boSObSr8fsvf8AOeXj / aP + p7QwHtXkmuNdaw3K1TkNa681FdzmcykpltXbcnfI8 / ID5NaBwA1oDWgAAAABdEgIiICIiAikH06dC3UJ1KyQZHSOlTidNSO + 9qLM91akW8 + TF4L5z8R + ra4A + HFvxVoHT56VvTvtAK2Z13WfuRqKLh5my8IZj4nj / wBumCWuH + K6T6jhBUlsv0s7 + dQNhrNrNtsplafd2SZORgrUIyPiHWZS2Pkfwgl30BU99mvRcriKHJ7 + bpSOkIDn4nS7A0NPx4dbnaefoQ2IfPh3zVoFOnUx9WGjQqw1q1dgjihhYGMjYBwGtaPAAHyC / qg8Y2o6NumbZaOB2hNoMDFer8FuTvwfbr3cP3hPP3vYT8eGFo + gC9nREBERAREQEREBERAREQEREBeNbs9HfTTvZ70 + 4G0WCs35ue7JU4jSulx / eM8BY9 / B88PLh + C9lRBV3vJ6Lld4nyewm6bo3eXR4nU8fc368NtwN5H0AdCfly75qA28 / S1v30 / 2Xx7pbbZXF0w / 248pGwWMfKSfHbZj7o + T / CSHfUBaPV / G7SpZKpNj8jUhtVbDDHNBNGHxyMI4LXNPggj5FBlzRXh9QXpW9O27zLOY0HUftxqKUOc2bERB2Okf8vcpkhrR / gmP6nlVfdRvQv1BdNEs2Q1dpc5bTTHcM1Fh + 6xS7efHu + A + A / D + 8a0E + Gl3xQR9REQEREHvPS51m7w9KmdE + jsl + k9NWpRJktN3pHGnZ + Rez5wS8fCRn0HcHgdqut6YurraPqq0y7LaCybquZpxtdlMBdc1t2iT47u0HiSIn4SN5aeQD2u5aM7K77QuvdZbZaqoa20DqO7g85jJPdq3aknY9h + YPyc0jw5rgWuBIIIJCDToihN0Oeo / pXqLbU233PFLTm4rWBkHa7sp5sgeTByf1c3zMJJ5 + LCRy1s2UBERAREQEREBERAREQEREBERAREQEREBERAREQERVZeo16jDpXZPp / 6fc / xGO + pqTUtKXy4 / B9Oq9vy + IklB8 + WtPHcSH6D1APUwGlZcjsl045uOTMs76uc1RWcHNou + D69Nw8GYeQ6UeGfBv3 / vMqdnnntTyWrU0k00zzJJJI4uc9xPJcSfJJPklfCICIiAiKdvRt6X2ut6vsO4O9Tb2kNESBs9en2 + 3k8tGfILGuH6iIjz7jx3OHHa3gh4CKeyuwW7HUJqpukNqNI2sxbb2vszjiOrTjJ49yeZ3DI2 / Hjk8njhoJ8K2jpe9KbaDaSOnqjeQ1twdVx9sorzRkYim8eeGQO82CPP3pR2nwRG0jlTA212u2 + 2e0nV0RtppShp / C1B9ytUj473cAGSR55dI88Dl7yXH5lfqUHxBBBVgjrVoWQwwsEcccbQ1rGgcBoA8AAeOF9oiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgL5mhisRPr2ImSxSNLHse0Oa5pHBBB + II + S + kQQX6pPSo2j3f + 16r2dfV2 + 1XIDIa8MP8Aqi4 / +eBo5rk + PvRDtHkmNxPKqX3r2B3Y6e9VP0jutpG3iLJLjVskd9S6wH + 8gmH3ZG + RzweW88ODT4WlBfltytrtv94dJ29D7l6VoZ / C3B9 + taj57HccCSN44dG8cnh7CHD5FBmWRTt6yPS91zsnHe3C2Xde1fomLuns0yzvyeKjHkl7Wj9fEB / tGAOaP2m8AvMEkBERB917FipYitVZ5IZ4XtkjkjcWvY8HkOaR5BB8ghWyen / 6l41dNjdkeozMxx5p / ZVweqLDw1t53wZXtuPgTHwGynw / wHcP + 8 + phEGpJFVr6c3qNTyT4vp + 6gc739 / ZT03qW3J97u + DKdt7vjz4bHKfPPDXc8gi0pAREQEREBERAREQEREBERAREQEREBERARFCT1IOuJnTvpQ7Xbb5Jh3F1HWJM8bgThKbuR9oP0mf5EbflwXn4NDg8r9TD1AH6Ybk + nDZPM9uYka6rqnOVZPNJpHDqUDwfEpHiR4 / YBLB98u7KnF9zzz2p5LNmZ8s0ry + SR7i5z3E8kknyST818ICIiAuw09p3PatzlHTOmMPcyuWyUza9OlThdLNPK48BrGNBJK7XbfbfWu7etMZt / t7gLOYzuWlEVatCP8Aie9x8MY0cuc9xAaASSryOinoS0N0o4BubyP2bP7h5CDsyOaMf3KrXftVqgd5ZGPgX + HSccngcMaHkXRD6YWmtqIsfufv / Qp5 / Wg7bFPCu7ZqGHd8Wl48tnsD6 + Y2H9nuID1YEiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgKAHW / 6YenN3G390NgqdLAa1d3WLuGHbDRzL / iXN + Da85 / i8Mef2u0kvU / 0QZftR6cz + kM7e0xqnD28VlsZO6tcpW4jFNBK08FrmnyCuuV93Wt0JaF6rNPSZrHNq4HcTHwduOzYj4ZaDR92tbDRy + M / AP4Lo / iOR3MdRvuTtrrfaLWeS2 / 3D0 / Zw2dxUvt2K04 + Xxa9jh4exw4LXtJDgQQUH5lERAVs3poeoBNq39HdOe92b78zGxtfS + ctSfevNA4bSncfjMB4jefLwO0 / fDe + plf0r2LFSxFbqTyQzwvbJFLG4tex4PIc0jyCCOQQg1HIoTenB1xN6i9KHbHcjIxjcbTlYO995DTm6TeB9oH / AO5vgSNHx5Dx4Lg2bKAiIgIiICIiAiIgIiICIiAiIgIi67UeosJpHAZHVOpcnBjsTiKst27bnd2xwQRtLnvcfoACUHknV31OaZ6V9ob2vMr7NvNWu6lp / Fudw69dLfu8geREwffe75NHAPc5oOfbXeudVbl6wy2vdbZibKZzOWn27tqY + ZHu + QA8NaBw1rRwGtAAAAAXrXWX1QZ3qp3jvaznfYr6bxxfR03jpDwKtIO / bc34CWUjvefPkhvJDGrwhAREQF + l23241nu3rXF7e7f4OfLZ3MTCGtWiH9XPe74MY0cuc88BoBJ8BdVp3Tuc1dnsfpfTOKs5LLZWzHUpU67C + WeZ7g1rGgfEkkK93oS6KcB0o6GORzbK2R3Dz8DDmsiwBzarPDhSru + UbTwXO / 2jhyfAYGh3PRl0ZaI6TNEiCBtfLa2y0Lf07nezy8 / H7PBz5ZA0 / AeC8jud + 61sjERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQFHXrL6M9D9WmiPs1oQYnWmJiecFnRH96M + T9nn4HL4HH4j4sJ7m + eQ6RSIMyW5G3Gs9pNbZXb3cDBz4nO4acwWa8o / q17HDw9jmkOa4chzSCPivzSvu67eirT / VZoQ5DCQ1aG4mBgccJknANFpg5caU7vnG489rj / duPI8F4dRFqPTud0jnshpfU + Ks4zLYqzJUu07LCyWCZji1zHA / AghB1yIiDvtBa71VtlrLEa + 0Rl5sZnMHaZbpWoj5Y9vyI + DmuBLXNPhzXEEEEhaCOkXqd0z1VbR0te4lsVPM1SKWfxbX8mjdDQXAc + TE8ffY75tPB + 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';


        // Get the specific case details
        const item = window.caseDetails[index];

        let y = 20; // Initial Y position
        const lineHeight = 10; // Space between lines

        // Title
        doc.setFontSize(16);
        doc.text('Case Details', 10, y);
        y += lineHeight;

        // Adding case details one by one
        doc.setFontSize(12);
       /* doc.text(`ID: ${item.Id || 'N/A'}`, 10, y); y += lineHeight;*/

        doc.text(`(i). Name of Court:`, 10, y);
        doc.text(`${item.CourtName || 'N/A'}`, 47, y);
        doc.line(45, y + 1, 120, y + 1); // Underline for the CourtName

    

        doc.text(`At:`, 125, y);
        doc.text(`${item.At || 'N/A'}`, 132, y);
        doc.line(130, y + 1, 190, y + 1); // Underline for the "At" field

        y += lineHeight;

        doc.text(`(ii).Forest Range Division:`, 10, y);
        doc.text(`${item.ForestRangeDivision || 'N/A'}`, 60, y);
        doc.line(58, y + 1, 95, y + 1); // Underline for Forest Range Division

        doc.text(`District:`, 98, y);
        doc.text(`${item.District || 'N/A'}`, 115, y);
        doc.line(112, y + 1, 150, y + 1); // Underline for District

       

        doc.text(`State:`, 152, y);
        doc.text(`${item.State || 'N/A'}`, 165, y);
        doc.line(163, y + 1, 190, y + 1); // Underline for State

        y += lineHeight;

        doc.text(`(iii).Court Case No:`, 10, y);
        doc.text(`${item.CourtCaseNo || 'N/A'}`,55,y)
        doc.line(50, y + 1, 190, y + 1);

        y += lineHeight;


        doc.text(`(iv).Date of Filing of Complaint:`, 10, y);
        doc.text(`${item.DateOfFiling || 'N/A'}`, 72, y);
        doc.line(70, y + 1, 100, y + 1);

        doc.text(`Court Diary No: `, 103, y);
        doc.text(`${item.CourtDiaryNo || 'N/A'}`, 135, y)
        doc.line(133,y+1,190,y+1)
        y += lineHeight;




        doc.text(`(v).Sections Invoked under WL.P. Act:`, 10, y);
        doc.text(`${item.SectionsInvoked || 'N/A'}`, 83, y);
        doc.line(81, y + 1, 130, y + 1);
       
        doc.text(`Previous Date:`,132,y)
        doc.text(` ${item.PreviousDate || 'N/A'}`, 160, y);
        doc.line(148, y + 1, 190, y + 1);


          y += lineHeight;
        doc.text(`(vii).Name(s) & Address (s) of Accused(s):`, 10, y);
        doc.text(` ${item.AccusedDetails || 'N/A'}`, 92, y);
        doc.line(90, y + 1, 190, y + 1);

        y += lineHeight;
        doc.text(`(viii).Son/Daughter/Wife of:`, 10, y);
        doc.text(`${item.RelativeDetails}`, 64, y);
        doc.line(62,y+1,190,y+1)

        y += lineHeight;

        doc.text(`(ix).Address:`, 10, y);
        doc.text(`${item.AccusedAddress}`, 35, y);
        doc.line(33, y + 1, 140, y + 1);

        doc.text(`Pin:`, 142, y);
        doc.text(`${item.PinCode}`, 150, y);
        doc.line(149, y + 1, 190,y+1);

        y += lineHeight;
        doc.text(`(x).Prosecution Status in Court(tick ):`, 10, y);
        y += lineHeight;
        doc.text(`Trial Stage:`, 10, y);
     
      
        function addTickOrCross(label, value, xPosition, yPosition) {
            // Ensure value is interpreted correctly as a string ("True" or "False")
            const booleanValue = value === "True";  // Compare the string 'True'

            // Choose the correct image based on the string value
            const image = booleanValue ? img : imgx;  // If value is "True", use tick image; if "False", use cross image

            // Add the image with a bit of spacing, adjust if needed
            const imgWidth = 5;  // Adjust image width if needed
            const imgHeight = 5; // Adjust image height if needed
            doc.addImage(image.src, 'JPEG', xPosition, yPosition, imgWidth, imgHeight);

            // Add label text next to the image, adjusting text position if needed
            const labelOffsetX = 10;  // Horizontal offset for the label
            const labelOffsetY = 3;   // Vertical offset for the label
            doc.text(label, xPosition + imgWidth + labelOffsetX, yPosition + labelOffsetY);
        }




        // Adding case details and tick/cross for true/false values
        doc.setFontSize(12);

        doc.text(' Summon Stage:', 40, y);
        addTickOrCross('', item.SummonStage, 75, y-4); // Pass the boolean value of SummonStage
       

      
        doc.text(' Bail Stage:', 85, y);
        addTickOrCross('', item.BailStage, 112, y-4); // Pass the boolean value of BailStage
        
        
        doc.text(' PreCharge:', 125, y);
        addTickOrCross('', item.PreCharge, 150, y-4); // Pass the boolean value of PreCharge
     
        y += lineHeight;
        doc.text(' Plead Guilty:', 40, y);
        addTickOrCross('', item.PleadGuilty, 75, y-4); // Pass the boolean value of PleadGuilty

       
        doc.text(' PostCharge:', 85, y);
        addTickOrCross('', item.PostCharge, 112, y - 4); // Pass the boolean value of PostCharge

     
        doc.text(' Pros Evidence:', 125, y);
        addTickOrCross('', item.ProsEvidence, 160, y - 4); // Pass the boolean value of ProsEvidence

        y += lineHeight;
        doc.text(' Defence Witness:', 40, y);
        addTickOrCross('', item.DefenceWitness, 75, y - 4); // Pass the boolean value of DefenceWitness

      
        doc.text(' Statement:', 85, y);
        addTickOrCross('', item.Statement, 112, y - 4); // Pass the boolean value of Statement

     
        doc.text(' Argument:', 125, y);
        addTickOrCross('', item.Argument, 150, y - 4); // Pass the boolean value of Argument

        y += lineHeight;

        doc.text(" (xi).Performance of the witness during trial:",10,y)

        // Add a title for the table
        y += lineHeight;
        doc.setFontSize(10);
        // Text for the title of the table
       

        // Initialize the table headers with two-line support
        const headers = [
            ["Type of ", "Witness"],
            ["Name of ", "Witnesses"],
            ["Summoned or", "Appeared"],
            ["Fully", "Supported"],
            ["Partly", "Supported"],
            ["Became", "Hostile"],
            ["If Not Examined", "Then Reasons"]
        ];
    
        const columnWidths = [28, 28, 28, 23, 23, 23, 37];
        const totalWidth = columnWidths.reduce((a, b) => a + b, 0);
        const headerBoxHeight = 15; // Height of the header box
        const cellHeight = 10; // Height of each cell
        const tableStartX = 10; // Starting X position for the table

        // Use `let` instead of `const` for tableY so that we can modify its value
        let tableY = y; // Starting Y position for the table

        // Define the table data (rows)
        const tableData = [
            [
                (item.WitnessType || "N/A").trim(),
                (item.NameOfWitness || "N/A").trim(),
                (item.SummonedOrAppeared || "N/A").trim(),
                (item.FullySupported || "N/A").trim(),
                (item.PartlySupported || "N/A").trim(),
                (item.BecameHostile || "N/A").trim(),
                (item.ReasonsNotExamined || "N/A").trim(),
            ],
          
        ];


        // Calculate the total height of the table
        const tableHeight = (headerBoxHeight + tableData.length * cellHeight)-4;

        // Start drawing the rectangle for the table
        doc.rect(tableStartX, tableY - 6, totalWidth, tableHeight);

        // Draw the table headers
        let currentX = tableStartX;
        headers.forEach((header, index) => {
            const xPosition = tableStartX + columnWidths.slice(0, index).reduce((a, b) => a + b, 0);
            header.forEach((line, lineIndex) => {
                const textY = tableY + (headerBoxHeight / 2) - (header.length * 2) + (lineIndex * 5);
                doc.text(line, xPosition + 2, textY);
            });
            currentX += columnWidths[index];
        });
        doc.setFontSize(10);
        // Advance the Y position after headers
        tableY += headerBoxHeight;
        var totht = 0;
        // Draw the data rows
        tableData.forEach((row) => {
         
            let currentX1 = tableStartX;
            row.forEach((cell, cellIndex) => {
                const cellWidth = columnWidths[cellIndex];
                const textWidth = doc.getTextWidth(cell);
                const textX = currentX1;
                const textY = tableY + 6;
                doc.text(cell, textX, textY, { maxWidth: cellWidth, align: 'justify' });
                const textDimensions = doc.getTextDimensions(cell, { maxWidth: textWidth, align: 'justify' });

                // Calculate the height spanned
                const lineHeight = textDimensions.h; // Height of one line of text
                const totalHeight = Math.ceil(textDimensions.h / doc.getLineHeightFactor());

                if (totalHeight > totht) {
                    totht = totalHeight; // Update max height
                 //   longestSentenceCell = cell; // Update the longest sentence cell
                }

                //doc.text(cell, , );
              //  doc.rect(currentX, tableY, cellWidth, cellHeight); // Draw cell box
                currentX1 += (textWidth + 10)/3 + 15;
                console.log(currentX1);
             //   totht += totalHeight;
            });
            tableY += totht; // Move to next row
        });
        console.log();
        y = tableY+10;
        doc.setFontSize(12);
        // Your initial text
        doc.text("(xii). Brief description of proceedings including cause of hostile witness & if any adjournment :-", 10, y);

        // Increment Y position after the header text
        y += lineHeight;

        // Split the text into lines that fit within 190 units
        const maxWidth = 180;
        const splitText = doc.splitTextToSize(item.ProceedingsBrief || 'N/A', maxWidth);

        // Add the split text to the document
        let currentY = y; // Start Y position for the text

        // Loop through each line of the split text
        splitText.forEach((line) => {
            // Check if the current Y position exceeds 285
            if (currentY > 285) {
                doc.addPage(); // Add a new page
                currentY = 10; // Reset the Y position at the top of the new page
            }

            // Draw each line of the wrapped text
            doc.text(line, 20, currentY); // Position text at (20, currentY)
            currentY += lineHeight; // Move to the next line
        });

        // Update the global y after the description text block
        y = currentY; // Update y position after the description text block

        // (xiv). Pairvi (Case) officer’s name & rank
        doc.text("(xiv). Pairvi (Case) officer’s name & rank:", 10, y);
        doc.text(`${item.OfficerNameRank || 'N/A'}`, 88, y);
        doc.line(86, y + 1, 190, y + 1);
        y += lineHeight; // Increment y after this section

        // Range/Division
        doc.text("Range/Division.:", 10, y);
        doc.text(`${item.RangeDivision || 'N/A'}`, 50, y);
        doc.line(45, y + 1, 190, y + 1);
        y += lineHeight; // Increment y after this section

        // DCF/DFO comments
        doc.text("DCF/DFO comments:", 10, y);
        y += lineHeight; // Increment y after the label

        // Define maxWidth for splitting text

        // Split the DCF/DFO comments into lines that fit within the maxWidth
        const dcfComments = item.DcfDfoComments || 'N/A';
        const splitComments = doc.splitTextToSize(dcfComments, maxWidth);

        // Start rendering the split comments
        splitComments.forEach((line) => {
            // Check if the current y position exceeds 285
            if (y > 285) {
                doc.addPage(); // Add a new page
                y = 10; // Reset y to start near the top of the new page
            }

            // Render each line of the split comments
            doc.text(line, 20, y); // Start the text at X = 40
            y += lineHeight; // Move to the next line
        });

    
        // Adding Signature Image Section
        if (item.SignaturePath) {
            y += lineHeight; // Increment y position to provide space for the signature

            // Check for page overflow before adding the label
            if (y > 285) {
                doc.addPage(); // Add a new page
                y = 10; // Reset y to start near the top of the new page
            }
            doc.text("Signature Image:", 10, y); // Add label
            y += lineHeight; // Increment y to position the image below the label

            // Check for page overflow before adding the image
            if (y + 20 > 285) { // Adding 20 to account for the image height
                doc.addPage(); // Add a new page
                y = 10; // Reset y to start near the top of the new page
            }
            const imgWidth = 50; // Width of the signature image
            const imgHeight = 20; // Height of the signature image
            doc.addImage(item.SignaturePath, "JPEG", 10, y, imgWidth, imgHeight); // Add signature image
            y += imgHeight + 10; // Adjust y for the next section
        } else {
            y += lineHeight; // Increment y position

            // Check for page overflow before adding the text
            if (y > 285) {
                doc.addPage(); // Add a new page
                y = 10; // Reset y to start near the top of the new page
            }
            doc.text("Signature Image: Not Provided", 10, y); // Handle missing signature image
            y += lineHeight; // Adjust y for the next section
        }


        // Finalize the PDF
        doc.save("Case_Details_Report.pdf"); // Save the PDF file with a descriptive name







        // Save the PDF
        doc.save(`Case_Details_${item.Id}.pdf`);

    }
</script>
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
            <i class='bx bx-menu' style="font-size: 30px;color: #fff;font-weight:600;"></i>
            <a href="#" class="nav-link"></a>

        </nav>
         <h3 class="sam"><i class="fa fa-paw" aria-hidden="true"></i>&nbsp;BLACK TIGER</h3>

         <main>

        <div>
             <h2 style="text-align:center; font-weight:500; margin:30px 0; color:#fff">CASE DETAILS</h2>
                      <div class="container mt-5">
                        <div class="table-responsive">
<table id="caseDetailsTable" class="table table-bordered table-hover table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Court Name</th>
            <th>At</th>
            <th>Forest Range Division</th>
            <th>District</th>
            <th>State</th>
            <th>Court Case No</th>
            <th>Date of Filing</th>
            <th>Court Diary No</th>
            <th>Sections Invoked</th>
            <th>Previous Date</th>
            <th>Accused Details</th>
            <th>Relative Details</th>
            <th>Accused Address</th>
            <th>Pin Code</th>
            <th>Summon Stage</th>
            <th>Bail Stage</th>
            <th>Pre-Charge</th>
            <th>Plead Guilty</th>
            <th>Post-Charge</th>
            <th>Prosecution Evidence</th>
            <th>Defence Witness</th>
            <th>Statement</th>
            <th>Argument</th>
            <th>Witness Type</th>
            <th>Name of Witness</th>
            <th>Summoned or Appeared</th>
            <th>Fully Supported</th>
            <th>Partly Supported</th>
            <th>Became Hostile</th>
            <th>Reasons Not Examined</th>
            <th>Proceedings Brief</th>
            <th>Remedies Suggested</th>
            <th>Officer Name/Rank</th>
            <th>Range Division</th>
            <th>DCF/DFO Comments</th>
            <th>Submission Date</th>
            <th>Signature Path</th>
            <th>Image Path</th>
            <th>Action</th>
        </tr>
    </thead>
                    <tbody id="submissionTableBody">
                        <!-- Data will be dynamically added here -->
                    </tbody>
</table>
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
