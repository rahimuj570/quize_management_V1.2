<%@page import="entities.Sections"%>
<%@page import="entities.BatchClass"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - Exam Management System</title>
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

.register-container {
	max-width: 500px;
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

.form-control, .form-select {
	border-radius: 5px;
}

.form-check-label {
	margin-left: 10px;
}

.student-fields {
	display: none;
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
.hide-spinners::-webkit-outer-spin-button,
.hide-spinners::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.hide-spinners[type=number] {
  -moz-appearance: textfield;
}
</style>
</head>


<%
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
ArrayList<BatchClass> batchList = bsDao.getAllClass();
ArrayList<Sections> sectionList = bsDao.getAllSection();
%>

<body>
	<div class="register-container">
		<div class="card">
			<div class="card-header">Create Account - Exam Management
				System</div>
			<div class="card-body p-4">
				<form id='register_form' action="#" method="POST">
					<div class="mb-3">
						<label for="fname" class="form-label">First Name</label> <input
							type="text" class="form-control" id="fname" name="fname"
							placeholder="Enter first name" required>
					</div>
					<div class="mb-3">
						<label for="lname" class="form-label">Last Name</label> <input
							type="text" class="form-control" id="lname" name="lname"
							placeholder="Enter last name" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">Email</label> <input
							type="email" class="form-control" id="email" name="email"
							placeholder="Enter email" required>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">Password</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="Enter password" required>
					</div>
					<div class="mb-3">
						<label for="id" class="form-label">ID</label> <input type="number"
							class="form-control hide-spinners" id="id" name="id" placeholder="Enter ID"
							required>
					</div>
					<div class="mb-3">
						<label class="form-label">Role</label>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="role"
								id="roleStudent" value="0" checked> <label
								class="form-check-label" for="roleStudent">Student</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="role"
								id="roleTeacher" value="1"> <label
								class="form-check-label" for="roleTeacher">Teacher</label>
						</div>
					</div>
					<div class="mb-3 student-fields">
						<label for="batch" class="form-label">Batch</label> <select
							class="form-select" id="batch" name="batch">
							<%
							for (BatchClass btch : batchList) {
							%>
							<option value="<%=btch.getId()%>"><%=bsDao.getBatchNameById(btch.getId())%></option>
							<%
							}
							%>
						</select>
					</div>
					<div class="mb-3 student-fields">
						<label for="section" class="form-label">Section</label> 
						<select
							class="form-select" id="section" name="section">

							<%
							for (Sections sec : sectionList) {
							%>
							<option value="<%=sec.getId()%>"><%=bsDao.getSectionNameById(sec.getId()).equals("ALL") ? "N/A" : bsDao.getSectionNameById(sec.getId())%></option>
							<%
							}
							%>
						</select>
					</div>

					<button id='spiner' class="btn btn-primary" type="submit" disabled>
						<span class="spinner-border spinner-border-sm" role="status"
							aria-hidden="true"></span> Loading...
					</button>



					<button id='reg_btn' type="submit" class="btn btn-primary">Register</button>
				</form>
				<div class="text-center mt-3">
					<p>
						Already have an account? <a href="login.jsp">Login</a>
					</p>
				</div>
			</div>
		</div>
	</div>


</body>
<!-- Bootstrap JS and Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script>

const roleStudent = document.getElementById('roleStudent');
const roleTeacher = document.getElementById('roleTeacher');
const studentFields = document.querySelectorAll('.student-fields');

function toggleStudentFields() {
    if (roleStudent.checked) {
        studentFields.forEach(field => field.style.display = 'block');
    } else {
        studentFields.forEach(field => field.style.display = 'none');
    }
}

roleStudent.addEventListener('change', toggleStudentFields);
roleTeacher.addEventListener('change', toggleStudentFields);

// Initialize on page load
toggleStudentFields();


	let spiner = document.getElementById('spiner');
	let reg_btn = document.getElementById('reg_btn');
	spiner.style.display='none';
document.getElementById("register_form").addEventListener("submit",(e)=>{
	spiner.style.display='block';
	reg_btn.style.display='none';
	e.preventDefault();
	let fname=e.target.fname.value;
	let lname=e.target.lname.value;
	let id=e.target.id.value;
	let password=e.target.password.value;
	let role=e.target.role.value;
	let email=e.target.email.value;
	let section=e.target.section.value;
	let batch=e.target.batch.value;
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner.style.display='none';
			reg_btn.style.display='block';
			if(this.status===200){
				if(this.responseText==1){
					alert('Successfully Registered!')
					window.location='verify.jsp'
				}else if(this.responseText==1001){
					alert("ID or Email already Registered!")
				}else{
					alert('Something Went Wrong!')
				}
			}else{
				alert('Server Error!')
			}
		}
	}
	
	ajx.open('post','RegisterServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("fname="+fname+"&lname="+lname+"&id="+id+"&email="+email+"&role="+role+"&password="+password+"&batch="+batch+"&section="+section);
});
</script>
</html>