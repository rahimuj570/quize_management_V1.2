<%@page import="entities.QuestionSets"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.TempExamCreateSessionPOJO"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@include file="top_common.jsp"%>


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

<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-th-list"></i> Select Question Set for Exams
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.SEE_QUESTION_SET)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show Exams</a></li>
		</ul>
	</div>
	<div class="container-fluid">




		<h2>
			Select Question Set for Exam named "<%=request.getParameter("exam_name")%>"
		</h2>
		<h4 class="mb-3">
			<strong class="text-danger">NOTE:</strong> Question Quantity Must be
			at least "<%=request.getParameter("exam_question_amount")%>"
		</h4>
		<div class="row" style="">
			<div class="col-4">
				<label for="id">Section</label><br /> <select class="form-control"
					name="difficulty" id="difficulty">
					<option selected value="<%=request.getParameter("section")%>"><%=bs.getSectionNameById(Integer.parseInt(request.getParameter("section")))%></option>
				</select>
			</div>
			<div class="col-4">
				<label for="id">Course</label><br /> <select class="form-control"
					name="course" id="course">
					<option selected value="<%=request.getParameter("course")%>"><%=bs.getCourseNameById(Integer.parseInt(request.getParameter("course")))%></option>

				</select>
			</div>

			<div class="col-4">
				<label for="id">Batch</label><br /> <select class="form-control"
					name="batch" id="batch">
					<option selected value="<%=request.getParameter("batch")%>"><%=bs.getBatchNameById(Integer.parseInt(request.getParameter("batch")))%></option>
				</select>
			</div>
		</div>
		<hr style="width: 100%" />
		<hr style="width: 100%" />
		<div style="overflow-x: auto;">
			<form method="post"
				action="<%=request.getContextPath()%>/CreateExamServlet">
				<table class="table table-hover table-bordered" id="sampleTable">
					<thead>
						<tr>
							<th>MARK</th>
							<th>Set ID</th>
							<th>Set Name</th>
							<th>Questions Quantity</th>
							<th>Section</th>
						</tr>
					</thead>


					<tbody>
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
						<div class="justify-content-center"
							style="display: flex; gap: 10px">
							<button type="submit" class="btn btn-primary mb-2" id="addSet">Add
								to Question Set</button>
						</div>






						<%
						if (session.getAttribute("no_qs_select") != null) {
						%>
						<div class="alert alert-danger" role="alert">
							<%=session.getAttribute("no_qs_select")%>
						</div>
						<%
						session.removeAttribute("no_qs_select");
						}
						%>





					</tbody>
				</table>

			</form>




		</div>
</main>

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
