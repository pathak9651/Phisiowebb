<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/webresources/header.jsp" />
<body>
    <jsp:include page="/webresources/navbar.jsp" />

    <div class="container p-2">
        <div class="row">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div>
                    <h2 style="margin-left: 40px;">Contact Information</h2>
                    <div class="contact">
                        <div class="contact-list">
                            <div class="info-text address">
                                <span><i class="fa fa-map-marker"></i> Pusauli, Robertsganj, Sonbhadra,<br> Uttar Pradesh 231216</span>
                                <br>
                                <span><i class="fa fa-map-marker"></i> Sarita Physiotherapy, Pusauli, Robertsganj, Sonbhadra, Uttar Pradesh 231216</span>
                            </div>
                            <div class="info-text phone mt-2">
                                <span><i class="fa fa-phone"></i>
                                    <a href="tel:+919651203151">+91-9651203151</a>,
                                    <a href="tel:+917307645571">+91-7307645571</a>
                                </span>
                            </div>
                            <div class="info-text address mt-2">
                                <span><i class="fa fa-envelope-o"></i>
                                    <a href="mailto:pathakayush8194@gmail.com">pathakayush8194@gmail.com</a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <a href="#">
                        <img alt="logo" src="media/logo.jpg.png" width="120" height="120"
                             style="border-radius: 75px; object-fit: cover;">
                    </a>
                </div>
            </div>
        </div>

        <div class="form m-4">
            <div class="form-decoration d-flex justify-content-start align-items-start mb-3 form-control my-3 bg-sky p-4">
                <form class="appointment-form w-100" style="margin-top: 20px;" method="post" action="bookAppointment">
                    <h3 class="mb-4">Book Your Appointment</h3>

                    <div class="form-group mb-3">
                        <label for="fname">Full Name *</label>
                        <input type="text" class="form-control" id="fname" name="fname" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="phone">Phone Number *</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="email">Email Address *</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="date">Preferred Date *</label>
                        <input type="date" class="form-control" id="date" name="date" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="time">Time *</label>
                        <input type="time" class="form-control" id="time" name="time" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="doctor">Preferred Doctor *</label>
                        <select class="form-control" id="doctor" name="doctor" required>
                            <option value="">Select doctor</option>
                            <option value="Dr. Atul Pathak">Dr. Atul Pathak</option>
                            <option value="Dr. Ashish Mishra">Dr. Ashish Mishra</option>
                            <option value="Dr. Ayush Pathak">Dr. Ayush Pathak</option>
                        </select>
                    </div>

                    <div class="form-group mb-3">
                        <label for="message">Additional Note</label>
                        <textarea class="form-control" id="message" name="message" rows="3" placeholder="Write the symptoms or any requests"></textarea>
                    </div>

                    <div class="form-group d-flex mt-4" style="justify-content: space-between;">
                        <button type="submit" class="btn btn-primary">Book Appointment</button>
                        <a class="btn btn-success" href="tracking.jsp">Track Status</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for response -->
    <div class="modal fade" id="responseModal" tabindex="-1" aria-labelledby="responseModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="responseModalLabel">Booking Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalMessage">
                    <!-- Dynamic content inserted via JS -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/webresources/footer.jsp" />

    <!-- JavaScript to handle form submission -->
    <script>
        document.querySelector('.appointment-form').addEventListener('submit', function (e) {
            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);
            const submitBtn = form.querySelector('button[type="submit"]');
            submitBtn.disabled = true;

            fetch('bookAppointment', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
            	console.log(data);
            	console.log("Fullname:", data.fullname);
                let messageHtml = '';
                if (data.status === 'success') {
                    messageHtml = '<div class="alert alert-success" role="alert">' +
                    '<div class="card text-center text-success p-3">' + 
                    	'<strong>Appointment Booked Successfully!</strong><br>' +
                    '</div>' +
                    '<strong>Appointment ID:</strong> ' + data.apointId + '<br>' +
                    '<strong>Name:</strong> ' + data.fullname + '<br>' +
                    '<strong>Phone:</strong> ' + data.phone + '<br>' +
                    '<strong>Email:</strong> ' + data.email + '<br>' +
                    '<strong>Date:</strong> ' + data.date + '<br>' +
                    '<strong>Time:</strong> ' + data.time + '<br>' +
                    '<strong>Doctor:</strong> ' + data.doctor + '<br>' +
                    '<strong>Message:</strong> ' + data.message + '<br>' +
                '</div>';
                        
                    form.reset();
                } else {
                    resultContainer.innerHTML =
                        '<div class="card p-4 shadow-sm border-danger">' +
                            '<p><strong>Appointment ID:</strong> ' + data.message + '</p>' +
                        '</div>';
                }

                document.getElementById('modalMessage').innerHTML = messageHtml;
                new bootstrap.Modal(document.getElementById('responseModal')).show();
                submitBtn.disabled = false;
            })
            .catch(err => {
                document.getElementById('modalMessage').innerHTML = `
                    <div class="alert alert-danger" role="alert">
                        <strong>Unexpected Error:</strong> ${err.message}
                    </div>
                `;
                new bootstrap.Modal(document.getElementById('responseModal')).show();
                submitBtn.disabled = false;
            });
        });
    </script>
</body>
</html>
