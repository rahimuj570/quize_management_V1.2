
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Home</a></li>
		<li><a href="pending_users.jsp">Pending Users</a></li>
		<li><a href="pending_exams.jsp">Pending Exams</a></li>
		<li><a href="show_teachers.jsp">Show Teachers</a></li>
		<li><a href="show_students.jsp">Show Student</a></li>
		<li><a href="show_permitted_exams.jsp">Show Permitted Exams</a></li>
		<li><a href="show_admins.jsp">Show Administrators</a></li>
		<%
		Users me = (Users) session.getAttribute("current_user");
		%>
		<li
			onclick="showProfileInfo('<%=me.getUser_last_name()%>','<%=me.getUser_email()%>','<%=me.getUser_id()%>')"><a
			href="#">Profile Info</a></li>
		<%
		if (me.getUser_is_teacher() == 1) {
		%>
		<li><a href="<%=request.getContextPath()%>/teacher/dashboard.jsp">Switch
				to Teacher Privilege</a></li>
		<%
		}
		%>
		<li onclick="changePassword('<%=request.getContextPath()%>')"
			style="cursor: pointer;">Change Password</li>
		<li><a href="<%=request.getContextPath()%>/LogoutServlet">LOGOUT</a></li>
	</ul>
</nav>
<div style="text-align: center; margin: 20px 0px">
	<%
	if (session.getAttribute("password_change_OK") != null) {
	%>
	<span class="center_txt success_txt"><%=session.getAttribute("password_change_OK")%></span>
	<%
	session.removeAttribute("password_change_OK");
	}
	%>
	<%
	if (session.getAttribute("password_change_BAD") != null) {
	%>
	<span class="center_txt danger_txt"><%=session.getAttribute("password_change_BAD")%></span>
	<%
	session.removeAttribute("password_change_BAD");
	}
	%>
</div>