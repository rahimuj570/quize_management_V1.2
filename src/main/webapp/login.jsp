<%@page import="helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Exam Management System</title>
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

.login-container {
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

.forgot-password, .create-account {
	color: #1abc9c;
	text-decoration: none;
}

.forgot-password:hover, .create-account:hover {
	color: #16a085;
	text-decoration: underline;
}

.text-center a {
	font-size: 0.9rem;
}
</style>

</head>
<body>
	<div class="login-container">
		<div class="card">
			<div class="card-header">Login to Exam Management System</div>
			<div class="card-body p-4">



				<form method="post" action="LoginServlet">
					<%
					if (session.getAttribute("user404") != null) {
					%>

					<div class="alert alert-danger" role="alert">
						<%=session.getAttribute("user404")%>
					</div>

					<%
					session.removeAttribute("user404");
					}
					%>
					<%
					if (session.getAttribute("not-approved") != null) {
					%>

					<div class="alert alert-danger" role="alert">
						<%=session.getAttribute("not-approved")%>
					</div>

					<%
					session.removeAttribute("not-approved");
					}
					%>



					<%
						if (session.getAttribute("success_change_pass") != null) {
						%>


						<div class="alert alert-success" role="alert">
							<%=session.getAttribute("success_change_pass")%>
						</div>



						<%
						session.removeAttribute("success_change_pass");
						}
						%>



					<div class="mb-3">
						<label for="email_id" class="form-label">Email or ID</label> <input
							type="text" class="form-control" id="email_id" name="email_id"
							placeholder="Enter email or ID" required>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">Password</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="Enter password" required>
					</div>
					<div class="mb-3 d-flex justify-content-between">
					<div>
					<input type="checkbox" name ="save_login" value="save_login" id="save-me">
					<label for="save-me">Save Login</label>
					</div>
						<a href="reset_password.jsp" class="forgot-password ">Forgot
							Password?</a>
					</div>
					<button type="submit" class="btn btn-primary">Login</button>
				</form>
				<div class="text-center mt-3">
					<p>
						Don't have an account? <a href="register.jsp"
							class="create-account">Create Account</a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and Popper.js -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>

</html>