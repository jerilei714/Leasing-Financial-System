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
    <title>Lessee Update Processing</title>
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
                // Receive the values from lessee_update.html
                String str_date_of_birth, v_up_field;
                int v_address;
                
                lessee.lessee_id = Integer.parseInt(request.getParameter("lessee_id"));
                lessee.up_field = v_up_field = request.getParameter("up_field");
                
                String v_field_val = request.getParameter("field_val");
                
                if(v_up_field.equals("name_last"))
                    lessee.name_last = request.getParameter("field_val");
                else if(v_up_field.equals("name_first"))
                    lessee.name_first = request.getParameter("field_val");
                else if(v_up_field.equals("name_middle"))
                    lessee.name_middle = request.getParameter("field_val");
                else if(v_up_field.equals("email"))
                    lessee.email = request.getParameter("field_val");
                else if(v_up_field.equals("date_of_birth")) {
                    str_date_of_birth = request.getParameter("field_val");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date parsedDate = dateFormat.parse(str_date_of_birth);
                    lessee.date_of_birth = parsedDate;
                } else if(v_up_field.equals("address"))
                    lessee.address = Integer.parseInt(request.getParameter("field_val"));
                
                // Call the addLeaseContract method
                int result = lessee.updateLessee();
        %>

        <% if (result == 1) { %>
            <h1 class="success-message">Lessee Record Successfully Updated!</h1>
        <% } else { %>
            <h1 class="error-message">Error Adding Lessee Record</h1>
        <% } %>

        <%
            } catch (Exception e) {
                e.printStackTrace(); // Print the exception for debugging
        %>
            <h1 class="error-message">Error Adding Lessee Record (2)</h1>
        <%
            }
        %>
    </div>
</body>
</html>