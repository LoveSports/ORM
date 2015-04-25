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
		GroupDAO gdao = new GroupDAO();
		BlogDAO bdao = new BlogDAO();
		
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String follow = request.getParameter("follow");
		String group = request.getParameter("group");
		String strBId = request.getParameter("blogId");
		
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
			else if ("block".equals(action))
			{
				Blog b = bdao.read(Integer.parseInt(strBId));
				b.setPresent(0);
				bdao.update(b);
				//response.sendRedirect("ManageBlog.jsp");
			}
			else if ("unblock".equals(action))
			{
				Blog b = bdao.read(Integer.parseInt(strBId));
				b.setPresent(1);
				bdao.update(b);
				//response.sendRedirect("ManageBlog.jsp");
			}
			else if ("delete".equals(action))
			{
				bdao.delete(Integer.parseInt(strBId));
				//response.sendRedirect("ManageBlog.jsp");
			}
		}
		
		User user = (User) session.getAttribute("User");
		
		
	%>
	<div id="top">
		<a href="/LoveSportsORM/Homepage.jsp">Homepage</a>
		<a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>
		<%
			if (user == null || adao.read(user.getUsername()) == null) {
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
	List<Group> groupList = gdao.readAll();
%>
<div>
<form>
<table>
	<tr>
		<%
		for (Group g : groupList)
		{
			%><td><a href="ManageBlog.jsp?group=<%= g.getName()%>"><%= g.getName()%></a></td><%
		}
		%>
	</tr>
</table>
</form>
</div>


<div>
	<form action="ManageBlog.jsp">
    <table class="table table-striped">
    <tr><%= group%></tr>
        <thead>
            <tr>
                <th>Blog</th>
                <th>Author</th>
                <th>Status</th>
                <th>Manage</th>
            </tr>
        </thead>
        <tbody>
    <%
    if (group != null)
    {
    	Group grp = gdao.read(group);
    	List<Blog> blogList = grp.getBlogs();
	    for(Blog b : blogList)
	    {
	    	%>
	    	    <tr>
	    	        <td><a href="Blog.jsp?blogId=<%= b.getId()%>&group=<%=group %>"><%=b.getTitle() %></a></td>
	    	        <td><a href="UserProfile.jsp?name=<%=b.getUser().getUsername() %>"><%=b.getUser().getUsername() %></a>
	 				<%
	 				if (b.getPresent() == 1)
	 				{
	 				%>   	  
	    	        <td>Present</td>
	    	        <td>
	    	        	<a class="btn btn-danger"  href="ManageBlog.jsp?action=block&blogId=<%=b.getId()%>&group=<%=group %>">Block</a>
	    	        </td>
	    	        <td>
	    	        	<a class="btn btn-danger"  href="ManageBlog.jsp?action=delete&blogId=<%=b.getId()%>&group=<%=group %>">Delete</a>
	    	        </td>
	    	    </tr>
	    	    <%
	    	        }
	 				else
	 				{
	 				%>
	 				<td>Blocked</td>
	    	        <td>
	    	        	<a class="btn btn-danger"  href="ManageBlog.jsp?action=unblock&blogId=<%=b.getId()%>&group=<%=group %>">Unblock</a>
	    	        </td>
	    	        <td>
	    	        	<a class="btn btn-danger"  href="ManageBlog.jsp?action=delete&blogId=<%=b.getId()%>&group=<%=group %>">Delete</a>
	    	        </td>
	    	    </tr>
	    	    <%
	 				}
	    }
    }
	 %>
        </tbody>
    </table>
    </form>
</div>
</body>
</html>