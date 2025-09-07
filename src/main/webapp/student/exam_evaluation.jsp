<!DOCTYPE html>
<%@page import="dao.OptionsDao"%>
<%@page import="entities.Options"%>
<%@page import="java.io.File"%>
<%@page import="helper.QuestionToAnswerePOJO"%>
<%@page import="entities.Questions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="entities.ExamsEvaluation"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="entities.Exams"%>
<%@page import="helper.GetBatchSectionOfStudentPOJO"%>
<%@page import="entities.Users"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ExamsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Evaluation</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.question-card {
	margin-bottom: 20px;
}

.counter {
	position: fixed;
	top: 15px;
	right: 20px;
	background: #0d6efd;
	color: white;
	padding: 10px 15px;
	border-radius: 50px;
	font-weight: bold;
}

.question-img {
	max-height: 200px;
	object-fit: contain;
	margin-bottom: 15px;
}
</style>
<link rel="stylesheet" type="text/css" href="main.css">

</head>
<!-- <body class="bg-light" oncontextmenu="return false"
	onselectstart="return false" onpaste="return false;"
	onCopy="return false" onCut="return false" onDrag="return false"
	onDrop="return false" autocomplete=off>
-->
<body>

	<%
	String exam_id = request.getParameter("exam_id");
	if (session.getAttribute("exam_valuation_BAD") != null) {
	%>
	<p class="text-center text-danger"><%=session.getAttribute("exam_valuation_BAD")%></p>
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






	<div class="container mt-4 bg-primary py-3 mb-4">

		<!-- Exam Info -->
		<div style="background: #1abc9c"
			class="text-white card shadow-sm mb-4">
			<div class="card-body">
				<h3 id="examName"><%=e.getExam_name()%></h3>
				<p>
					<strong>Batch:</strong>
					<%=bsDao.getBatchNameById(e.getExam_batch())%>
					| <strong>Section:</strong>
					<%=bsDao.getSectionNameById(e.getExam_section())%>
					| <strong>Course:</strong>
					<%=bsDao.getCourseNameById(e.getExam_course())%>
				</p>
				<p>
					<strong>Total Marks:</strong>
					<%=e.getExam_marks()%>
					| <strong>Duration:</strong>
					<%=e.getExam_duration()%>
					min | <strong>Questions:</strong>
					<%=e.getExam_question_amount()%>
					| <strong>Deadline:</strong>
					<%=e.getExam_end()%>
				</p>
				<p>
					<strong>Student ID:</strong>
					<%=cu.getUser_id()%>
				</p>


			</div>
		</div>

		<%
		if (eev.getIsExpelled() == 1) {
		%>

		<p class="text-danger">
			<strong>EXPELLED</strong>

		</p>

		<%
		} else {
		%>





		<div style="background: #1abc9c"
			class="text-white card shadow-sm mb-4">
			<div class="card-body">
				<p>
					<strong>Correct Answers:</strong>
					<%=eev.getCorrect_answer()%>
					| <strong>Wrong Answers:</strong>
					<%=eev.getWrong_answer()%>
					| <strong>Ignored Question:</strong>
					<%=eev.getPass_question()%>
				</p>
				<p>
					<strong>Obtained Marks:</strong>
					<%=eev.getCorrect_answer() * (e.getExam_marks() / e.getExam_question_amount())%>
				</p>

			</div>
		</div>
		<%
		}
		if (exam_id == null) {
		%>
		<table class="table table-hover table-bordered" id="sampleTable">
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
					<td>
						<%
						if (qap.getAnswer_id() == qap.getSelected_option_id())
							out.print("Correct");
						else
							out.print("Wrong");
						%>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<div class="mt-5 text-center">
			<button onclick="window.print(); window.close();"
				class="btn bg-danger text-white">Print</button>
			<p class="text-danger">NOTE: YOU WILL NOT ABLE TO SEE IN DETAILS
				SECOND TIME!</p>
		</div>
		<%
		} else {
		%>

		<div class="mt-5 text-center">
			<button onclick="history.back();"
				class="btn bg-danger text-white">Back</button>
			
		</div>

		<%
		}

		session.removeAttribute("current_exam_selected_options");
		session.removeAttribute("current_exam_evaluation");
		%>




	</div>



	<script>
		
	</script>

</body>
</html>
