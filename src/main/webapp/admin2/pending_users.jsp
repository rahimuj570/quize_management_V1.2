<%@page import="entities.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pending Users</title>
<link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body>
	<%
	UsersDao u = new UsersDao(ConnectionProvider.main());
	ArrayList<Users> uList = u.getUnapprovedUsers();
	%>
	<%@include file="admin_nav.jsp"%>
	<h1 class="center_txt">
		Pending Users (<%=uList.size()%>)
	</h1>
	<%
	if (session.getAttribute("success_approved") != null) {
	%>
	<p class="center_txt success_txt">
		<%=session.getAttribute("success_approved")%>
	</p>
	<%
	session.removeAttribute("success_approved");
	}
	%>
	<%
	if (session.getAttribute("fail_approved") != null) {
	%>
	<p class="center_txt danger_txt">
		<%=session.getAttribute("fail_approved")%>
	</p>
	<%
	session.removeAttribute("fail_approved");
	}
	%>

	<!--	============	-->

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
				<th>Role</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Approved</th>
				<th>Decline</th>
			</tr>
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
				<td><button style="background: lime">
						<a
							href="<%=request.getContextPath()%>/ApprovedUserServlet?user_id=<%=user.getUser_id()%>">Accept</a>
					</button></td>
				<td><button style="background: #ffc6c6">
						<a
							href="<%=request.getContextPath()%>/DeclineUserServlet?user_id=<%=user.getUser_id()%>">Reject</a>
					</button></td>
			</tr>
			<%
			}
			%>

		</table>
	</div>
	<script src="./admin.js"></script>
</body>
</html>