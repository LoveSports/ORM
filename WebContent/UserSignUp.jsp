
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.models.*, edu.neu.lovesports.orm.dao.*, edu.neu.lovesports.orm.method.*, java.util.*, java.util.regex.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up I Love Sports</title>
</head>

<body>
	<h1>Sign Up</h1>
	<%
    	UserDAO dao = new UserDAO();
    
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");
        String first = request.getParameter("first");
        String last = request.getParameter("last");
        
        if("create".equals(action))
        {
        	Pattern pattern = Pattern.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");   
            Matcher matcher = pattern.matcher(username);
            Matcher matcher1 = pattern.matcher(email);
        	if (username == "")
        	{
        		%>
    			<p style="color:red">Please enter username!</p>
    			<p style="color:red">Username should be valid email address!</p>
    			<%
        	}
        	else if (!matcher.matches())
        	{
        		%>
    			<p style="color:red">Username entered is not valid email address!</p>
    			<p style="color:red">Username should be valid email address!</p>
    			<%
        	}
        	else if (dao.read(username) != null)
        	{
        		%>
        			<p style="color:red">Username exists!</p>
        		<%
        	}
            else if (password == "")
            {
            	%>
    			<p style="color:red">Please enter password!</p>
    			<%
            }
        	else if(!password.equals(repassword))
        	{
        		%>
        		<p style="color:red">Password is not consistent!</p>
        		<%
        	}
        	else if (nickname == "")
        	{
        		%>
        		<p style="color:red">Nickname is required!</p>
        		<%
        	}
        	else if (!matcher1.matches())
        	{
        		%>
        		<p style="color:red">Invalid email!</p>
        		<%
        	}
        	else
        	{
	        	User user = new User(username, password, nickname, first, last, email);
	        	dao.create(user);
	        	%>
	        		<p style="color:green">SignUp successfully!</p>
	        	<%
	        	UserLog check = new UserLog();
	        	check.Login(request, response, username, password);
	        	String str = "/LoveSports/UserProfile.jsp?name=CUR_USERNAME";
	        	String redirect = str.replace("CUR_USERNAME", username);
	        	response.sendRedirect(redirect);
        	}
        }
    %>
	
	<form action="UserSignUp.jsp">
	<table>
		<tr>
			<td>Username</td>
			<td><input name="username" class="form-control"/></td>
			<td>*</td>
			<td>(Username should be valid email address.)</td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="password" name="password" class="form-control"/></td>
			<td>*</td>
		</tr>
		<tr>
			<td>Re-enter password</td>
			<td><input type="password" name="repassword" class="form-control"/></td>
			<td>*</td>
		</tr>
		<tr>
			<td>Nickname</td>
			<td><input name="nickname" class="form-control"/></td>
			<td>*</td>
		</tr>
		<tr>
			<td>First Name</td>
			<td><input name="first" class="form-control"/></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><input name="last" class="form-control"/></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input name="email" class="form-control"/></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<button type="submit" name="action" value="create">Sign Up</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>