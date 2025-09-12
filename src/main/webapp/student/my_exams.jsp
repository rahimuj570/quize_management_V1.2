
<%@page import="helper.GetBatchSectionOfStudentPOJO"%>
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
				<i class="fa fa-calendar-check-o"></i> Upcoming Exam
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.ParticipatedExam)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Upcoming
					Exams</a></li>
		</ul>
	</div>
	<div class="container-fluid">






		<%
		if (session.getAttribute("exam_early_entry") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("exam_early_entry")%>
		</div>
		<%
		session.removeAttribute("exam_early_entry");
		}
		%>
		<%
		if (session.getAttribute("exam_violation") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("exam_violation")%>
		</div>
		<%
		session.removeAttribute("exam_violation");
		}
		%>
		<%
		if (session.getAttribute("exam_over_entry") != null) {
		%>
		<div class="alert alert-danger" role="alert">
			<%=session.getAttribute("exam_over_entry")%>
		</div>
		<%
		session.removeAttribute("exam_over_entry");
		}
		%>





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
								<th>Exam Type</th>
								<th>Enter</th>
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
								<td><%=e.getExam_question_amount()%></td>
								<td><%=e.getExam_marks()%></td>
								<td><%=e.getExam_start()%></td>
								<td><%=e.getExam_duration()%> Minutes</td>
								<td><%=e.getExam_privacy() == 0 ? "Public" : "Protected"%></td>
								<%
								if (e.getExam_privacy() == 0) {
								%>
								<td>
									<button class="btn btn-primary"
										onclick="enterExam(<%=e.getExam_id()%>)"
										style="color: white; padding: 3px 5px">Enter</button>
								</td>
								<%
								} else if (eDao.isAlredyPermited(cu.getUser_id(), e.getExam_id())) {
								%>
								<td>
									<button class="btn btn-primary"
										onclick="enterExam(<%=e.getExam_id()%>)"
										style="color: white; padding: 3px 5px">Enter</button>
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




						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>


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
