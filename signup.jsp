<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="/webresources/header.jsp" />
<body>
	<jsp:include page="/webresources/navbar.jsp" />
    <div class="container mt-5">
        <div class="card shadow rounded-4 p-4 mx-auto" style="max-width: 500px;">
            <h2 class="text-center mb-4">Sign Up</h2>
            <form action="user" method="post">
                <input type="hidden" name="action" value="signup">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" id="username" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" name="email" id="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" id="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Create Account</button>
            </form>
        </div>
    </div>
    <jsp:include page="/webresources/footer.jsp" />
</body>
</html>
