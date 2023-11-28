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
    
    <title>Add Lessee</title>
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
    <form action="lessee_add_processing.jsp" method="POST">
        <label for="name_last">Last name:</label>
        <input type="text" id="name_last" name="name_last" required>
        
        <label for="name_first">First name:</label>
        <input type="text" id="name_first" name="name_first" required>
        
        <label for="name_middle">Middle name:</label>
        <input type="text" id="name_middle" name="name_middle">

       <label for="email">E-mail:</label>
        <input type="text" id="email" name="email" required>

        <label for="date_of_birth">Birth date:</label>
        <input type="date" id="date_of_birth" name="date_of_birth" required>

        <label for="address">Address ID:</label>
        <select id="address" name="address" required>
            <%
                ArrayList<Integer> addList = lessee.getExistingAddresses();
                for (Integer id : addList) { 
            %>
                <option value="<%= id %>"><%= id %></option>
            <%
                }
            %>
        </select>

        <button type="submit">Add Lessee</button>
        <button type="submit" formaction="lease_contracts.html">Cancel</button>
    </form>

</body>
</html>