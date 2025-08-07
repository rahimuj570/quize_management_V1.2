<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Users"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Exam</title>
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

table.scrolldown {
	width: 100%;
	/* border-collapse: collapse; */
	border-spacing: 0;
	border: 2px solid black;
	display: block;
	overflow-y: scroll;
	max-height: 200px;
}

td {
	text-align: center;
}
</style>

<link rel="stylesheet" type="text/css" href="./teacher.css">
</head>
<body>
	<%@include file="teacher_nav.jsp"%>

	<%
	BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
	QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
	ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
	Users cu = (Users) session.getAttribute("current_user");
	Exams e = eDao.getExamById(request.getParameter("exam_id"));
	ArrayList<Sections> sectiponList = bs.getAllSection();
	ArrayList<BatchClass> classList = bs.getAllClass();
	ArrayList<Course> courseList = bs.getAllCourse();
	ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());

	if (e.getExam_start().before(new Date(new Date().getTime() + 10 * 60000))) {
		session.setAttribute("update_exam_401", "Can't Modify Exam Now, Please Contact with Admin!");
		response.sendRedirect(request.getContextPath() + "/teacher/show_exams.jsp");
	}

	/////////////////
	if (e.getExam_teacher().equals(cu.getUser_id())) {
	%>
	<!-- ///////////// -->


	<%
	if (session.getAttribute("create_exam_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("create_exam_BAD")%></p>
	<%
	session.removeAttribute("create_exam_BAD");
	}
	%>
	<form action="<%=request.getContextPath()%>/EditExamServlet"
		method='get' id="question_form">
		<h2>-Create Exam-</h2>
		<%
		if (session.getAttribute("update_exam_BAD") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("update_exam_BAD")%></p>
		<%
		session.removeAttribute("update_exam_BAD");
		}
		%>
		<p>
			The fields that have this sign (<span class="danger_txt">*</span>)
			are mandatory to fill out!
		</p>

		<div>
			<label for="exam_name">Exam ID</label><br /> <input name=""
				value="<%=e.getExam_id()%>" disabled="disabled" type="number" /> <input
				name="exam_id" value="<%=e.getExam_id()%>" hidden=true type="number" />
		</div>
		<div>
			<label for="exam_name">Exam Name<span class="danger_txt">*</span></label><br />
			<input maxlength="100" type="text" required name="exam_name"
				id="exam_name" value="<%=e.getExam_name()%>"/>
		</div>
		<hr style="width: 100vh" />
		<div>
			<label for="exam_question_amount">Exam's Question Amount <span
				class='danger_txt'>*</span></label><br /> <input
				onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
				min='5' required name="exam_question_amount"
				id="exam_question_amount" type="number"
				value="<%=e.getExam_question_amount()%>" />
		</div>
		<div>
			<label for="exam_mark">Exam's Total Mark <span
				class='danger_txt'>*</span></label><br /> <input
				onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
				min='5' value='<%=e.getExam_marks()%>' required name="exam_mark"
				id="exam_mark" type="number" />
			<p>
				(Per question's mark will be: <span id='per_mark'>1</span>)
			</p>
		</div>

		<hr style="width: 100vh" />
		<div>
			<label for="exam_start">Exam Date <span class='danger_txt'>*</span></label><br />
			<input min="2024-06-21" required name="exam_start" id="exam_start"
				type="date" />
		</div>
		<div>
			<label for="exam_time">Exam Time <span class='danger_txt'>*</span></label><br />
			<input required name="exam_time" id="exam_time" type="time" />
		</div>
		<div>
			<label for="exam_duration">Exam Duration (in minutes) <span
				class='danger_txt'>*</span></label><br /> <input
				value='<%=e.getExam_duration()%>' min="10" required
				name="exam_duration" id="exam_duration" type="number" />
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

			<div>
				<label for="id">Privacy</label><br /> <select name="privacy"
					id="privacy">
					<option selected value="0">Public</option>
					<option value="1">Private</option>
				</select>
			</div>
		</div>

		<hr style="width: 100vh" />
		<button
			onclick="document.getElementsByName('mark[]').forEach(e=>e.checked=false); return false;">Clear
			All Checked Set</button>
		<div style="display: flex; gap: 30px">
			<table
				style="text-align: center; width: 100%; border-spacing: 0; border: 2px solid black; display: block; overflow-y: scroll; overflow-x: scroll; max-height: 400px;">
				<tr>
					<th>MARK</th>
					<th>Exam ID</th>
					<th>Exam Name</th>
					<th>Questions Quantity</th>
					<th>Section</th>
				</tr>
				<%
				if (session.getAttribute("no_qs_select") != null) {
				%>
				<p class="center_txt danger_txt"><%=session.getAttribute("no_qs_select")%></p>
				<%
				session.removeAttribute("no_qs_select");
				}
				%>
				<%
				ArrayList<Integer> prevSetID = eDao.getAllQuestionSetById(request.getParameter("exam_id"));
				for (var q : qsList) {
				%>
				<tr>
					<td><input name="mark[]" type="checkbox"
						value="<%=q.getQs_id()%>"
						<%=prevSetID.indexOf(q.getQs_id()) != -1 ? "checked" : ""%> /></td>
					<td><%=q.getQs_id()%></td>
					<td><%=q.getQs_name()%></td>
					<td><%=qs.getTotalQuestionAmount(q.getQs_id())%></td>
					<td><%=bs.getSectionNameById(q.getQs_section())%></td>
				</tr>
				<%
				}
				%>
			</table>


		</div>
		<div>
			<input style="width: 100px; height: 30px" name="btn" id="btn"
				type="submit" value="Update" />
		</div>
	</form>
	<%
	} else {
	%>
	<%
	out.print("Authorization failed!!!");
	}
	%>
	<script src="./teacher.js"></script>
	<script type="text/javascript">

	document.getElementById('batch').value=`<%=e.getExam_batch()%>` 
	document.getElementById('section').value=`<%=e.getExam_section()%>`
	document.getElementById('course').value=`<%=e.getExam_course()%>`
	document.getElementById('privacy').value=`<%=e.getExam_privacy()%>`

	let d = new Date();
	let date = d.getDate();
	let month = d.getMonth() + 1;
	date = date.toString().length == 1 ? '0' + date : date;
	month = month.toString().length == 1 ? '0' + month : month;
	const year = d.getFullYear();
	document.getElementById('exam_start').min = year + '-' + month + '-' + date;
	const currentDate = new Date();
	let hours = currentDate.getHours();
	let minutes = currentDate.getMinutes();
	let meridiem = hours >= 12 ? 'PM' : 'AM';

	//document.getElementById('exam_time').min = d.getHours() + ':'	+ d.getMinutes();
</script>
</body>
</html>