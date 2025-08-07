<%@page import="java.time.Year"%>
<%@page import="entities.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Sections"%>
<%@page import="entities.BatchClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Exam</title>
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
<%@include file="teacher_nav.jsp" %>
	<%
	BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
	QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
	Users cu = (Users) session.getAttribute("current_user");
	ArrayList<Sections> sectiponList = bs.getAllSection();
	ArrayList<BatchClass> classList = bs.getAllClass();
	ArrayList<Course> courseList = bs.getAllCourse();
	ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
	%>
	<%
	if (session.getAttribute("create_exam_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("create_exam_BAD")%></p>
	<%
	session.removeAttribute("create_exam_BAD");
	}
	%>
	<form action="select_question_set.jsp" method='get' id="question_form">
		<h2>-Create Exam-</h2>
		<p>
			The fields that have this sign (<span class="danger_txt">*</span>)
			are mandatory to fill out!
		</p>
		<div>
			<label for="id">Exam Name</label><br /> <select name="exam_name"
				id="section">
				<option
					value="Final_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">Final_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
				<option
					value="Mid_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">Mid_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
				<option
					value="CT_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">CT_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
				<option
					value="Final_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">Final_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
				<option
					value="Mid_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">Mid_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
				<option
					value="CT_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">CT_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
			</select>
		</div>
		<hr style="width: 100vh" />
		<div>
			<label for="exam_question_amount">Exam's Question Amount <span
				class='danger_txt'>*</span></label><br /> <input
				onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
				min='5' value='5' required name="exam_question_amount"
				id="exam_question_amount" type="number" />
		</div>
		<div>
			<label for="exam_mark">Exam's Total Mark <span
				class='danger_txt'>*</span></label><br /> <input
				onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
				min='5' value='5' required name="exam_mark" id="exam_mark"
				type="number" />
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
		<input hidden="true" required="required" id="datetime_prev" type="datetime-local" name="date_prev"/>
		<div>
			<label for="exam_duration">Exam Duration (in minutes) <span
				class='danger_txt'>*</span></label><br /> <input value='10' min="10"
				required name="exam_duration" id="exam_duration" type="number" />
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
					id="batch">
					<option selected value="0">Public</option>
					<option value="1">Private</option>
				</select>
			</div>
		</div>
		<div>
			<input style="width: 100px; height: 30px" name="btn" id="btn"
				type="submit" value="Next" />
		</div>
	</form>
	 <script src="./teacher.js"></script> 
<script type="text/javascript">
	let d = new Date();
	let date = d.getDate();
	let month = d.getMonth() + 1;
	date = date.toString().length == 1 ? '0' + date : date;
	month = month.toString().length == 1 ? '0' + month : month;
	const year = d.getFullYear();

	let currentDate = new Date();
	let hours = currentDate.getHours();
	let minutes = currentDate.getMinutes();
	let meridiem = hours >= 12 ? 'PM' : 'AM';
	
	document.getElementById('datetime_prev').min=year+"-"+month+"-"+date+"T"+hours+":"+minutes;
	const datepick=document.getElementById('exam_start');
	const timepick= document.getElementById('exam_time');
	
	
	datepick.addEventListener('change',(e)=>{		
	document.getElementById('datetime_prev').value = datepick.value+"T"+timepick.value;
	console.log(document.getElementById('exam_start').value+"T"+document.getElementById('exam_time').value);
	})
	timepick.addEventListener('change',(e)=>{		
	document.getElementById('datetime_prev').value = datepick.value+"T"+timepick.value;
	console.log(document.getElementById('exam_start').value+"T"+document.getElementById('exam_time').value);
	})
	
	
	document.getElementById('btn').addEventListener('click',(e)=>{
		const selectedDate = new Date(document.getElementById('datetime_prev').value);
		if(selectedDate<new Date()){			
		alert("Invalid Date/Time!")
		e.preventDefault();
		}
	})

</script>
</body>
</html>