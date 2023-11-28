<%-- 
    Document   : delete_contract
    Created on : 11 16, 23, 3:12:39 AM
    Author     : ccslearner
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Lease Contract</title>
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

        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
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
    <form action="delete_contract_confirm.jsp" method="POST">
        <label for="contractId">Select Contract ID to Delete:</label>
        <select id="contractId" name="contractId" required>

            <%
                contractsmgt.LeaseContracts leaseContract = new contractsmgt.LeaseContracts();
                ArrayList<Integer> contractIds = leaseContract.getExistingContractIds();
                Collections.sort(contractIds); 
                for (Integer contractId : contractIds) {
            %>
                    <option value="<%= contractId %>"><%= contractId %></option>
            <%
                }
            %>
        </select>

        <button type="submit">Delete Contract</button>
        <button type="submit" formaction="lease_contracts.html">Cancel</button>
    </form>
</body>
</html>

