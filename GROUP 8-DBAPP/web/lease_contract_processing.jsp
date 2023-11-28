<%-- 
    Document   : lease_contract_processing
    Created on : 11 14, 23, 12:38:37 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, contractsmgt.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lease Contract Processing</title>
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
    <jsp:useBean id="leaseContract" class="contractsmgt.LeaseContracts" scope="session" />

    <div class="message-container">
        <%

            if (request.getParameter("lessee_id") != null && request.getParameter("asset_id") != null) {
                try {

                    int v_lesseeId = Integer.parseInt(request.getParameter("lessee_id"));
                    int v_assetId = Integer.parseInt(request.getParameter("asset_id"));
                    String start_date_str = request.getParameter("start_date");
                    String end_date_str = request.getParameter("end_date");
                    float v_monthly_due = Float.parseFloat(request.getParameter("monthly_due"));
                    String v_status = request.getParameter("status");
                    String v_payment_history = request.getParameter("payment_history");
                    String v_terms_and_conditions = request.getParameter("terms_and_conditions");
                    boolean v_renewal_option = request.getParameter("renewal_option") != null;
                    float v_deposit_amount = Float.parseFloat(request.getParameter("deposit_amount"));

                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date startDate = dateFormat.parse(start_date_str);
                    Date endDate = dateFormat.parse(end_date_str);

                    leaseContract.lessee_id = v_lesseeId;
                    leaseContract.asset_id = v_assetId;
                    leaseContract.startDate = startDate;
                    leaseContract.endDate = endDate;
                    leaseContract.monthlyDue = v_monthly_due;
                    leaseContract.status = v_status;
                    leaseContract.paymentHistory = v_payment_history;
                    leaseContract.termsAndConditions = v_terms_and_conditions;
                    leaseContract.renewalOption = v_renewal_option;
                    leaseContract.depositAmount = v_deposit_amount;

                    int result = leaseContract.addLeaseContract();
        %>

        <% if (result == 1) { %>
            <h1 class="success-message">Lease Contract Successfully Added!</h1>
        <% } else { %>
            <h1 class="error-message">Error Adding Lease Contract</h1>
        <% } %>

        <%
            } catch (Exception e) {
                e.printStackTrace(); // Print the exception for debugging
        %>
            <h1 class="error-message">Error Adding Lease Contract</h1>
        <%
            }
        }
        %>
        
        <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
        <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
    </div>
</body>
</html>













