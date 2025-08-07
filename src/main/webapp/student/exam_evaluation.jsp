<%@page import="dao.OptionsDao"%>
<%@page import="entities.Users"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Exams"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ExamsDao"%>
<%@page import="helper.QuestionToAnswerePOJO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.ExamsEvaluation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Exam Evaluation</title>
<link rel="stylesheet" type="text/css" href="student.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"
	integrity="sha512-BNaRQnYJYiPSqHHDb58B0yaPfCu+Wgds8Gp/gU33kqBtgNS4tSPHuGibyoeqMV/TJlSKda6FXzoEyYGjTe+vXA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body>
	<%@include file="student_nav.jsp"%>
	<%
	String exam_id = request.getParameter("exam_id");
	if (session.getAttribute("exam_valuation_BAD") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("exam_valuation_BAD")%></p>
	<%
	session.removeAttribute("exam_valuation_BAD");
	}
	%>

	<%
	OptionsDao oDao = new OptionsDao(ConnectionProvider.main());
	BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
	ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
	ArrayList<QuestionToAnswerePOJO> qaPOJO = new ArrayList<QuestionToAnswerePOJO>();
	ExamsEvaluation eev = new ExamsEvaluation();
	Users cu = (Users) session.getAttribute("current_user");
	Exams e = new Exams();
	if (exam_id == null) {
		eev = (ExamsEvaluation) session.getAttribute("current_exam_evaluation");
		qaPOJO = (ArrayList<QuestionToAnswerePOJO>) session.getAttribute("current_exam_selected_options");
		e = eDao.getExamById(eev.getExam_id() + "");
	} else {
		e = eDao.getExamById(request.getParameter("exam_id"));
		eev = eDao.getExamEvaluation(cu.getUser_id(), e.getExam_id());
	}
	%>


	<div id="pdf_body">
		<h1><%=e.getExam_name()%></h1>
		<p>
			Batch:
			<%=bsDao.getBatchNameById(e.getExam_batch())%></p>
		<p>
			Section:
			<%=bsDao.getSectionNameById(e.getExam_section())%></p>
		<p>
			Course:
			<%=bsDao.getCourseNameById(e.getExam_course())%></p>
		<p>
			Student ID:
			<%=eev.getStudent_id()%></p>
		<%
		if (eev.getIsExpelled() == 1) {
		%>
		<h2>EXPELLED</h2>
		<%
		} else {
		%>
		<p>
			<section class="grid2cols">
				<p>
					Total Exam Mark:
					<%=e.getExam_marks()%></p>
				<p>
					Total Question Quantity:
					<%=e.getExam_question_amount()%></p>
				<p>
					Exam Duration:
					<%=e.getExam_duration()%>
					Minutes
				</p>
				<hr style="width: 100%; border: 1px solid black;" />
				<p>
					Correct Answer:
					<%=eev.getCorrect_answer()%></p>
				<p>
					Wrong Answer:
					<%=eev.getWrong_answer()%></p>
				<p>
					Ignored Questions:
					<%=eev.getPass_question()%></p>
				<p>
					Total Obtained Marks:
					<%=eev.getCorrect_answer() * (e.getExam_marks() / e.getExam_question_amount())%></p>

				<%
				}
				if (exam_id == null) {
				%>
				<table>
					<tr>
						<th>Question</th>
						<th>Answer</th>
						<th>Selected Option</th>
						<th>Verdict</th>
					</tr>
					<tbody>
						<%
						for (QuestionToAnswerePOJO qap : qaPOJO) {
						%>
						<tr>
							<td><%=qap.getQuestion_statement()%></td>
							<td><%=qap.getAnswer_statement()%></td>
							<td><%=oDao.getOptionStatementByOptId(qap.getSelected_option_id())%></td>
							<td><% if(qap.getAnswer_id()==qap.getSelected_option_id())out.print("Correct");else out.print("Wrong");%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</section>
		<hr style="width: 100%; border: 1px solid black;" />
		<hr style="width: 100%; border: 1px solid black;" />
	</div>
		<div style="text-align: center;margin:10px 0px;">
		<button onclick="funct()">Export as PDF</button>
		<p style="color:red; font-style: italic; font-weight: bold;">NOTE: YOU WILL NOT ABLE TO SEE IN DETAILS SECOND TIME!</p>
		</div>
	<%
	}
	session.removeAttribute("current_exam_selected_options");
	session.removeAttribute("current_exam_evaluation");
	%>
		 <script src="./student.js"></script> 
		 <script type="text/javascript">
		 
		 let funct=()=>{
			 window.jsPDF = window.jspdf.jsPDF;
			 var myPDF = new jsPDF();
			 myPDF.html(document.getElementById('pdf_body'),{
			 	callback: async function(doc){
			 	await myPDF.save('Submition_of_<%=e.getExam_name()%>.pdf');
			     await setTimeout(window.close(),10000);
			 	},
			 	x:5,
			 	y:5,
			 	width:200,
			 	windowWidth: 1000
			 })
			 	};
		 
		 
		 </script>
</body>
</html>