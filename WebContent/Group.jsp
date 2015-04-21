<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<script type="text/javascript" src="js/jquery-2.1.3.js"></script>
</head>
<body>
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String groupName = null;
		if (request.getParameter("groupName") == null)
			groupName = "Forum";
		else
			groupName = request.getParameter("groupName");

		if (action != null) {
			if ("signup".equals(action)){
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			}
			else if ("logout".equals(action)){
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="+groupName);
				action = null;
			}
			else if ("login".equals(action)) {
					if (username == "" || password == "")
						out.println("Please enter account and password.");
					else if (check.Login(request, response, username, password)){
						response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="+groupName);
					}
					else{
						out.println("Username and Password are not matched.");
					}
					action = null;
				}
		}
		User user = (User) session.getAttribute("User");
	%>
	<div id="top">
		<a>Homepage</a>
		<a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>
		<%
			if (user == null) {
		%>
		<div id="login">
			<form id="form" action="Group.jsp">
				Account: <input name="username" type="text" /> 
				Password:<input name="password" type="password" />
				<button type="submit" name="action" value="login">Log In</button>
				<button name="action" value="signup">Sign Up</button>
				<input type="hidden" name="groupName" value="<%=groupName%>"/>
			</form>
		</div>
		<%
			} 
			else {
		%>
		<div id="login">
			<strong>Hello <%=user.getNickname() %>!
			</strong>
			<form action="Group.jsp">
				<button type="submit" name="action" value="logout">Log Out</button>
				<input type="hidden" name="groupName" value="<%=groupName%>"/>
			</form>
		</div>
		<%
			}
		%>
	</div>
	<%
	if(action != null){
		if(user != null){
			if("createBlog".equals(action))
				response.sendRedirect("/LoveSportsORM/BlogEditor.jsp?groupName="+groupName);
		}
		
		if(!"createBlog".equals(action))
			response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="+groupName);
	}
	
	%>
	<div>
		<form id="searchForm" action="Group.jsp">
			<input name="content" type="text">
			<button type="submit" name="action" value="search">Search</button>
		</form>
		<h1>Welcome to <%=groupName %></h1>
		<form action="Group.jsp">
			<button name="action" value="createBlog">New Blog</button>
			<input type="hidden" name="groupName" value="<%=groupName%>"/>
		</form>
		<ul>
			<%
			GroupDAO gdao = new GroupDAO();
			List<Blog> blogs = gdao.read(groupName).getBlogs();
			int n = 0;
			if (request.getParameter("blogPage") != null)
				n = (Integer.parseInt(request.getParameter("blogPage"))-1)*10;
			
			for (int i=1; i<11; i++) {
				int j = blogs.size() - i - n;
				if(blogs.size() != 0){
				Blog blog = blogs.get(j);
			%>
			<li>
				<div>
					<h2>
						<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blog.getId()%>"><%=blog.getTitle()%></a>
					</h2>
					<i> <a
						href="/LoveSportsORM/UserProfile.jsp?name=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a>
					</i>
					<p id="text<%=i %>">
						<textarea id="loadText<%=i %>" style="display:none"><%=blog.getText() %></textarea>
						<script>
						var textId = "#text<%=i %>";
						var loadTextId = "#loadText<%=i %>";
						var text = $(loadTextId).val();
						$(textId).append(text);
						</script>
					</p>
				</div>
			</li>

			<%
				}
				if(j <= 0)
					break; 
			}
			%>
		</ul>
		<p>
				Page
					<%				
					int pageNum = (int) (blogs.size() / 10) + 1;
					int pageNow = n/10 + 1;
					int i;
					for(i = 1; i <= pageNum; i++){
						if(i == pageNow){ 
						%>
						<strong><%=i %></strong>
						<%
						}
						else if(pageNum > 5){
							if(pageNow < 4){
								if(i == 6){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>">&gt&gt</a>
									<%
									}
								else if(i < 6){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>"><%=i %></a>
									<%
									}
								}
							else if(pageNow > (pageNum - 2)){
								if(i == (pageNum - 5)){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>">&lt&lt</a>
									<%
								}
								else if(i > (pageNum - 5)){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>"><%=i %></a>
									<%
									}
								}
							else{
								if(i == (pageNow - 3)){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>">&lt&lt</a>
									<%
								}
								else if(i == (pageNow + 3)){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>">&gt&gt</a>
									<%
								}
								else if(((pageNow - 3) < i) && (i <(pageNow + 3))){
									%>
									<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>"><%=i %></a>
									<%
									}
								}
							}
						else{
							%>
							<a href="/LoveSportsORM/Group.jsp?groupName=<%=groupName %>&blogPage=<%=i %>"><%=i %></a>
							<%
							}
					}
						%>
			</p>
	</div>
</body>
</html>