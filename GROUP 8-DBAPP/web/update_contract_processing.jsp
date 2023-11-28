<%-- 
    Document   : update_contract_processing
    Created on : 11 16, 23, 2:16:39 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, contractsmgt.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Lease Contract</title>
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
            flex-direction: column;
        }

        .message-container {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .success-message {
            color: #2ecc71;
        }

        .error-message {
            color: #e74c3c;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>
    <div class="message-container">
        <%
            try {
                int contractId = Integer.parseInt(request.getParameter("contractId"));
                int assetId = Integer.parseInt(request.getParameter("assetId"));
                Date startDate = java.sql.Date.valueOf(request.getParameter("startDate"));
                Date endDate = java.sql.Date.valueOf(request.getParameter("endDate"));
                float monthlyDue = Float.parseFloat(request.getParameter("monthlyDue"));
                String status = request.getParameter("status");
                String paymentHistory = request.getParameter("paymentHistory");
                String termsAndConditions = request.getParameter("termsAndConditions");
                boolean renewalOption = Boolean.parseBoolean(request.getParameter("renewalOption"));
                float depositAmount = Float.parseFloat(request.getParameter("depositAmount"));

                LeaseContracts leaseContract = new LeaseContracts();
                int result = leaseContract.updateLeaseContract(contractId, assetId, startDate, endDate, monthlyDue, status,
                        paymentHistory, termsAndConditions, renewalOption, depositAmount);

                if (result == 1) {
        %>
                    <h1 class="success-message">Lease contract updated successfully.</h1>
        <%
                } else {
        %>
                    <h1 class="error-message">Error updating lease contract.</h1>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <h1 class="error-message">An error occurred.</h1>
        <%
            }
        %>

        <!-- "Back to Lease Contracts Menu" button -->
        <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
        <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
    </div>
</body>
</html>








