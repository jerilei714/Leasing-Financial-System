<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>
<%@ page import="java.util.List" %>

<%
    // Assuming you have an Asset class with a method like searchAssetsByType
    String assetTypeToSearch = request.getParameter("assetType");

    Asset asset = new Asset();
    List<Asset> searchResults = asset.searchAssetsByType(assetTypeToSearch);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asset Search Results</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
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

    <h1 style="margin-bottom: 20px;">Asset Search Results for <%= assetTypeToSearch %></h1>

    <% if (!searchResults.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Asset ID</th>
                    <th>Asset Name</th>
                    <th>Description</th>
                    <th>Asset Type</th>
                    <th>Category</th>
                    <th>Purchase Date</th>
                    <th>Purchase Cost</th>
                    <th>Warranty Info</th>
                    <th>Asset Condition</th>
                    <th>Address ID</th>
                    <!-- Include other headers as needed -->
                </tr>
            </thead>
            <tbody>
                <% for (Asset result : searchResults) { %>
                    <tr>
                        <td><%= result.getAssetId() %></td>
                        <td><%= result.getAssetName() %></td>
                        <td><%= result.getDescription() %></td>
                        <td><%= result.getAssetType() %></td>
                        <td><%= result.getCategory() %></td>
                        <td><%= result.getPurchaseDate() %></td>
                        <td><%= result.getPurchaseCost() %></td>
                        <td><%= result.getWarrantyInfo() %></td>
                        <td><%= result.getAssetCondition() %></td>
                        <td><%= result.getAddressId() %></td>
                        <!-- Include other details as needed -->
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No assets found for <%= assetTypeToSearch %>.</p>
    <% } %>

    <a href="asset_info.html" class="back-button">Back to Asset Information</a>

</body>
</html>
