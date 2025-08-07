<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="top_common.jsp"%>
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-check-square"></i> Select Students for the Exam
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.ADMIN)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Select
					Students for the Exams</a></li>
		</ul>
	</div>
	<%
	Connection con = ConnectionProvider.main();
	%>
	<div class="row">

		<%
		BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
		ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
		Exams e = eDao.getExamById(request.getParameter("exam_id"));
	
		%>
		<h1>
		
			You need to provide the eligible students IDs, because the exam (ID:<%=e.getExam_id()%>;
			Name:<%=e.getExam_name()%>; Batch:<%=bsDao.getBatchNameById(e.getExam_batch())%>; Course:<%=bsDao.getCourseNameById(e.getExam_course())%>;
			Section:<%=bsDao.getSectionNameById(e.getExam_section())%>) is
			protected!
		</h1>
		<form
			style="text-align: center; background: white; padding: 10px 0px"
			action="<%=request.getContextPath()%>/ApprovedExamServlet"
			method="post" enctype="multipart/form-data">
			<%
			if (session.getAttribute("no_list_added") != null) {
			%>
			<p class="danger_txt"><%=session.getAttribute("no_list_added")%></p>
			<%
			session.removeAttribute("no_list_added");
			}
			%>
			<%
			if (session.getAttribute("permission_BAD") != null) {
			%>
			<p class="danger_txt"><%=session.getAttribute("permission_BAD")%></p>
			<%
			session.removeAttribute("permission_BAD");
			}
			%>
			<input type="hidden" value="<%=request.getParameter("exam_id")%>"
				name="exam_id" /> <label for="id_list">Provide student IDs
				separated by comma(,). Ex: 221010020,221010021, ...</label><br />
			<textarea name="id_list" id="id_list" rows="10" cols="100%"></textarea>
			<div style="display: flex; margin: 10px 0px">
				<hr style="width: 100%" />
				OR
				<hr style="width: 100%" />
			</div>
			<label for="csv_file">Provide CSV file of student IDs.</label><br />
			<input class="form-control w-50 mx-auto" type="file" name="csv_file" id="csv_file" />
			<div style="text-align: center; margin: 20px 0 0 0">
				<button class="btn btn-primary">Approved</button>
			</div>
		</form>
		<hr style="width: 100%" />
		<hr style="width: 100%" />
		<div
			style="text-align: center; background: white; padding: 20px 0px">
			<h3>Do You Want to Approve All Students?</h3>
			<button class="btn btn-success"
				onclick="location='<%=request.getContextPath()%>/ApprovedAllStudent?exam_id=<%=request.getParameter("exam_id")%>'">Click
				Here</button>
		</div>

	</div>

</main>
<%@include file="bottom_common.jsp"%>