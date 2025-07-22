<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="/webresources/header.jsp" />
<body>
	<jsp:include page="/webresources/navbar.jsp" />

<div class="pt-5">
	<div class="container mt-5 mb-5">
	    <div class="card shadow rounded-4 p-4 mx-auto" style="max-width: 600px;">
	        <h2 class="text-center mb-4">Profile</h2>
	        <div id="profileContent" class="text-center text-muted mb-5">
	            Loading profile...
	        </div>
	    </div>
	</div>
</div>


<jsp:include page="/webresources/footer.jsp" />

<script>
    window.addEventListener("DOMContentLoaded", () => {
        fetch("user?action=profile")
            .then(response => response.text())
            .then(data => {
                document.getElementById("profileContent").innerHTML = data;
            })
            .catch(error => {
                document.getElementById("profileContent").innerHTML =
                    `<div class="alert alert-danger">Error loading profile.</div>`;
                console.error("Profile fetch error:", error);
            });
    });
</script>
</body>
</html>
