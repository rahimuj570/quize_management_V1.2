<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if (session.getAttribute("verify_user_id") == null)
	response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Account - Exam Management System</title>
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

.verify-container {
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

.btn-secondary {
	background-color: #34495e;
	border-color: #34495e;
	width: 100%;
}

.btn-secondary:hover {
	background-color: #2c3e50;
	border-color: #2c3e50;
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
	<div class="verify-container">
		<div class="card">
			<div class="card-header">Verify Your Account</div>
			<div class="card-body p-4">
				<p class="text-center mb-4">Enter the 6 characters verification
					code sent to your email.</p>
				<form id="register_form" method="POST">
					<div class="mb-3">
						<label for="verificationCode" class="form-label">Verification
							Code</label> <input type="text" class="form-control"
							id="verificationCode" name="code" placeholder="Enter code"
							required>
					</div>
					<button id='verify_btn' type="submit" class="btn btn-primary mb-3">Verify
						Account</button>
					<button id='spiner' class="btn btn-primary" type="submit" disabled>
						<span class="spinner-border spinner-border-sm" role="status"
							aria-hidden="true"></span> Processing...
					</button>
				</form>

				<button type="submit" id='resentCode' class="btn btn-secondary">Request
					New Code</button>
				<button id='spiner2' class="btn btn-secondary" type="submit" disabled>
					<span class="spinner-border spinner-border-sm" role="status"
						aria-hidden="true"></span> Processing...
				</button>

				<div class="text-center mt-3">
					<p>
						Back to <a href="login.jsp">Login</a>
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







	<script>
	let spiner = document.getElementById('spiner');
	let spiner2 = document.getElementById('spiner2');
	let vb = document.getElementById('verify_btn');
	spiner.style.display='none';
	spiner2.style.display='none';
document.getElementById("register_form").addEventListener("submit",(e)=>{
	spiner.style.display='block';
	vb.style.display='none';
	e.preventDefault();
	let code=e.target.code.value;
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner.style.display='none';
			vb.style.display='block';
			if(this.status===200){
				if(this.responseText=='valid'){
					alert('Successfully Verified!')
					window.location='login.jsp'
				}else if(this.responseText=='invalid'){
					alert("Invalid Pin Code!")
				}else if(this.responseText=='expire'){
					alert('Expired Pin Code!')
				}else if(this.responseText=='mismatch'){
					alert("Code is not Matched!")
				}else if(this.responseText=='request_new_pin'){
					alert("Request for a new code!")
				}
			}else{
				alert('Server Error!')
			}
		}
	}
	
	ajx.open('post','VerifyCodeServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("code="+code);
});

let rb = document.getElementById("resentCode");
rb.addEventListener("click",()=>{
	spiner2.style.display='block';
	rb.style.display='none';
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner2.style.display='none';
			rb.style.display='block';
			if(this.status===200){
				if(this.responseText=='sent'){
					alert('Check Your Email!')
				}else if(this.responseText=='not_sent'){
					alert("Your old pin_code is not expire yet!")
			}else if(this.responseText=='user_not_exist'){
					alert("Invalid Account!")
			}else if(this.responseText=='login_redirect'){
					window.location='login.jsp';
			}else{
				alert('Server Error!')
			}
		}
	}
	}
	
	ajx.open('post','ResentCodeServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("c=c");
});
</script>
</body>
</html>