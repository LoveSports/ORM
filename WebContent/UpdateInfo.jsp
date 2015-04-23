<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Information</title>
</head>
<body>


	<%
		UserDAO dao = new UserDAO();

		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String first = request.getParameter("first");
		String last = request.getParameter("last");
		String email = request.getParameter("email");

		if (action != null) {

			if ("signup".equals(action))
				response.sendRedirect("UserSignUp.jsp");

			if ("logout".equals(action))
			{
				session.removeAttribute("User");
				response.sendRedirect("UserProfile.jsp" + "?name=" + name);
			}
			else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password))
					response.sendRedirect("UserProfile.jsp" + "?name=" + name);
				else
					out.println("Username and Password are not matched.");
			}
			else if ("update".equals(action))
		    {
		    	User newUser = new User(name, dao.read(name).getPassword(), nickname, first, last, email);
		    	newUser = dao.update(newUser);
		    	session.removeAttribute("User");
		    	check.Login(request, response, newUser.getUsername(), newUser.getPassword());
		    	String str = "UserProfile.jsp?name=CUR_USERNAME";
	        	String redirect = str.replace("CUR_USERNAME", name);
	        	response.sendRedirect(redirect);
		    }
			else if ("cancel".equals(action))
			{
				String str = "UserProfile.jsp?name=CUR_USERNAME";
	        	String redirect = str.replace("CUR_USERNAME", name);
	        	response.sendRedirect(redirect);
			}
		}
		User user = (User) session.getAttribute("User");
		User curUser = dao.read(name);
		
	%>
	<div id="top">
		<a href="/LoveSportsORM/Homepage.jsp">Homepage</a>
		<a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>
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
			<strong>Hello <%=user.getNickname() %>!
			</strong>
			<form action="UserProfile.jsp?name=<%=name%>">
				<button type="submit" name="action" value="logout">Log Out</button>
				<input type="hidden" name="name" value="<%=name %>" style="display:none"/>
			</form>
		</div>
		<%
			}
		%>
	</div>	


<!-- --------------- -->
	
	<div>
	<form action="UpdateInfo.jsp">
	<p>Update Information</p>
	<table>
	<tbody>
		<tr>
			<td>name</td>
			<td><input type="text" name="name" value="<%=name%>"readonly/></td>
		</tr>
		<tr>
			<td>Nickame</td>
			<td><input type="text" name="nickname" value="<%=user.getNickname()%>"/></td>
		</tr>
		<tr>
			<td>First Name</td>
			<td><input type="text" name="first" value="<%=user.getFirstName()%>"/></td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><input type="text" name="last" value="<%=user.getLastName()%>"/></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input type="text" name="email" value="<%=user.getEmail()%>"/></td>
		</tr>
		<tr>
			<td><button class="btn btn-primary" name="action" value="update">Update</button></td>
			<td><button class="btn btn-primary" name="action" value="cancel">Cancel</button></td>
		</tr>
		</tbody>
	</table>
	</form>
	</div>
</body>
</html>