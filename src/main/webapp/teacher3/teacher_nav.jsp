
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="dashboard.jsp">Home</a></li>
		<li><a href="create_question.jsp">Create Question</a></li>
		<li><a href="show_question_set.jsp">Question Sets</a></li>
		<li><a href="show_questions.jsp">Show Questions</a></li>
		<li><a href="create_exam.jsp">Create Exam</a></li>
		<li><a href="show_exams.jsp">Show Exam</a></li>
		<%
		Users me = (Users) session.getAttribute("current_user");
		if (me.getUser_is_admin() == 1) {
		%>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Switch
				to Admin Privilege</a></li>
		<%
		}
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