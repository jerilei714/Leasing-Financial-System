<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.Date, java.text.*, AssetManagement.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Asset Management</title>
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

        .back-button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>
    <jsp:useBean id="asset" class="AssetManagement.Asset" scope="session" />

    <div class="message-container">
        <%
            try {
                // Receive the values from your HTML form
                asset.assetName = request.getParameter("asset_name");
                asset.description = request.getParameter("description");
                asset.assetType = request.getParameter("asset_type");
                asset.category = request.getParameter("category");
                asset.purchaseDate = new Date(); // Set the purchase date as the current date for simplicity
                asset.purchaseCost = Float.parseFloat(request.getParameter("purchase_cost"));
                asset.warrantyInfo = request.getParameter("warranty_info");
                asset.assetCondition = request.getParameter("asset_condition");
                asset.addressId = Integer.parseInt(request.getParameter("address_id"));

                // Call the addAsset method
                int result = asset.addAsset();
        %>

        <% if (result == 1) { %>
            <h1 class="success-message">Asset Successfully Added!</h1>
        <% } else { %>
            <h1 class="error-message">Error Adding Asset</h1>
        <% } %>

        <a href="asset_info.html" class="back-button">Back to Asset Information</a>

        <%
            } catch (Exception e) {
                e.printStackTrace(); // Print the exception for debugging
        %>
            <h1 class="error-message">Error Adding Asset</h1>
        <a href="asset_info.html" class="back-button">Back to Asset Information</a>
        <%
            }
        %>
    </div>
</body>
</html>
