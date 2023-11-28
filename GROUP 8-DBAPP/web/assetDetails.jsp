<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    // Assuming you have an Asset class with a method like getAssetById
    int assetId = Integer.parseInt(request.getParameter("assetId"));

    Asset asset = new Asset();
    Asset assetDetails = asset.getAssetById(assetId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asset Information</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        table {
            max-width: 800px;
            margin: 50px auto;
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: #fff;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>

    <h1>Asset Information</h1>

    <% if (assetDetails != null) { %>
        <table>
            <tr>
                <th>Attribute</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>Asset ID:</td>
                <td><%= assetDetails.getAssetId() %></td>
            </tr>
            <tr>
                <td>Asset Name:</td>
                <td><%= assetDetails.getAssetName() %></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><%= assetDetails.getDescription() %></td>
            </tr>
            <tr>
                <td>Asset Type:</td>
                <td><%= assetDetails.getAssetType() %></td>
            </tr>
            <tr>
                <td>Category:</td>
                <td><%= assetDetails.getCategory() %></td>
            </tr>
            <tr>
                <td>Purchase Date:</td>
                <td><%= assetDetails.getPurchaseDate() %></td>
            </tr>
            <tr>
                <td>Purchase Cost:</td>
                <td><%= assetDetails.getPurchaseCost() %></td>
            </tr>
            <tr>
                <td>Warranty Information:</td>
                <td><%= assetDetails.getWarrantyInfo() %></td>
            </tr>
            <tr>
                <td>Asset Condition:</td>
                <td><%= assetDetails.getAssetCondition() %></td>
            </tr>
            <tr>
                <td>Address ID:</td>
                <td><%= assetDetails.getAddressId() %></td>
            </tr>
            <!-- Include other details as needed -->
        </table>
        <button onclick="window.location.href='asset_info.html'">Back to Asset Information</button>
    <% } else { %>
        <p>Asset not found.</p>
    <% } %>

</body>
</html>
