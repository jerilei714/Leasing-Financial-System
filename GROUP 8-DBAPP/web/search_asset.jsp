<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>
<%@ page import="java.util.List" %>

<%
    // Assuming you have an Asset class with a method like getValidAssetIds
    Asset asset = new Asset();
    List<Integer> validAssetIds = asset.getValidAssetIds();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asset Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        select {
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
            width: 100%;
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>

    <form action="assetDetails.jsp" method="POST">
        <h1>Select Asset ID:</h1>

        <label for="assetId">Select Asset ID:</label>
        <select id="assetId" name="assetId" required>
            <option value="" disabled selected>Select an Asset ID</option>
            <% 
                for (Integer assetId : validAssetIds) {
            %>
                <option value="<%= assetId %>"><%= assetId %></option>
            <% } %>
        </select>

        <button type="submit">View Asset Details</button>
    </form>

</body>
</html>
