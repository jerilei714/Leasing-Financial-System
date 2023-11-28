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
    
    <title>Filter Lessees</title>
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
        
        .inline-income, .inline-insurance, .inline-date {
        display: inline-block;
        }
    </style>
</head>
<body>
    
    <jsp:useBean id="lessee" class="lesseemgt.LesseeRecord" scope="session" />
    <form action="lessee_filter_processing.jsp" method="POST">
        <p>All fields are optional.</p> <br>
        
        
        <label for="min_inc">Minimum yearly net income:</label>
        <input type="number" id="min_inc" name="min_inc">
        
        <label for="max_inc">Maximum yearly net income:</label>
        <input type="number" id="max_inc" name="max_inc">

        <br>
        <label for="min_insur">Minimum insurance coverage:</label>
        <input type="number" id="min_insur" name="min_insur">

        <label for="max_insur">Maximum insurance coverage:</label>
        <input type="number" id="max_insur" name="max_insur">

        <br>
        <label for="min_date">Insurance expires after:</label>
        <input type="date" id="min_date" name="min_date">

        <label for="max_date">Insurance expires before:</label>
        <input type="date" id="max_date" name="max_date">

        </select>

        <button type="submit">Filter Lessees</button>
    </form>

</body>
</html>