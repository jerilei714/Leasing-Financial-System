<%-- 
    Document   : lease_contract_form
    Created on : 11 14, 23, 4:48:54 PM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, contractsmgt.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lease Contract Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input, select, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>
    <jsp:useBean id="leaseContract" class="contractsmgt.LeaseContracts" scope="session" />
    <form action="lease_contract_processing.jsp" method="POST">
    <label for="lessee_id">Choose Your Lessee ID:</label>
    <select id="lessee_id" name="lessee_id" required>
        <%
            ArrayList<Integer> lesseeIdList = leaseContract.getExistingLesseeIds();
             Collections.sort(lesseeIdList);
            for (Integer lesseeId : lesseeIdList) {
        %>
            <option value="<%= lesseeId %>"><%= lesseeId %></option>
        <%
            }
        %>
    </select>

    <label for="asset_id">Choose The Asset ID:</label>
    <select id="asset_id" name="asset_id" required>
        <%
            ArrayList<Integer> assetIdList = leaseContract.getExistingAssetIds();
             Collections.sort(assetIdList);
            for (Integer assetId : assetIdList) {
        %>
            <option value="<%= assetId %>"><%= assetId %></option>
        <%
            }
        %>
    </select>

    <label for="start_date">Lease Start Date:</label>
    <input type="date" id="start_date" name="start_date" required>

    <label for="end_date">Lease End Date:</label>
    <input type="date" id="end_date" name="end_date" required>

    <label for="monthly_due">Monthly Due:</label>
    <input type="number" id="monthly_due" name="monthly_due" step="0.01" required>

    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="active">Active</option>
    </select>

    <label for="payment_history">Payment History:</label>
    <input type="text" id="payment_history" name="payment_history">

    <label for="terms_and_conditions">Terms and Conditions:</label>
    <textarea id="terms_and_conditions" name="terms_and_conditions" rows="4" required></textarea>

    <label for="renewal_option">Potential Renewal (click if agree):</label>
    <input type="checkbox" id="renewal_option" name="renewal_option">

    <label for="deposit_amount">Deposit Amount:</label>
    <input type="number" id="deposit_amount" name="deposit_amount" step="0.01">

    <button type="submit">Add Lease Contract</button>
    <button type="submit" formaction="lease_contracts.html">Cancel</button>
</form>
</body>
</html>



