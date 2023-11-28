<%-- 
    Document   : paymentRecordDetails
    Created on : 11 16, 23, 11:50:49 PM
    Author     : ccslearner
--%>

<%@page import="PaymentManagement.PaymentRecord"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    int paymentID = Integer.parseInt(request.getParameter("payment_id"));

    PaymentRecord payment = new PaymentRecord();
    PaymentRecord paymentDetails = payment.getPaymentRecordById(paymentID);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Record Information</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        table {
            max-width: 800px;
            margin: 50px auto;
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: #fff;
        }
    </style>
    </head>
    <body>
        <h1>Asset Information</h1>

        <% if (paymentDetails != null) { %>
            <table>
                <tr>
                    <th>Attribute</th>
                    <th>Value</th>
                </tr>
                <tr>
                    <td>Payment ID:</td>
                    <td><%= paymentDetails.getPaymentID() %></td>
                </tr>
                <tr>
                    <td>Leesee ID:</td>
                    <td><%= paymentDetails.getLesee_id() %></td>
                </tr>
                <tr>
                    <td>Date:</td>
                    <td><%= paymentDetails.getDate_of_payment() %></td>
                </tr>
                <tr>
                    <td>Amount Paid: </td>
                    <td><%= paymentDetails.getAmount_paid() %></td>
                </tr>
                <tr>
                    <td>Details:</td>
                    <td><%= paymentDetails.getPayment_method() %></td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td><%= paymentDetails.getStatus() %></td>
                </tr>
                <tr>
                    <td>Lease Contract:</td>
                    <td><%= paymentDetails.getLease_contract() %></td>
                </tr>
                <tr>
                    <td>Late_fee</td>
                    <td><%= paymentDetails.getLate_fee() %></td>
                </tr>
                <!-- Include other details as needed -->
            </table>
            <button onclick="window.location.href='payment_info.html'">Back to Payment Record Info</button>
        <% } else { %>
            <p>Asset not found.</p>
        <% } %>
    </body>
</html>
