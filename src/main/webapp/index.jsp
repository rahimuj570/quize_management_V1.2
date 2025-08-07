<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome To IDP1</title>
</head>
<body>
	<%
	Users cu = (Users) session.getAttribute("current_user");
	if (cu == null) {
		response.sendRedirect("login.jsp");
	} else {
		if (cu.getUser_is_admin() == 1) {
			response.sendRedirect("admin/dashboard.jsp");
		} else if (cu.getUser_is_teacher() == 1) {
			response.sendRedirect("teacher/dashboard.jsp");
		} else {
			response.sendRedirect("student/dashboard.jsp");
		}
	}
	%>
</body>
</html>