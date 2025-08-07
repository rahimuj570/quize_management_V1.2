<%@page import="helper.TempExamCreateSessionPOJO"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.QuestionSets"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Select Question Set</title>
<link rel="stylesheet" type="text/css" href="teacher.css">
<style type="text/css">
th {
	width: 1%;
	border: 2px solid red;
}

td {
	border: 1px solid black;
}
</style>
</head>
<body>
	<%@include file="teacher_nav.jsp"%>
	<%
	BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
	Users cu = (Users) session.getAttribute("current_user");
	QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());

	TempExamCreateSessionPOJO esc = new TempExamCreateSessionPOJO();
	esc.setExam_batch(request.getParameter("batch"));
	esc.setExam_name(request.getParameter("exam_name"));
	esc.setExam_question_amount(request.getParameter("exam_question_amount"));
	esc.setExam_total_mark(request.getParameter("exam_mark"));
	esc.setExam_date(request.getParameter("exam_start"));
	esc.setExam_time(request.getParameter("exam_time"));
	esc.setExam_duration(request.getParameter("exam_duration"));
	esc.setExam_section(request.getParameter("section"));
	esc.setExam_course(request.getParameter("course"));
	esc.setExam_privacy(request.getParameter("privacy"));

	ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id(), esc.getExam_course(), esc.getExam_batch());

	session.setAttribute("temp_exam_create", esc);
	%>
	<%
	if (session.getAttribute("n_qs_select") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("no_s_select")%></p>
	<%
	session.removeAttribute("noqs_select");
	}
	%>
	<%
	if (session.getAttribute("remove_to_question_set_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("remove_to_question_set_BAD")%></p>
	<%
	session.removeAttribute("remove_to_question_set_BAD");
	}
	%>
	<%
	if (session.getAttribute("other_question_remove") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("other_question_remove")%></p>
	<%
	session.removeAttribute("other_question_remove");
	}
	%>
	<%
	if (session.getAttribute("remove_to_question_set_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("remove_to_question_set_OK")%></p>
	<%
	session.removeAttribute("remove_to_question_set_OK");
	}
	%>
	<%
	if (session.getAttribute("question_delete_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("question_delete_BAD")%></p>
	<%
	session.removeAttribute("question_delete_BAD");
	}
	%>
	<%
	if (session.getAttribute("other_question_delete") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("other_question_delete")%></p>
	<%
	session.removeAttribute("other_question_delete");
	}
	%>
	<%
	if (session.getAttribute("question_delete_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("question_delete_OK")%></p>
	<%
	session.removeAttribute("question_delete_OK");
	}
	%>

	<h2>
		Select Question Set for Exam named "<%=request.getParameter("exam_name")%>"
	</h2>
	<h3>
		<strong class="danger_txt">NOTE:</strong> Question Quantity Must be at
		least "<%=request.getParameter("exam_question_amount")%>"
	</h3>
	<div style="display: flex; gap: 10px; margin: 5px 0px">
		<div>
			<label for="id">Section</label><br /> <select name="difficulty"
				id="difficulty">
				<option selected value="<%=request.getParameter("section")%>"><%=bs.getSectionNameById(Integer.parseInt(request.getParameter("section")))%></option>
			</select>
		</div>
		<div>
			<label for="id">Course</label><br /> <select name="course"
				id="course">
				<option selected value="<%=request.getParameter("course")%>"><%=bs.getCourseNameById(Integer.parseInt(request.getParameter("course")))%></option>

			</select>
		</div>

		<div>
			<label for="id">Batch</label><br /> <select name="batch" id="batch">
				<option selected value="<%=request.getParameter("batch")%>"><%=bs.getBatchNameById(Integer.parseInt(request.getParameter("batch")))%></option>
			</select>
		</div>
	</div>
	<hr style="width: 100%" />
	<hr style="width: 100%" />
	<div style="overflow-x: auto;">
		<table
			style="text-align: center; width: 100%; border-spacing: 0; border: 2px solid black; display: block; overflow-y: scroll; max-height: 400px;">
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
			<form method="post"
				action="<%=request.getContextPath()%>/CreateExamServlet">
				<%
				for (var q : qsList) {
				%>
				<tr>

					<td><input class="checkboxes" name="mark[]" type="checkbox"
						value="<%=q.getQs_id()%>" /></td>
				
						
					<td><%=q.getQs_id()%></td>
					<td><%=q.getQs_name()%></td>
					<td><%=qs.getTotalQuestionAmount(q.getQs_id())%></td>
					<td><%=bs.getSectionNameById(q.getQs_section())%></td>
				</tr>
				<%
				}
				%>
				<div style="display: flex; gap: 10px">
					<button id="addSet">Add to Question Set</button>
				</div>

			</form>
		</table>
	</div>
	<script src="./teacher.js"></script>
	<script type="text/javascript">
	const exam_question_requirement = new URLSearchParams(location.search).get('exam_question_amount')-'0';
	let q_count=0;
		if (location.search.length < 2) {
			history.back();
		}
		
		Array.from(document.getElementsByClassName("checkboxes")).forEach((d,index)=>{
			d.addEventListener('change',(e)=>{
				let parent = e.target.parentElement.parentElement.children[3];
				if(e.target.checked==true){					
				q_count+=parent.innerText-'0';
				}else{
				q_count-=parent.innerText-'0';					
				}
				console.log(q_count);
				const btn = document.getElementById("addSet");
				if(q_count<exam_question_requirement){
					btn.disabled=true;
				}else{
					btn.disabled=false;
				}
			})
		})
	</script>
</body>

</html>