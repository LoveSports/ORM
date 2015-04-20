<%@page import="org.eclipse.persistence.jpa.jpql.parser.ElseExpressionBNF"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, java.util.*, java.util.regex.*, edu.neu.lovesports.orm.method.*, java.sql.*, javax.script.*"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
					response.sendRedirect("UserProfile.jsp" + "?name=" + name);
				else
					out.println("Username and Password are not matched.");
			}
			else if ("freeze".equals(action))
			{
				User u = dao.read(name);
				u.setFrozen(1);
				dao.update(u);
				response.sendRedirect("ManageUser.jsp");
				
			}
			else if ("activate".equals(action))
			{
				User u = dao.read(name);
				u.setFrozen(0);
				dao.update(u);
				response.sendRedirect("ManageUser.jsp");
			}
		}
		
		User user = (User) session.getAttribute("User");
		
		
	%>
	<div id="top">
		<%
			if (user == null) {
				response.sendRedirect("Warning.jsp");
		%>
		<%-- <div id="login">
			<form id="form" action="UserProfile.jsp">
				Account: <input name="username" type="text" /> Password:<input
					name="password" type="password" />
					<input name="name" type="text" value="<%=name %>" type="hidden" style="display:none"/>
				<button type="submit" name="action" value="login">Log In</button>
				<button name="action" value="signup">Sign Up</button>
			</form>
		</div> --%>
		
		<%
			} 
			else {
		%>
		<div id="logout">
			<strong> <a href="UserProfile.jsp?name=<%=user.getUsername() %>">Hello <%=user.getNickname() %>!</a>
			</strong>
			<form action="UserProfile.jsp?name=<%=user.getUsername()%>">
				<button type="submit" name="action" value="logout">Log Out</button>
				<input type="hidden" name="name" value="<%=user.getUsername() %>" style="display:none"/>
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
	
<!-- ------------------- -->
<%
	List<User> userList = dao.readAll();
%>
<div>
	<form action="ManageUser.jsp">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Username</th>
                <th>Type</th>
                <th>Status</th>
                <th>Manage</th>
            </tr>
        </thead>
        <tbody>
    <%
    for(User u : userList)
    {
    	%>
    	    <tr>
    	        <td><a href="UserProfile.jsp?name=<%= u.getUsername()%>"><%=u.getUsername() %></a></td>
 				<%
 				if (adao.read(u.getUsername()) == null)
 				{
 					%>
 				<td>User</td>
 					<%	
 				}
 				else
 				{
 					%>
 				<td>Admin</td>
 					<%
 				}
 				if (u.getFrozen() == 0)
 				{
 				%>   	  
    	        <td>Active</td>
    	        <td>
    	        <%
    	        if(adao.read(u.getUsername()) == null) {
    	        %>
    	        	<a class="btn btn-danger"  href="ManageUser.jsp?action=freeze&name=<%=u.getUsername()%>">Freeze</a>
    	        </td>
    	    </tr>
    	    <%
    	        }
 				}
 				else
 				{
 				%>
 				<td>Frozen</td>
    	        <td>
    	        	<a class="btn btn-danger"  href="ManageUser.jsp?action=activate&name=<%=u.getUsername()%>">Activate</a>
    	        </td>
    	    </tr>
    	    <%
 				}
    }
    %>
        </tbody>
    </table>
    </form>
</div>
</body>
</html>