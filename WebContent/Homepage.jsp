<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*,
	java.util.regex.Matcher, java.util.regex.Pattern"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
</head>
<body style="padding-top: 70px;">
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Homepage.jsp");
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/Homepage.jsp");
				} else {
					out.println("Username and Password are not matched.");
				}
				action = null;
			}
		}
		User user = (User) session.getAttribute("User");
	%>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="navbar-brand" style="color: #CCCCCC"> LoveSports </a>
				<div class="container">
					<div class="row">
						<div class="col-lg-5">
							<div id="navbar" class="navbar-collapse collapse">
								<ul class="nav navbar-nav">
									<li><a href="/LoveSportsORM/Homepage.jsp">Homepage</a></li>
									<li><a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>

									</li>
								</ul>
							</div>
						</div>
						<div class="col-lg-7">
							<%
								if (user == null) {
							%>
							<div id="login" class="navbar-form pull-right">
								<form id="form" action="Homepage.jsp">
									<input class="form-control" name="username" type="text"
										placeholder="Email" /> <input class="form-control"
										name="password" type="password" placeholder="Password" />
									<button class="btn btn-success" type="submit" name="action"
										value="login">Log In</button>
									<button class="btn btn-info" name="action" value="signup">Sign Up</button>
								</form>
							</div>
							<%
								} else {
							%>
							<div id="login" class="navbar-form pull-right">
								<form action="Homepage.jsp">
									<strong><a
										href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
											<%=user.getNickname()%>!
									</a></strong>
									<button type="submit" name="action" value="logout"
										class="btn btn-danger">Log Out</button>
								</form>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>