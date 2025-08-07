<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Unauthorized Access</title>
</head>
<body style="text-align: center">
	<h2>Unauthorized Access!</h2>
	<a href="<%=request.getContextPath()%>/login.jsp"><button>Login</button></a>
</body>
</html>