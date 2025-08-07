
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/student/dashboard.jsp">Home</a></li>
		<li><a href="my_exams.jsp">Upcoming Exams</a></li>
		<li><a href="participated_exams.jsp">Participated Exams</a></li>
		<%
		Users me = (Users) session.getAttribute("current_user");
		%>
		<li
			onclick="showProfileInfo('<%=me.getUser_last_name()%>','<%=me.getUser_email()%>','<%=me.getUser_id()%>')"><a
			href="#">Profile Info</a></li>
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