<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>
<%@ page import="java.util.List" %>

<%
    // Assuming you have an Asset class with a method like getAvailableAssetTypes
    Asset asset = new Asset();
    List<String> availableAssetTypes = asset.getAvailableAssetTypes();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asset Type Search</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        section {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form {
            max-width: 400px;
            margin: 20px auto; /* Adjusted margin */
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

        input {
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

    <section>
        <h2>Available Asset Types:</h2>
        <ul>
            <% for (String type : availableAssetTypes) { %>
                <li><%= type %></li>
            <% } %>
        </ul>
    </section>

    <form action="result_asset_type.jsp" method="POST">
        <label for="assetType">Enter Asset Type:</label>
        <input type="text" id="assetType" name="assetType" required>

        <button type="submit">Search</button>
    </form>

</body>
</html>
