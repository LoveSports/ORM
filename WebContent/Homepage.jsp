<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="edu.neu.cs5200.spur.main.*"
	import="edu.neu.lovesports.orm.dao.*, java.util.Date, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/homepage.css" style="text/css">

</head>
<body style="padding-top: 70px;">
<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserDAO udao = new UserDAO();
		GroupDAO gdao = new GroupDAO();
		CategoryDAO cdao = new CategoryDAO();

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Homepage.jsp");
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/Homepage.jsp");
				} else {
					out.println("Username and Password are not matched.");
				}
				action = null;
			}
		}
		User user = (User) session.getAttribute("User");
	%>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="navbar-brand" style="color: #CCCCCC"> LoveSports </a>
				<div class="container">
					<div class="row">
						<div class="col-lg-5">
							<div id="navbar" class="navbar-collapse collapse">
								<ul class="nav navbar-nav">
									<li><a href="/LoveSportsORM/Homepage.jsp">Homepage</a></li>
									<li><a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>

									</li>
								</ul>
							</div>
						</div>
						<div class="col-lg-7">

							<%
								if (user == null) {
							%>
							<div id="login" class="navbar-form pull-right">
								<form id="form" action="Homepage.jsp">
									<input class="form-control" name="username" type="text"
										placeholder="Email" /> <input class="form-control"
										name="password" type="password" placeholder="Password" />
									<button class="btn btn-login" type="submit" name="action"
										value="login">Log In</button>
									<button class="btn btn-login" name="action" value="signup">Sign
										Up</button>
								</form>
							</div>
							<%
								} else {
							%>
							<div id="login" class="navbar-form pull-right">
								<form action="Homepage.jsp">
									<strong><a
										href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
											<%=user.getNickname()%>!
									</a></strong>
									<button type="submit" name="action" value="logout"
										class="btn btn-logout">Log Out</button>
								</form>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="jumbotron home-title">
		<h1>LoveSports</h1>
		<p>Welcome to I Love Sports, a website providing information about
			all kinds of sports.</p>
	</div>
			<%
			List<String> basic = new ArrayList<String>();
			basic.add("Football");
			basic.add("Basketball");
			basic.add("Baseball");
			basic.add("Soccer");
			basic.add("Badminton");
			basic.add("Tennis");
			basic.add("Tabletennis");
			
			String[][] link;
			if(user != null){
				user = udao.read(user.getUsername());
				if(user.getSubs().size() > 0){
					List<Subscription> subs =user.getSubs();
					for(Subscription sub : subs){
						String title = sub.getCategory().getTitle();
						String img = sub.getCategory().getImgs().get(0).getUrl();
						if(basic.contains(title)){
							basic.remove(title);
						}
						
			%>
			<div class="col-md-6">
				<div>
				<a href="/LoveSportsORM/Category.jsp?catId=<%=sub.getCategory().getId()%>">
					<h2 class="blog-header"><%=title %></h2>
					</a>
 					<img
						src="<%=img %>">
						<p>
						<%
							link = GetNewsByQuery.findNewsByQuery(sub.getCategory().getTitle());
							for (int i = 0; i < link.length; i++) {
						%><a href="/LoveSportsORM/News.jsp?href=<%out.println(link[i][0]);%>"> <%
 	out.println(" <br> " + link[i][1] + " <br> ");
 %></a>
						<%
							}
						%>
					</p>
				</div>
			</div>
			<%
					}
				}
			}
			Category c = null;
			for(String elem : basic){
				c = cdao.readByTitle(elem);
				%>
				<div class="col-md-6">
					<div>
					<a href="/LoveSportsORM/Category.jsp?catId=<%=c.getId()%>">
						<h2 class="blog-header"><%=c.getTitle() %></h2>
						</a>
	 					<img
							src="<%=c.getImgs().get(0).getUrl() %>">
							<p>
							<%
								link = GetNewsByQuery.findNewsByQuery(c.getTitle());
								for (int i = 0; i < link.length; i++) {
							%><a href="/LoveSportsORM/News.jsp?href=<%out.println(link[i][0]);%>"> <%
	 	out.println(" <br> " + link[i][1] + " <br> ");
	 %></a>
							<%
								}
							%>
						</p>
					</div>
				</div>
				<%
			}
			
			boolean tag = false;
			if(user != null){
				for(Subscription sub : user.getSubs()){
					if("Forum".equals(sub.getCategory().getTitle())){
						tag = true;
						break;
					}
				}
			}
			if(tag == false){
			%>
			<div class="col-md-6">
				<div class="blog">
					<a href="/LoveSportsORM/Group.jsp"><h2 class="blog-header">FORUM</h2></a>
					<img
						src="Img/discussionforums.jpg">
						<p>
						<%
							Group forum = gdao.read("Forum");
							List<Blog> blogs = forum.getBlogs();
							for (int i = blogs.size() - 1; i > blogs.size() - 5; i--) {
						%><a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogs.get(i).getId() %>"><br /><%=blogs.get(i).getTitle() %></a><br />
						<%
							}
						%>
					</p>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<div class="return_to_top">
		<a href="#top"> <img
			src="Img/icon-back-to-top.jpg"
			width="50" height="50">
		</a>
	</div>
</body>
</html>