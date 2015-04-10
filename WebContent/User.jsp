<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<h1>Users</h1>
	
	<ul>
	<%
	UserDAO check = new UserDAO();
	String action = request.getParameter("action");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if("remove".equals(action)){
		check.delete(username);
	}
	else if("create".equals(action)){
		User newuser = new User(username, password, null, null, null);
		check.create(newuser);
	}
	
	//User user = new User("Alice@gmail.com","alice","Alice","Wonderland","Alice@gmail.com");
	//check.create(user);
	List<User> users = check.readAll();	
	for (User u : users){
	%>
	<li>
	
		<%=u.getUsername() %>
		<a href = "User.jsp?action=remove&username=<%=u.getUsername() %>">
			&times;
		</a>
		
	</li>
	<%
	}
 	%>
	</ul>
	<form action="User.jsp">
		<p>Username:
		<input name="username" type="text"/><br />
		Password:
		<input name="password" type="password"/><br />
		<input name="action" value="create" type="hidden"/>
		<button type="submit">Create User</button>
		</p>
	</form>
</body>
</html>