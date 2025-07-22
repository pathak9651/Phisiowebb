package com.website;

import java.sql.*;
import java.util.*;

public class AppointmentC {

    // Fetch all appointments
    public List<Map<String, String>> getAllAppointments() {
        List<Map<String, String>> list = new ArrayList<>();
        try (
            Connection con = DBMS.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM appointment");
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Map<String, String> appt = new HashMap<>();
                appt.put("id", rs.getString("id"));
                appt.put("fullname", rs.getString("fullname"));
                appt.put("email", rs.getString("email"));
                appt.put("phone", rs.getString("phone"));
                appt.put("date", rs.getString("date"));
                appt.put("time", rs.getString("time"));
                appt.put("doctor", rs.getString("doctor"));
                appt.put("notes", rs.getString("notes"));
                appt.put("apointId", rs.getString("apointId"));
                appt.put("status", rs.getString("status"));
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // You can add more methods later like:
    // getAppointmentById(), updateStatus(), resheduleAppointment(), etc.
    public static boolean cancelAppointment(String apointId) {
        try (Connection con = DBMS.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE appointment SET status = 'Cancelled' WHERE apointId = ?")) {

            ps.setString(1, apointId);
            int rows = ps.executeUpdate();
            System.out.println("Cancel rows affected: " + rows); // Debug
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public static boolean rescheduleAppointment(String apointId, String date, String time) {
        try (Connection con = DBMS.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE appointment SET date = ?, time = ?, status = 'Rescheduled' WHERE apointId = ?")) {
            
            ps.setString(1, date);       // ✅ Correct: 1st placeholder is date
            ps.setString(2, time);       // ✅ Correct: 2nd is time
            ps.setString(3, apointId);   // ✅ Correct: 3rd is apointId

            int rows = ps.executeUpdate();
            System.out.println("Reschedule rows affected: " + rows);
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static boolean updateStatus(String apointId, String status) {
        boolean result = false;

        try {
            Connection conn = DBMS.getConnection(); // Your existing DB connection class
            String sql = "UPDATE appointment SET status = ? WHERE apointId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, apointId);

            int rows = ps.executeUpdate();
            result = (rows > 0);

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
