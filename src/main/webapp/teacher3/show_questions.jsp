<%@page import="helper.ShowQuestionFilterPOJO"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Options"%>
<%@page import="dao.OptionsDao"%>
<%@page import="java.io.File"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionsDao"%>
<%@page import="entities.Questions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Questions</title>
<link rel="stylesheet" type="text/css" href="teacher.css">
</head>
<body>
	<%@include file="teacher_nav.jsp"%>
	<%
	Users cu = (Users) session.getAttribute("current_user");
	BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
	QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
	ArrayList<Sections> sectiponList = bs.getAllSection();
	ArrayList<BatchClass> classList = bs.getAllClass();
	ArrayList<Course> courseList = bs.getAllCourse();
	ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());

	OptionsDao optDao = new OptionsDao(ConnectionProvider.main());
	ShowQuestionFilterPOJO q_pojo = new ShowQuestionFilterPOJO();
	q_pojo.setOwn(request.getParameter("own") != null ? request.getParameter("own") : "0");
	q_pojo.setOther(request.getParameter("other") != null ? request.getParameter("other") : "0");
	q_pojo.setDifficulty(request.getParameter("difficulty") != null ? request.getParameter("difficulty") : "0");
	q_pojo.setCourse(request.getParameter("course") != null ? request.getParameter("course") : "0");
	q_pojo.setSection(request.getParameter("section") != null ? request.getParameter("section") : "21");
	q_pojo.setBatch(request.getParameter("batch") != null ? request.getParameter("batch") : "0");
	QuestionsDao qDao = new QuestionsDao(ConnectionProvider.main());
	q_pojo.setQs_id(request.getParameter("qs") != null ? request.getParameter("qs") : "0");
	q_pojo.setExclude_qs_id(request.getParameter("exclude_qs") != null ? request.getParameter("exclude_qs") : "0");
	q_pojo.setQ_teacher(cu.getUser_id());

	ArrayList<Questions> qList = qDao.getAllQuestion(q_pojo);
	%>
	<%
	if (session.getAttribute("q_edit404") != null) {
	%>
	<p class="center_txt danger_txt"><%=session.getAttribute("q_edit404")%></p>
	<%
	session.removeAttribute("q_edit404");
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
	<p class="center_txt danger_txt"><%=session.getAttribute("other_question_delete")%></p>
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

	<form method="get"
		action="<%=request.getContextPath()%>/teacher/show_questions.jsp">
		<input type="checkbox" id="own" name="own" value="1"> <label
			for="own"> My Questions</label><br> <input type="checkbox"
			id="other" name="other" value="1"> <label for="other">Others
			Question</label><br>
		<div style="display: flex; gap: 10px; margin: 5px 0px">
			<div>
				<label for="id">Difficulty</label><br /> <select name="difficulty"
					id="difficulty">
					<option selected value="0">ALL</option>
					<option value="1">Easy</option>
					<option value="2">Medium</option>
					<option value="3">Hard</option>
				</select>
			</div>
			<div>
				<label for="id">Course</label><br /> <select name="course"
					id="course">
					<option selected value="0">N/A</option>
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
			<div>
				<label for="id">Batch</label><br /> <select name="batch" id="batch">
					<option selected value="0">N/A</option>
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
				<label for="id">Question Set</label><br /> <select name="qs"
					id="q_set_filter">
					<option selected="selected" value="0">Default</option>
					<%
					for (QuestionSets qset : qsList) {
					%>
					<option value="<%=qset.getQs_id()%>"><%=qset.getQs_name()%></option>
					<%
					}
					%>
				</select>
			</div>
		</div>
		<input style="background: cyan" type="submit" value="Filter">
	</form>
	<hr style="width: 100%" />
	<hr style="width: 100%" />
	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>MARK</th>
				<th>ID</th>
				<th>Image</th>
				<th>Statement</th>
				<th>Course</th>
				<th>Created By</th>
				<th>See Details</th>
				<th>Edit</th>
				<%
				if (request.getParameter("qs") != null && !request.getParameter("qs").equals("0")) {
				%>
				<th>Remove</th>
				<%
				}
				%>
				<th>Delete</th>
			</tr>
			<form method="post"
				action="<%=request.getContextPath()%>/AddToQuestionSetServlet">
				<%
				for (var q : qList) {
				%>
				<tr>
					<td><input name="mark[]" type="checkbox"
						value="<%=q.getQ_id()%>" /></td>
					<td><%=q.getQ_id()%></td>
					<td><a target="_blank"
						href="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>" />
						<img width="100px" alt=""
						src="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>">
						</a></td>
					<td><%=q.getQ_statement()%></td>
					<td><%=q.getQ_subject()%></td>
					<td><%=q.getQ_teacher()%></td>
					<%
					ArrayList<Options> optList = optDao.getAllOptionsByQid(q.getQ_id(), 1, 0);
					ArrayList<Options> optList2 = optDao.getAllOptionsByQid(q.getQ_id(), 0, 1);
					%>
					<td><button
							onclick="alert('Wrong options : \n <%for (var o : optList) {
	out.print(o.getOpt_text());%>\n<%}%>\nRight options : \n <%for (var o : optList2) {
	out.print(o.getOpt_text());%>\n<%}%> \nBatch: <%=q.getQ_batch()%>\nDificulty Level: <%=q.getQ_difficulty()%>\nPrivacy Level: <%=q.getQ_privacy()%>'); return false; "
							style="background: lime">See Details</button></td>
					<td>
					<%if(q.getQ_teacher()==cu.getUser_id()){%>
					<button
					
					onclick="location=`<%=request.getContextPath()%>/teacher/edit_question.jsp?q_id=<%=q.getQ_id()%>`;return false;"
					
					 style="background: gold">
							Edit
						</button>
						<%}else{ %>
						<button onclick="return false;" disabled="disabled">
							Edit</button>
						<%} %>
						</td>
					<%
					if (request.getParameter("qs") != null && !request.getParameter("qs").equals("0")) {
					%>
					<td>
						<button style="background: #ffc6c6">
							<a
								href="<%=request.getContextPath()%>/RemoveToQuestionSetServlet?qs=<%=request.getParameter("qs")%>&q_id=<%=q.getQ_id()%>">Remove</a>
						</button>
					</td>
					<%
					}
					%>
					<td>
						<%
						if (q.getQ_teacher() == cu.getUser_id()) {
						%>
						<button
							onclick="location=`<%=request.getContextPath()%>/DeleteQuestionServlet?q_id=<%=q.getQ_id()%>`;return false;"
							style="background: #ffc6c6">Delete</button> <%
 } else {
 %>
						<button onclick="return false;" disabled="disabled">
							Delete</button> <%
 }
 %>
					</td>
				</tr>
				<%
				}
				%>
				<div style="display: flex; gap: 10px">
					<div>
						<label for="id">Question Set</label><br /> <select name="qs"
							id="q_set">
							<option selected="selected" value="0">Default</option>
							<%
							for (QuestionSets qset : qsList) {
							%>
							<option value="<%=qset.getQs_id()%>"><%=qset.getQs_name()%></option>
							<%
							}
							%>
						</select>
						<button>Add to Question Set</button>
						<%
						if (session.getAttribute("no_question_slected") != null) {
						%>
						<span sype="padding-left:10px" class="danger_txt"><%=session.getAttribute("no_question_slected")%></span>
						<%
						session.removeAttribute("no_question_slected");
						}
						%>
						<%
						if (session.getAttribute("add_to_question_set_OK") != null) {
						%>
						<span sype="padding-left:10px" class="success_txt"><%=session.getAttribute("add_to_question_set_OK")%></span>
						<%
						session.removeAttribute("add_to_question_set_OK");
						}
						%>
						<%
						if (session.getAttribute("add_to_question_set_BAD") != null) {
						%>
						<span sype="padding-left:10px" class="danger_txt"><%=session.getAttribute("add_to_question_set_BAD")%></span>
						<%
						session.removeAttribute("add_to_question_set_BAD");
						}
						%>
						<%
						if (session.getAttribute("no_question_set_slected") != null) {
						%>
						<span sype="padding-left:10px" class="danger_txt"><%=session.getAttribute("no_question_set_slected")%></span>
						<%
						session.removeAttribute("no_question_set_slected");
						}
						%>
					</div>
				</div>
			</form>
		</table>
	</div>
	<script src="./teacher.js"></script>
	<script type="text/javascript">
if(location.search.search("own")<0 && location.search.search("other")<0){	
	document.getElementById('other').checked=1
	document.getElementById('own').checked=1
}else{	
	document.getElementById('other').checked=<%=q_pojo.getOther()%>
	document.getElementById('own').checked=<%=q_pojo.getOwn()%>
}


	document.getElementById('difficulty').value=<%=q_pojo.getDifficulty()%>
	document.getElementById('course').value=<%=q_pojo.getCourse()%>
	document.getElementById('section').value=<%=q_pojo.getSection()%>
	document.getElementById('batch').value=<%=q_pojo.getBatch()%>
	document.getElementById('q_set').value=<%=q_pojo.getExclude_qs_id()%>
	document.getElementById('q_set_filter').value=<%=q_pojo.getQs_id()%>
	if(location.search.search("exclude_qs")>0){
	document.getElementById('q_set_filter').value=0;		
	}

	document.getElementById('q_set').addEventListener('change',(e)=>{
		let params = new URLSearchParams(location.search);
		params.delete('qs');
		let loc;
		if(location.search==""){
			loc=location.href+"?";
		}
		if(location.search.search("exclude_qs")>0){
			params.set('exclude_qs',e.target.value);
		console.log(loc)
		window.location = location.pathname+'?'+params;
		}else{
			params.append('exclude_qs',e.target.value)
			window.location=location.pathname+'?'+params;
		}
	})
	</script>
</body>
</html>