<%@page import="entities.ExamsEvaluation"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Users"%>
<%@page import="dao.ExamsDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Exam</title>
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

ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
Exams e = eDao.getExamById(request.getParameter("exam_id"));
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
ArrayList<ExamsEvaluation> evaluationList = eDao
		.getAllExamEvaluation(Integer.parseInt(request.getParameter("exam_id")));
%>

<body>
	<%@include file="teacher_nav.jsp"%>
	<h2>Total Participants: <%=evaluationList.size() %> Students</h2>
	<div style="overflow: auto;">
		<table>
			<tr>
				<th style="opacity: .5;">Exam ID</th>
				<th style="opacity: .5;">Exam Name</th>
				<th style="opacity: .5;">Course</th>
				<th style="opacity: .5;">Batch</th>
				<th style="opacity: .5;">Section</th>
				<th style="opacity: .5;">Total Questions</th>
				<th style="opacity: .5;">Exam Mark</th>
				<th>Student ID</th>
				<th>Correct Answers</th>
				<th>Wrong Answers</th>
				<th>Skipped Questions</th>
				<th>Expelled Status</th>
				<th>Obtained Marks</th>
				<th>Verdict</th>
			</tr>
			<%
			for (ExamsEvaluation ev : evaluationList) {
			%>
			<tr>
				<td style="opacity: .5;"><%=e.getExam_id()%></td>
				<td style="opacity: .5;"><%=e.getExam_name()%></td>
				<td style="opacity: .5;"><%=bsDao.getCourseNameById(e.getExam_course())%></td>
				<td style="opacity: .5;"><%=bsDao.getBatchNameById(e.getExam_batch())%></td>
				<td style="opacity: .5;"><%=bsDao.getSectionNameById(e.getExam_section())%></td>
				<td style="opacity: .5;"><%=e.getExam_question_amount()%>
				<td style="opacity: .5;"><%=e.getExam_marks()%>
				<td><%=ev.getStudent_id()%></td>
				<td><%=ev.getCorrect_answer()%></td>
				<td><%=ev.getWrong_answer()%></td>
				<td><%=ev.getPass_question()%></td>
				<td><%=ev.getIsExpelled() == 0 ? "FALSE" : "TRUE"%></td>
				<td><%=(e.getExam_marks() / e.getExam_question_amount()) * ev.getCorrect_answer()%></td>
				<td><%=(ev.getCorrect_answer() * 100) / e.getExam_marks()%>%</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<script src="./teacher.js"></script>
</body>
</html>