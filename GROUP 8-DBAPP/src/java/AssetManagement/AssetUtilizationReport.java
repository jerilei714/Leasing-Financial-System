/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AssetManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author ccslearner
 */
public class AssetUtilizationReport {
    
    //Establish connection to DB
    private static final String DB_URL = "jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678";
    
    public ArrayList<Asset> getAllAssets() {
        ArrayList<Asset> allAssets = new ArrayList<>();
    

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT * FROM assets";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Asset asset = new Asset();
                        asset.setAssetId(rs.getInt("asset_id"));
                        asset.setAssetName(rs.getString("asset_name"));
                        asset.setDescription(rs.getString("description"));
                        asset.setAssetType(rs.getString("asset_type"));
                        asset.setCategory(rs.getString("category"));
                        asset.setPurchaseDate(rs.getDate("purchase_date"));
                        asset.setPurchaseCost(rs.getFloat("purchase_cost"));
                        asset.setWarrantyInfo(rs.getString("warranty_info"));
                        asset.setAssetCondition(rs.getString("asset_condition"));
                        asset.setAddressId(rs.getInt("address_id"));

                        allAssets.add(asset);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return allAssets;
    }
    
    public int getTotalAsset() {
        int count = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT COUNT(*) AS TotalAsset FROM assets";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                ResultSet result = pstmt.executeQuery();
                result.next();
                count = result.getInt("TotalAsset");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int getTotalAssigned() {
        int count = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT COUNT(*) AS TotalAssigned \n" +
                        "FROM assets a LEFT JOIN lease_contracts lc \n" +
                        "ON a.asset_id = lc.asset_id\n" +
                        "WHERE lc.status IN('active','renewed')";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                ResultSet result = pstmt.executeQuery();
                result.next();
                count = result.getInt("TotalAssigned");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int getTotalUnassigned() {
        int count = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT COUNT(*) AS TotalUnassigned \n" +
                        "FROM assets a LEFT JOIN lease_contracts lc \n" +
                        "ON a.asset_id = lc.asset_id\n" +
                        "WHERE lc.status NOT IN('active','renewed')";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               
                ResultSet result = pstmt.executeQuery();
                result.next();
                count = result.getInt("TotalUnassigned");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public float getTotalAssetCost() {
        float sum = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT SUM(purchase_cost) AS TotalCost FROM assets";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                ResultSet result = pstmt.executeQuery();
                result.next();
                float totalCost = result.getFloat("TotalCost");
                sum = totalCost;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sum;
    }
    
    public static ArrayList<AssetConditionReport> getAllConditions() {
        ArrayList<AssetConditionReport> conditions = new ArrayList<>();
    

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT a.asset_condition, \n" + 
                    "COUNT(*) AS count,\n" + 
                    "CONCAT(ROUND(COUNT(a.asset_condition) * 100.0/\n" + 
                    "(SELECT COUNT(*) FROM assets)),'%') AS percentage\n" + 
                    "FROM assets a\n" + 
                    "GROUP BY asset_condition;";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        AssetConditionReport asset = new AssetConditionReport();
                        asset.setCondition(rs.getString("asset_condition"));
                        asset.setCount(rs.getInt("count"));
                        asset.setPercentage(rs.getString("percentage"));
                        conditions.add(asset);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return conditions;
    }
    
    public static ArrayList<MaintenanceSchedule> getOverdueMaintenance(){
        
        ArrayList<MaintenanceSchedule> overdue = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT a.asset_id, a.asset_name, a.asset_type,address_id,\n" +
                        "ms.next_maintenance \n" +
                        "FROM assets a JOIN maintenance_schedule ms ON a.asset_id=ms.asset_id\n" +
                        "WHERE next_maintenance <= curdate();";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        MaintenanceSchedule asset = new MaintenanceSchedule();
                        asset.setAsset_id(rs.getInt("asset_id"));
                        asset.setAsset_name(rs.getString("asset_name"));
                        asset.setAsset_type(rs.getString("asset_type"));
                        asset.setNext_maintenance(rs.getDate("next_maintenance"));
                        overdue.add(asset);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return overdue;
    }
    
    public static ArrayList<MaintenanceSchedule> getUpcomingMaintenance(){
        
        ArrayList<MaintenanceSchedule> upcoming = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT a.asset_id, a.asset_name, a.asset_type,address_id,\n" +
                        "ms.next_maintenance \n" +
                        "FROM assets a JOIN maintenance_schedule ms ON a.asset_id=ms.asset_id\n" +
                        "WHERE next_maintenance >= curdate() AND DATEDIFF(next_maintenance,curdate()) <= 30;";
    
            // for debugging
            System.out.println("Connection Successful");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        MaintenanceSchedule asset = new MaintenanceSchedule();
                        asset.setAsset_id(rs.getInt("asset_id"));
                        asset.setAsset_name(rs.getString("asset_name"));
                        asset.setAsset_type(rs.getString("asset_type"));
                        asset.setNext_maintenance(rs.getDate("next_maintenance"));
                        upcoming.add(asset);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return upcoming;
    }
    
    
}
