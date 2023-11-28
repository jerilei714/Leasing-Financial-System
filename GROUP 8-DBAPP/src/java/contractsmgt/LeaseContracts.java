package contractsmgt;



/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;
import java.util.Date;

public class LeaseContracts {

    // Fields of assets
    public int contractId;
    public Date startDate;  
    public Date endDate; 
    public float monthlyDue;
    public String status;   
    public String paymentHistory;
    public String termsAndConditions;
    public boolean renewalOption; // Should be boolean
    public float depositAmount;
    public int lessee_id;
    public int asset_id;
    public String assetName;
    public String assetType;

    // List
    public ArrayList<Integer> contractIdList = new ArrayList<>();
    public ArrayList<String> statusList = new ArrayList<>();
    
    //getters
    
    public int getContractId() {
        return contractId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public float getMonthlyDue() {
        return monthlyDue;
    }

    public String getStatus() {
        return status;
    }

    public String getPaymentHistory() {
        return paymentHistory;
    }

    public String getTermsAndConditions() {
        return termsAndConditions;
    }

    public boolean isRenewalOption() {
        return renewalOption;
    }

    public float getDepositAmount() {
        return depositAmount;
    }

    public int getLesseeId() {
        return lessee_id;
    }

    public int getAssetId() {
        return asset_id;
    }
    
    public String getAssetName() {
        return assetName;
    }
    
    public String getAssetType() {
        return assetType;
    }
    
    //setters
    
    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setMonthlyDue(float monthlyDue) {
        this.monthlyDue = monthlyDue;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPaymentHistory(String paymentHistory) {
        this.paymentHistory = paymentHistory;
    }

    public void setTermsAndConditions(String termsAndConditions) {
        this.termsAndConditions = termsAndConditions;
    }

    public void setRenewalOption(boolean renewalOption) {
        this.renewalOption = renewalOption;
    }

    public void setDepositAmount(float depositAmount) {
        this.depositAmount = depositAmount;
    }

    public void setLesseeId(int lesseeId) {
        this.lessee_id = lesseeId;
    }

    public void setAssetId(int assetId) {
        this.asset_id = assetId;
    }
    
    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }
    
    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    public LeaseContracts() {
    }

    public int addLeaseContract() {
        try {

            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            System.out.println("Connection Successful");

            PreparedStatement pstmtId = conn.prepareStatement("SELECT MAX(contract_id) + 1 AS newID FROM lease_contracts");
            ResultSet rstId = pstmtId.executeQuery();
            while (rstId.next()) {
                contractId = rstId.getInt("newID");
            }

            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO lease_contracts VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, contractId);
            pstmt.setDate(2, new java.sql.Date(startDate.getTime()));
            pstmt.setDate(3, new java.sql.Date(endDate.getTime()));
            pstmt.setFloat(4, monthlyDue);
            pstmt.setString(5, status);
            pstmt.setString(6, paymentHistory);
            pstmt.setString(7, termsAndConditions);
            pstmt.setBoolean(8, renewalOption);
            pstmt.setFloat(9, depositAmount);

            if (lessee_id != 0) {
                pstmt.setInt(10, lessee_id);
            } else {
                pstmt.setNull(10, Types.INTEGER);
            }

            if (asset_id != 0) {
                pstmt.setInt(11, asset_id);
            } else {
                pstmt.setNull(11, Types.INTEGER);
            }

            pstmt.executeUpdate();

            pstmt.close();
            pstmtId.close();
            conn.close();
        } catch (Exception e) {

            e.printStackTrace();
            return 0;
        }

        return 1;
    }
    
    
    public ArrayList<Integer> getExistingLesseeIds() {
        ArrayList<Integer> lesseeIdList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT lessee_id FROM lessees");
            ResultSet rs = pstmt.executeQuery();
            // Print a message for debugging
            System.out.println("Connection Successful");

            while (rs.next()) {
                lesseeIdList.add(rs.getInt("lessee_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesseeIdList;
    }

    public ArrayList<Integer> getExistingAssetIds() {
        ArrayList<Integer> assetIdList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT asset_id FROM assets");
            ResultSet rs = pstmt.executeQuery();

            System.out.println("Connection Successful");

            while (rs.next()) {
                assetIdList.add(rs.getInt("asset_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assetIdList;
    }
    
    public ArrayList<LeaseContracts> searchLeaseContracts(String searchType, String searchValue) {
        ArrayList<LeaseContracts> searchResults = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            String sql;
            if ("asset_id".equalsIgnoreCase(searchType)) {
                sql = "SELECT * FROM lease_contracts WHERE asset_id = ?";
            } else if ("contract_id".equalsIgnoreCase(searchType)) {
                sql = "SELECT * FROM lease_contracts WHERE contract_id = ?";
            } else {

                return searchResults;
            }

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, searchValue);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        LeaseContracts contract = new LeaseContracts();
                        contract.setContractId(rs.getInt("contract_id"));
                        contract.setAssetId(rs.getInt("asset_id"));
                        contract.setStartDate(rs.getDate("start_date"));
                        contract.setEndDate(rs.getDate("end_date"));
                        contract.setMonthlyDue(rs.getFloat("monthly_due"));
                        contract.setStatus(rs.getString("status"));
                        contract.setPaymentHistory(rs.getString("payment_history"));
                        contract.setTermsAndConditions(rs.getString("terms_and_conditions"));
                        contract.setRenewalOption(rs.getBoolean("renewal_option"));
                        contract.setDepositAmount(rs.getFloat("deposit_amount"));
                        contract.setLesseeId(rs.getInt("lessee_id"));

                        searchResults.add(contract);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchResults;
    } 
    
    public ArrayList<Integer> getExistingContractIds() {
    ArrayList<Integer> contractIdList = new ArrayList<>();

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
        PreparedStatement pstmt = conn.prepareStatement("SELECT contract_id FROM lease_contracts");
        ResultSet rs = pstmt.executeQuery();

        System.out.println("Connection Successful");

        while (rs.next()) {
            contractIdList.add(rs.getInt("contract_id"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return contractIdList;
}

    
public ArrayList<LeaseContracts> filterContractsByLessee(int lesseeId) {
    ArrayList<LeaseContracts> filteredContracts = new ArrayList<>();

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
        String sql = "SELECT lc.*, a.asset_name, a.asset_type FROM lease_contracts lc " +
                     "JOIN assets a ON lc.asset_id = a.asset_id " +
                     "WHERE lc.lessee_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, lesseeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    LeaseContracts contract = new LeaseContracts();
                    contract.setContractId(rs.getInt("contract_id"));
                    contract.setLesseeId(rs.getInt("lessee_id"));
                    contract.setAssetId(rs.getInt("asset_id"));
                    contract.setEndDate(rs.getDate("end_date"));
                    contract.setAssetName(rs.getString("asset_name"));
                    contract.setAssetType(rs.getString("asset_type"));

                    filteredContracts.add(contract);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return filteredContracts;
} 

public int updateLeaseContract(int contractId, int assetId, Date startDate, Date endDate, float monthlyDue, String status,
                               String paymentHistory, String termsAndConditions, boolean renewalOption, float depositAmount) {
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
        String sql = "UPDATE lease_contracts SET asset_id = ?, start_date = ?, end_date = ?, monthly_due = ?, " +
                     "status = ?, payment_history = ?, terms_and_conditions = ?, renewal_option = ?, deposit_amount = ? " +
                     "WHERE contract_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, assetId);
            pstmt.setDate(2, new java.sql.Date(startDate.getTime()));
            pstmt.setDate(3, new java.sql.Date(endDate.getTime()));
            pstmt.setFloat(4, monthlyDue);
            pstmt.setString(5, status);
            pstmt.setString(6, paymentHistory);
            pstmt.setString(7, termsAndConditions);
            pstmt.setBoolean(8, renewalOption);
            pstmt.setFloat(9, depositAmount);
            pstmt.setInt(10, contractId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return 0;
}

public LeaseContracts getLeaseContractDetails(int contractId) {
    LeaseContracts contractDetails = new LeaseContracts();

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
        String sql = "SELECT * FROM lease_contracts WHERE contract_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, contractId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    contractDetails.setContractId(rs.getInt("contract_id"));
                    contractDetails.setLesseeId(rs.getInt("lessee_id"));
                    contractDetails.setAssetId(rs.getInt("asset_id"));
                    contractDetails.setStartDate(rs.getDate("start_date"));
                    contractDetails.setEndDate(rs.getDate("end_date"));
                    contractDetails.setMonthlyDue(rs.getFloat("monthly_due"));
                    contractDetails.setStatus(rs.getString("status"));
                    contractDetails.setPaymentHistory(rs.getString("payment_history"));
                    contractDetails.setTermsAndConditions(rs.getString("terms_and_conditions"));
                    contractDetails.setRenewalOption(rs.getBoolean("renewal_option"));
                    contractDetails.setDepositAmount(rs.getFloat("deposit_amount"));
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return contractDetails;
}

public int deleteLeaseContract(int contractId) {
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
        String sql = "DELETE FROM lease_contracts WHERE contract_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, contractId);
            pstmt.executeUpdate();

            return 1;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return 0;
}


    public static void main(String args[]) {
        
         LeaseContracts leaseContract = new LeaseContracts();

    //for testing!!
    leaseContract.startDate = new Date();  
    leaseContract.endDate = new Date();   
    leaseContract.monthlyDue = 1000.00f;
    leaseContract.status = "active";
    leaseContract.paymentHistory = "none";
    leaseContract.termsAndConditions = "Regular Terms and Conditions";
    leaseContract.renewalOption = false;
    leaseContract.depositAmount = 4000;
    
    

    int result = leaseContract.addLeaseContract();

    if (result == 1) {
        System.out.println("Lease contract added successfully.");
    } else {
        System.out.println("Error adding lease contract.");
    }

    }
}
