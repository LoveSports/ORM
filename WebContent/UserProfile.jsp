<%@page
	import="org.eclipse.persistence.jpa.jpql.parser.ElseExpressionBNF"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, java.util.*, java.util.regex.*, edu.neu.lovesports.orm.method.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="css/lovesports.css">
</head>
<body style="padding-top: 70px;">

	<%
		UserDAO dao = new UserDAO();
		FollowingDAO fdao = new FollowingDAO();
		AdminDAO adao = new AdminDAO();

		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String follow = request.getParameter("follow");

		if (action != null) {
			if ("signup".equals(action))
				response.sendRedirect("UserSignUp.jsp");

			if ("logout".equals(action))
				session.removeAttribute("User");
			else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					if (dao.read(username).getFrozen() == 1) {
						session.removeAttribute("User");
	%><p style="font-size: 300%; color: red">
		You are frozen!!!(<%=username%>)
	</p>
	<%
		} else
						response.sendRedirect("UserProfile.jsp" + "?name="
								+ name);
				} else
					out.println("Username and Password are not matched.");
			} else if ("follow".equals(action)) {
				User u1 = dao.read(username);
				User u2 = dao.read(name);
				Following f = fdao.create(u1, u2);

				response.sendRedirect("UserProfile.jsp" + "?name=" + name);

			} else if ("unfollow".equals(action)) {
				User u1 = dao.read(username);
				User u2 = dao.read(name);
				fdao.delete(u1, u2);

				response.sendRedirect("UserProfile.jsp" + "?name=" + name);
			}
		}

		User user = (User) session.getAttribute("User");
		User curUser = dao.read(name);
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
						<%
							if (user == null) {
						%>
						<div id="login" class="navbar-form pull-right">
							<form id="form" action="UserProfile.jsp">
								<input class="form-control" name="username" type="text"
									placeholder="Email" /> <input class="form-control"
									name="password" type="password" placeholder="Password" />
								<button class="btn btn-login" type="submit" name="action"
									value="login">Log In</button>
								<button class="btn btn-login" name="action" value="signup">Sign
									Up</button>
								<input type="hidden" name="name" value="<%=name%>"
									style="display: none" />
							</form>
						</div>
						<%
							} else {
						%>
						<div id="login" class="navbar-form pull-right">
							<form action="UserProfile.jsp?name=<%=name%>">
								<strong><a
									href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
										<%=user.getNickname()%>!
								</a></strong>
								<button type="submit" name="action" value="logout"
									class="btn btn-logout">Log Out</button>
								<input type="hidden" name="name" value="<%=name%>"
									style="display: none" />
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
	<!-- ------------------ -->

	<div class="container">
		<div class="jumbotron">
			<h1><%=curUser.getNickname()%></h1>
			<div class="row">
<!-- 				<div class="col-lg-1">
					<img alt="Avatar" style="width: 300; height: 300;">
				</div> -->
				<div class="col-lg-1">
					<form action="UserProfile.jsp">
						<%
							if (user != null
									&& !user.getUsername().equals(curUser.getUsername())) {
						%>
						<%
							if (fdao.read(new FollowingId(user.getUsername(), curUser
										.getUsername())) != null) {
						%>
						<button type="submit" name="action" value="unfollow"
							class="btn">Unfollow</button>
						<input type="hidden" name="name" value="<%=name%>"
							style="display: none" /> <input type="hidden" name="username"
							value="<%=user.getUsername()%>" style="display: none" />
						<%
							} else {
						%>
						<button type="submit" name="action" value="follow" class="btn btn-create">Follow</button>
						<input type="hidden" name="name" value="<%=name%>"
							style="display: none" /> <input type="hidden" name="username"
							value="<%=user.getUsername()%>" style="display: none" />
						<%
							}
							}
						%>
					</form>
				</div>
			</div>
			<%
				if (curUser.getFrozen() == 1) {
			%><p style="color: red; font: 200; margin-top: 30px">This user is
				Frozen!!!</p>
			<%
				} else {
			%>
		</div>

		<div>
			<h2 class="sub-header">Information</h2>
			<table class="table table-striped">
				<tbody>
					<tr>
						<td>Username</td>
						<td><%=curUser.getUsername()%></td>
					</tr>
					<tr>
						<td>First Name</td>
						<td><%=curUser.getFirstName()%></td>
					</tr>
					<tr>
						<td>Last Name</td>
						<td><%=curUser.getLastName()%></td>
					</tr>
					<tr>
						<td>Email</td>
						<td><%=curUser.getEmail()%></td>
					</tr>
				</tbody>
			</table>
			<%
				if (user != null
							&& user.getUsername().equals(curUser.getUsername())) {
			%>
			<a class="btn" href="UpdateInfo.jsp?name=<%=curUser.getUsername()%>">Update
				Info</a> <a class="btn"
				href="ChangePassword.jsp?name=<%=curUser.getUsername()%>">Change
				Password</a>
			<%
				if (adao.read(user.getUsername()) != null) {
			%>
			<a href="ManageUser.jsp"><img
				src="Img/glyphicons-8-user-remove.png" style="padding-left:10px"></a>
			<a href="ManageBlog.jsp"><img
				src="Img/glyphicons-147-folder-minus.png" style="padding-left:5px"></a>
			<%
				}
				}
			%>
		</div>

		<div style="margin-top:40px">
		<div class="col-lg-4">
		<div class="profile-frame">
			<%
				if (user != null
							&& user.getUsername().equals(curUser.getUsername())) {
			%>
			<h3>Users follow me</h3>
			<%
				} else {
			%>
			<h3> 
				Users follow
				<%=curUser.getNickname()%></h3>
			<%
				}
			%>
			<%
				List<Following> followerList = curUser.getFollowers();
					for (Following f : followerList) {
			%>
			<ul class="list">
				<li><a
					href="UserProfile.jsp?name=<%=f.getFollower().getUsername()%>"><%=f.getFollower().getUsername()%></a></li>
			</ul>
			<%
				}
			%>
			</div>
		</div>
		<div class="col-lg-4">
		<div class="profile-frame">
			<%
				if (user != null
							&& user.getUsername().equals(curUser.getUsername())) {
			%>
			<h3>Users I follow</h3>
			<%
				} else {
			%>
			<h3>
				Users
				<%=curUser.getNickname()%>
				follow
			</h3>
			<%
				}

					List<Following> followeeList = curUser.getFollowees();
					for (Following f : followeeList) {
			%>
			<ul class="list">
				<li><a
					href="UserProfile.jsp?name=<%=f.getFollowee().getUsername()%>"><%=f.getFollowee().getUsername()%></a></li>
			</ul>
			<%
				}
			%>

		</div>
		</div>
		<div class="col-lg-4">
		<div class="profile-frame">
			<%
				if (user != null
							&& user.getUsername().equals(curUser.getUsername())) {
			%>
			<h3>Group I create</h3>
			<%
				} else {
			%>
			<h3>
				Group
				<%=curUser.getNickname()%>
				create
			</h3>
			<%
				}
			%>

			<%
				List<Group> groups = curUser.getGroups();
					for (Group g : groups) {
			%>
			<ul class="list">
				<li><a href="Group.jsp?groupName=<%=g.getName()%>"><%=g.getName()%></a></li>
			</ul>
			<%
				}
			%>

		</div>
		</div>
		</div>
		<div class="col-lg-4">
		<div class="profile-frame">
		<h3>
		Blogs I wrote
		</h3>
		<ul class="list">
		<%
		List<Blog> blogList = curUser.getBlogs();
		for (Blog b : blogList)
		{
			if (b.getPresent() == 1)
			{
		%>
		<li>
			[<a href="Group.jsp?groupName=<%= b.getGroup().getName()%>"><%=b.getGroup().getName() %></a>]
			<a href="Blog.jsp?blogId=<%= b.getId()%>"><%=b.getTitle()%></a><br>
		</li>
		<%
			}
			else
			{
				if (user != null && user.getUsername().equals(curUser.getUsername()))
				{
		%>
		<li>
				[<a style="color:red "href="Group.jsp?groupName=<%= b.getGroup().getName()%>"><%=b.getGroup().getName() %></a>]
				<a style="color:red" href="Blog.jsp?blogId=<%= b.getId()%>"><%=b.getTitle()%> (Blocked)</a><br>
		</li>
		<%
				}
			}
		}
		%>
		</ul>
	</div>
	</div>
	<div class="col-lg-4">
	<div class="profile-frame">
	<h3>
		Blogs I collected
		</h3>
		<ul class="list">
		<%
		List<edu.neu.lovesports.orm.models.Collection> clcList = curUser.getCollections();
		for(edu.neu.lovesports.orm.models.Collection c : clcList)
		{
			if (c.getBlog().getPresent() == 1)
			{
			%>
			<li>
			[<a href="Group.jsp?groupName=<%= c.getBlog().getGroup()%>"><%=c.getBlog().getGroup().getName() %></a>]
			<a href="Blog.jsp?blogId=<%= c.getBlog().getId()%>"><%=c.getBlog().getTitle()%></a><br>
			</li>
			<%
			}
		}
		%>
		</ul>
	</div>
	</div>
	<%
	}
	%>
	</div>
</body>
</html>