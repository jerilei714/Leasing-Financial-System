<%-- 
    Document   : lease_contract_processing
    Created on : 11 14, 23, 12:38:37 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, java.util.Date, lesseemgt.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lessee Search Processing</title>
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
    <jsp:useBean id="lessee" class="lesseemgt.LesseeRecord" scope="session" />

    <div class="message-container">
        <%
            try {
                // Receive the values from lessee_search.html
                int v_lessee_id = Integer.parseInt(request.getParameter("lessee_id"));

                // Set values in the Lessee bean
                //lessee.lessee_id = v_lessee_id;
                lessee.lessee_id = v_lessee_id;

                // Call the addLeaseContract method
                String lesseeInfo = lessee.getLesseeInfo();
        %>

        <% if (lesseeInfo != null) { %>
        
            <h1>Lessee Record:</h1>
            <%= lesseeInfo.replace("\n","<br>") %>
            
        <% } else { %>
            <h1 class="error-message">Error Finding Lessee Record</h1>
        <% } %>

        <%
            } catch (Exception e) {
                e.printStackTrace(); // Print the exception for debugging
        %>
            <h1 class="error-message">Error Finding Lessee Record (2)</h1>
        <%
            }
        %>
    </div>
</body>
</html>