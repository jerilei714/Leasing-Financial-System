<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    int assetId = Integer.parseInt(request.getParameter("assetId"));
    Asset asset = new Asset();
    int deleteResult = asset.deleteAsset(assetId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Asset</title>
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
            text-align: center;
        }

        h1 {
            text-align: center;
            color: #e74c3c;
        }

        p {
            margin-bottom: 16px;
        }

        a {
            display: block;
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 16px;
        }

        a:hover {
            background-color: #2070a0;
        }
    </style>
</head>
<body>

    <form>
        <h1>Delete Asset</h1>

        <% if (deleteResult == 1) { %>
            <p>Asset with ID <%= assetId %> has been successfully deleted.</p>
        <% } else { %>
            <p>Error deleting asset with ID <%= assetId %>.</p>
        <% } %>

        <a href="asset_info.html">Back to Asset Information</a>
    </form>

</body>
</html>
