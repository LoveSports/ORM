<%@page import="org.eclipse.persistence.jpa.jpql.parser.ElseExpressionBNF"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, java.util.*, java.util.regex.*, edu.neu.lovesports.orm.method.*, java.sql.*, javax.script.*"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile Page</title>
</head>
<body>

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
				else if (check.Login(request, response, username, password))
				{
					if (dao.read(username).getFrozen() == 1)
					{
						session.removeAttribute("User");
						%><p style="font-size:300%;color:red">You are frozen!!!(<%=username %>)</p> <%
					}
					else
						response.sendRedirect("UserProfile.jsp" + "?name=" + name);
				}
				else
					out.println("Username and Password are not matched.");
			}
			else if ("follow".equals(action))
			{
				User u1 = dao.read(username);
				User u2 = dao.read(name);
				Following f = fdao.create(u1, u2);

				response.sendRedirect("UserProfile.jsp" + "?name=" + name);
				
			}
			else if ("unfollow".equals(action))
			{	
				User u1 = dao.read(username);
				User u2 = dao.read(name);
				fdao.delete(u1, u2);

				response.sendRedirect("UserProfile.jsp" + "?name=" + name);
			}
		}
		
		User user = (User) session.getAttribute("User");
		User curUser = dao.read(name);
		
		
	%>
	<div id="top">
		<%
			if (user == null) {
		%>
		<div id="login">
			<form id="form" action="UserProfile.jsp">
				Account: <input name="username" type="text" /> Password:<input
					name="password" type="password" />
					<input name="name" type="text" value="<%=name %>" type="hidden" style="display:none"/>
				<button type="submit" name="action" value="login">Log In</button>
				<button name="action" value="signup">Sign Up</button>
			</form>
		</div>
		<%
			} 
			else {
		%>
		<div id="logout">
			<strong> <a href="UserProfile.jsp?name=<%=user.getUsername() %>">Hello <%=user.getNickname() %>!</a>
			</strong>
			<form action="UserProfile.jsp?name=<%=name%>">
				<button type="submit" name="action" value="logout">Log Out</button>
				<input type="hidden" name="name" value="<%=name %>" style="display:none"/>
			</form>
			<button><a href="UserHomepage.jsp">Homepage</a></button>
			<%
			if (adao.read(user.getUsername()) != null)
			{
				%>
				<a href="ManageUser.jsp">Manage User</a>
				<%
			}
			
			%>
		</div>
		<%
			}
		%>
	</div>	
	
<!-- ------------------ -->		

	<h1><%=curUser.getNickname() %></h1>	
	
	<%
	if (curUser.getFrozen() == 1)
	{
		%><p style="color:red; font:200">This user is Frozen!!!</p><%
	}
	else
	{
	%>
		
	<div>
		<img alt="Avatar" style="width:300;height:300">
	</div>
	<div>
		<form action="UserProfile.jsp">
		<% 
		if (user != null && !user.getUsername().equals(curUser.getUsername()))
		{
		%>
			<%
			if (fdao.read(new FollowingId(user.getUsername(), curUser.getUsername())) != null)
			{
			
			%>
				<button type="submit" name="action" value="unfollow">Unfollow</button>
				<input type="hidden" name="name" value="<%=name %>" style="display:none"/>
				<input type="hidden" name="username" value="<%=user.getUsername() %>" style="display:none"/>
			<%
			}
			else
			{
			%>
				<button type="submit" name="action" value="follow">Follow</button>
				<input type="hidden" name="name" value="<%=name %>" style="display:none"/>
				<input type="hidden" name="username" value="<%=user.getUsername() %>" style="display:none"/>
			<%
			}
		}
			%>
		</form>
	</div>
	
	<div>
	<p>Information</p>
	<table>
	<tbody>
		<tr>
			<td>Username</td>
			<td><%=curUser.getUsername() %></td>
		</tr>
		<tr>
			<td>First Name</td>
			<td><%=curUser.getFirstName() %></td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><%=curUser.getLastName() %></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><%=curUser.getEmail() %></td>
		</tr>
		<tr>
			<% 
			if (user != null && user.getUsername().equals(curUser.getUsername()))
			{
			%>
				<td><a href="UpdateInfo.jsp?name=<%=curUser.getUsername()%>">Update Info</a></td>
				<td><a href="ChangePassword.jsp?name=<%=curUser.getUsername()%>">Change Password</a></td>
			<%
			}
			%>			
		</tr>
		</tbody>
	</table>
	</div>
	
	<div>
		<% 
			if (user != null && user.getUsername().equals(curUser.getUsername()))
			{
			%>
				<p>Users follow me</p>
			<%
			}
			else
			{
			%>
				<p>Users follow <%=curUser.getNickname()%></p>				
			<%
			}
		%>	
		<%
		
		List<Following> followerList = curUser.getFollowers();
		for (Following f : followerList)
		{
			
			%>
				<ul>
					<li><a href="UserProfile.jsp?name=<%=f.getFollower().getUsername() %>"><img alt="<%=f.getFollower().getUsername()%>"></a></li>
				</ul>
			<%
		}
	
		%>
	</div>
	<div>
	<% 
		if (user != null && user.getUsername().equals(curUser.getUsername()))
		{
		%>
			<p>Users I follow</p>
		<%
		}
		else
		{
		%>
			<p>Users <%=curUser.getNickname()%> follow</p>				
		<%
		}
	
	    List<Following> followeeList = curUser.getFollowees();
		for (Following f : followeeList)
		{
			
			%>
				<ul>
					<li><a href="UserProfile.jsp?name=<%=f.getFollowee().getUsername() %>"><img alt="<%=f.getFollowee().getUsername()%>"></a></li>
				</ul>
			<%
		}
	
	%>
	
	</div>
		<div>
		<% 
			if (user != null && user.getUsername().equals(curUser.getUsername()))
			{
			%>
				<p>Group I create</p>
			<%
			}
			else
			{
			%>
				<p>Group <%=curUser.getNickname()%> create</p>				
			<%
			}
		%>
		
	<%
	    List<Group> groups = curUser.getGroups();
		for (Group g : groups)
		{
			
			%>
				<ul>
					<li><a href="group.jsp?group=<%=g.getName() %>"><%=g.getName()%></a></li>
				</ul>
			<%
		}
	
	%>
	
	</div>
	<%}%>
</body>
</html>