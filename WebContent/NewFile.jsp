<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
</head>
<body>
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String group;
		if(request.getParameter("group") == null)
			group = "Forum";
		else
			group = request.getParameter("group");

		if (action != null) {

			if ("signup".equals(action))
		response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");

			if ("logout".equals(action))
		session.removeAttribute("User");
			else if ("login".equals(action)) {
		if (username == "" || password == "")
			out.println("Please enter account and password.");
		else if (check.Login(request, response, username, password))
			response.sendRedirect("/LoveSportsORM/NewFile.jsp"+"?group="+group);
		else
			out.println("Username and Password are not matched.");
			}
		}	
		User user = (User) session.getAttribute("User");
		if (user == null) {%>
		<div id="login">
			<form id="form" action="NewFile.jsp">
				Account: <input name="username" type="text" /> Password:<input
					name="password" type="password" />
				<button type="submit" name="action" value="login">Log In</button>
				<button name="action" value="signup">Sign Up</button>
			</form>
		</div>
	<%}
		else{
	%>
	<div>
	<strong>Hello!</strong>
	<form action="NewFile.jsp">
	<button type="submit" name="action" value="logout">Log Out</button>
	</form>
	</div>
	<%
		}
	%>

	<div>
		<h1></h1>
		<form id="searchForm" action="Group.jsp">
			<input name="content" type="text">
			<button type="submit" name="action" value="search">Search</button>
		</form>
		<ul>
			<%
				GroupDAO gdao = new GroupDAO();
				List<Blog> blogs = gdao.read(group).getBlogs();
				for (Blog blog : blogs) {
			%>
			<li>
				<div>
					<h2>
						<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blog.getId()%>"><%=blog.getTitle()%></a>
					</h2>
					<i> <a
						href="/LoveSportsORM/UserProfile.jsp?user=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a>
					</i>
					<p><%=blog.getTexts().get(0).getText()%></p>
				</div>
			</li>

			<%
				}
			%>
		</ul>
	</div>

</body>
</html>