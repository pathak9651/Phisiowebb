<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("role");

    if (userEmail == null || "admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <jsp:include page="/webresources/header.jsp" />
</head>
<body class="bg-light">
    <jsp:include page="/webresources/navbar.jsp" />

    <div class="container mt-5">
        <div class="card shadow rounded-4 p-5 text-center">
            <h2 class="mb-4">Welcome, <%= session.getAttribute("userName") %>!</h2>
            <p class="lead">This is your dashboard.</p>
            <p>You are logged in as a regular user. Use the navigation bar to explore services, book appointments, or contact us.</p>
        </div>
    </div>

    <jsp:include page="/webresources/footer.jsp" />
</body>
</html>
