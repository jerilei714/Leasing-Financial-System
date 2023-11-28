<%-- 
    Document   : search_lease_contract
    Created on : 11 14, 23, 11:41:18 PM
    Author     : ccslearner
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, contractsmgt.*" %>

<%
    // Assuming you have a LeaseContracts class with a method like searchLeaseContracts
    String searchType = request.getParameter("searchType");
    String searchValue = request.getParameter("searchValue");

    // Validate searchType and searchValue

    LeaseContracts leaseContract = new LeaseContracts();
    ArrayList<LeaseContracts> searchResults = leaseContract.searchLeaseContracts(searchType, searchValue);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lease Contract Search Results</title>
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

        h1 {
            margin: 20px 0;
        }

        table {
            max-width: 800px;
            width: 100%;
            border-collapse: collapse;
            margin: 20px;
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

        p {
            margin-top: 20px;
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
    <h1>Lease Contract Search Results</h1>

    <% if (searchResults.isEmpty()) { %>
        <p>No results found.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Contract ID</th>
                    <th>Asset ID</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Monthly Due</th>
                    <th>Status</th>
                    <th>Payment History</th>
                    <th>Terms and Conditions</th>
                    <th>Renewal Option</th>
                    <th>Deposit Amount</th>
                    <th>Lessee ID</th>
                </tr>
            </thead>
            <tbody>
                <% for (LeaseContracts result : searchResults) { %>
                    <tr>
                        <td><%= result.getContractId() %></td>
                        <td><%= result.getAssetId() %></td>
                        <td><%= result.getStartDate() %></td>
                        <td><%= result.getEndDate() %></td>
                        <td><%= result.getMonthlyDue() %></td>
                        <td><%= result.getStatus() %></td>
                        <td><%= result.getPaymentHistory() %></td>
                        <td><%= result.getTermsAndConditions() %></td>
                        <td><%= result.isRenewalOption() %></td>
                        <td><%= result.getDepositAmount() %></td>
                        <td><%= result.getLesseeId() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <!-- "Back to Lease Contracts Menu" button -->
    <a href="lease_contracts.html"><button type="button">Back to Lease Contracts Menu</button></a>
    <button type="button" onclick="location.href='index.html'">Back to Main Menu</button>
</body>
</html>




