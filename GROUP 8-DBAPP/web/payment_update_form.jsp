<%-- 
    Document   : payment_update_form
    Created on : 11 17, 23, 12:42:25 AM
    Author     : ccslearner
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="contractsmgt.LeaseContracts"%>
<%@page import="PaymentManagement.PaymentRecord"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    int paymentID = Integer.parseInt(request.getParameter("payment_id"));

    PaymentRecord payment = new PaymentRecord();
    PaymentRecord paymentDetails = payment.getPaymentRecordById(paymentID);
    
    if (paymentDetails == null) {
        response.sendRedirect("error.jsp"); // Redirect to an error page or handle accordingly
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Updated Asset Information</title>
        <style>
            body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #3498db;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input {
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
        <div>
        <form action="update_payment_processing.jsp" method="POST">
            
        <input type="hidden" name="payment_id" value="<%= paymentDetails.getPaymentID() %>">
         
        <label for="lessee_id">Choose Your Lessee ID:</label>
        <input type="text" id="lessee_id" name="lessee_id" value="<%= paymentDetails.getLesee_id()%>" required>
        

        <label for="date_of_payment">Date of Payment:</label>
        <input type="text" id="date_of_payment" name="date_of_payment" value="<%=paymentDetails.getDate_of_payment() %>" required>

        <label for="amount_paid">Amount:</label>
        <input type="text" id="amount_paid" name="amount_paid" value="<%=paymentDetails.getAmount_paid() %>" required>

        <label for="payment_method">Payment Method:</label>
        <input type="text" id="payment_method" name="payment_method" value="<%= paymentDetails.getPayment_method() %>">

        <label for="status">Status:(<%=paymentDetails.getStatus()%>)</label>
        <select id="status" name="status" required>
            <option value="Completed">Completed</option>
            <option value="Pending">Pending</option>
            <option value="Disputed">Disputed</option>
        </select>

        <label for="late_fee">Late Fee:</label>
        <input type="text" id="late_fee" name="late_fee" value="<%=paymentDetails.getLate_fee() %>" required>

        <label for="lease_contract">Lease Contract:</label>
        <input type="text" id="lease_contract" name="lease_contract" value="<%=paymentDetails.getLease_contract() %>" required>
        
        <button type="submit">Update Payment Record</button>
    </form>
    </div>
    </body>
</html>
