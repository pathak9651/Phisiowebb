package com.website;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.ResultSet;

@WebServlet("/user")
public class UserS extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserC userController = new UserC();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("text/html");

        try {
            switch (action) {
                case "signup": {
                    String uname = request.getParameter("username");
                    String email = request.getParameter("email");
                    String pass = request.getParameter("password");

                    // Encrypt password
                    String encPass = BCrypt.hashpw(pass, BCrypt.gensalt(10));
                    boolean signedUp = userController.signup(uname, email, encPass);

                    if (signedUp) {
                        response.sendRedirect("index.jsp");
                    } else {
                        response.sendRedirect("signup.jsp?error=1");
                    }
                    break;
                }

                case "login": {
                    String logEmail = request.getParameter("email");
                    String logPass = request.getParameter("password");

                    // Fetch hashed password from DB
                    String hashedPass = userController.getPass(logEmail);

                    if (hashedPass != null && BCrypt.checkpw(logPass, hashedPass)) {
                        User user = userController.getUserByEmail(logEmail);

                        if (user == null) {
                            response.sendRedirect("login.jsp?error=usernotfound");
                            return;
                        }

                        HttpSession session = request.getSession();
                        session.setAttribute("userEmail", user.getEmail());
                        session.setAttribute("userName", user.getName());
                        session.setAttribute("role", user.getRole());

                        // Redirect based on role
                        if ("admin".equals(user.getRole())) {
                            response.sendRedirect("index.jsp");
                        } else {
                            response.sendRedirect("index.jsp");
                        }
                    } else {
                        response.sendRedirect("login.jsp?error=invalid");
                    }
                    break;
                }

                case "logout": {
                    HttpSession session = request.getSession(false);
                    if (session != null) session.invalidate();
                    response.sendRedirect("index.jsp");
                    break;
                }

                default:
                    response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // For fetching profile via GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("text/html");

        try {
            if ("profile".equals(action)) {
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("userEmail") == null) {
                    response.getWriter().println("Please login to view profile.");
                    return;
                }

                String email = (String) session.getAttribute("userEmail");
                ResultSet rs = userController.getProfile(email);

                if (rs.next()) {
                    response.getWriter().println("Username: " + rs.getString("username") + "<br>");
                    response.getWriter().println("Email: " + rs.getString("email") + "<br>");
                } else {
                    response.getWriter().println("Profile not found.");
                }

                rs.getStatement().getConnection().close();
            } else {
                response.getWriter().println("Invalid GET action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
