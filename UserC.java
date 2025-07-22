
 package com.website;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserC {

    public boolean signup(String username, String email, String password) throws SQLException {
        String sql = "INSERT INTO user (username, email, passward) VALUES (?, ?, ?)";
        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM user WHERE email = ? AND passward = ?";
        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
    
    public User getUserByEmail(String email) {
        User user = null;
        try {
            Connection con = DBMS.getConnection();
            String sql = "SELECT * FROM user WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("username");   // ✅ correct column
                String password = rs.getString("passward"); // ✅ correct column
                String role = rs.getString("role");       // ✅ role column you added

                user = new User(name, email, password, role);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }


      public String getPass(String email) throws SQLException {
        String sql = "SELECT passward FROM user WHERE email = ?";
        try (
            Connection conn = DBMS.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("passward");
                }
            }
        }
        return null;
    }

    public ResultSet getProfile(String email) throws SQLException {
        String sql = "SELECT * FROM user WHERE email = ?";
        Connection conn = DBMS.getConnection(); // Don't close yet, caller must close
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        return stmt.executeQuery(); // Caller must handle closing
    }


   
}


