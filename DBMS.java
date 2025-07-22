package com.website;

import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.SQLException;

public class DBMS {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/mydb";
    private static final String JDBC_USERNAME = "root"; // update if needed
    private static final String JDBC_PASSWORD = "Zxcv@12345"; // update if needed

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }
    
   

}
