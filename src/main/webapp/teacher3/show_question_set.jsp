<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Users"%>
<%@page import="entities.QuestionSets"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Question Sets</title>
<link rel="stylesheet" type="text/css" href="teacher.css">
<style type="text/css">
label {
	padding: 0 10px 0 18px;
}
</style>
</head>
<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();

QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<QuestionSets> qsList = qsDao.getAllQuestionSet(cu.getUser_id());
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>
<body>
	<%@include file="teacher_nav.jsp"%>
	<%
	if (session.getAttribute("qs_delete_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("qs_delete_BAD")%></p>
	<%
	session.removeAttribute("qs_delete_BAD");
	}
	%>
	<%
	if (session.getAttribute("other_qs_delete") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("other_qs_delete")%></p>
	<%
	session.removeAttribute("other_qs_delete");
	}
	%>
	<%
	if (session.getAttribute("qs_delete_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("qs_delete_OK")%></p>
	<%
	session.removeAttribute("qs_delete_OK");
	}
	%>

	<form
		style="margin: 20px 0px; border: 3px solid lime; padding: 10px 0px"
		action="<%=request.getContextPath()%>/CreateQuestionSetServlet"
		method="post">
		<label for="qs_name">Set Name</label> <input required="required" id="qs_name"
			name="qs_name" type="text" /> <label for="id">Course</label><select
			name="course" id="course">
			<%
			for (Course c : courseList) {
			%>
			<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
			<%
			}
			%>
		</select> <label for="id">Batch</label><select name="batch" id="batch">
			<%
			for (BatchClass bc : classList) {
			%>
			<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
			<%
			}
			%>
		</select> <label for="id">Section</label><select name="section" id="section">
			<%
			for (Sections s : sectiponList) {
			%>
			<option value="<%=s.getId()%>"><%=s.getSection()%></option>
			<%
			}
			%>
		</select>
		<button style="margin-left: 10px; background: cyan">Create
			Question Set</button>
		<%
		if (session.getAttribute("qs_create_success") != null) {
		%>
		<span class="success_txt"><%=session.getAttribute("qs_create_success")%></span>
		<%
		session.removeAttribute("qs_create_success");
		}
		%>
		<%
		if (session.getAttribute("qs_create_fail") != null) {
		%>
		<span class="success_txt"><%=session.getAttribute("qs_create_fail")%></span>
		<%
		session.removeAttribute("qs_create_fail");
		}
		%>
	</form>
	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>ID</th>
				<th>Set Name</th>
				<th>Batch</th>
				<th>Course</th>
				<th>Total Questions</th>
				<th>Details</th>
				<th>Delete</th>
			</tr>
			<%
			for (QuestionSets qs : qsList) {
			%>
			<tr>
				<td><%=qs.getQs_id()%></td>
				<td><%=qs.getQs_name()%></td>
				<td><%=bsDao.getBatchNameById(qs.getQs_batch())%></td>
				<td><%=bsDao.getCourseNameById(qs.getQs_course())%></td>
				<td><%=qsDao.getTotalQuestionAmount(qs.getQs_id())%>
					<button>
						<a href="show_questions.jsp?qs=<%=qs.getQs_id()%>">Edit</a>
					</button></td>
				<td><button
						onclick="alert('Created By: <%=cu.getUser_first_name() + " " + cu.getUser_last_name()%> \nCreated On: <%=qs.getQs_created()%>\n Section: <%=bsDao.getSectionNameById(qs.getQs_section())%>\n')"
						style="background: lime">
						<a href="#">More Details</a>
					</button></td>
				<td>
					<button style="background: #ffc6c6">
						<a
							href="<%=request.getContextPath()%>/DeleteQuestionSetServlet?qs=<%=qs.getQs_id()%>">Delete</a>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<script src="./teacher.js"></script>
</body>
</html>