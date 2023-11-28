/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PaymentManagement;

/**
 *
 * @author ccslearner
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PaymentRecord {
    public int payment_id;
    public int lesee_id;
    public Date date_of_payment;
    public float amount_paid;
    public String payment_method;
    public String status;
    public int lease_contract;
    public float late_fee;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678";

    // Constructor
    public PaymentRecord(){

    }
    
    public PaymentRecord(int lesee_id, Date date_of_payment, float amount_paid, 
                        String payment_method, String status, int lease_contract, 
                        float late_fee) {
        this.lesee_id = lesee_id;
        this.date_of_payment = date_of_payment;
        this.amount_paid = amount_paid;
        this.payment_method = payment_method;
        this.status = status;
        this.lease_contract = lease_contract;
        this.late_fee = late_fee;
    }

    //getters
    
    /**
     * @return the amount_paid
     */
    
    public int getPaymentID() {
        return payment_id;
    }
    
    
    public float getAmount_paid() {
        return amount_paid;
    }

    /**
     * @return the date_of_payment
     */
    public Date getDate_of_payment() {
        return date_of_payment;
    }
    
    /**
     * @return the late_fee
     */
    public float getLate_fee() {
        return late_fee;
    }

    /**
     * @return the lease_contract
     */
    public int getLease_contract() {
        return lease_contract;
    }

    /**
     * @return the lesee_id
     */
    public int getLesee_id() {
        return lesee_id;
    }

    /**
     * @return the payment_method
     */
    public String getPayment_method() {
        return payment_method;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    //setters

    /**
     * @param amount_paid the amount_paid to set
     */
    public void setAmount_paid(float amount_paid) {
        this.amount_paid = amount_paid;
    }

    /**
     * @param date_of_payment the date_of_payment to set
     */
    public void setDate_of_payment(Date date_of_payment) {
        this.date_of_payment = date_of_payment;
    }

    /**
     * @param late_fee the late_fee to set
     */
    public void setLate_fee(float late_fee) {
        this.late_fee = late_fee;
    }

    /**
     * @param lease_contract the lease_contract to set
     */
    public void setLease_contract(int lease_contract) {
        this.lease_contract = lease_contract;
    }

    /**
     * @param lesee_id the lessee_id to set
     */
    public void setLesee_id(int lesee_id) {
        this.lesee_id = lesee_id;
    }
    
    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    /**
     * @param payment_method the payment_method to set
     */
    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int addPaymentRecord() {
        try {

            Connection conn = DriverManager.getConnection(DB_URL);

            System.out.println("Connection Successful");

            PreparedStatement pstmtId = conn.prepareStatement("SELECT MAX(payment_id) + 1 AS newID FROM payment_record");
            ResultSet rstId = pstmtId.executeQuery();
            
            while (rstId.next()) {
                payment_id = rstId.getInt("newID");
            }

            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO payment_record VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, payment_id);
            pstmt.setInt(2, lesee_id);
            pstmt.setDate(3, new java.sql.Date(date_of_payment.getTime()));
            pstmt.setFloat(4, amount_paid);
            pstmt.setString(5, payment_method);
            pstmt.setString(6, status);
            pstmt.setInt(7, lease_contract);
            pstmt.setFloat(8, late_fee);
            
            
        //(30001, 99991, '2023-12-01', 1500, 'Online', 'Completed', 10001, NULL);
        
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
    
    public List<Integer> getAllPaymentIDs() {
           List<Integer> paymentIDs = new ArrayList<>();

           try (Connection conn = DriverManager.getConnection(DB_URL)) {
               System.out.println("Connection Successful");

               // Query to retrieve valid Asset IDs
               String query = "SELECT payment_id FROM payment_record";
               try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                   try (ResultSet rs = pstmt.executeQuery()) {
                       while (rs.next()) {
                           paymentIDs.add(rs.getInt("payment_id"));
                       }
                   }
               }

           } catch (SQLException e) {
               e.printStackTrace();
           }

           System.out.println("Valid Asset IDs: " + payment_id); // Add this line for debugging

           return paymentIDs;
    }
    
    public PaymentRecord getPaymentRecordById(int payment_id) {
        PaymentRecord payment = null;
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to retrieve asset details based on the asset ID
            String query = "SELECT * FROM payment_record WHERE payment_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, payment_id);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        payment = new PaymentRecord();
                        payment.payment_id = rs.getInt("payment_id");
                        payment.lesee_id = rs.getInt("leesee_id");
                        payment.date_of_payment = rs.getDate("date_of_payment");
                        payment.amount_paid = rs.getFloat("amount_paid");
                        payment.payment_method = rs.getString("payment_method");
                        payment.status = rs.getString("status");
                        payment.lease_contract = rs.getInt("lease_contract");
                        payment.late_fee = rs.getFloat("late_fee");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payment;
    }
    
    public int updatePaymentRecord(int payment_id, int lesee_id, Date date_of_payment,
                                float amount_paid, String payment_method, String status,
                                int lease_contract, float late_fee) {
        
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to update asset information
            String query = "UPDATE payment_record SET leesee_id= ?, date_of_payment = ?, amount_paid = ?," +
                            "payment_method = ?, status = ?, lease_contract = ?, late_fee = ?" +
                            "WHERE payment_id = ?";
            
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, lesee_id);
                pstmt.setDate(2, new java.sql.Date(date_of_payment.getTime()));
                pstmt.setFloat(3, amount_paid);
                pstmt.setString(4, payment_method);
                pstmt.setString(5, status);
                pstmt.setInt(6, lease_contract);
                pstmt.setFloat(7, late_fee);
                pstmt.setInt(8, payment_id);

                int rowsUpdated = pstmt.executeUpdate();
                
                System.out.println("Rows Updated: " + rowsUpdated); // For debugging
                
                return rowsUpdated;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    
    public int deleteAsset(int payment_id) {
        int result = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            System.out.println("Connection Successful");

            // Query to delete an asset based on the asset ID
            String query = "DELETE FROM payment_record WHERE payment_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, payment_id);

                // Execute the delete query
                result = pstmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public ArrayList<PaymentRecord> filterPaymentsByLessee(int lesseeId) {
    ArrayList<PaymentRecord> filteredRecords = new ArrayList<>();

    try (Connection conn = DriverManager.getConnection(DB_URL)) {
        String sql = "SELECT * FROM payment_record WHERE leesee_id= ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, lesseeId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PaymentRecord payment = new PaymentRecord();
                    payment.payment_id = rs.getInt("payment_id");
                    payment.lesee_id = rs.getInt("leesee_id");
                    payment.date_of_payment = rs.getDate("date_of_payment");
                    payment.amount_paid = rs.getFloat("amount_paid");
                    payment.payment_method = rs.getString("payment_method");
                    payment.status = rs.getString("status");
                    payment.lease_contract = rs.getInt("lease_contract");
                    payment.late_fee = rs.getFloat("late_fee");
                    
                    filteredRecords.add(payment);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return filteredRecords;
} 
    
    public ArrayList<PaymentRecord> filterPaymentsByContract(int contractID) {
    ArrayList<PaymentRecord> filteredRecords = new ArrayList<>();

    try (Connection conn = DriverManager.getConnection(DB_URL)) {
        String sql = "SELECT * FROM payment_record WHERE lease_contract= ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, contractID);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PaymentRecord payment = new PaymentRecord();
                    payment.payment_id = rs.getInt("payment_id");
                    payment.lesee_id = rs.getInt("leesee_id");
                    payment.date_of_payment = rs.getDate("date_of_payment");
                    payment.amount_paid = rs.getFloat("amount_paid");
                    payment.payment_method = rs.getString("payment_method");
                    payment.status = rs.getString("status");
                    payment.lease_contract = rs.getInt("lease_contract");
                    payment.late_fee = rs.getFloat("late_fee");
                    
                    filteredRecords.add(payment);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return filteredRecords;
} 
    
    public List<Map<String, Object>> generateReport(String year, String month) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            
            String baseQuery = "SELECT * FROM payment_record WHERE YEAR(date_of_payment) = ?";
            
            StringBuilder dynamicQuery = new StringBuilder();
            
            if (Integer.parseInt(month) > 0)
                dynamicQuery.append(" AND MONTH(date_of_payment) = ?");

            String finalQuery = baseQuery + dynamicQuery.toString();

            System.out.println("Final SQL Query: " + finalQuery);
            
            PreparedStatement pstmt = conn.prepareStatement(finalQuery);
            
            pstmt.setInt(1, Integer.parseInt(year));

            if (Integer.parseInt(month) > 0) pstmt.setInt(2, Integer.parseInt(month));

            ResultSet resultSet = pstmt.executeQuery();
            
            List<Map<String, Object>> resultList = new ArrayList<>();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (resultSet.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    Object value = resultSet.getObject(i);
                    row.put(columnName, value);
                }
                resultList.add(row);
            }

            return resultList;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static void main(String args[]) {
        
        PaymentRecord leaseContract = new PaymentRecord();


    ArrayList<PaymentRecord> record = leaseContract.filterPaymentsByContract(10001) ;

    for(int i=0; i< record.size();i++){
        System.out.println(record);
    }
    
    }
}

