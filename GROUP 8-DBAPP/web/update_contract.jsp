<%-- 
    Document   : update_contract
    Created on : 11 16, 23, 2:16:09 AM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        select, input {
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
    <form action="update_contract_processing.jsp" method="POST">
        <label for="contractId">Contract ID:</label>
        <select id="contractId" name="contractId" required>

            <%@ page import="contractsmgt.LeaseContracts" %>
            <%@ page import="java.util.*" %>
            <%
                LeaseContracts leaseContract = new LeaseContracts();
                ArrayList<Integer> contractIds = leaseContract.getExistingContractIds();
                Collections.sort(contractIds); 

                for (Integer contractId : contractIds) {
            %>
                    <option value="<%= contractId %>"><%= contractId %></option>
            <%
                }
            %>
        </select>

        <label for="assetId">Asset ID:</label>
        <select id="assetId" name="assetId" required>

            <%
                ArrayList<Integer> assetIds = leaseContract.getExistingAssetIds();
                Collections.sort(assetIds); 

                for (Integer assetId : assetIds) {
            %>
                    <option value="<%= assetId %>"><%= assetId %></option>
            <%
                }
            %>
        </select>

        <label for="startDate">Lease Start Date:</label>
        <input type="date" id="startDate" name="startDate" required>

        <label for="endDate">Lease End Date:</label>
        <input type="date" id="endDate" name="endDate" required>

        <label for="monthlyDue">Monthly Due:</label>
        <input type="number" id="monthlyDue" name="monthlyDue" required>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="active">Active</option>
            <option value="expired">Expired</option>
            <option value="terminated">Terminated</option>
            <option value="renewed">Renewed</option>
        </select>

        <label for="paymentHistory">Payment History:</label>
        <input type="text" id="paymentHistory" name="paymentHistory" required>

        <label for="termsAndConditions">Terms and Conditions:</label>
        <textarea id="termsAndConditions" name="termsAndConditions" rows="4" required></textarea>

        <label for="renewalOption">Renewal Option:</label>
        <select id="renewalOption" name="renewalOption" required>
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>

        <label for="depositAmount">Deposit Amount:</label>
        <input type="number" id="depositAmount" name="depositAmount" required>

        <button type="submit">Update Contract</button>
        <button type="submit" formaction="lease_contracts.html">Cancel</button>
    </form>
</body>
</html>







