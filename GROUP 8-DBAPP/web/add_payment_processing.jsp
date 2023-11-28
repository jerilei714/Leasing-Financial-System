<%-- 
    Document   : add_payment_processing
    Created on : 11 16, 23, 4:22:41 PM
    Author     : ccslearner
--%>

<%@page import="PaymentManagement.PaymentRecord"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Record Processing</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .message-container {
                text-align: center;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .success-message {
                color: #2ecc71;
            }

            .error-message {
                color: #e74c3c;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="payment" class="PaymentManagement.PaymentRecord" scope="session" />

        <div class="message-container">
            <%
                // Process form submission when lessee_id and amount_paid are present in the request parameters
                if (request.getParameter("lessee_id") != null && request.getParameter("amount_paid") != null) {
                    try {
                        // Receive the values from the form
                        int v_lesseeId = Integer.parseInt(request.getParameter("lessee_id"));
                        String vdate_of_payment = request.getParameter("date_of_payment");
                        float v_amount_paid = Float.parseFloat(request.getParameter("amount_paid"));
                        String v_payment_method = request.getParameter("payment_method");
                        String v_status = request.getParameter("status");
                        float v_late_fee = Float.parseFloat(request.getParameter("late_fee"));
                        int v_lease_contract = Integer.parseInt(request.getParameter("lease_contract"));

                        // Convert String representations to Date objects
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date vDate = dateFormat.parse(vdate_of_payment);

                        // Set values in the Payment bean
                        payment.lesee_id = v_lesseeId;
                        payment.date_of_payment = vDate;
                        payment.amount_paid = v_amount_paid;
                        payment.status = v_status;
                        payment.payment_method = v_payment_method;
                        payment.lease_contract = v_lease_contract;
                        payment.late_fee = v_late_fee;
                        
                        //(30001, 99991, '2023-12-01', 1500, 'Online', 'Completed', 10001, NULL);
                        
                        // Call the addPaymentRecord method
                        int result = payment.addPaymentRecord();
            %>
                        
            <% if (result == 1) { %>
                <h1 class="success-message">Payment Record Successfully Added!</h1>
            <% } else { %>
                <h1 class="error-message">Error Adding Payment Record Function</h1>
            <% } %>

            <%
                } catch (Exception e) {
                    e.printStackTrace(); // Print the exception for debugging
            %>
                <h1 class="error-message">Error Adding Payment Record Exception</h1>
            <%
                }
            }
            %>
            <button onclick="window.location.href='payment_info.html'">Back to Payment Record Info</button>
        </div>
    </body>
</html>
