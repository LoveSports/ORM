<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
<body>
	<%
		UserLog check = new UserLog();
			String action = request.getParameter("action");
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			if (action != null) {

		if ("signup".equals(action))
			response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");

		if ("logout".equals(action))
			session.removeAttribute("User");
		else if ("login".equals(action)) {
			if (username == "" || password == "")
				out.println("Please enter account and password.");
			else if (check.Login(request, response, username, password))
				response.sendRedirect("/LoveSportsORM/Forum.jsp");
			else
				out.println("Username and Password are not matched.");
		}
			}
	%>
<div id="top">
	<div id="login">
		<form id="form" action="Forum.jsp">
			Account: <input name="username" type="text" /> Password:<input
				name="password" type="password" />
			<button type="submit" name="action" value="login">Log In</button>
			<button name="action" value="signup">Sign Up</button>
		</form>
	</div>
</div>
	<%
		User user = (User) session.getAttribute("User");
			if (user != null) {
	%>
	<script>
		target = document.getElementById("login");
		var username = "<%=user.getUsername() %>";
		var firstName = "<%=user.getFirstName() %>";
		var lastName = "<%=user.getLastName()%>";
		target.innerHTML = "Hello " + firstName + " " + lastName + "!"
					+ "<form action='Forum.jsp'><button name='action' value='logout'>Log Out</button></form>";
	</script>
	<%
		}
	%>
	
	
</body>
</html>