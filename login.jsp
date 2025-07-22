<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<jsp:include page="/webresources/header.jsp" />
<body class="bg-light">
<jsp:include page="/webresources/navbar.jsp" />

<div class="container mt-5">
    <div class="card shadow rounded-4 p-4 mx-auto" style="max-width: 500px;">
        <h2 class="text-center mb-4">Login</h2>

        <form action="user" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" name="email" id="email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" name="password" id="password" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Login</button>

            <!-- Forgot Password Trigger -->
            <div class="text-center mt-3">
                <a href="forget.jsp" >Forgot Password?</a>
            </div>
        </form>
    </div>
</div>




<jsp:include page="/webresources/footer.jsp" />
</body>
</html>
