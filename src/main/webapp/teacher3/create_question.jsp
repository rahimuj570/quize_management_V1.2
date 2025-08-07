<%@page import="entities.Users"%>
<%@page import="entities.QuestionSets"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Sections"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();
ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Question</title>
<style>
#question_form {
	display: flex;
	flex-direction: column;
	gap: 10px;
	align-items: center;
	justify-content: center
}

.danger_txt {
	color: red;
	font-weight: bold;
}

.success_txt {
	font-weight: bold;
	color: green;
}

.how {
	background: chartreuse;
	width: 15px;
	display: inline-block;
	height: 18px;
	text-align: center;
	border-radius: 50%;
	font-weight: bold;
	border: 1px solid;
	cursor: help;
	margin-bottom: 2px;
}
</style>
<link rel="stylesheet" type="text/css" href="./teacher.css">
</head>
<body>
	<%@include file="./teacher_nav.jsp"%>
	<form action="<%=request.getContextPath()%>/CreateQuestionServlet"
		method='post' id="question_form" enctype="multipart/form-data">
		<h2>-Create Question-</h2>
		<%
		if (session.getAttribute("question_create_success") != null) {
		%>
		<p class="success_txt"><%=session.getAttribute("question_create_success")%></p>
		<%
		session.removeAttribute("question_create_success");
		}
		%>
		<%
		if (session.getAttribute("question_create_fail") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("question_create_fail")%></p>
		<%
		session.removeAttribute("question_create_fail");
		}
		%>
		
				<%
		if (session.getAttribute("big_img") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("big_img")%></p>
		<%
		session.removeAttribute("big_img");
		}
		%>
		<p>
			The fields that have this sign (<span class="danger_txt">*</span>)
			are mandatory to fill out!
		</p>
		<div>
			<label for="q_statement">Question Statement<span
				class="danger_txt">*</span></label><br />
			<textarea cols="30" required name="q_statement" id="q_statement"></textarea>
		</div>
		<div>
			<label for="q_img">Question Image (optional)</label><br /> <input
				name="q_img" id="q_img" type="file" /> <br />
			<div id='prev_div' style='border: 1px solid green; margin-top: 10px'>
				<input onclick='return false;' name="q_img_prev" id="q_img_prev"
					src='' value=" " type="image" width="200" /> <span
					style='cursor: pointer'
					onclick="document.getElementById('q_img').value='';document.getElementById('prev_div').style.display='none';"
					class='danger_txt'>[Clear Image]</span>
			</div>
		</div>
		<hr style="width: 100vh" />
		<div>
			<label for="opt_1">Wrong Option One <span class='danger_txt'>*</span></label><br />
			<input required name="opt_1" id="opt_1" type="text" />
		</div>
		<div>
			<label for="opt_2">Wrong Option Two <span class='danger_txt'>*</span></label><br />
			<input required name="opt_2" id="opt_2" type="text" />
		</div>
		<div>
			<label for="opt_3">Wrong Option Three <span
				class='danger_txt'>*</span></label><br /> <input required name="opt_3"
				id="opt_3" type="text" />
		</div>
		<div>
			<label for="opt_n">n<sup>th</sup> Wrong Option (optional) <span
				title="To Seperate multiple options use triple slash(/)... example: Dollar///Dirham///Rupe"
				onclick="alert('To Seperate multiple options use triple slash(/)\n example: Dollar///Taka///Rupe')"
				class='how'>?</span></label><br />
			<textarea name="opt_n" cols=25 id="opt_n" type="text"></textarea>
		</div>
		<hr style="width: 100vh" />
		<div>
			<label for="ans_1">Answer One <span class='danger_txt'>*</span></label><br />
			<input required name="ans_1" id="ans_1" type="text" />
		</div>
		<div>
			<label for="ans_n">n<sup>th</sup> Answer (optional) <span
				title="To Seperate multiple answers use triple slash(/)... example: Money///Taka///Tk"
				onclick="alert('To Seperate multiple answers use triple slash(/)\n example: Money///Taka///Tk')"
				class='how'>?</span></label><br />
			<textarea name="ans_n" id="ans_n" type="text"></textarea>
		</div>
		<hr style="width: 100vh" />

		<div style="display: flex; gap: 30px">

			<div>
				<label for="id">Batch/Class</label><br /> <select name="batch"
					id="batch">
					<%
					for (BatchClass bc : classList) {
					%>
					<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div>
				<label for="id">Section</label><br /> <select name="section"
					id="section">
					<%
					for (Sections s : sectiponList) {
					%>
					<option value="<%=s.getId()%>"><%=s.getSection()%></option>
					<%
					}
					%>
				</select>
			</div>
		</div>

		<div style="display: flex; gap: 30px">
			<div>
				<label for="id">Question Set</label><br /> <select name="q_set"
					id="q_set">
					<option selected="selected" value="0">Default</option>
					<%
					for (QuestionSets qset : qsList) {
					%>
					<option value="<%=qset.getQs_id()%>"><%=qset.getQs_name()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div>
				<label for="id">Course</label><br /> <select name="course"
					id="course">
					<%
					for (Course c : courseList) {
					%>
					<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
					<%
					}
					%>
				</select>
			</div>
		</div>

		<div style="display: flex; gap: 30px">

			<div>
				<label for="id">Privacy</label><br /> <select name="privacy"
					id="batch">
					<option selected value="0">Public</option>
					<option value="1">Private</option>
				</select>
			</div>
			<div>
				<label for="id">Difficulty</label><br /> <select name="difficulty"
					id="section">
					<option selected value="1">Easy</option>
					<option value="2">Medium</option>
					<option value="3">Hard</option>
				</select>
			</div>
		</div>

		<div>
			<input style="width: 100px; height: 30px" name="btn" id="btn"
				type="submit" value="Create" />
		</div>
	</form>
	<script>
const file = document.getElementById('q_img');
file.value='';
document.getElementById('prev_div').style.display='none';
file.addEventListener('change',(e)=>{
	document.getElementById('prev_div').style.display='block';
	const reader= new FileReader();
	if(file.files[0].type=='image/jpeg' || file.files[0].type=='image/png');
	else {
		alert("Only jpg, jpeg and png file allowed!")
		file.value='';
		document.getElementById('q_img_prev').src='';
		document.getElementById('prev_div').style.display='none';
	}
	reader.readAsDataURL(file.files[0]);
	reader.onload = () => {
		document.getElementById('q_img_prev').src=reader.result;      
  };
	
})
</script>
	<script src="./teacher.js"></script>
</body>
</html>