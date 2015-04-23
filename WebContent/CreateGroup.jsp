<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.Date, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
<script>
	$(function(){
		$('#cancel').click(function(){
			window.location.href = "/LoveSportsORM/Group.jsp";
			});
	});

</script>
</head>
<body>
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (action != null) {
			if ("logout".equals(action)) {
				session.removeAttribute("User");
				action = null;
				response.sendRedirect("/LoveSportsORM/Homepage.jsp");
			}
		}
		User user = (User) session.getAttribute("User");
	%>
	<div id="top">
		<a href="/LoveSportsORM/Homepage">Homepage</a> <a
			href="/LoveSportsORM/Group.jsp">Forum</a>
		<div id="login">
			<strong>Hello <%=user.getNickname()%>!
			</strong>
			<form action="CreateGroup.jsp">
				<button type="submit" name="action" value="logout">Log Out</button>
			</form>
		</div>
	</div>

	<%
		GroupDAO gdao = new GroupDAO();
		String groupName = request.getParameter("groupName");
		String description = request.getParameter("description");
		if (action != null) {
			if (user != null) {
				if ("createGroup".equals(action)) {
					if (gdao.read(groupName) == null) {
						Date createDate = new Date();
						Group newgroup = new Group(groupName, description,createDate, user);
						gdao.create(newgroup);
						response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
								+ groupName);
					}
				}
			}
		}
	%>

	<div>
		<h1>Create a new group</h1>
		<form action="CreateGroup.jsp">
			<p>
				Group Name: <input id="groupName" type="text" name="groupName" required />
				<%
				if(groupName != null){
					if (gdao.read(groupName) != null) {
				%>
				<em>Group name has been used.</em>
				<%
					}
				}
				%>
			</p>
			<p>Group Description:</p>
			<p>
				<textarea id="description" name="description" required></textarea>
			</p>
			<button name="action" value="createGroup">Create</button>
			<button id="cancel">Cancel</button>
		</form>
	</div>
</body>
</html>