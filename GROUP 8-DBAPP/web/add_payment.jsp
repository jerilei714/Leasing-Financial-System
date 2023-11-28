<%-- 
    Document   : add_payment
    Created on : 11 16, 23, 3:32:04 PM
    Author     : ccslearner
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="contractsmgt.*" %>
<%@ page import="java.util.Collections" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Payment Record Form</title>
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
        <jsp:useBean id="payment" class="PaymentManagement.PaymentRecord" scope="session" />
        <form action="add_payment_processing.jsp" method="POST">
        <label for="lessee_id">Choose Your Lessee ID:</label>
        <select id="lessee_id" name="lessee_id" required>
            <%
                LeaseContracts contracts = new LeaseContracts();
                ArrayList<Integer> lesseeIdList = contracts.getExistingLesseeIds();
                Collections.sort(lesseeIdList);
                for (Integer lesseeId : lesseeIdList) {
            %>
                <option value="<%= lesseeId %>"><%= lesseeId %></option>
            <%
                }
            %>
        </select>

        <label for="date_of_payment">Date of Payment:</label>
        <input type="date" id="date_of_payment" name="date_of_payment" required>

        <label for="amount_paid">Amount:</label>
        <input type="number" id="amount_paid" name="amount_paid" step="0.01" required>

        <label for="payment_method">Payment Method:</label>
        <input type="text" id="payment_method" name="payment_method">

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="Completed">Completed</option>
            <option value="Pending">Pending</option>
            <option value="Disputed">Disputed</option>
        </select>

        <label for="late_fee">Late Fee:</label>
        <input type="number" id="late_fee" name="late_fee" step="0.01" required>

        <label for="lease_contract">Lease Contract:</label>
        <input type="number" id="lease_contract" name="lease_contract" required>
        
        <button type="submit">Add Payment Record</button>
    </form>
    </body>
</html>
