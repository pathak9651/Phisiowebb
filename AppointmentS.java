package com.website;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.*;

@WebServlet("/appointments")
public class AppointmentS extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        AppointmentC controller = new AppointmentC();
        List<Map<String, String>> appointments = controller.getAllAppointments();


        request.setAttribute("appointments", appointments);
        RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String apointId = request.getParameter("apointId");
        System.out.println("Received POST: apointId=" + apointId + ", action=" + action);

        if (action != null && apointId != null) {
            String newStatus = action.equals("accept") ? "Accepted"
                             : action.equals("reject") ? "Rejected"
                             : null;

            if (newStatus != null) {
                boolean success = AppointmentC.updateStatus(apointId, newStatus);
                response.setContentType("text/plain");
                response.getWriter().write(success
                    ? "Appointment status updated to: " + newStatus
                    : "Failed to update appointment.");
            } else {
                response.setStatus(400);
                response.getWriter().write("Invalid action.");
            }
        } else {
            response.setStatus(400);
            response.getWriter().write("Missing parameters.");
        }
    }

}
