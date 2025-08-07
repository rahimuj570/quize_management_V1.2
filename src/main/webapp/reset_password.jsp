<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset Password - Exam Management System</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom CSS -->
<style>
body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.reset-container {
	max-width: 400px;
	width: 100%;
	padding: 20px;
}

.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #fff;
}

.card-header {
	background-color: #2c3e50;
	color: #ecf0f1;
	text-align: center;
	font-weight: bold;
	border-radius: 10px 10px 0 0;
	padding: 15px;
}

.btn-primary {
	background-color: #1abc9c;
	border-color: #1abc9c;
	width: 100%;
}

.btn-primary:hover {
	background-color: #16a085;
	border-color: #16a085;
}

.form-control {
	border-radius: 5px;
}

.text-center a {
	color: #1abc9c;
	text-decoration: none;
	font-size: 0.9rem;
}

.text-center a:hover {
	color: #16a085;
	text-decoration: underline;
}

#step2 {
	display: none;
}
</style>
</head>

<body>
	<div class="reset-container">
		<div class="card">
			<div class="card-header">Reset Password</div>
			<div class="card-body p-4">

				<!-- Step 1: Email Input -->
				<div id="step1">
					<p class="text-center mb-4">Enter your email to receive a reset
						code.</p>
					<form id="emailForm" action="#" method="POST">


						<div class="mb-3">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email" name="email"
								placeholder="Enter email" required>
						</div>
						<button id='btn1' type="submit" class="btn btn-primary">Send
							Reset Code</button>
						<button id='spiner' class="btn btn-primary" type="submit"
							disabled>
							<span class="spinner-border spinner-border-sm" role="status"
								aria-hidden="true"></span> Processing...
						</button>
					</form>
					<div class="text-center mt-3">
						<p>
							Back to <a href="login.jsp">Login</a>
						</p>
					</div>
				</div>



				
				
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and Popper.js -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
	<!-- Custom JS for step transition -->
	<script>
		let vb = document.getElementById('btn1');
		let spiner = document.getElementById('spiner');
		spiner.style.display = 'none';
		vb.style.display = 'block';
		document
				.getElementById('emailForm')
				.addEventListener(
						'submit',
						function(e) {
							e.preventDefault(); // Prevent actual form submission for demo

							spiner.style.display = 'block';
							vb.style.display = 'none';
							
							let email = e.target.email.value;
							console.log(email);
							const ajx = new XMLHttpRequest();
							
							ajx.onreadystatechange = function() {

								

								if (this.readyState === 4) {
									spiner.style.display='none';
									vb.style.display='block';
									if (this.status === 200) {
										if (this.responseText == 'user404') {
											alert('User Not Found!')

										} else if (this.responseText == 'not_approved') {
											alert("Account is not Approved by Admin yet!")

										} else if (this.responseText == 'sent_forgot_pass'
												|| this.responseText == 'already_sent_forgot_pass') {

											alert('Code Sent! Check Your Email.')
											window.location='set_new_password.jsp';

										} else {
											alert('Something went wrong!')
										}
									} else {
										alert('Something went wrong!')
									}
								}
							}

							ajx.open('post', 'ForgotePasswordSentCodeServlet',
									true);
							ajx.setRequestHeader('content-type',
									'application/x-www-form-urlencoded');
							ajx.send("email=" + email);

						});
	</script>







</body>
</html>