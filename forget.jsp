<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<jsp:include page="/webresources/header.jsp" />
<body class="bg-light">
<jsp:include page="/webresources/navbar.jsp" />

<div class="container mt-5">
    <div class="card shadow rounded-4 p-4 mx-auto" style="max-width: 500px;">
        <h2 class="text-center mb-4">forgot Password</h2>

       

        <% if (request.getParameter("status") != null) { %>
            <div class="alert alert-info mt-3 text-center">
                <% if ("mismatch".equals(request.getParameter("status"))) { %>
                    Passwords do not match.
                <% } else if ("updated".equals(request.getParameter("status"))) { %>
                    Password successfully updated.
                <% } else if ("failed".equals(request.getParameter("status"))) { %>
                    Error updating password.
                <% } %>
            </div>
        <% } %>
    </div>
</div>

<jsp:include page="/webresources/footer.jsp" />
</body>
</html>
