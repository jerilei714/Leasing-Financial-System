<%-- 
    Document   : filter_payment_by_lessee
    Created on : 11 21, 23, 8:15:01 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="lesseemgt.LesseeRecord" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<%
    // Assuming you have an Asset class with a method like getValidAssetIds
    LesseeRecord lessee = new LesseeRecord();
    List<Integer> validLessee = lessee.getExistingLessees();
%>


<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Filter Payment Record by Lessee</title>
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
        <form action="payment_records_lessee.jsp" method="POST">
        <h1>Select Lessee ID:</h1>

        <label for="lesseeId">Select Lessee ID:</label>
        <select id="lesseeId" name="lesseeId" required>
            <option value="" disabled selected>Select a Lessee ID</option>
            <% 
                for (Integer lesseeID : validLessee) {
            %>
                <option value="<%= lesseeID %>"><%= lesseeID %></option>
            <% } %>
        </select>

        <button type="submit">View Payment Records</button>
    </form>
    </body>
</html>
