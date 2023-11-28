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
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            width: 80%;
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            margin-bottom: 16px;
            border-collapse: collapse;
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

        p {
            margin-bottom: 8px;
        }

        button {
            background-color: #e74c3c;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #c0392b;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 16px;
            text-decoration: none;
            color: #333;
        }
    </style>
    </head>
    <body>
        <form action="process_delete_payment_record.jsp" method="POST">
            <% if (paymentDetails != null) { %>
                <h1>Payment Information</h1>
                <p>Are you sure you want to delete the following payment record?</p>
                    
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
                    
                <input type="hidden" name="payment_id" value="<%= paymentDetails.getPaymentID() %>">
                <button type="submit">Yes, Delete Payment</button>
            <% } else { %>
                <p>Error retrieving record information for deletion.</p>
            <% } %>
        </form>
        <a href="search_payment_delete.jsp">Cancel</a>
    </body>
</html>
