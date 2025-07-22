<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("role");
%>

<nav class="navbar navbar-expand-lg navbar-light bg-info fixed-top">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand" href="index.jsp">
            <img src="media/logo.jpg.png" alt="Logo" id="logo" style="height: 40px;">
        </a>

        <!-- Toggle button for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Left nav links -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link active" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link active" href="services.jsp">Services</a></li>
                <li class="nav-item"><a class="nav-link active" href="treatments.jsp">Treatments</a></li>
                <li class="nav-item"><a class="nav-link active" href="contactus.jsp">Contact Us</a></li>
            </ul>

            <!-- Right-side actions -->
            <div class="d-flex align-items-center">
                <%
                    if (userEmail == null) {
                %>
                    <a href="login.jsp" class="btn btn-danger me-2">Login</a>
                    <a href="signup.jsp" class="btn btn-primary">Sign Up</a>
                <%
                    } else {
                %>
                    <a href="profile.jsp" class="btn btn-primary me-2">Profile</a>

                    <!-- Dashboard based on role -->
                    <%
                        if ("admin".equals(role)) {
                    %>
                        <a href="appointments" class="btn btn-success me-2">Dashboard</a>
                    <%
                        } else if ("user".equals(role)) {
                    %>
                        <a href="userdashboard.jsp" class="btn btn-success me-2">Dashboard</a>
                    <%
                        }
                    %>

                    <!-- Logout -->
                    <form action="user" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="btn btn-danger">Logout</button>
                    </form>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>
