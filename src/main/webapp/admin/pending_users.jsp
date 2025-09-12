<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.UsersDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@include file="top_common.jsp"%>


<%
UsersDao u = new UsersDao(ConnectionProvider.main());
ArrayList<Users> uList = u.getUnapprovedUsers();
%>
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-user-plus"></i> Pending Users
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.PENDING_USERS)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Pending Users</a></li>
		</ul>
	</div>

	<%
	if (session.getAttribute("success_approved") != null) {
	%>


	<%
	session.removeAttribute("success_approved");
	}
	%>
	<%
	if (session.getAttribute("fail_approved") != null) {
	%>
	
	<div class="alert alert-danger" role="alert">
		<%=session.getAttribute("fail_approved")%>
	</div>
	<%
	session.removeAttribute("fail_approved");
	}
	%>

	<!--	============	-->

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
								<th>Role</th>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
								<th>Approved</th>
								<th>Decline</th>

							</tr>
						</thead>
						<tbody>
							<%
							for (Users user : uList) {
							%>
							<tr>
								<td><%=user.getUser_id()%></td>
								<td>
									<%
									if (user.getUser_is_teacher() == 0) {
									%>Student<%
									} else {
									%>Teacher<%
									}
									%>
								</td>
								<td><%=user.getUser_first_name()%></td>
								<td><%=user.getUser_last_name()%></td>
								<td><%=user.getUser_email()%></td>
								<td><a style="color: white"
									href="<%=request.getContextPath()%>/ApprovedUserServlet?user_id=<%=user.getUser_id()%>"><button
											class="btn btn-success" style="padding: 3px 5px">
											Accept</button></a></td>
								<td><a
									href="<%=request.getContextPath()%>/DeclineUserServlet?user_id=<%=user.getUser_id()%>">

										<button class="btn btn-danger"
											style="color: white; padding: 3px 5px">Reject</button>
								</a></td>
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
