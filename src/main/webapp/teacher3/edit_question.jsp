<%@page import="java.io.File"%>
<%@page import="entities.Options"%>
<%@page import="dao.OptionsDao"%>
<%@page import="entities.Questions"%>
<%@page import="dao.QuestionsDao"%>
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
OptionsDao optDao = new OptionsDao(ConnectionProvider.main());
QuestionsDao qDao = new QuestionsDao(ConnectionProvider.main());
Questions q = qDao.getQuestionById(Integer.parseInt(request.getParameter("q_id")));
ArrayList<Options> wrongOptList = optDao.getAllOptionsByQid(q.getQ_id(), 1, 0);
ArrayList<Options> rightOptList = optDao.getAllOptionsByQid(q.getQ_id(), 0, 1);

out.print(wrongOptList.get(0));

BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();
ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
if (q.getQ_teacher() != cu.getUser_id()) {
	session.setAttribute("q_edit404", "Can't be allowed to edit other teacher's questions! ");
	response.sendRedirect(request.getHeader("referer"));
}
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
	<form action="<%=request.getContextPath()%>/UpdateQuestionServlet"
		method='post' id="question_form" enctype="multipart/form-data">
		<h2>-Update Question-</h2>
		<%
		if (session.getAttribute("question_update_success") != null) {
		%>
		<p class="success_txt"><%=session.getAttribute("question_update_success")%></p>
		<%
		session.removeAttribute("question_update_success");
		}
		%>
		<%
		if (session.getAttribute("question_update_fail") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("question_update_fail")%></p>
		<%
		session.removeAttribute("question_update_fail");
		}
		%>
		<p>
			The fields that have this sign (<span class="danger_txt">*</span>)
			are mandatory to fill out!
		</p>
		<div>
			<label for="q_statement">Question Statement<span
				class="danger_txt">*</span></label><br />
			<textarea cols="30" required name="q_statement" id="q_statement"
				value="<%=q.getQ_statement()%>"></textarea>
		</div>
		<div>
			<label for="q_img">Question Image (optional)</label><br /> <input
				name="q_img" id="q_img" type="file" /> <br />
			<div id='prev_div' style='border: 1px solid green; margin-top: 10px'>
				<a target="_blank"
					href="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>"><img
					id="q_img_prev"
					src='<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>'
					value=" " width="200" /></a> <span style='cursor: pointer'
					onclick="document.getElementById('deleteOldImg').value='1';document.getElementById('q_img').value='';document.getElementById('prev_div').style.display='none';"
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
				<label for="id">Question Set</label><br /> <select
					disabled="disabled">
					<option selected="selected">Disabled</option>
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
					id="privacy">
					<option selected value="0">Public</option>
					<option value="1">Private</option>
				</select>
			</div>
			<div>
				<label for="id">Difficulty</label><br /> <select name="difficulty"
					id="difficulty">
					<option selected value="1">Easy</option>
					<option value="2">Medium</option>
					<option value="3">Hard</option>
				</select>
			</div>
		</div>
		<input name="oldImg" type="hidden" value="<%=q.getQ_img()%>" /> <input
			name="q_id" type="hidden" value="<%=q.getQ_id()%>" /> <input
			id="deleteOldImg" name="deleteOldImg" type="hidden" value="0" />
		<div>
			<input style="width: 100px; height: 30px" name="btn" id="btn"
				type="submit" value="Update" />
		</div>
	</form>
	<script>
document.getElementById('q_statement').value=`<%=q.getQ_statement()%>`;
document.getElementById('opt_1').value=`<%=wrongOptList.get(0).getOpt_text()%>`;
document.getElementById('opt_2').value=`<%=wrongOptList.get(1).getOpt_text()%>`;
document.getElementById('opt_3').value=`<%=wrongOptList.get(2).getOpt_text()%>`;
document.getElementById('ans_1').value=`<%=rightOptList.get(0).getOpt_text()%>`;
document.getElementById('opt_n').value=`<%for (int i = 3; i < wrongOptList.size(); i++) {%><%=wrongOptList.get(i).getOpt_text().strip()%>///<%}%>`;
document.getElementById('ans_n').value=`<%for (int i = 1; i < rightOptList.size(); i++) {%><%=rightOptList.get(i).getOpt_text().strip().replace("\n", "")%>///<%}%>`;
document.getElementById('batch').value=`<%=q.getQ_batch()%>` 
document.getElementById('section').value=`<%=q.getQ_section()%>`
document.getElementById('course').value=`<%=q.getQ_subject()%>`
document.getElementById('privacy').value=`<%=q.getQ_privacy()%>`
document.getElementById('difficulty').value=`<%=q.getQ_difficulty()%>`
const file = document.getElementById('q_img');
file.value='';
<%if (q.getQ_img()==null) {%>
document.getElementById('prev_div').style.display='none';
<%}%>
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