<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    int assetId = Integer.parseInt(request.getParameter("assetId"));
    Asset asset = new Asset();
    Asset assetDetails = asset.getAssetById(assetId);

    if (assetDetails == null) {
        response.sendRedirect("error.jsp"); // Redirect to an error page or handle accordingly
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Asset Information</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #3498db;
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

    <div class="container">
        <h1>Update Asset Information</h1>

    <form action="process_update.jsp" method="POST">
        <input type="hidden" name="assetId" value="<%= assetDetails.getAssetId() %>">

        <label for="assetName">Asset Name:</label>
        <input type="text" id="assetName" name="assetName" value="<%= assetDetails.getAssetName() %>" required>

        <label for="description">Description:</label>
        <input type="text" id="description" name="description" value="<%= assetDetails.getDescription() %>" required>

        <label for="assetType">Asset Type:</label>
        <input type="text" id="assetType" name="assetType" value="<%= assetDetails.getAssetType() %>" required>

        <label for="category">Category:</label>
        <input type="text" id="category" name="category" value="<%= assetDetails.getCategory() %>" required>

        <label for="purchaseDate">Purchase Date:</label>
        <input type="date" id="purchaseDate" name="purchaseDate" value="<%= assetDetails.getPurchaseDate() %>" required>

        <label for="purchaseCost">Purchase Cost:</label>
        <input type="text" id="purchaseCost" name="purchaseCost" value="<%= assetDetails.getPurchaseCost() %>" required>

        <label for="warrantyInfo">Warranty Info:</label>
        <input type="text" id="warrantyInfo" name="warrantyInfo" value="<%= assetDetails.getWarrantyInfo() %>" required>

        <label for="assetCondition">Asset Condition:</label>
        <input type="text" id="assetCondition" name="assetCondition" value="<%= assetDetails.getAssetCondition() %>" required>

        <label for="addressId">Address ID:</label>
        <input type="text" id="addressId" name="addressId" value="<%= assetDetails.getAddressId() %>" required>

        <!-- Include other fields as needed -->

        <button type="submit">Update Asset</button>
    </form>

</body>
</html>
