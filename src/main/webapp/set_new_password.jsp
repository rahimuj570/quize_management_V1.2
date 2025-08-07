<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Set New Password - Exam Management System</title>
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
</style>
</head>

<body>
	<div class="reset-container">
		<div class="card">
			<div class="card-header">Reset Password</div>
			<div class="card-body p-4">

				<!-- Step 1: Email Input -->




				<!-- Step 2: Verification and New Password -->
				<div id="step2">
					<p class="text-center mb-4">Enter the code sent to your email
						and set a new password.</p>
					<form action="ForgotePasswordCheckCodeServlet" method="POST">


						<%
						if (session.getAttribute("expire_forgot_pass") != null) {
						%>
						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("expire_forgot_pass")%>
						</div>


						<%
						session.removeAttribute("expire_forgot_pass");
						}
						%>
						<%
						if (session.getAttribute("user4042") != null) {
						%>

						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("user4042")%>
						</div>


						<%
						session.removeAttribute("user4042");
						}
						%>
						<%
						if (session.getAttribute("pin404") != null) {
						%>

						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("pin404")%>
						</div>


						<%
						session.removeAttribute("pin404");
						}
						%>
						<%
						if (session.getAttribute("verify404") != null) {
						%>

						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("verify404")%>
						</div>



						<%
						session.removeAttribute("verify404");
						}
						%>
						<%
						if (session.getAttribute("pin_mismatch") != null) {
						%>


						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("pin_mismatch")%>
						</div>


						<%
						session.removeAttribute("pin_mismatch");
						}
						%>
						<%
						if (session.getAttribute("failed_change_pass") != null) {
						%>

						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("failed_change_pass")%>
						</div>



						<%
						session.removeAttribute("failed_change_pass");
						}
						%>
	
						<%
						if (session.getAttribute("pass_mismatch") != null) {
						%>

						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("pass_mismatch")%>
						</div>


						<%
						session.removeAttribute("pass_mismatch");
						}
						%>
						<%
						if (session.getAttribute("invalid_pin") != null) {
						%>
						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("invalid_pin")%>
						</div>
						<%
						session.removeAttribute("invalid_pin");
						}
						%>












						<div class="mb-3">
							<label for="verificationCode" class="form-label">Verification
								Code</label> <input type="text" class="form-control"
								id="verificationCode" name="code" placeholder="Enter code"
								required>
						</div>
						<div class="mb-3">
							<label for="retypeEmail" class="form-label">Retype Email</label>
							<input type="email" class="form-control" id="retypeEmail"
								name="email" placeholder="Retype email" required>
						</div>
						<div class="mb-3">
							<label for="newPassword" class="form-label">New Password</label>
							<input type="password" class="form-control" id="newPassword"
								name="password" placeholder="Enter new password" required>
						</div>
						<div class="mb-3">
							<label for="retypePassword" class="form-label">Retype
								Password</label> <input type="password" class="form-control"
								id="retypePassword" name="re_password"
								placeholder="Retype password" required>
						</div>
						<button type="submit" class="btn btn-primary">Reset
							Password</button>
					</form>
					<div class="text-center mt-3">
						<p>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2z"/>
  <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466"/>
</svg><a href="reset_password.jsp">Change Email or Request for a new pin</a>
						</p>
					</div>
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






</body>
</html>