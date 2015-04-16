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
			String blogId = request.getParameter("blogId");
			BlogDAO bdao = new BlogDAO();
			Blog blog = null;
			if(blogId != null)
				blog = bdao.read(Integer.parseInt(blogId));

			if (action != null) {

				if ("signup".equals(action))
					response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				if ("logout".equals(action))
					session.removeAttribute("User");
				else if ("login".equals(action)) {
						if (username == "" || password == "")
							out.println("Please enter account and password.");
						else if (check.Login(request, response, username, password))
							response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="+blogId);
						else
							out.println("Username and Password are not matched.");
						}
			}
			User user = (User) session.getAttribute("User");
			%>
			<div id="top">
				<%
					if (user == null) {
				%>
				<div id="login">
					<form id="form" action="Blog.jsp">
						Account: <input name="username" type="text" /> Password:<input
							name="password" type="password" />
						<button type="submit" name="action" value="login">Log In</button>
						<button name="action" value="signup">Sign Up</button>
						<input type="hidden" name="blogId" value="<%=blogId%>"/>
					</form>
				</div>
				<%
					} 
					else {
				%>
				<div id="login">
					<strong>Hello <%=user.getNickname() %>!
					</strong>
					<form action="Blog.jsp">
						<button type="submit" name="action" value="logout">Log Out</button>
						<input type="hidden" name="blogId" value="<%=blogId%>"/>
					</form>
				</div>
				<%
					}
				%>
			</div>
	<%
		StampDAO stdao = new StampDAO();
		if(user != null)
			if("like".equals(action)){
		stdao.create(blog, user);
			}
			else if("dislike".equals(action)){
		stdao.delete(blog, user);
			}
	%>
	<div>
		<div>
			<h1><%=blog.getTitle()%></h1>
			<p>
				<strong> Written by: </strong><i><a
					href="/LoveSportsORM/UserProfile.jsp?user=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a></i>
			</p>
			<%
				List<Text> texts = blog.getTexts();
					for (Text text : texts) {
			%>
			<p><%=text.getText()%></p>
			<%
				}
			%>
			<div>
				<button><%=blog.getComments().size()%>
					COMMENTS
				</button>
				<%
				List<Stamp> stamps = blog.getStamps();
				%>
				<form id="stampForm" action="Blog.jsp">
					<button id="stampButton" type="submit" name="action" value="like"><%=stamps.size()%>
						LIKES
					</button>
					<input type="hidden" name="blogId" value="<%=blogId%>" />
				</form>
				<%
				if(user != null){
					for (Stamp stamp : stamps) {
						if (stamp.getUser().getUsername().equals(user.getUsername())) {
							%>
							<script>
							document.getElementById("stampButton").setAttribute("value", "dislike");
							</script>
							<%
							break;
						}
					}
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>