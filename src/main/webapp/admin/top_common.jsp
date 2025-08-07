<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>OEMS - Online Management System</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<%
Users me = (Users) session.getAttribute("current_user");
String currentPage = request.getRequestURI();
%>

<script>
let showProfileInfo = (lname, email, id) => {
	alert('Last Name: ' + lname + '\nID: ' + id + '\nEmail: ' + email)
}

let changePassword = (url_loc) => {
	let password = prompt("Enter new password: \n[Must be greather than 3 charecter and less then 21 character]", "");
	if (password==null || password == '' || password.length > 20 || password.length < 4);
	else {
		location = url_loc + "/ChangePasswordServlet?p=" + password;
	}
}
</script>





</head>
<body class="app sidebar-mini rtl">
	<!-- Navbar-->
	<header style="background: #1abc9c" class="app-header">
		<a style='background: #009688' class="app-header__logo"
			href="dashboard.jsp">OEMS</a>
		<!-- Sidebar toggle button-->
		<a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
			aria-label="Hide Sidebar"></a>
		<!-- Navbar Right Menu-->
		<ul class="app-nav">

			<li
				onclick="showProfileInfo('<%=me.getUser_last_name()%>','<%=me.getUser_email()%>','<%=me.getUser_id()%>')"
				title="Profile info" class="dropdown"><a class="app-nav__item"
				href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i
					class="fa fa-user-circle-o fa-lg"></i></a>
			<li onclick="changePassword('<%=request.getContextPath()%>')"
				title="Change Password" class="dropdown"><a
				class="app-nav__item" href="#" data-toggle="dropdown"
				aria-label="Open Profile Menu"><i class="fa fa-key fa-lg"></i></a>
			<li
				onclick="window.location='<%=request.getContextPath()%>/LogoutServlet'"
				title="Logout" class="dropdown"><a class="app-nav__item"
				href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i
					class="fa fa-sign-out fa-lg"></i></a></li>

		</ul>
	</header>
	<!-- Sidebar menu-->
	<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
	<aside class="app-sidebar">
		<div class="app-sidebar__user">
			<img width="50" class="app-sidebar__user-avatar"
				src="https://avatar.iran.liara.run/username?username=<%=me.getUser_first_name() + "+" + me.getUser_last_name()%>"
				alt="User Image">
			<div>
				<p class="app-sidebar__user-name"><%=me.getUser_first_name() + " " + me.getUser_last_name()%></p>
				<p class="app-sidebar__user-designation">
					<%
					if (me.getUser_is_teacher() == 1 && me.getUser_is_admin() == 1) {
						if (currentPage.contains("admin")) {
							out.print("Admin");
						} else {
							out.print("Teacher");
						}
					} else if (me.getUser_is_teacher() == 1) {
						out.print("Teacher");
					} else if (me.getUser_is_admin() == 1) {
						out.print("Admin");
					} else {
						out.print("Student");
					}
					%>
				</p>
			</div>
		</div>




		<ul class="app-menu">
			<li><a
				class='app-menu__item <%=currentPage.endsWith("dashboard.jsp") ? "active" : ""%>'
				href="dashboard.jsp"><i class="app-menu__icon fa fa-dashboard"></i><span
					class="app-menu__label">Dashboard</span></a></li>
			<li><a
				class='app-menu__item <%=currentPage.endsWith("pending_users.jsp") ? "active" : ""%>'
				href="pending_users.jsp"><i
					class="app-menu__icon fa fa-user-plus"></i><span
					class="app-menu__label">Pending Users</span></a></li>


			<li><a
				class='app-menu__item <%=currentPage.endsWith("pending_exams.jsp") ? "active" : ""%>'
				href="pending_exams.jsp"><i
					class="app-menu__icon fa fa-calendar-check-o"></i><span
					class="app-menu__label">Pending Exams</span></a></li>

			<li><a
				class='app-menu__item <%=currentPage.endsWith("show_teachers.jsp") ? "active" : ""%>'
				href="show_teachers.jsp"><i
					class="app-menu__icon fa fa-id-badge"></i><span
					class="app-menu__label">Show Teachers</span></a></li>

			<li><a class="app-menu__item" href="show_students.jsp"><i
					class="app-menu__icon fa fa-graduation-cap"></i><span
					class="app-menu__label">Show Students</span></a></li>

			<li><a
				class='app-menu__item <%=currentPage.endsWith("show_admins.jsp") ? "active" : ""%>'
				href="show_admins.jsp"><i
					class="app-menu__icon fa fa-user-secret"></i><span
					class="app-menu__label">Show Admins</span></a></li>

			<li><a
				class='app-menu__item <%=currentPage.endsWith("show_permitted_exams.jsp") ? "active" : ""%>'
				href="show_permitted_exams.jsp"><i
					class="app-menu__icon fa fa-check-square"></i><span
					class="app-menu__label">Show Permitted Exam</span></a></li>



			<%
			if (me.getUser_is_teacher() == 1 && me.getUser_is_admin() == 1) {
			%>

			<hr class="bg-primary h-2" style="height: 2px" />

			<li><a class='app-menu__item '
				href="<%=request.getContextPath()%>/admin/dashboard.jsp"><i
					class="app-menu__icon fa fa-refresh"></i><span
					class="app-menu__label">Switch to Admin</span></a></li>

			<%
			}
			%>

			<!-- <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span class="app-menu__label">Tables</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="table-basic.html"><i class="icon fa fa-circle-o"></i> Basic Tables</a></li>
            <li><a class="treeview-item" href="table-data-table.html"><i class="icon fa fa-circle-o"></i> Data Tables</a></li>
          </ul>
        </li>-->

		</ul>
	</aside>