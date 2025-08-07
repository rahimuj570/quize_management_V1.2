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
ArrayList<Exams> examList = request.getParameter("course_id") == null
		? eDao.getAllStudentExamById(gbs.getBatchId(), gbs.getSectionId(), "")
		: eDao.getAllStudentExamById(gbs.getBatchId(), gbs.getSectionId(), request.getParameter("course_id"));

BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>

<body>
	<%@include file="./student_nav.jsp"%>

	<%
	if (session.getAttribute("exam_early_entry") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("exam_early_entry")%></p>
	<%
	session.removeAttribute("exam_early_entry");
	}
	%>
	<%
	if (session.getAttribute("exam_violation") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("exam_violation")%></p>
	<%
	session.removeAttribute("exam_violation");
	}
	%>
	<%
	if (session.getAttribute("exam_over_entry") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("exam_over_entry")%></p>
	<%
	session.removeAttribute("exam_over_entry");
	}
	%>
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
				<th>Exam Start</th>
				<th>Exam Duration</th>
				<th>Exam Type</th>
				<th>Enter</th>
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
				<td><%=e.getExam_start()%></td>
				<td><%=e.getExam_duration()%> Minutes</td>
				<td><%=e.getExam_privacy() == 0 ? "Public" : "Protected"%></td>
				<%
				if (e.getExam_privacy() == 0) {
				%>
				<td>
					<button onclick="enterExam(<%=e.getExam_id()%>)"
						style="background: lime">Enter</button>
				</td>
				<%
				} else if (eDao.isAlredyPermited(cu.getUser_id(), e.getExam_id())) {
				%>
				<td>
					<button onclick="enterExam(<%=e.getExam_id()%>)"
						style="background: lime">Enter</button>
				</td>

				<%
				} else {
				%>
				<td>Ineligible</td>
				<%
				}
				%>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<script src="./student.js"></script>
	<script type="text/javascript">
	let enterExam=(exam_id)=>{	
	 if (confirm('You have only one chance to complete this exam. If somehow this tab close, then you will be expelled.Tab can be closed via some illegal action. Here are the criteria:\n\n1) If you change the exam tab,\n2) If you minimize the browser,\n3) If you try to change the size of the browser window,\n4) If you try to open "inspect tool" or "web tool",\n5) If you refresh/reload the exam tab.\n6) Must grant pop-up permission if system requires\n\nSo be careful about the rules. If you agree, click "ok" and participate the exam.')) {
				var a = document.createElement('a');
				a.target="_blank";
  				a.href="<%=request.getContextPath()%>/student/exam.jsp?exam_id="+exam_id;
 			 	a.click();
			   } 
	}
	 </script>
</body>
</html>