<%-- 
    Document   : payment_records_lessee
    Created on : 11 21, 23, 8:24:11 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="PaymentManagement.PaymentRecord"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>

<%
    // Assuming you have a LeaseContracts class with a method like searchLeaseContracts
    int contractID = Integer.parseInt(request.getParameter("contractID"));

    // Validate searchType and searchValue
    PaymentRecord payment = new PaymentRecord();
    ArrayList<PaymentRecord> searchResults = payment.filterPaymentsByContract(contractID);
%>
<html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Records of Contract</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #3498db;
            margin-top: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #ddd;
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

        tr:hover {
            background-color: #f5f5f5;
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
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
    <body>
        <h2>Filtered Records for Contract: <%= contractID %></h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Lessee</th>
                    <th>Payment ID </th>
                    <th>Date of Payment</th>
                    <th>Amount Paid</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Late Fee</th>
                </tr>
            </thead>
            <tbody>
                <% for (PaymentRecord record : searchResults) { %>

                    <tr>
                        <td><%= record.getLesee_id() %></td>
                        <td><%= record.getPaymentID() %></td>
                        <td><%= record.getDate_of_payment() %></td>
                        <td><%= record.getAmount_paid() %></td>
                        <td><%= record.getPayment_method() %></td>
                        <td><%= record.getStatus() %></td>
                        <td><%= record.getLate_fee() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- "Back to Lease Contracts Menu" button -->
        <a href="payment_info.html"><button type="button">Back to Payment Record Menu</button></a>
        <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
    </body>
</html>
