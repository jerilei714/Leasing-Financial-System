<%-- 
    Document   : delete_contract_processing
    Created on : 11 16, 23, 3:12:57 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="contractsmgt.LeaseContracts" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Lease Contract Processing</title>
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
            margin-right: 10px;
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
            try {
                if (request.getParameter("contractId") != null) {
                    int contractId = Integer.parseInt(request.getParameter("contractId"));
                    int result = leaseContract.deleteLeaseContract(contractId);

                    if (result == 1) {
        %>
                        <h1 class="success-message">Lease Contract Successfully Deleted!</h1>
        <%
                    } else {
        %>
                        <h1 class="error-message">Error Deleting Lease Contract</h1>
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace(); // Print the exception for debugging
        %>
                <h1 class="error-message">Error Deleting Lease Contract</h1>
        <%
            }
        %>

        <!-- "Back to Lease Contracts Menu" button -->
        <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
        
        <!-- "Back to Main Menu" button -->
        <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
    </div>
</body>
</html>







