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
    <jsp:useBean id="lessee" class="lesseemgt.LesseeRecord" scope="session" />

    <div class="message-container">
        <%
            try {
                Float[] minmax = new Float[4];
                String s;
                List<Map<String, Object>> resultList;
                 
                if((s = request.getParameter("min_inc")) != null && !s.isEmpty())
                    minmax[0] = Float.parseFloat(s);
                if((s = request.getParameter("max_inc")) != null && !s.isEmpty())
                    minmax[1] = Float.parseFloat(s);
                if((s = request.getParameter("min_insur")) != null && !s.isEmpty())
                    minmax[2] = Float.parseFloat(s);
                if((s = request.getParameter("max_insur")) != null && !s.isEmpty())
                    minmax[3] = Float.parseFloat(s); 
                
               if(request.getParameter("max_date") != null && !request.getParameter("max_date").isEmpty())
                   resultList = lessee.filterLessees(minmax, request.getParameter("min_date"), request.getParameter("max_date"));
               else resultList = lessee.filterLessees(minmax, request.getParameter("min_date"), "9999-99-99");


                 %> <table border=\"1\"> <%
                    
                if (!resultList.isEmpty()) { 
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