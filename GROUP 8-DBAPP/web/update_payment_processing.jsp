<%-- 
    Document   : update_payment_processing
    Created on : 11 17, 23, 1:23:17 AM
    Author     : ccslearner
--%>

<%@page import="PaymentManagement.PaymentRecord"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Retrieve parameters from the form
    int payment_id = Integer.parseInt(request.getParameter("payment_id"));
    int lesee_id = Integer.parseInt(request.getParameter("lessee_id"));
    String date_of_payment = request.getParameter("date_of_payment");
    float amount_paid = Float.parseFloat(request.getParameter("amount_paid"));
    String payment_method = request.getParameter("payment_method");
    String status = request.getParameter("status");
    int lease_contract = Integer.parseInt(request.getParameter("lease_contract"));
    float late_fee = Float.parseFloat(request.getParameter("late_fee"));

    // Create an instance of Asset and update the information
    PaymentRecord payment = new PaymentRecord();
    payment.setPayment_id(payment_id);
    payment.setLesee_id(lesee_id);
    payment.setDate_of_payment(java.sql.Date.valueOf(date_of_payment));
    payment.setAmount_paid(amount_paid);
    payment.setPayment_method(payment_method);
    payment.setStatus(status);
    payment.setLease_contract(lease_contract);
    payment.setLate_fee(late_fee);

    // Update the asset information in the database
    int result = payment.updatePaymentRecord(payment_id, lesee_id, java.sql.Date.valueOf(date_of_payment), amount_paid, payment_method, status, lease_contract, late_fee);

    // Redirect to a page to display the updated information

        
    if (result == 1) {
        response.sendRedirect("updated_paymentRecordDetails.jsp?payment_id=" + payment_id);
    } else {
        response.sendRedirect("error.jsp"); // Redirect to an error page or handle accordingly
    }
%>  
