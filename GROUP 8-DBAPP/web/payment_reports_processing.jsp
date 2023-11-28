<%-- 
    Document   : lease_contract_processing
    Created on : 11 14, 23, 12:38:37 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, java.io.*, java.util.Date, java.sql.*, lesseemgt.*" %>
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
    <jsp:useBean id="payment" class="PaymentManagement.PaymentRecord" scope="session" />

    <div class="message-container">
        <%
            try {
                List<Map<String, Object>> resultList;
                
                resultList = payment.generateReport(request.getParameter("year"), request.getParameter("month"));

                 %> <table border=\"1\"> <%
                    
                if (!resultList.isEmpty()) { %>
                    <p>No of payments:</p>
                    <%= resultList.size() %> <%
                    Map<String, Object> firstRow = resultList.get(0); %> 
                    <tr>
                    <% for (String columnName : firstRow.keySet()) { %>
                        <th> <%= columnName %> </th>
                    <% } %>
                    </tr>
                    <% for (Map<String, Object> row : resultList) { %>
                        <tr>
                        <% for (Object value: row.values()) { %>
                            <td> <%= value %> </td>
                        <% } %>
                        
                        </tr>
                    <% } %>
                <% } else { %>
                    <h1 class="error-message">No Lessee Records Found</h1>
             <% }
            } catch (Exception e) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                e.printStackTrace(pw);
                String stackTrace = sw.toString();
                out.println(stackTrace);
        %>
            <h1 class="error-message">Error Finding Lessee Record (2)</h1>
        <%
            }
        %>
    </div>
</body>
</html>