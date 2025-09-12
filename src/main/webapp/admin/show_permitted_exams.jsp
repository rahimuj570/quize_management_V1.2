<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.UsersDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@include file="top_common.jsp"%>


<%
UsersDao u = new UsersDao(ConnectionProvider.main());
ArrayList<Users> uList = u.getUsersList(1);
%>
<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Exams> examList = eDao.getPermittedExam();
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>

<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-calendar-check-o"></i> Show Permitted Exam
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_EXAM)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show
					Permitted Exam</a></li>
		</ul>
	</div>



	<%
	if (session.getAttribute("success_admin") != null) {
	%>

	<div class="alert alert-success" role="alert">
		<%=session.getAttribute("success_admin")%>
	</div>
	<%
	session.removeAttribute("success_admin");
	}
	%>
	<%
	if (session.getAttribute("fail_admin") != null) {
	%>

	<div class="alert alert-danger" role="alert">
		<%=session.getAttribute("fail_admin")%>
	</div>
	<%
	session.removeAttribute("fail_admin");
	}
	%>

	<!-- ========== -->

	<%
	if (session.getAttribute("success_decline") != null) {
	%>
	<div class="alert alert-success" role="alert">
		<%=session.getAttribute("success_decline")%>
	</div>
	<%
	session.removeAttribute("success_decline");
	}
	%>
	<%
	if (session.getAttribute("fail_decline") != null) {
	%>

	<div class="alert alert-danger" role="alert">
		<%=session.getAttribute("fail_decline")%>
	</div>
	<%
	session.removeAttribute("fail_decline");
	}
	%>


	<div class="row">
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<table class="table table-hover table-bordered" id="sampleTable">
						<thead>
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
								<th>Exam Over</th>
								<th>Permit More Student</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Exams e : examList) {
							%>
							<tr>
								<td><%=e.getExam_id()%></td>
								<td><%=e.getExam_name()%></td>
								<td><%=bsDao.getCourseNameById(e.getExam_course())%></td>
								<td><%=bsDao.getBatchNameById(e.getExam_batch())%></td>
								<td><%=bsDao.getSectionNameById(e.getExam_section())%></td>
								<td><%=e.getExam_question_amount()%>
								<td><%=e.getExam_marks()%>
								<td><%=e.getExam_start()%>
								<td><%=e.getExam_duration()%>
								<td>
									<%
									if (e.getExam_end().before(new Date(new Date().getTime())))
										out.print("Yes");
									else
										out.print("No");
									%> <%
 if (e.getExam_end().before(new Date())) {
 %>
								
								<td>N/A</td>
								<%
								} else {
								%>

								<td><a
									href="<%=request.getContextPath()%>/admin/select_students.jsp?exam_id=<%=e.getExam_id()%>">

										<button style="color: white; padding: 3px 5px"
											class="btn btn-warning">Permit</button>
								</a></td>
								<%
								}
								%>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>




</main>


<script type="text/javascript">
let removeUser=(e)=>{
	if(confirm('Are you sure to remove this user as admin?')){
		location=e;
	}
}


let makeAdmin=(e)=>{
	if(confirm('Are you sure to make admin this user?')){
		location=e;
	}
}
</script>


<!-- Essential javascripts for application to work-->
<script src="../assets/jquery-3.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script src="../assets/main.js"></script>

<!-- Data table plugin-->
<script type="text/javascript" src="../assets/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../assets/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
	$('#sampleTable').DataTable();
</script>
</body>
</html>
