
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Users"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BatchSectionDao"%>
<%@include file="top_common.jsp"%>

<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-th-list"></i> Question Sets
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.SEE_QUESTION_SET) %></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Question Set</a></li>
		</ul>
	</div>
	<div class="container-fluid">
		<div class="text-center mt-4">
			<button
				style="background-color: #1abc9c; color: #fff; border: none; padding: 5px 10px; font-size: 1rem; border-radius: 3px; transition: background-color 0.3s ease; margin-bottom: 5px"
				class="create-button" data-bs-toggle="modal"
				data-bs-target="#createQuestionSetModal">Create Set</button>
		</div>


		<%
		if (session.getAttribute("qs_delete_BAD") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("qs_delete_BAD")%>
		</div>
		<%
		session.removeAttribute("qs_delete_BAD");
		}
		%>
		<%
		if (session.getAttribute("other_qs_delete") != null) {
		%>
		<div class="alert alert-success" role="alert">
			<%=session.getAttribute("other_qs_delete")%>
		</div>
		<%
		session.removeAttribute("other_qs_delete");
		}
		%>
		<%
		if (session.getAttribute("qs_delete_OK") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("qs_delete_OK")%></div>

		<%
		session.removeAttribute("qs_delete_OK");
		}
		%>
		<%
		if (session.getAttribute("qs_create_success") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("qs_create_success")%></div>

		<%
		session.removeAttribute("qs_create_success");
		}
		%>
		<%
		if (session.getAttribute("qs_create_fail") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("qs_create_fail")%>
		</div>
		<%
		session.removeAttribute("qs_create_fail");
		}
		%>






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



		<!-- Modal -->
		<div class="modal fade" id="createQuestionSetModal" tabindex="-1"
			aria-labelledby="createQuestionSetModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div style="background-color: #2c3e50; color: #ecf0f1;"
						class="modal-header">
						<h5 class="modal-title" id="createQuestionSetModalLabel">Create
							Question Set</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form
							action="<%=request.getContextPath()%>/CreateQuestionSetServlet"
							method="POST">
							<div class="mb-3">
								<label for="setName" class="form-label required">Set
									Name</label> <input type="text" class="form-control" id="setName"
									name="qs_name" required>
							</div>
							<div class="mb-3">
								<label for="course" class="form-label required">Course</label> <select
									class="form-control" id="course" name="course" required>
									<%
									for (Course c : courseList) {
									%>
									<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="mb-3">
								<label for="batch" class="form-label required">Batch</label> <select
									class="form-control" id="batch" name="batch" required>
									<%
									for (BatchClass bc : classList) {
									%>
									<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="mb-3">
								<label for="section" class="form-label required">Section</label>
								<select class="form-control" id="section" name="section"
									required>
									<%
									for (Sections s : sectiponList) {
									%>
									<option value="<%=s.getId()%>"><%=s.getSection()%></option>
									<%
									}
									%>
								</select>
							</div>
							<button type="submit" class="btn btn-primary">Create
								Question Set</button>
						</form>
					</div>
				</div>
			</div>
		</div>






	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<table class="table table-hover table-bordered" id="sampleTable">
						<thead>
							<tr>
								<th>Id</th>
								<th>Set Name</th>
								<th>Batch</th>
								<th>Course</th>
								<th>Total question</th>
								<th>Details</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>



							<%
							for (QuestionSets qs : qsList) {
							%>
							<tr>
								<td><%=qs.getQs_id()%></td>
								<td><%=qs.getQs_name()%></td>
								<td><%=bsDao.getBatchNameById(qs.getQs_batch())%></td>
								<td><%=bsDao.getCourseNameById(qs.getQs_course())%></td>
								<td><%=qsDao.getTotalQuestionAmount(qs.getQs_id())%>
									<button class="btn btn-secondary">
										<a style="color:white" href="show_questions.jsp?qs=<%=qs.getQs_id()%>">Edit</a>
									</button></td>
								<td><button class="btn btn-info"
										onclick="alert('Created By: <%=cu.getUser_first_name() + " " + cu.getUser_last_name()%> \nCreated On: <%=qs.getQs_created()%>\n Section: <%=bsDao.getSectionNameById(qs.getQs_section())%>\n')">
										<a style="color:white" href="#">More Details</a>
									</button></td>
								<td>
									<button class="btn btn-danger">
										<a style="color:white"
											href="<%=request.getContextPath()%>/DeleteQuestionSetServlet?qs=<%=qs.getQs_id()%>">Delete</a>
									</button>
								</td>
							</tr>
							<%
							}
							%>






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



						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>


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
