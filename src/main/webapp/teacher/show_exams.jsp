
<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
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
				<i class="fa fa-th-list"></i> Exams
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_EXAM)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show Exams</a></li>
		</ul>
	</div>
	<div class="container-fluid">
		<div class="text-center mt-4">
			<button onclick="window.location='create_exam.jsp'"
				style="background-color: #1abc9c; color: #fff; border: none; padding: 5px 10px; font-size: 1rem; border-radius: 3px; transition: background-color 0.3s ease; margin-bottom: 5px"
				class="create-button" 
				>Create Exam</button>
		</div>



		<%
		if (session.getAttribute("update_exam_OK") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("update_exam_OK")%></div>

		<%
		session.removeAttribute("update_exam_OK");
		}
		%>
		<%
		if (session.getAttribute("create_exam_OK") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("create_exam_OK")%></div>

		<%
		session.removeAttribute("create_exam_OK");
		}
		%>
		<%
		if (session.getAttribute("delete_exam_OK") != null) {
		%>
		<div class="alert alert-success" role="alert"><%=session.getAttribute("delete_exam_OK")%></div>

		<%
		session.removeAttribute("delete_exam_OK");
		}
		%>
		<%
		if (session.getAttribute("update_exam_401") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("update_exam_401")%>
		</div>
		<%
		session.removeAttribute("update_exam_401");
		}
		%>






		<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();

ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Exams> examList = eDao.getAllExamById(cu.getUser_id());
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>









	</div>
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
								<th>Privacy</th>
								<th>Approved by Admin</th>
								<th>Edit</th>
								<th>Delete</th>
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
					%>
				
				<td><%=e.getExam_privacy() == 0 ? "Public" : "Protected"%></td>
				<td><%=e.getExam_isApproved() == 1 ? "YES" : "NO"%></td>
				<%if(!e.getExam_end().before(new Date(new Date().getTime()))){ %>
				<td>
					<button style="background: cyan">
						<a
							href="<%=request.getContextPath()%>/teacher/edit_exam.jsp?exam_id=<%=e.getExam_id()%>">Edit</a>
					</button>
				</td>
				<td>
					<button style="background: #ffc6c6">
						<a
							href="<%=request.getContextPath()%>/DeleteExamServlet?exam_id=<%=e.getExam_id()%>">Delete</a>
					</button>
				</td>
				<%}else{ %>
				<td colspan="2">
					<button style="background: lime">
						<a
							href="show_results.jsp?exam_id=<%=e.getExam_id()%>">Show Student Result</a>
					</button>
				</td>				
				<%} %>
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
