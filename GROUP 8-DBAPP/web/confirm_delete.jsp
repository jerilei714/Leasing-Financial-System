<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    int assetId = Integer.parseInt(request.getParameter("assetId"));
    Asset asset = new Asset();
    Asset assetDetails = asset.getAssetById(assetId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Asset Deletion</title>
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
            width: 80%;
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            margin-bottom: 16px;
            border-collapse: collapse;
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

        p {
            margin-bottom: 8px;
        }

        button {
            background-color: #e74c3c;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #c0392b;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 16px;
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>

    <form action="process_delete.jsp" method="POST">
        <h1>Confirm Asset Deletion</h1>

        <% if (assetDetails != null) { %>
            <p>Are you sure you want to delete the following asset?</p>

            <table>
                <tr>
                    <th>Attribute</th>
                    <th>Value</th>
                </tr>
                <tr>
                    <td>Asset ID</td>
                    <td><%= assetDetails.getAssetId() %></td>
                </tr>
                <tr>
                    <td>Asset Name</td>
                    <td><%= assetDetails.getAssetName() %></td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td><%= assetDetails.getDescription() %></td>
                </tr>
                <tr>
                    <td>Asset Type</td>
                    <td><%= assetDetails.getAssetType() %></td>
                </tr>
                <tr>
                    <td>Category</td>
                    <td><%= assetDetails.getCategory() %></td>
                </tr>
                <tr>
                    <td>Purchase Date</td>
                    <td><%= assetDetails.getPurchaseDate() %></td>
                </tr>
                <tr>
                    <td>Purchase Cost</td>
                    <td><%= assetDetails.getPurchaseCost() %></td>
                </tr>
                <tr>
                    <td>Warranty Info</td>
                    <td><%= assetDetails.getWarrantyInfo() %></td>
                </tr>
                <tr>
                    <td>Asset Condition</td>
                    <td><%= assetDetails.getAssetCondition() %></td>
                </tr>
                <tr>
                    <td>Address ID</td>
                    <td><%= assetDetails.getAddressId() %></td>
                </tr>
                <!-- Include other details as needed -->
            </table>

            <input type="hidden" name="assetId" value="<%= assetDetails.getAssetId() %>">
            <button type="submit">Yes, Delete Asset</button>
        <% } else { %>
            <p>Error retrieving asset information for deletion.</p>
        <% } %>

        <a href="choose_asset_for_deletion.jsp">Cancel</a>
    </form>

</body>
</html>
