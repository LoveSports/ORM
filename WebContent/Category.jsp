<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.cs5200.spur.main.*, edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*,
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
		String catId = request.getParameter("catId");
		CategoryDAO cdao = new CategoryDAO();
		IncludingDAO indao = new IncludingDAO();
		Category category = null;
		if(catId != null){
			category = cdao.read(Integer.parseInt(catId));
		}

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Group.jsp?catIds="
						+ catId);
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/Group.jsp?catId="
							+ catId);
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
							<form id="form" action="Category.jsp">
								<input class="form-control" name="username" type="text"
									placeholder="Email" /> <input class="form-control"
									name="password" type="password" placeholder="Password" />
								<button class="btn btn-login" type="submit" name="action"
									value="login">Log In</button>
								<button class="btn btn-login" name="action" value="signup">Sign
									Up</button>
								<input type="hidden" name="catId" value="<%=catId%>" />
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
								<input type="hidden" name="catId" value="<%=catId%>" />
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
	<div class="jumbotron group-title-<%=category.getTitle()%>">
		<h1><%=category.getTitle() %></h1>
		<p><%=category.getDescription() %></p>
	</div>
	<%
	List<Including> ins = category.getSubs();
	Category sub = new Category();
	String[][] link;
	for(Including in : ins){
		sub = in.getSub();
		String img = sub.getImgs().get(0).getUrl();
		String title = sub.getTitle();
	%>
	<div class="col-lg-6">
				<div>
				<a href="/LoveSportsORM/Category.jsp?catId=<%=sub.getId()%>">
					<h2 class="blog-header"><%=title %></h2>
					</a>
 					<img
						src="<%=img %>">
						<p>
						<%
							link = GetNewsByQuery.findNewsByQuery(title);
							for (int i = 0; i < link.length; i++) {
						%><a href="/LoveSportsORM/News.jsp?href=<%out.println(link[i][0]);%>"> <%
 		out.println(" <br> " + link[i][1] + " <br> ");%></a>
						<%
							}
						%>
					</p>
				</div>
			</div>
	<%
	}
	if(category.getId() == 3){
		%>
		<div class="col-lg-6 showImg">
					<div>
					<a href="/LoveSportsORM/NBATeam/NBATeamsInfor.jsp">
						<h2 class="blog-header">Teams Information</h2>
						</a>
						<img src="Img/nba-teams.jpg">
					</div>
				</div>
		<%
	}
	%>
	</div>
</body>
</html>