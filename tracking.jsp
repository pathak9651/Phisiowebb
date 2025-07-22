<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/webresources/header.jsp" />
<body>
<jsp:include page="/webresources/navbar.jsp" />

<div class="container text-center mt-5 mb-5">
  <div class="card p-4 shadow">
    <h2 class="mb-4">Track Appointment Status</h2>

    <div class="form-group mb-3 d-flex align-items-center justify-content-center">
      <input type="text" class="form-control me-3" id="trackId" placeholder="e.g., APT0015" style="max-width: 300px;">
      <button class="btn btn-success" onclick="trackAppointment()">Check Status</button>
    </div>

    <div id="trackResult"></div>
    <div id="editModalContainer"></div>
  </div>
</div>

<jsp:include page="/webresources/footer.jsp" />

<script>
function cancelAppointment(apointId) {
  if (!confirm("Are you sure to cancel this appointment?")) return;

  fetch("bookAppointment", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: "action=cancel&apointId=" + encodeURIComponent(apointId)
  })
  .then(res => res.json())
  .then(data => {
    if (data.success) {
      alert("Appointment cancelled successfully.");
      trackAppointment();
    } else {
      alert("Failed to cancel appointment.");
    }
  })
  .catch(err => {
    console.error(err);
    alert("Error cancelling appointment.");
  });
}

function trackAppointment() {
  const apointId = document.getElementById('trackId').value.trim();
  const resultContainer = document.getElementById('trackResult');
  document.getElementById('editModalContainer').innerHTML = ""; // Clear edit form

  if (!apointId) {
    resultContainer.innerHTML = `
      <div class="alert alert-warning">Please enter a valid Appointment ID.</div>
    `;
    return;
  }

  fetch("bookAppointment?apointId=" + encodeURIComponent(apointId))
    .then(res => {
      if (!res.ok) throw new Error("Appointment not found");
      return res.json();
    })
    .then(data => {
    	console.log(data); // <-- Keep this to debug

    	if (data.status === 'success') {
    	  console.log("apointId:", data.apointId); // Should print something like APT0021

        resultContainer.innerHTML =
          '<div class="card border-success shadow-sm">' +
            '<div class="card-header bg-success text-white text-center">' +
              '<h5 class="mb-0">Appointment Details</h5>' +
            '</div>' +
            '<div class="card-body">' +
              '<div class="mb-2"><strong>Appointment ID:</strong> ' + data.apointId + '</div>' +
              '<div class="mb-2"><strong>Name:</strong> ' + data.fullname + '</div>' +
              '<div class="mb-2"><strong>Phone:</strong> ' + data.phone + '</div>' +
              '<div class="mb-2"><strong>Email:</strong> ' + data.email + '</div>' +
              '<div class="mb-2"><strong>Date:</strong> ' + data.date + '</div>' +
              '<div class="mb-2"><strong>Time:</strong> ' + data.time + '</div>' +
              '<div class="mb-2"><strong>Doctor:</strong> ' + data.doctor + '</div>' +
              '<div class="mb-2"><strong>Message:</strong> ' + data.message + '</div>' +
              '<div class="mt-3"><strong>Status:</strong> <span class="badge bg-info text-dark">' + data.appointmentStatus + '</span></div>' +
              '<div class="mt-3">' +
              '<button class="btn btn-warning me-2" onclick="showEditForm(\'' +
              data.apointId + '\')">Edit Appointment</button>' +
                '<button class="btn btn-danger" onclick="cancelAppointment(\'' + data.apointId + '\')">Cancel Appointment</button>' +
              '</div>' +
            '</div>' +
          '</div>';
      } else {
        resultContainer.innerHTML =
          '<div class="card p-4 shadow-sm border-danger">' +
            '<p><strong>Appointment ID:</strong> ' + data.message + '</p>' +
          '</div>';
      }
    })
    .catch(error => {
      resultContainer.innerHTML = `
        <div class="alert alert-danger">Error: ${error.message}</div>
      `;
    });
}

function showEditForm(apointId, date = '', time = '') {
    const container = document.getElementById("editModalContainer");
    console.log("I am Here");
    console.log(apointId);

    container.innerHTML = 
        '<div class="card mt-4 p-3 shadow">' +
            '<h5>Edit Appointment: ' + apointId + '</h5>' +
            '<div class="mb-2">' +
                '<label for="editDate' + apointId + '" class="form-label">New Date:</label>' +
                '<input type="date" class="form-control" id="editDate' + apointId + '" value="' + date + '">' +
            '</div>' +
            '<div class="mb-2">' +
                '<label for="editTime' + apointId + '" class="form-label">New Time:</label>' +
                '<input type="time" class="form-control" id="editTime' + apointId + '" value="' + time + '">' +
            '</div>' +
            '<button class="btn btn-primary mt-2" onclick="rescheduleAppointment(\'' + apointId + '\')">Save Changes</button>' +
        '</div>';
}

function rescheduleAppointment(apointId) {
    const date = document.getElementById("editDate" + apointId).value;
    const time = document.getElementById("editTime" + apointId).value;
    console.log("Sending apointId: ", apointId);

    fetch("bookAppointment", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "action=edit&apointId=" + encodeURIComponent(apointId) +  
              "&date=" + encodeURIComponent(date) +
              "&time=" + encodeURIComponent(time)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert("Appointment rescheduled successfully.");
            trackAppointment(); // Optional refresh
        } else {
            alert("Failed to reschedule appointment.");
        }
    })
    .catch(err => {
        console.error(err);
        alert("Error rescheduling appointment.");
    });
}
</script>

</body>
</html>
