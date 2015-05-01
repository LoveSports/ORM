<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*,
	java.util.regex.Matcher, java.util.regex.Pattern"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="css/lovesports.css">
<script type="text/javascript" src="js/jquery-2.1.3.js"></script>
</head>
<body style="padding-top: 70px;">
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String groupName = null;
		GroupDAO gdao = new GroupDAO();
		if (request.getParameter("groupName") == null)
			groupName = "Forum";
		else
			groupName = request.getParameter("groupName");

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
						+ groupName);
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
							+ groupName);
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
							<form id="form" action="Group.jsp">
								<input class="form-control" name="username" type="text"
									placeholder="Email" /> <input class="form-control"
									name="password" type="password" placeholder="Password" />
								<button class="btn btn-login" type="submit" name="action"
									value="login">Log In</button>
								<button class="btn btn-login" name="action" value="signup">Sign
									Up</button>
								<input type="hidden" name="groupName" value="<%=groupName%>" />
							</form>
						</div>
						<%
							} else {
						%>
						<div id="login" class="navbar-form pull-right">
							<form action="Group.jsp">
								<strong><a
									href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
										<%=user.getNickname()%>!
								</a></strong>
								<button type="submit" name="action" value="logout"
									class="btn btn-logout">Log Out</button>
								<input type="hidden" name="groupName" value="<%=groupName%>" />
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
	<%
		if (action != null) {
			if (user != null) {
				if ("createBlog".equals(action))
					response.sendRedirect("/LoveSportsORM/BlogEditor.jsp?groupName="
							+ groupName);
				else if ("createGroup".equals(action))
					response.sendRedirect("/LoveSportsORM/CreateGroup.jsp");
			}
		}
	%>
	<div class="container"">
		<!-- 		<form id="searchForm" action="Group.jsp">
			<input name="content" type="text">
			<button type="submit" name="action" value="search">Search</button>
		</form> -->
		<div class="jumbotron group-title">
			<h1>
				Welcome to
				<%=groupName%></h1>
			<p><%=gdao.read(groupName).getDescription()%></p>
		</div>
		<div class="row">
			<div class="navbar-form pull-right">
				<form action="Group.jsp">
					<button name="action" value="createBlog" class="btn btn-create">New
						Blog</button>
					<button name="action" value="createGroup" class="btn btn-create">Create
						your group</button>
					<input type="hidden" name="groupName" value="<%=groupName%>" />
				</form>
			</div>
		</div>
		<div>
			<%
				List<Blog> blogs = gdao.read(groupName).getBlogs();
				int n = 0;
				if (request.getParameter("blogPage") != null)
					n = (Integer.parseInt(request.getParameter("blogPage")) - 1) * 10;
				int block = 0;
				for (int i = 1; i < 11; i++) {
					int j = blogs.size() - i - n;
					if (j < 0)
						break;
					if (blogs.size() != 0) {
						Blog blog = blogs.get(j);
						if(blog.getPresent()==0){
							block++;
							continue;
						}
						Pattern pattern = Pattern.compile("<img src=.*?>");
						String content = blog.getText();
						String[] textList = content.split("<img.*?>");
						String text = null;
						if (textList.length > 0) {
							text = textList[0];
						}
						List<String> img = new ArrayList<String>();
						Matcher matcher = pattern.matcher(blog.getText());
						while (matcher.find()) {
							img.add(matcher.group().replace(" ", " class=\"blog-img\" "));
						}
			%>
			<div class="blog-frame">
				<div class="blog">
				<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blog.getId()%>"><h2 class="blog-header"><%=blog.getTitle()%></h2></a>
				<p>
					<%=blog.getCreateDate()%>
					by <a
						href="/LoveSportsORM/UserProfile.jsp?name=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a>
				</p>
				<p class="blog-text">
					<%
						if (text != null) {
									out.println(text);
								}
					%>
				</p>
				<%
					if (img.size() > 0) {
						out.print(img.get(0));
					}
				%>
				</div>
			</div>

			<%
				}
				}
			%>
		</div>
		<p class="page">
			Page
			<%
			int pageNum = (int) ((blogs.size()/ 10) + 1);
			int pageNow = n / 10 + 1;
			int i;
			for (i = 1; i <= pageNum; i++) {
				if (i == pageNow) {
		%>
			<strong><%=i%></strong>
			<%
				} else if (pageNum > 5) {
						if (pageNow < 4) {
							if (i == 6) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>">&gt&gt</a>
			<%
				} else if (i < 6) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>"><%=i%></a>
			<%
				}
						} else if (pageNow > (pageNum - 2)) {
							if (i == (pageNum - 5)) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>">&lt&lt</a>
			<%
				} else if (i > (pageNum - 5)) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>"><%=i%></a>
			<%
				}
						} else {
							if (i == (pageNow - 3)) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>">&lt&lt</a>
			<%
				} else if (i == (pageNow + 3)) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>">&gt&gt</a>
			<%
				} else if (((pageNow - 3) < i) && (i < (pageNow + 3))) {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>"><%=i%></a>
			<%
				}
						}
					} else {
			%>
			<a
				href="/LoveSportsORM/Group.jsp?groupName=<%=groupName%>&blogPage=<%=i%>"><%=i%></a>
			<%
				}
				}
			%>
		</p>
	</div>
		<div class="return_to_top">
		<a href="#top"> <img
			src="Img/icon-back-to-top.jpg"
			width="50" height="50">
		</a>
	</div>

</body>
</html>