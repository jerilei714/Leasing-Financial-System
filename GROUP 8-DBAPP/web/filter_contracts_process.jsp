<%@ page import="contractsmgt.LeaseContracts" %>
<%@ page import="java.util.ArrayList" %>

<%
    int lesseeId = Integer.parseInt(request.getParameter("lesseeId"));

    LeaseContracts leaseContracts = new LeaseContracts();

    ArrayList<LeaseContracts> filteredContracts = leaseContracts.filterContractsByLessee(lesseeId);
    
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filtered Contracts</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #3498db;
            margin-top: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #ddd;
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

        tr:hover {
            background-color: #f5f5f5;
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
    <!-- Display the filtered contracts in a table or other suitable format -->
    <h2>Filtered Contracts for Lessee ID: <%= lesseeId %></h2>
    <table border="1">
        <thead>
            <tr>
                <th>Contract ID</th>
                <th>Lessee ID</th>
                <th>Asset ID</th>
                <th>End Date</th>
                <th>Asset Name</th>
                <th>Asset Type</th>
            </tr>
        </thead>
        <tbody>
            <% for (LeaseContracts contract : filteredContracts) { %>
            
                <tr>
                    <td><%= contract.getContractId() %></td>
                    <td><%= contract.getLesseeId() %></td>
                    <td><%= contract.getAssetId() %></td>
                    <td><%= contract.getEndDate() %></td>
                    <td><%= contract.getAssetName() %></td>
                    <td><%= contract.getAssetType() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
    
    <!-- "Back to Lease Contracts Menu" button -->
    <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
    <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
</body>
</html>








