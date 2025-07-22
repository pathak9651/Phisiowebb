<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="/webresources/header.jsp" />
<body>
	<jsp:include page="/webresources/navbar.jsp" />
	<div>
		<div class="newCarosoul my-6">

			<div id="myCarousel" class="carousel slide " data-bs-ride="carousel">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="0" class="" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="2" aria-label="Slide 3" class="active"
						aria-current="true"></button>
				</div>
				<div class="carousel-inner">
					<div class="carousel-item">
						<img alt=""
							src="https://images.unsplash.com/photo-1706353399656-210cca727a33?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
							class="bd-placeholder-img" width="100%" height="100%">

						<div class="container">
							<div class="carousel-caption text-start">
								<h1 style="color: black;">About Us</h1>
								<p style="color: black;">"Physiotherapy is not just about
									healing the body it's about restoring movement, rebuilding
									confidence, and reclaiming life."</p>
								<p>
									<a class="btn btn-lg btn-primary" href="tel:9651203151"> <span>
											<i class="fa fa-phone" style="color: white;"></i>
									</span> 9651203151
									</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<img alt=""
							src="https://plus.unsplash.com/premium_photo-1683133816393-b04d94c65872?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
							class="bd-placeholder-img" width="100%" height="100%">

						<div class="container">
							<div class="carousel-caption">
								<h1 style="color: black;">Something More</h1>
								<p style="color: black;">"Move Better. Live Stronger. Heal
									Naturally with Physiotherapy."</p>
								<p>
									<a class="btn btn-lg btn-primary" href="contactus.jsp">Book
										Appointment</a>
								</p>
							</div>
						</div>
					</div>
					<div class="carousel-item active">
						<img alt=""
							src="https://plus.unsplash.com/premium_photo-1661716849429-6796ea134487?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHBoeXNpb3RoZXJhcHl8ZW58MHx8MHx8fDA%3D"
							class="bd-placeholder-img" width="100%" height="100%">

						<div class="container">
							<div class="carousel-caption text-end">
								<h1>One more for good measure.</h1>
								<p>To Know more about our Services, click the button.</p>
								<p>
									<a class="btn btn-lg btn-primary" href="services.jsp">Know
										More</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#myCarousel" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#myCarousel" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>

		<div class="container-fluid bg-dark my-4 border rounded  ">
			<h1 style="color: #6EC1E4; text-align: center; margin-top: 50px;">SARITA
				PHYSIOTHERAPY CLINIC</h1>
			<p
				style="color: #6EC1E4; text-align: center; margin-top: 50px; margin-bottom: 80px">
				Physiotherapy Clinic is clinic that provides Ortho and Sports
				Rehabilitation Services. Established in Gurugram, Haryana, India.
				The Clinic offers a range of Physiotherapy Services to help Patients
				improve their Physical Health. The Clinic is Staffed by Experienced
				Physiotherapists. who use the Latest Techniques Equipment to provide
				Personalized Care to each patient. Our Approach to Physiotherapy
				Assessment and Treatment with Qualified group of Physiotherapists
				altered the Final Result.</p>

			<div class="container marketing"></div>

			<!-- START THE FEATURETTES -->

			<hr class="featurette-divider">

			<div
				class="row featurette d-flex justify-content-center align-items-center my-6"
				style="border-left: 1rem solid red">
				<div class="col-md-7">
					<h2 class="featurette-heading"
						style="color: #6EC1E4; text-align: center; margin-top: 20px;">
						Dr. Atul Pathak <span class="text-muted">(Diploma in
							Physiotherapy)</span>
					</h2>
					<p class="lead"
						style="color: #6EC1E4; text-align: center; margin-top: 50px;">Some
						great placeholder content for the first featurette here. Imagine
						some exciting prose here.</p>
				</div>
				<div class="col-md-5">
					<img alt="" src="media/atul.jpg" class="bd-placeholder-img"
						width="75%" height="75%" style="border-radius: 20px">
				</div>
			</div>

			<hr class="featurette-divider">

			<div
				class="row featurette  d-flex justify-content-center align-items-center"
				style="border-right: 1rem solid green;">
				<div class="col-md-7 order-md-2">
					<h2 class="featurette-heading"
						style="color: #6EC1E4; text-align: center; margin-top: 50px;">
						Oh yeah, its that good. <span class="text-muted">See for
							yourself.</span>
					</h2>
					<p class="lead"
						style="color: #6EC1E4; text-align: center; margin-top: 50px;">Another
						featurette? Of course. More placeholder content here to give you
						an idea of how this layout would work with some actual real-world
						content in place.</p>
				</div>
				<div class="col-md-5 order-md-1">
					<img alt=""
						src="https://media.istockphoto.com/id/1199908661/photo/physiotherapist-treatment-patient-she-holding-patients-hand-shoulder-joint-treatment.jpg?s=612x612&w=0&k=20&c=yghgsRCfhifTxzIS8UqlHIxpyyHDUNXkfqwQHABDRuY="
						class="bd-placeholder-img" width="100%" height="100%">

				</div>
			</div>

			<hr class="featurette-divider ">

			<div
				class="row featurette  d-flex justify-content-center align-items-center"
				style="border-left: 1rem solid blue">
				<div class="col-md-7">
					<h2 class="featurette-heading"
						style="color: #6EC1E4; text-align: center; margin-top: 50px;">
						And lastly, this one. <span class="text-muted">Checkmate.</span>
					</h2>
					<p class="lead"
						style="color: #6EC1E4; text-align: center; margin-top: 50px;">And
						yes, this is the last block of representative placeholder content.
						Again, not really intended to be actually read, simply here to
						give you a better view of what this would look like with some
						actual content. Your content.</p>
				</div>
				<div class="col-md-5">
					<img alt=""
						src="https://media.istockphoto.com/id/1079107724/photo/patient-at-the-physiotherapy-doing-physical-exercises-with-his-therapist.jpg?s=612x612&w=0&k=20&c=j8WZxvdEgc5X9OrdJOH66V0TaaSPMFRgD9XPeROUfXQ="
						class="bd-placeholder-img" width="100%" height="100%">
				</div>
			</div>


			<hr class="featurette-divider">

			<!-- /END THE FEATURETTES -->

		</div>
	</div>

	<jsp:include page="/webresources/footer.jsp" />
</body>
</html>