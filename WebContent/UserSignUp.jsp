
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, edu.neu.lovesports.orm.method.*, java.util.*, java.util.regex.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up I Love Sports</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="css/lovesports.css">
</head>

<body style="background-color: #eee;">
	<nav class="navbar navbar-inverse">
	<div class="container">
		<div class="row">

			<div class="col-lg-5">
				<h1 style="font-size: 100px">SignUp</h1>
			</div>
		</div>
	</div>
	</nav>
	<div class="container" style="padding-top: 40px">
		<%
			UserDAO dao = new UserDAO();

			String action = request.getParameter("action");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String repassword = request.getParameter("repassword");
			String nickname = request.getParameter("nickname");
			String email = request.getParameter("email");
			String first = request.getParameter("first");
			String last = request.getParameter("last");

			if ("cancel".equals(action)) {
				response.sendRedirect("/LoveSportsORM/Homepage.jsp");
			}
			if ("create".equals(action)) {
				Pattern pattern = Pattern
						.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
				Matcher matcher = pattern.matcher(username);
				Matcher matcher1 = pattern.matcher(email);
				if (username == "") {
		%>
		<p style="color: red">Please enter username!</p>
		<p style="color: red">Username should be valid email address!</p>
		<%
			} else if (!matcher.matches()) {
		%>
		<p style="color: red">Username entered is not valid email address!</p>
		<p style="color: red">Username should be valid email address!</p>
		<%
			} else if (dao.read(username) != null) {
		%>
		<p style="color: red">Username exists!</p>
		<%
			} else if (password == "") {
		%>
		<p style="color: red">Please enter password!</p>
		<%
			} else if (!password.equals(repassword)) {
		%>
		<p style="color: red">Password is not consistent!</p>
		<%
			} else if (nickname == "") {
		%>
		<p style="color: red">Nickname is required!</p>
		<%
			} else if (email != "" && !matcher1.matches()) {
		%>
		<p style="color: red">Invalid email!</p>
		<%
			} else {
					User user = new User(username, password, nickname, first,
							last, email);
					dao.create(user);
		%>
		<p style="color: green">SignUp successfully!</p>
		<%
			UserLog check = new UserLog();
					check.Login(request, response, username, password);
					String str = "/LoveSportsORM/UserProfile.jsp?name=CUR_USERNAME";
					String redirect = str.replace("CUR_USERNAME", username);
					response.sendRedirect(redirect);
				}
			}
		%>
		<div>
			<form action="UserSignUp.jsp">
				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Username</div>
					<div class="col-lg-5">
						<input name="username"
							placeholder="Username should be valid email address."
							class="form-control" />
					</div>
					<div class="col-lg-1">*</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Password</div>
					<div class="col-lg-5">
						<input type="password" name="password" class="form-control" />
					</div>
					<div class="col-lg-1">*</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Re-enter password</div>
					<div class="col-lg-5">
						<input type="password" name="repassword" class="form-control" />
					</div>
					<div class="col-lg-1">*</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Nickname</div>
					<div class="col-lg-5">
						<input name="nickname" class="form-control" />
					</div>
					<div class="col-lg-1">*</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">First Name</div>
					<div class="col-lg-5">
						<input name="first" class="form-control" />
					</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Last Name</div>
					<div class="col-lg-5">
						<input name="last" class="form-control" />
					</div>
				</div>

				<div class="row" style="padding-top: 5px; padding-bottom: 5px">
					<div class="col-lg-1"></div>
					<div class="col-lg-2">Email</div>
					<div class="col-lg-5">
						<input name="email" class="form-control" />
					</div>
				</div>

				<div class="row" style="padding-top: 20px; padding-bottom: 5px">
					<div class="col-lg-4"></div>
					<div class="col-lg-2">
						<button type="submit" name="action" value="create"
							class="btn btn-lg btn-primary btn-block">Sign Up</button>
					</div>
					<div class="col-lg-2">
						<button type="submit" name="action" value="cancel"
							class="btn btn-lg btn-danger btn-block">Cancel</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>