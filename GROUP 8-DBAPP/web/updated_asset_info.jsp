<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    // Retrieve asset ID from the request parameter
    int assetId = Integer.parseInt(request.getParameter("assetId"));

    // Create an instance of Asset and retrieve the updated information
    Asset asset = new Asset();
    Asset updatedAsset = asset.getAssetById(assetId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Updated Asset Information</title>
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

        div {
            max-width: 800px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
            color: #3498db; /* Updated to blue */
        }

        p {
            margin-bottom: 8px;
            color: #000; /* Updated to black */
        }

        a.button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        a.button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>

    <div>
        <h1>Updated Asset Information</h1>

        <% if (updatedAsset != null) { %>
            <p>Asset ID: <%= updatedAsset.getAssetId() %></p>
            <p>Asset Name: <%= updatedAsset.getAssetName() %></p>
            <p>Description: <%= updatedAsset.getDescription() %></p>
            <p>Asset Type: <%= updatedAsset.getAssetType() %></p>
            <p>Category: <%= updatedAsset.getCategory() %></p>
            <p>Purchase Date: <%= updatedAsset.getPurchaseDate() %></p>
            <p>Purchase Cost: <%= updatedAsset.getPurchaseCost() %></p>
            <p>Warranty Info: <%= updatedAsset.getWarrantyInfo() %></p>
            <p>Asset Condition: <%= updatedAsset.getAssetCondition() %></p>
            <p>Address ID: <%= updatedAsset.getAddressId() %></p>
            <!-- Include other details as needed -->
        <% } else { %>
            <p>Error retrieving updated asset information.</p>
        <% } %>

        <a href="asset_info.html" class="button">Back to Asset Information</a>
    </div>

</body>
</html>
