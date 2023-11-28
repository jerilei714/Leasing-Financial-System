<%-- 
    Document   : filter_payment_by_lessee
    Created on : 11 21, 23, 8:15:01 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="contractsmgt.LeaseContracts" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<%
    // Assuming you have an Asset class with a method like getValidAssetIds
    LeaseContracts contract = new LeaseContracts();
    List<Integer> validContract = contract.getExistingContractIds() ;
%>


<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Filter Payment Record by Contract</title>
        <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
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
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
    </head>
    <body>
        <form action="payment_records_contract.jsp" method="POST">
        <h1>Select Contract ID:</h1>

        <label for="contractID">Select Contract ID:</label>
        <select id="lesseeId" name="contractID" required>
            <option value="" disabled selected>Select a Contract ID</option>
            <% 
                for (Integer contractID : validContract) {
            %>
                <option value="<%= contractID %>"><%= contractID %></option>
            <% } %>
        </select>

        <button type="submit">View Payment Records</button>
    </form>
    </body>
</html>
