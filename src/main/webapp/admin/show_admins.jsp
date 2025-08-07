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
ArrayList<Users> uList = u.getUsersList(0);
%>
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-graduation-cap"></i> Show Admins
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.ADMIN)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show Admins</a></li>
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
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
								<th>Details</th>
								<th>Decline</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Users user : uList) {
							%>
							<tr>
								<td><%=user.getUser_id()%></td>
								<td><%=user.getUser_first_name()%></td>
								<td><%=user.getUser_last_name()%></td>
								<td><%=user.getUser_email()%></td>
								<td><button class="btn btn-info"
										onclick="alert('Details will show here!')"
										style="color: white; padding: 3px 5px">Details</button></td>
								<td>
									<%
									if (user.getUser_id().equals(me.getUser_id())) {
									%>
									<button style="color: white; padding: 3px 5px"
										class="btn btn-danger" disabled>Remove</button> <%
 } else {
 %>
									<button class="btn btn-danger"
										onclick="removeUser('<%=request.getContextPath()%>/RemoveAdminServlet?user_id=<%=user.getUser_id()%>')"
										style="color: white; padding: 3px 5px">Remove</button> <%
 }
 %>
								</td>
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
