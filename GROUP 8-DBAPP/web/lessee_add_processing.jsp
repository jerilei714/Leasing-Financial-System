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
    <title>Lessee Processing</title>
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
                // Receive the values from lessee_add.html
                //int v_lessee_id = Integer.parseInt(request.getParameter("lessee_id"));
                String v_name_last = request.getParameter("name_last");
                String v_name_first = request.getParameter("name_first");
                String v_name_middle = request.getParameter("name_middle");
                String v_email = request.getParameter("email");
                String str_date_of_birth = request.getParameter("date_of_birth");
                int v_address = Integer.parseInt(request.getParameter("address"));
                
                // Convert String representations to Date objects
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date v_date_of_birth = dateFormat.parse(str_date_of_birth);

                // Set values in the Lessee bean
                //lessee.lessee_id = v_lessee_id;
                lessee.name_last = v_name_last;
                lessee.name_first = v_name_first;
                lessee.name_middle = v_name_middle;
                lessee.email = v_email;
                lessee.date_of_birth = v_date_of_birth;
                lessee.address = v_address;

                // Call the addLeaseContract method
                int result = lessee.addLessee();
        %>

        <% if (result == 1) { %>
            <h1 class="success-message">Lessee Record Successfully Added!</h1>
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