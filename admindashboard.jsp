<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>

<%
HttpSession sessio = request.getSession(false);
String role = (session != null) ? (String) session.getAttribute("role") : null;
if (role == null || !"admin".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - Appointments</title>
<jsp:include page="/webresources/header.jsp" />
<style>
.table a {
	text-decoration: none;
}
</style>
</head>
<body class="bg-light">

	<jsp:include page="/webresources/navbar.jsp" />

	<div class="container mt-5">
		<div class="card shadow rounded-4 p-4">
			<h2 class="mb-4 text-center">All Appointments</h2>

			<div class="table-responsive">
				<table class="table table-bordered align-middle text-center">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Full Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Date</th>
							<th>Time</th>
							<th>Doctor</th>
							<th>Notes</th>
							<th>Appointment ID</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
                    List<Map<String, String>> appointments = (List<Map<String, String>>) request.getAttribute("appointments");
                    if (appointments != null && !appointments.isEmpty()) {
                        for (Map<String, String> appt : appointments) {
                    %>
						<tr>
							<td><%= appt.get("id") %></td>
							<td><%= appt.get("fullname") %></td>
							<td><a href="mailto:<%= appt.get("email") %>"><%= appt.get("email") %></a></td>
							<td><a href="tel:<%= appt.get("phone") %>"><%= appt.get("phone") %></a></td>
							<td><%= appt.get("date") %></td>
							<td><%= appt.get("time") %></td>
							<td><%= appt.get("doctor") %></td>
							<td><%= appt.get("notes") %></td>
							<td><a href="javascript:void(0);"
								onclick="openAdminModal('<%= appt.get("apointId") %>')"> <%= appt.get("apointId") %>
							</a></td>
							<td><%= appt.get("status") %></td>
						</tr>
						<%
                        }
                    } else {
                    %>
						<tr>
							<td colspan="10" class="text-center text-danger fw-bold">No
								appointments found.</td>
						</tr>
						<%
                    }
                    %>
					</tbody>
				</table>
			</div>
		</div>
	</div>



	<!-- Modal Script -->
	<script>
function openAdminModal(apointId) {
    console.log("Clicked apointId:", apointId); // ✅ Debug line

    var modalHtml = ''
        + '<div class="modal fade show" id="statusModal" tabindex="-1" style="display:block; background-color:rgba(0,0,0,0.5); z-index:1050;">'
        + '  <div class="modal-dialog">'
        + '    <div class="modal-content border-0 shadow rounded-4">'
        + '      <div class="modal-header bg-primary text-white">'
        + '        <h5 class="modal-title">Update Appointment Status</h5>'
        + '        <button type="button" class="btn-close" onclick="closeStatusModal()"></button>'
        + '      </div>'
        + '      <div class="modal-body text-center">'
        + '        <h4 class="text-dark fw-bold">' + "AppointId : " + apointId + '</h4>'
        + '        <div class="mt-3">'
        + '          <button class="btn btn-success me-2" onclick="updateAppointmentStatus(\'' + apointId + '\', \'accept\')">Accept</button>'
        + '          <button class="btn btn-danger" onclick="updateAppointmentStatus(\'' + apointId + '\', \'reject\')">Reject</button>'
        + '        </div>'
        + '      </div>'
        + '    </div>'
        + '  </div>'
        + '</div>';

    document.getElementById("statusModalContainer").innerHTML = modalHtml;
}




function closeStatusModal() {
    document.getElementById("statusModalContainer").innerHTML = "";
}

function updateAppointmentStatus(apointId, action) {
    const label = action === "accept" ? "Accept" : "Reject";

    if (!confirm("Are you sure you want to " + label + " this appointment?")) return;

    fetch("appointments", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "action=" + encodeURIComponent(action) + "&apointId=" + encodeURIComponent(apointId)
    })
    .then(response => response.text())
    .then(result => {
        alert(result);
        location.reload();
    })
    .catch(error => {
        console.error("Error:", error);
        alert("Failed to update appointment status.");
    });
}
</script>
	<!-- Modal Container -->
	<div id="statusModalContainer"></div>

	<jsp:include page="/webresources/footer.jsp" />

</body>
</html>
