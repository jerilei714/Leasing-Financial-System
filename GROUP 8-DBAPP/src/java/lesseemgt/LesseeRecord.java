package lesseemgt;



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

public class LesseeRecord {

    // Fields of assets
    public int lessee_id;
    public String name_last;
    public String name_first;
    public String name_middle;
    public String email;
    public Date date_of_birth;
    public int address;
    public String up_field;

    // List
    public ArrayList<Integer> lesseeIdList = new ArrayList<>();
    public ArrayList<String> statusList = new ArrayList<>();

    public LesseeRecord() {
    }

    public int addLessee() {
        try {
            // Connect to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Print a message for debugging
            System.out.println("Connection Successful");

            // Get the next contract ID
            PreparedStatement pstmtId = conn.prepareStatement("SELECT MAX(lessee_id) + 1 AS newID FROM lessees");
            ResultSet rstId = pstmtId.executeQuery();
            while (rstId.next()) {
                lessee_id = rstId.getInt("newID");
            }

            // Insert lease contract into the database
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO lessees VALUES (?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, lessee_id);
            pstmt.setString(2, name_last);
            pstmt.setString(3, name_middle);
            pstmt.setString(4, name_first);
            pstmt.setString(5, email);
            pstmt.setDate(6, new java.sql.Date(date_of_birth.getTime()));

            // Set the correct index for the address placeholder
            if (address != 0) {
                pstmt.setInt(7, address);
            } else {
                pstmt.setNull(7, Types.INTEGER);
            }

            // Execute the update
            pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            pstmtId.close();
            conn.close();
        } catch (Exception e) {
            // Print the exception message for debugging
            e.printStackTrace();
            return 0;
        }

        return 1;
    }
    
    public ArrayList<Integer> getExistingAddresses() {
        ArrayList<Integer> addList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT address_id FROM address");
            ResultSet rs = pstmt.executeQuery();
            // Print a message for debugging
            System.out.println("Connection Successful");

            while (rs.next()) {
                addList.add(rs.getInt("address_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return addList;
    }
    
    public ArrayList<Integer> getExistingLessees() {
        ArrayList<Integer> list = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT lessee_id FROM lessees");
            ResultSet rs = pstmt.executeQuery();
            // Print a message for debugging
            System.out.println("Connection Successful");

            while (rs.next()) {
                list.add(rs.getInt("lessee_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public String getLesseeInfo() {
        StringBuilder lesseeInfo = new StringBuilder();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT lessee_id, name_last, name_middle, name_first, email, date_of_birth, address "
                    + "FROM lessees  WHERE lessee_id = ?");
            pstmt.setInt(1, this.lessee_id);
            ResultSet rs = pstmt.executeQuery();

            // Process the ResultSet
            while (rs.next()) {
                // Retrieve column values and append them to the StringBuilder
                int lesseeId = rs.getInt("lessee_id");
                String nameLast = rs.getString("name_last");
                String nameMiddle = rs.getString("name_middle");
                String nameFirst = rs.getString("name_first");
                String email = rs.getString("email");
                Date dateOfBirth = rs.getDate("date_of_birth");
                int address = rs.getInt("address");

                lesseeInfo.append("Lessee ID: ").append(Integer.toString(lesseeId)).append("\n");
                lesseeInfo.append("Last Name: ").append(nameLast).append("\n");
                lesseeInfo.append("Middle Name: ").append(nameMiddle).append("\n");
                lesseeInfo.append("First Name: ").append(nameFirst).append("\n");
                lesseeInfo.append("Email: ").append(email).append("\n");
                lesseeInfo.append("Date of Birth: ").append(dateOfBirth.toString()).append("\n");
                lesseeInfo.append("Address: ").append(Integer.toString(address)).append("\n");
            }

            // Print a message for debugging
            System.out.println("Connection Successful");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesseeInfo.toString();
    }
    
    public List<Map<String, Object>> filterLessees(Float[] minmax, String min_date, String max_date) {

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            
            String baseQuery = "SELECT l.lessee_id, l.name_last, l.name_first, l.name_middle, f.net_income, i.coverage AS InsuranceCoverage, i.expiration_date AS InsuranceExpiration "
                    + "FROM lessees l LEFT JOIN financial_info f ON l.lessee_id = f.lessee_id LEFT JOIN insurance_info i ON l.lessee_id = i.lessee_id WHERE ";
            
            StringBuilder dynamicQuery = new StringBuilder();
            boolean flag = false;
            
            if (minmax[0] != null) {
                dynamicQuery.append("f.net_income >= ? AND ");
                flag = true;
            } if (minmax[1] != null) {
                dynamicQuery.append("f.net_income <= ? AND ");
                flag = true;
            } if (minmax[2] != null) {
                dynamicQuery.append("i.coverage >= ? AND ");
                flag = true;
            } if (minmax[3] != null) {
                dynamicQuery.append("i.coverage <= ? AND ");
                flag = true;
            } if(min_date != null) {
                dynamicQuery.append("i.expiration_date >= ? AND ");
                flag = true;
            } if (max_date != null) {
                dynamicQuery.append("i.expiration_date <= ? AND ");
                flag = true;
            } 
            
            if (flag)   dynamicQuery.delete(dynamicQuery.length() - 5, dynamicQuery.length());
            else        dynamicQuery.append("1 = 1");

            String finalQuery = baseQuery + dynamicQuery.toString();
            
            System.out.println("Final SQL Query: " + finalQuery);

            PreparedStatement pstmt = conn.prepareStatement(finalQuery);

            int parameterIndex = 1;      
            for(int i=0; i<4; i++)
                if (minmax[i] != null)
                    pstmt.setFloat(parameterIndex++, minmax[i]);

            if (min_date != null)   pstmt.setString(parameterIndex++, min_date);
            if (max_date != null)   pstmt.setString(parameterIndex++, max_date);

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
    
    public int updateLessee() {
        try {
            // Connect to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Print a message for debugging
            System.out.println("Connection Successful");

            // Insert lease contract into the database
            PreparedStatement pstmt = conn.prepareStatement("UPDATE lessees SET " + this.up_field + " = ? WHERE lessee_id = ?");
            
            if(up_field.equals("name_last"))
                pstmt.setString(1, name_last);
            else if(up_field.equals("name_first"))
                pstmt.setString(1, name_first);
            else if(up_field.equals("name_middle"))
                pstmt.setString(1, name_middle);
            else if(up_field.equals("email"))
                pstmt.setString(1, email);
            else if(up_field.equals("date_of_birth"))
                pstmt.setDate(1, new java.sql.Date(date_of_birth.getTime()));
            else if(up_field.equals("address"))
                pstmt.setInt(1, address);
            
            pstmt.setInt(2, lessee_id);
            
            // Execute the update
            pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            // Print the exception message for debugging
            e.printStackTrace();
            return 0;
        }

        return 1;
    }
    
    public int deleteLessee() {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/financial_leasing?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM lessees WHERE lessee_id = ?");
            pstmt.setInt(1, this.lessee_id);
            pstmt.executeUpdate();
            return 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
   
    public static void main(String args[]) {
        
       

        //for testing!!
        LesseeRecord lr = new LesseeRecord();

// Set values for the lessee
lr.name_last = "Smith";
lr.name_middle = "J";
lr.name_first = "John";
lr.email = "john.smith@example.com";
lr.date_of_birth = new Date(); // You can set a specific date here
lr.address = 1001; // Assuming 1 is a valid address ID in your database


        int result = lr.addLessee();

        if (result == 1) {
            System.out.println(result);
        } else {
            System.out.println("Error adding lease contract.");
        }

        } 
    } 
