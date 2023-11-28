<%-- 
    Document   : search_payment
    Created on : 11 16, 23, 11:37:47 PM
    Author     : ccslearner
--%>

<%@page import="java.util.List"%>
<%@page import="PaymentManagement.PaymentRecord"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Assuming you have a PaymentRecord class with a method like get all payment IDs
    PaymentRecord payment = new PaymentRecord();
    List<Integer> paymentList = payment.getAllPaymentIDs();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Record Details</title>
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
        <h1>Select Payment Record ID:</h1>

        <form action="payment_update_form.jsp" method="POST">
            <label for="payment_id">Select Payment Record ID:</label>
            <select id="payment_id" name="payment_id" required>
                <option value="" disabled selected>Select Payment ID</option>
                <% 
                    for (Integer record : paymentList) {
                %>
                    <option value="<%= record %>"><%= record %></option>
                <% } %>
            </select>

            <button type="submit">View Payment Record Details</button>
        </form>
    </body>
</html>
