<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*,lesseemgt.* " %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
   <script>
        function updateInputType() {
            var selectedOption = document.getElementById("up_field").value;
            var fieldValueInput = document.getElementById("field_val");

            // Set the input type based on the selected option
            if (selectedOption === "date_of_birth") {
                fieldValueInput.type = "date";
            } else {
                fieldValueInput.type = "text";
            }
        }
    </script>
    
    <title>Update Lessee</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input, select, textarea {
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
    
    <jsp:useBean id="lessee" class="lesseemgt.LesseeRecord" scope="session" />
    <form action="lessee_update_processing.jsp" method="POST">
        
        <label for="lessee_id">Lessee ID</label>
        <select id="lessee_id" name="lessee_id" required>
            <%
                lesseemgt.LesseeRecord lesseeRec = new lesseemgt.LesseeRecord();
                ArrayList<Integer> lesseeList = lesseeRec.getExistingLessees();
                Collections.sort(lesseeList);
                for (Integer id : lesseeList) { 
            %>
                <option value="<%= id %>"><%= id %></option>
            <% } %>
        </select>
        
        <label for="up_field">Field to update:</label>
        <select id="up_field" name="up_field" required required onchange="updateInputType()">
                <option value="name_last">Last Name</option>
                <option value="name_first">First Name</option>
                <option value="name_middle">Middle Name</option>
                <option value="email">E-mail</option>
                <option value="date_of_birth">Date of Birth</option>
                <option value="address">Address ID</option>
        </select>
        
        <label for="field_val">Field value:</label>
        <input type="text" id="field_val" name="field_val" required>

        <button type="submit">Update Lessee Info</button>
    </form>

</body>
</html>