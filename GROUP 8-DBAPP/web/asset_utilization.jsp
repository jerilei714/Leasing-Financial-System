<%-- 
    Document   : asset_utilization
    Created on : 11 15, 23, 6:00:54 PM
    Author     : ccslearner
--%>

<%@page import="AssetManagement.MaintenanceSchedule"%>
<%@page import="AssetManagement.Asset"%>
<%@page import="AssetManagement.AssetConditionReport"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Leasing Financial System Application</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            h1 {
                color: #333;
                text-align: center;
                margin-top: 50px;
            }
            
            h2 {
                color: #666;
                text-align: center;
                margin-bottom: 10px;
            }

            h4 {
                color: #666;
                text-align: center;
                margin-bottom: 10px;
            }

            ul {
                list-style-type: none;
                padding: 0;
                text-align: center;
            }

            li {
                margin: 10px 0;
            }

            a {
                text-decoration: none;
                color: #3498db;
                font-weight: bold;
                font-size: 18px;
                transition: color 0.3s ease;
            }

            a:hover {
                color: #2070a0;
            }
            
            div {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            
            table, th, td{
            color: #666;
            text-align: left;
            margin-bottom: 10px;    
            padding: 20px;
            font-weight: bold;
            font-size: 15px;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid black;
            border-collapse: collapse;
            }
            
        </style>
    </head>
    <body>
        <h1>Asset Utilization Report</h1>
        
        <%  Asset asset = new Asset(); 
            int totalAsset = asset.getTotalAsset();
            int totalAssigned = asset.getTotalAssigned();
            int totalUnassigned = asset.getTotalUnassigned();
            
            String assignedPrecent = ((float)asset.getTotalAssigned()/totalAsset * 100)+"%";
            String unassignedPrecent = ((float)asset.getTotalAssigned()/totalAsset * 100)+"%";
        %>
        <div>
            <h4>Total Asset: <%=totalAsset%></h4>
            <h4>Total Assigned: <%=totalAssigned%> (<%=assignedPrecent%>) </h4>
            <h4>Total Unassigned: <%=totalUnassigned%> (<%=unassignedPrecent%>)</h4>
        </div>
        <div>
            <h4>Total Asset Cost: <%=asset.getTotalAssetCost()%></h4>
        </div>
        <div>
            <h4>Asset Condition</h4>
            <table>
                <thead>
                    <tr>
                        <th>Condition</th>
                        <th>Count</th>
                        <th>Percent</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    ArrayList<AssetConditionReport> conditionList = Asset.getAllConditions();
                    for (AssetConditionReport condition : conditionList) {
                %>
                    <tr>
                        <td><%=condition.getCondition()%></td>
                        <td><%=condition.getCount()%></td>
                        <td><%=condition.getPercentage()%></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
                <%
                    ArrayList<MaintenanceSchedule> overdueList = Asset.getOverdueMaintenance();
                    ArrayList<MaintenanceSchedule> upcomingList = Asset.getUpcomingMaintenance();
                    int overdueSize = overdueList.size();
                    int upcomingSize = upcomingList.size();
                %>
                
        <div>
            <h2>Asset Maintenance</h2>
            <h4>Overdue Maintenance: <%=overdueSize%></h4>
            <table>
                <thead>
                    <tr>
                        <th>Asset ID</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Next Maintenance</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(MaintenanceSchedule overdue : overdueList) {
                %>
                    <tr>
                        <td><%=overdue.getAsset_id()%></td>
                        <td><%=overdue.getAsset_name()%></td>
                        <td><%=overdue.getAsset_type()%></td>
                        <td><%=overdue.getNext_maintenance()%></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
                <h4>Upcoming: <%=upcomingSize%></h4>
                <table>
                    <thead>
                        <tr>
                            <th>Asset ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Next Maintenance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for(MaintenanceSchedule upcoming : upcomingList) {
                    %>
                        <tr>
                            <td><%=upcoming.getAsset_id()%></td>
                            <td><%=upcoming.getAsset_name()%></td>
                            <td><%=upcoming.getAsset_type()%></td>
                            <td><%=upcoming.getNext_maintenance()%></td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
        </div>
    </body>
</html>
