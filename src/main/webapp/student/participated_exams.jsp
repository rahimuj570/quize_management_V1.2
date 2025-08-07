<%@page import="helper.GetBatchSectionOfStudentPOJO"%>
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
<title>My Exams</title>
<link rel="stylesheet" type="text/css" href="student.css">
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
GetBatchSectionOfStudentPOJO gbs = bs.getBatchSectionOfStudent(cu.getUser_id());
ArrayList<Exams> examList = eDao.getAllParticipatedExamById(cu.getUser_id());

BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>

<body>
	<%@include file="./student_nav.jsp"%>


	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>ID</th>
				<th>Exam Name</th>
				<th>Course</th>
				<th>Batch</th>
				<th>Section</th>
				<th>Total Questions</th>
				<th>Exam Mark</th>
				<th>Exam End</th>
				<th>Exam Duration</th>
				<th>Exam Type</th>
				<th>Result</th>
			</tr>
			<%
			for (Exams e : examList) {
			%>
			<tr>
				<td><%=e.getExam_id()%></td>
				<td><%=e.getExam_name()%></td>
				<td><%=bsDao.getCourseNameById(e.getExam_course())%></td>
				<td><%=bsDao.getBatchNameById(e.getExam_batch())%></td>
				<td><%=bsDao.getSectionNameById(e.getExam_section())%></td>
				<td><%=e.getExam_question_amount()%></td>
				<td><%=e.getExam_marks()%></td>
				<td><%=e.getExam_end()%></td>
				<td><%=e.getExam_duration()%> Minutes</td>
				<td><%=e.getExam_privacy() == 0 ? "Public" : "Protected"%></td>

				<td>
					<button style="background: lime">
						<a
							href="<%=request.getContextPath()%>/student/exam_evaluation.jsp?exam_id=<%=e.getExam_id()%>">View
							Result</a>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<script src="./student.js"></script>
	
</body>
</html>