package com.website;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // ✅ import this
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/bookAppointment")
@MultipartConfig // ✅ this enables multipart/form-data handling
public class Apoint extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String apointId = request.getParameter("apointId");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        System.out.println("Action: " + action + ", ApointId: " + apointId); // Debug
       
        if ("cancel".equals(action)) {
            boolean success = AppointmentC.cancelAppointment(apointId);
            System.out.println("Cancel success: " + success); // Debug
            out.print("{\"success\": " + success + "}");
            return;
        }
        if ("edit".equals(action)) {
            apointId = request.getParameter("apointId"); // No `String` if already declared above
            String date = request.getParameter("date");
            String time = request.getParameter("time");

            System.out.println("Edit for: " + apointId + ", Date: " + date + ", Time: " + time);

            boolean success = AppointmentC.rescheduleAppointment(apointId, date, time);
            System.out.println("Edit success: " + success);
            out.print("{\"success\": " + success + "}");
            return;
        }
      


        // ✅ 3. Otherwise, it's a New Appointment
        String fullName = request.getParameter("fname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String doctor = request.getParameter("doctor");
        String message = request.getParameter("message");

        // Validation
        if (fullName == null || fullName.isEmpty() ||
            phone == null || phone.isEmpty() ||
            email == null || email.isEmpty() ||
            date == null || date.isEmpty() ||
            time == null || time.isEmpty() ||
            doctor == null || doctor.isEmpty()) {

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out1 = response.getWriter()) {
                out1.write("{\"status\":\"error\",\"message\":\"All required fields must be filled.\"}");
            }
            return;
        }

        // Insert Appointment
        try (Connection conn = DBMS.getConnection()) {
            String apointId1 = generateNextAppointmentId(conn);
            String status = "Pending";

            String sql = "INSERT INTO appointment (fullname, email, phone, date, time, doctor, notes, apointId, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, date);
                stmt.setString(5, time);
                stmt.setString(6, doctor);
                stmt.setString(7, message);
                stmt.setString(8, apointId1);
                stmt.setString(9, status);
                stmt.executeUpdate();
            }

            // Send JSON response
            try (PrintWriter out1 = response.getWriter()) {
                out1.write("{");
                out1.write("\"status\":\"success\",");
                out1.write("\"apointId\":\"" + escapeJson(apointId1) + "\",");
                out1.write("\"fullname\":\"" + escapeJson(fullName) + "\",");
                out1.write("\"phone\":\"" + escapeJson(phone) + "\",");
                out1.write("\"email\":\"" + escapeJson(email) + "\",");
                out1.write("\"date\":\"" + escapeJson(date) + "\",");
                out1.write("\"time\":\"" + escapeJson(time) + "\",");
                out1.write("\"doctor\":\"" + escapeJson(doctor) + "\",");
                out1.write("\"message\":\"" + escapeJson(message) + "\"");
                out1.write("}");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out1 = response.getWriter()) {
                out1.write("{\"status\":\"error\",\"message\":\"Internal server error occurred. Please try again later.\"}");
            }
        }
    }


    private String generateNextAppointmentId(Connection conn) throws SQLException {
        String lastId = null;
        String query = "SELECT apointId FROM appointment ORDER BY apointId DESC LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                lastId = rs.getString("apointId");
            }
        }

        if (lastId == null) {
            return "APT0001";
        } else {
            int num = 0;
            try {
                num = Integer.parseInt(lastId.substring(3));
            } catch (NumberFormatException e) {
                num = 0;
            }
            return String.format("APT%04d", num + 1);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String apointId = request.getParameter("apointId");

        if (apointId == null || apointId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\",\"message\":\"Missing appointment ID.\"}");
            }
            return;
        }

        try (Connection conn = DBMS.getConnection()) {
            String sql = "SELECT fullname, email, phone, date, time, doctor, notes, status FROM appointment WHERE apointId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, apointId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        try (PrintWriter out = response.getWriter()) {
                            out.write("{");
                            out.write("\"status\":\"success\",");
                            out.write("\"apointId\":\"" + escapeJson(apointId) + "\",");
                            out.write("\"fullname\":\"" + escapeJson(rs.getString("fullname")) + "\",");
                            out.write("\"phone\":\"" + escapeJson(rs.getString("phone")) + "\",");
                            out.write("\"email\":\"" + escapeJson(rs.getString("email")) + "\",");
                            out.write("\"date\":\"" + escapeJson(rs.getString("date")) + "\",");
                            out.write("\"time\":\"" + escapeJson(rs.getString("time")) + "\",");
                            out.write("\"doctor\":\"" + escapeJson(rs.getString("doctor")) + "\",");
                            out.write("\"message\":\"" + escapeJson(rs.getString("notes")) + "\",");
                            out.write("\"appointmentStatus\":\"" + escapeJson(rs.getString("status")) + "\"");
                            out.write("}");
                        }
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        try (PrintWriter out = response.getWriter()) {
                            out.write("{\"status\":\"error\",\"message\":\"Appointment ID not found.\"}");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\",\"message\":\"Database error occurred.\"}");
            }
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
