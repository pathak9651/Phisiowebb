package com.website;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/CURD")
public class CURD extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // READ
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String sql = "SELECT * FROM testTable WHERE id = ?";
        response.setContentType("text/plain");

        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            PrintWriter out = response.getWriter();

            if (rs.next()) {
                out.println("ID: " + rs.getInt("id"));
                out.println("First Name: " + rs.getString("firstname"));
                out.println("Last Name: " + rs.getString("lastname"));
                out.println("Mobile: " + rs.getString("mobile"));
                out.println("Email: " + rs.getString("email"));
            } else {
                out.println("No record found for ID: " + id);
            }
        } catch (SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    // CREATE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");

        String sql = "INSERT INTO testTable (firstname, lastname, mobile, email) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, firstname);
            stmt.setString(2, lastname);
            stmt.setString(3, mobile);
            stmt.setString(4, email);
            stmt.executeUpdate();

            response.getWriter().write("Record created successfully.");
        } catch (SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    // UPDATE
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Manually parse body since HttpServlet doesn't parse PUT parameters by default
        String body = request.getReader().lines().reduce("", (acc, line) -> acc + line);
        String[] params = body.split("&");

        String id = null, firstname = null, lastname = null, mobile = null, email = null;

        for (String param : params) {
            String[] keyValue = param.split("=");
            switch (keyValue[0]) {
                case "id": id = keyValue[1]; break;
                case "firstname": firstname = keyValue[1]; break;
                case "lastname": lastname = keyValue[1]; break;
                case "mobile": mobile = keyValue[1]; break;
                case "email": email = keyValue[1]; break;
            }
        }

        String sql = "UPDATE testTable SET firstname = ?, lastname = ?, mobile = ?, email = ? WHERE id = ?";

        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, firstname);
            stmt.setString(2, lastname);
            stmt.setString(3, mobile);
            stmt.setString(4, email);
            stmt.setInt(5, Integer.parseInt(id));
            int rows = stmt.executeUpdate();

            response.getWriter().write(rows > 0 ? "Record updated successfully." : "Record not found.");
        } catch (SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    // DELETE
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Manually parse body for DELETE
        String body = request.getReader().lines().reduce("", (acc, line) -> acc + line);
        String[] params = body.split("&");
        String id = null;

        for (String param : params) {
            if (param.startsWith("id=")) {
                id = param.split("=")[1];
                break;
            }
        }

        if (id == null) {
            response.getWriter().write("Missing ID for deletion.");
            return;
        }

        String sql = "DELETE FROM testTable WHERE id = ?";

        try (Connection conn = DBMS.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(id));
            int rows = stmt.executeUpdate();
            response.getWriter().write(rows > 0 ? "Record deleted successfully." : "Record not found.");
        } catch (SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
