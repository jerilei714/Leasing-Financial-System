package AssetManagement;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Asset {

    // Fields of assets
    public int assetId;
    public String assetName;
    public String description;
    public String assetType;
    public String category;
    public Date purchaseDate;
    public float purchaseCost;
    public String warrantyInfo;
    public String assetCondition;
    public int addressId;

    // List
    private static final String DB_URL = "jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678";

    public Asset() {
    }

        // Constructors, getters, and setters


    public Asset(int assetId, String assetName, String description, String assetType, String category,
                 Date purchaseDate, float purchaseCost, String warrantyInfo, String assetCondition, int addressId) {
        this.assetId = assetId;
        this.assetName = assetName;
        this.description = description;
        this.assetType = assetType;
        this.category = category;
        this.purchaseDate = purchaseDate;
        this.purchaseCost = purchaseCost;
        this.warrantyInfo = warrantyInfo;
        this.assetCondition = assetCondition;
        this.addressId = addressId;
    }

    // Getters and setters for each field

    public int getAssetId() {
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAssetType() {
        return assetType;
    }

    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public float getPurchaseCost() {
        return purchaseCost;
    }

    public void setPurchaseCost(float purchaseCost) {
        this.purchaseCost = purchaseCost;
    }

    public String getWarrantyInfo() {
        return warrantyInfo;
    }

    public void setWarrantyInfo(String warrantyInfo) {
        this.warrantyInfo = warrantyInfo;
    }

    public String getAssetCondition() {
        return assetCondition;
    }

    public void setAssetCondition(String assetCondition) {
        this.assetCondition = assetCondition;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }
    public int addAsset() {
    try (Connection conn = DriverManager.getConnection(DB_URL)) {
        System.out.println("Connection Successful");

        try (PreparedStatement pstmtId = conn.prepareStatement("SELECT MAX(asset_id) + 1 AS newID FROM assets");
             ResultSet rstId = pstmtId.executeQuery()) {

            while (rstId.next()) {
                assetId = rstId.getInt("newID");
            }
        }

        try (PreparedStatement pstmt = conn.prepareStatement("INSERT INTO assets VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            pstmt.setInt(1, assetId);
            pstmt.setString(2, assetName);
            pstmt.setString(3, description);
            pstmt.setString(4, assetType);
            pstmt.setString(5, category);
            pstmt.setDate(6, new java.sql.Date(purchaseDate.getTime()));
            pstmt.setFloat(7, purchaseCost);
            pstmt.setString(8, warrantyInfo);
            pstmt.setString(9, assetCondition);
            pstmt.setInt(10, addressId);

            pstmt.executeUpdate();
        }

        System.out.println("Successful");
    } catch (SQLException e) {
        e.printStackTrace();
        return 0;
    }

    return 1;
    }
    
    public Asset getAssetById(int assetId) {
        Asset asset = null;
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to retrieve asset details based on the asset ID
            String query = "SELECT * FROM assets WHERE asset_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, assetId);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        asset = new Asset();
                        asset.assetId = rs.getInt("asset_id");
                        asset.assetName = rs.getString("asset_name");
                        asset.description = rs.getString("description");
                        asset.assetType = rs.getString("asset_type");
                        asset.category = rs.getString("category");
                        asset.purchaseDate = rs.getDate("purchase_date");
                        asset.purchaseCost = rs.getFloat("purchase_cost");
                        asset.warrantyInfo = rs.getString("warranty_info");
                        asset.assetCondition = rs.getString("asset_condition");
                        asset.addressId = rs.getInt("address_id");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return asset;
    }
    
    // Fetch valid Asset IDs from the database
        public List<Integer> getValidAssetIds() {
           List<Integer> validAssetIds = new ArrayList<>();

           try (Connection conn = DriverManager.getConnection(DB_URL)) {
               System.out.println("Connection Successful");

               // Query to retrieve valid Asset IDs
               String query = "SELECT asset_id FROM assets";
               try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                   try (ResultSet rs = pstmt.executeQuery()) {
                       while (rs.next()) {
                           validAssetIds.add(rs.getInt("asset_id"));
                       }
                   }
               }

           } catch (SQLException e) {
               e.printStackTrace();
           }

           System.out.println("Valid Asset IDs: " + validAssetIds); // Add this line for debugging

           return validAssetIds;
       }
        
            public List<Asset> searchAssets(String searchType, String searchValue) {
           List<Asset> searchResults = new ArrayList<>();

           try (Connection conn = DriverManager.getConnection(DB_URL)) {
               String sql;

               // Construct SQL query based on search type
               if ("asset_id".equalsIgnoreCase(searchType)) {
                   sql = "SELECT * FROM assets WHERE asset_id = ?";
               } else if ("asset_name".equalsIgnoreCase(searchType)) {
                   sql = "SELECT * FROM assets WHERE asset_name LIKE ?";
               } else {
                   return searchResults;
               }

               try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                   // Set parameters based on search type
                   if ("asset_id".equalsIgnoreCase(searchType)) {
                       pstmt.setInt(1, Integer.parseInt(searchValue));
                   } else if ("asset_name".equalsIgnoreCase(searchType)) {
                       pstmt.setString(1, "%" + searchValue + "%");
                   }

                   try (ResultSet rs = pstmt.executeQuery()) {
                       while (rs.next()) {
                           Asset asset = new Asset();
                           asset.assetId = rs.getInt("asset_id");
                           asset.assetName = rs.getString("asset_name");
                           asset.description = rs.getString("description");
                           asset.assetType = rs.getString("asset_type");
                           asset.category = rs.getString("category");
                           asset.purchaseDate = rs.getDate("purchase_date");
                           asset.purchaseCost = rs.getFloat("purchase_cost");
                           asset.warrantyInfo = rs.getString("warranty_info");
                           asset.assetCondition = rs.getString("asset_condition");
                           asset.addressId = rs.getInt("address_id");

                           searchResults.add(asset);
                       }
                   }
               }

           } catch (SQLException e) {
               e.printStackTrace();
           }

           return searchResults;
       }
            
        public List<Asset> searchAssetsByType(String assetType) {
        List<Asset> searchResults = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to retrieve assets based on asset type
            String query = "SELECT * FROM assets WHERE asset_type = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, assetType);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Asset asset = new Asset();
                        asset.assetId = rs.getInt("asset_id");
                        asset.assetName = rs.getString("asset_name");
                        asset.description = rs.getString("description");
                        asset.assetType = rs.getString("asset_type");
                        asset.category = rs.getString("category");
                        asset.purchaseDate = rs.getDate("purchase_date");
                        asset.purchaseCost = rs.getFloat("purchase_cost");
                        asset.warrantyInfo = rs.getString("warranty_info");
                        asset.assetCondition = rs.getString("asset_condition");
                        asset.addressId = rs.getInt("address_id");

                        searchResults.add(asset);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchResults;
    }
        
        public List<String> getAvailableAssetTypes() {
        List<String> availableAssetTypes = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to retrieve distinct asset types
            String query = "SELECT DISTINCT asset_type FROM assets";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        availableAssetTypes.add(rs.getString("asset_type"));
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Available Asset Types: " + availableAssetTypes); // For debugging

        return availableAssetTypes;
    }
    
        public int updateAsset(int assetId, String assetName, String description, String assetType, String category,
                            Date purchaseDate, float purchaseCost, String warrantyInfo, String assetCondition, int addressId) {
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to update asset information
            String query = "UPDATE assets SET asset_name = ?, description = ?, asset_type = ?, category = ?, " +
                    "purchase_date = ?, purchase_cost = ?, warranty_info = ?, asset_condition = ?, address_id = ? " +
                    "WHERE asset_id = ?";
            
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, assetName);
                pstmt.setString(2, description);
                pstmt.setString(3, assetType);
                pstmt.setString(4, category);
                pstmt.setDate(5, new java.sql.Date(purchaseDate.getTime()));
                pstmt.setFloat(6, purchaseCost);
                pstmt.setString(7, warrantyInfo);
                pstmt.setString(8, assetCondition);
                pstmt.setInt(9, addressId);
                pstmt.setInt(10, assetId);

                int rowsUpdated = pstmt.executeUpdate();
                
                System.out.println("Rows Updated: " + rowsUpdated); // For debugging
                
                return rowsUpdated;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
        
        public int deleteAsset(int assetId) {
        int result = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to delete an asset based on the asset ID
            String query = "DELETE FROM assets WHERE asset_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, assetId);

                // Execute the delete query
                result = pstmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
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


    public static void main(String[] args) {
        Asset asset = new Asset();

        // Sample data for testing
        asset.assetName = "Phone";
        asset.description = "High-performance laptop for business use";
        asset.assetType = "Electronics";
        asset.category = "IT Equipment";
        asset.purchaseDate = new Date();
        asset.purchaseCost = 1200.00f;
        asset.warrantyInfo = "1-year warranty";
        asset.assetCondition = "Excellent";
        asset.addressId = 1002;

        int result = asset.addAsset();

        if (result == 1) {
            System.out.println("Asset added successfully.");
            // Testing getAssetById
            Asset retrievedAsset = asset.getAssetById(asset.assetId);
            if (retrievedAsset != null) {
                System.out.println("Retrieved Asset Details:");
                System.out.println("Asset ID: " + retrievedAsset.assetId);
                System.out.println("Asset Name: " + retrievedAsset.assetName);
                // Display other details as needed
            } else {
                System.out.println("Error retrieving asset details.");
            }
        } else {
            System.out.println("Error adding asset.");
        }
        
        // Test the getValidAssetIds method
        List<Integer> validAssetIds = asset.getValidAssetIds();
        System.out.println("Valid Asset IDs: " + validAssetIds);
    
    }
}

