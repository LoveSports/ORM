<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*,java.sql.Timestamp, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="css/lovesports.css">
<script type="text/javascript" src="js/jquery-2.1.3.js">
	
</script>
<script>
	$(function() {
		$('#cancel').click(function() {
			window.location.href = "/LoveSportsORM/Group.jsp";
		});
	});
</script>
</head>
<body style="padding-top: 70px;">
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = (User) session.getAttribute("User");

		if (action != null) {
			if ("logout".equals(action)) {
				session.removeAttribute("User");
				action = null;
				response.sendRedirect("/LoveSportsORM/Group.jsp");
			}
		}
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
								<li><a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-7">
						<div id="login" class="navbar-form pull-right">
							<form action="CreateGroup.jsp">
								<strong><a
									href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
										<%=user.getNickname()%>!
								</a></strong>
								<button type="submit" name="action" value="logout"
									class="btn btn-logout">Log Out</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</nav>
	<%
		GroupDAO gdao = new GroupDAO();
		String groupName = request.getParameter("groupName");
		String description = request.getParameter("description");
		if (action != null) {
			if (user != null) {
				if ("createGroup".equals(action)) {
					if (gdao.read(groupName) == null) {
						long time = System.currentTimeMillis();
						Timestamp createDate = new Timestamp(time);
						Group newgroup = new Group(groupName, description,
								createDate, user);
						gdao.create(newgroup);
						response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
								+ groupName);
					}
				}
			}
		}
	%>

	<div class="container">
		<form action="CreateGroup.jsp">
			<div class="row" style="padding-top: 30px; padding-bottom: 5px">
				<div class="col-lg-2"></div>
				<div class="col-lg-6">
					<h1 style="font-size: 60px">New group</h1>
				</div>
			</div>
			<div class="row" style="padding-top: 5px; padding-bottom: 10px">
				<div class="col-lg-2"></div>
				<div class="col-lg-6">
					<input id="groupName" placeholder="Enter Group Name" type="text"
						name="groupName" class="form-control" required />
				</div>
				<div class="col-lg-3">
					<%
						if (groupName != null) {
							if (gdao.read(groupName) != null) {
					%>
					<em>Group name has been used.</em>
					<%
						}
						}
					%>
				</div>
			</div>
			<div class="row" style="padding-top: 10px; padding-bottom: 5px">
				<div class="col-lg-2"></div>
				<div class="col-lg-6">
					<textarea id="description" placeholder="Enter Group Description"
						rows="5" name="description" class="form-control" required></textarea>
				</div>
			</div>
			<div class="row" style="padding-top: 20px; padding-bottom: 5px">
				<div class="col-lg-4"></div>
				<div class="col-lg-2">
					<button name="action" value="createGroup"
						class="btn btn-lg btn-primary btn-block">Create</button>
				</div>
				<div class="col-lg-2">
					<button id="cancel" class="btn btn-lg btn-danger btn-block">Cancel</button>
				</div>
		</form>
	</div>
</body>
</html>