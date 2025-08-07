<%@page import="helper.ConnectionProvider"%>
<%@page import="entities.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Teachers List</title>
<link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body>
	<%
	UsersDao u = new UsersDao(ConnectionProvider.main());
	ArrayList<Users> uList = u.getUsersList(1);
	%>
	<%@include file="admin_nav.jsp"%>
	<h1 class="center_txt">
		Teachers List (<%=uList.size()%>)
	</h1>

	<%
	if (session.getAttribute("success_admin") != null) {
	%>
	<p class="center_txt success_txt">
		<%=session.getAttribute("success_admin")%>
	</p>
	<%
	session.removeAttribute("success_admin");
	}
	%>
	<%
	if (session.getAttribute("fail_admin") != null) {
	%>
	<p class="center_txt danger_txt">
		<%=session.getAttribute("fail_admin")%>
	</p>
	<%
	session.removeAttribute("fail_admin");
	}
	%>

	<!-- ========== -->

	<%
	if (session.getAttribute("success_decline") != null) {
	%>
	<p class="center_txt success_txt">
		<%=session.getAttribute("success_decline")%>
	</p>
	<%
	session.removeAttribute("success_decline");
	}
	%>
	<%
	if (session.getAttribute("fail_decline") != null) {
	%>
	<p class="center_txt danger_txt">
		<%=session.getAttribute("fail_decline")%>
	</p>
	<%
	session.removeAttribute("fail_decline");
	}
	%>
	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Details</th>
				<th>Make Admin</th>
				<th>Decline</th>
			</tr>
			<%
			for (Users user : uList) {
			%>
			<tr>
				<td><%=user.getUser_id()%></td>
				<td><%=user.getUser_first_name()%></td>
				<td><%=user.getUser_last_name()%></td>
				<td><%=user.getUser_email()%></td>
				<td><button onclick="alert('Details will show here!')"
						style="background: lime">
						<a href="#">Details</a>
					</button></td>
				<td>
					<%
					if (user.getUser_is_admin() == 1) {
					%>
					<button disabled style="background:">Make Admin</button> <%
 } else {
 %>
					<button
						onclick="makeAdmin('<%=request.getContextPath()%>/MakeAdminServlet?user_id=<%=user.getUser_id()%>')"
						style="background: cyan">
						<a href="#">Make Admin</a>
					</button> <%
 }
 %>
				</td>
				<td><button
						onclick="removeUser('<%=request.getContextPath()%>/DeclineUserServlet?user_id=<%=user.getUser_id()%>')"
						style="background: #ffc6c6">
						<a href="#">Remove</a>
					</button></td>
			</tr>
			<%
			}
			%>

		</table>
	</div>
	<script src="./admin.js"></script>
	<script type="text/javascript">
let removeUser=(e)=>{
	if(confirm('Are you sure to delete this user from the database?')){
		location=e;
	}
}
let makeAdmin=(e)=>{
	if(confirm('Are you sure to make admin this user?')){
		location=e;
	}
}
</script>
</body>
</html>