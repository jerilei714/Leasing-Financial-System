<%-- 
    Document   : delete_contract_confirm
    Created on : 11 16, 23, 3:20:50 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="contractsmgt.LeaseContracts" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Lease Contract Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .confirmation-container {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .details-container {
            margin-top: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .button-container {
            margin-top: 20px;
        }

        button {
            background-color: #e74c3c;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <jsp:useBean id="leaseContract" class="contractsmgt.LeaseContracts" scope="session" />

    <div class="confirmation-container">
        <h1>Confirm Deletion of Lease Contract</h1>

        <div class="details-container">
            <%
                if (request.getParameter("contractId") != null) {
                    try {
                        int contractId = Integer.parseInt(request.getParameter("contractId"));

                        LeaseContracts contractDetails = leaseContract.getLeaseContractDetails(contractId);
            %>

            <p>Contract ID: <%= contractDetails.getContractId() %></p>
            <p>Lessee ID: <%= contractDetails.getLesseeId() %></p>
            <p>Asset ID: <%= contractDetails.getAssetId() %></p>
            <p>Start Date: <%= contractDetails.getStartDate() %></p>
            <p>End Date: <%= contractDetails.getEndDate() %></p>
            <p>Monthly Due: <%= contractDetails.getMonthlyDue() %></p>
            <p>Status: <%= contractDetails.getStatus() %></p>
            <p>Payment History: <%= contractDetails.getPaymentHistory() %></p>
            <p>Terms and Conditions: <%= contractDetails.getTermsAndConditions() %></p>
            <p>Renewal Option: <%= contractDetails.isRenewalOption() %></p>
            <p>Deposit Amount: <%= contractDetails.getDepositAmount() %></p>

            <div class="button-container">
                <form action="delete_contract_processing.jsp" method="POST">
                    <input type="hidden" name="contractId" value="<%= contractId %>">
                    <button type="submit">Confirm Delete</button>
                    <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
                </form>
            </div>

            <%
                } catch (Exception e) {
                    e.printStackTrace(); 
            %>
                <h1>Error Retrieving Lease Contract Details</h1>
            <%
                }
            }
            %>
        </div>
    </div>
</body>
</html>



