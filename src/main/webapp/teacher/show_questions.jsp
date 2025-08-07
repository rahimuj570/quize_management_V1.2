<%@page import="entities.Options"%>
<%@page import="java.io.File"%>
<%@page import="entities.Questions"%>
<%@page import="dao.QuestionsDao"%>
<%@page import="helper.ShowQuestionFilterPOJO"%>
<%@page import="dao.OptionsDao"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="helper.Quotes"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@include file="top_common.jsp"%>

<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-eye"></i> Show Questions
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.SEE_QUESTION)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show
					Questions</a></li>
		</ul>
	</div>







	<div class="container-fluid">


		<%
		if (session.getAttribute("q_edit404") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("q_edit404")%>
		</div>
		<%
		session.removeAttribute("q_edit404");
		}
		%>

		<%
		if (session.getAttribute("remove_to_question_set_BAD") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("remove_to_question_set_BAD")%>
		</div>
		<%
		session.removeAttribute("remove_to_question_set_BAD");
		}
		%>

		<%
		if (session.getAttribute("other_question_remove") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("other_question_remove")%>
		</div>
		<%
		session.removeAttribute("other_question_remove");
		}
		%>


		<%
		if (session.getAttribute("remove_to_question_set_OK") != null) {
		%>
		<div class="alert alert-success" role="alert">
			<%=session.getAttribute("remove_to_question_set_OK")%>
		</div>
		<%
		session.removeAttribute("remove_to_question_set_OK");
		}
		%>


		<%
		if (session.getAttribute("question_delete_BAD") != null) {
		%>
		<div class="alert alert-success" role="alert">
			<%=session.getAttribute("question_delete_BAD")%>
		</div>
		<%
		session.removeAttribute("question_delete_BAD");
		}
		%>

		<%
		if (session.getAttribute("other_question_delete") != null) {
		%>
		<div class="alert alert-success" role="alert">
			<%=session.getAttribute("other_question_delete")%>
		</div>
		<%
		session.removeAttribute("other_question_delete");
		}
		%>

		<%
		if (session.getAttribute("question_delete_OK") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("question_delete_OK")%></div>

		<%
		session.removeAttribute("question_delete_OK");
		}
		%>







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
		q_pojo.setCurrent_user(cu.getUser_id());

		ArrayList<Questions> qList = qDao.getAllQuestion(q_pojo);
		%>









	</div>
	<div class="row">
		<div class="col-md-12">

			<form
				style="background:white; margin-bottom: 10px; padding: 20px; border-radius: 3px; box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 1px 5px 0 rgba(0, 0, 0, 0.12), 0 3px 1px -2px rgba(0, 0, 0, 0.2);"
				method="get"
				action="<%=request.getContextPath()%>/teacher2/show_questions.jsp">
				<input type="checkbox" id="own" name="own" value="1"> <label
					for="own"> My Questions</label><br> <input type="checkbox"
					id="other" name="other" value="1"> <label for="other">Others
					Question</label><br>
				<div style="display: flex; gap: 10px; margin: 5px 0px">
					<div>
						<label for="id">Difficulty</label><br /> <select
							name="difficulty" id="difficulty">
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
						<label for="id">Batch</label><br /> <select name="batch"
							id="batch">
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
				<input class="btn btn-primary mb-2"
					style="color: white; padding: 3px 5px" type="submit" value="Filter">
			</form>










			<div class="tile">
				<div class="tile-body">
					<form
						action="<%=request.getContextPath()%>/AddToQuestionSetServlet"
						method="get">
						<table class="table table-hover table-bordered" id="sampleTable">
							<thead>
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
							</thead>
							<tbody>
								<div class="form-container">

									<div class="row g-2 align-items-end justify-content-center">

										<div class="col-auto">
											<label for="q_set" class="form-label">Question Set</label> <select style="border: 1px solid #009688;"
												class="form-select" id="q_set" name="qs">
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
										<div class="col-auto">
											<button type="submit" class="btn btn-primary">Add to
												Question Set</button>
										</div>


										<div>


											<%
											if (session.getAttribute("no_question_slected") != null) {
											%>
											<div class=" mx-auto w-75 alert alert-danger" role="alert">
												<%=session.getAttribute("no_question_slected")%>
											</div>
											<%
											session.removeAttribute("no_question_slected");
											}
											%>
											<%
											if (session.getAttribute("add_to_question_set_OK") != null) {
											%>
											<div class="alert alert-success  mx-auto w-75" role="alert">
												<%=session.getAttribute("add_to_question_set_OK")%>
											</div>
											<%
											session.removeAttribute("add_to_question_set_OK");
											}
											%>
											<%
											if (session.getAttribute("add_to_question_set_BAD") != null) {
											%>
											<div class="alert alert-danger  mx-auto w-75" role="alert">
												<%=session.getAttribute("add_to_question_set_BAD")%>
											</div>
											<%
											session.removeAttribute("add_to_question_set_BAD");
											}
											%>
											<%
											if (session.getAttribute("no_question_set_slected") != null) {
											%>
											<div class="alert alert-danger  mx-auto w-75" role="alert">
												<%=session.getAttribute("no_question_set_slected")%>
											</div>
											<%
											session.removeAttribute("no_question_set_slected");
											}
											%>

										</div>

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
									<td><button class="btn btn-info"
											onclick="alert('Wrong options : \n <%for (var o : optList) {
	out.print(o.getOpt_text());%>\n<%}%>\nRight options : \n <%for (var o : optList2) {
	out.print(o.getOpt_text());%>\n<%}%> \nBatch: <%=q.getQ_batch()%>\nDificulty Level: <%=q.getQ_difficulty()%>\nPrivacy Level: <%=q.getQ_privacy()%>'); return false; "
											style="color: white; padding: 3px 5px">See Details</button></td>
									<td>
										<%
										if (q.getQ_teacher() == cu.getUser_id()) {
										%>
										<button class="btn btn-warning"
											onclick="location=`<%=request.getContextPath()%>/teacher2/edit_question.jsp?q_id=<%=q.getQ_id()%>`;return false;"
											style="color: green; padding: 3px 5px">Edit</button> <%
 } else {
 %>
										<button onclick="return false;" disabled="disabled">
											Edit</button> <%
 }
 %>
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
										<button class="btn btn-danger"
											onclick="location=`<%=request.getContextPath()%>/DeleteQuestionServlet?q_id=<%=q.getQ_id()%>`;return false;"
											style="color: white; padding: 3px 5px">Delete</button> <%
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

								</div>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</main>




</main>

<script type="text/javascript">
if(location.search.search("own")<0 && location.search.search("other")<0){	
	document.getElementById('other').checked=1
	document.getElementById('own').checked=1
}else{	
	document.getElementById('other').checked=<%=q_pojo.getOther()%>
	document.getElementById('own').checked=<%=q_pojo.getOwn()%>
}
//if(location.search.search("qs")<0){	
//	document.getElementById('th_remove').display=none;
//	document.getElementById('td_remove').display=none;
//}

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


<!-- Essential javascripts for application to work-->
<script src="jquery-3.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script src="main.js"></script>

<!-- Data table plugin-->
<script type="text/javascript" src="plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
	$('#sampleTable').DataTable();
</script>
</body>
</html>
