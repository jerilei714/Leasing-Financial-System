<%-- 
    Document   : filter_contracts
    Created on : 11 15, 23, 1:01:04 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, contractsmgt.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filter Lease Contracts</title>
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
    <form action="filter_contracts_process.jsp" method="POST">
        <label for="lesseeId">Lessee ID:</label>
        <select id="lesseeId" name="lesseeId" required>

            <%
                contractsmgt.LeaseContracts leaseContract = new contractsmgt.LeaseContracts();
                ArrayList<Integer> lesseeIds = leaseContract.getExistingLesseeIds();
                 Collections.sort(lesseeIds);
                for (Integer lesseeId : lesseeIds) {
            %>
                    <option value="<%= lesseeId %>"><%= lesseeId %></option>
            <%
                }
            %>
        </select>

        <button type="submit">Filter Contracts</button>
        <button type="submit" formaction="lease_contracts.html">Cancel</button>
    </form>
</body>
</html>







