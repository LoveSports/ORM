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

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Homepage.jsp");
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
						<div id="login" class="navbar-form pull-right">
							<form action="Subscription.jsp">
								<strong><a
									href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
										<%=user.getNickname()%>!
								</a></strong>
								<button type="submit" name="action" value="logout"
									class="btn btn-logout">Log Out</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</nav>
	
	<%
	SubscriptionDAO sdao = new SubscriptionDAO();
	if(action != null){
		if(user != null){
			if("cancel".equals(action))
				response.sendRedirect("/LoveSportsORM/UserProfile.jsp?name=" + user.getUsername());
			else if("submit".equals(action)){
				String status = null;
				for(Category cat : cdao.readAll()){
					status = request.getParameter(cat.getTitle());
					if((sdao.read(user, cat) != null)&&(!"on".equals(status)))
						sdao.delete(user, cat);
					else if((sdao.read(user, cat) == null)&&("on".equals(status)))
						sdao.create(user, cat);
				}
				response.sendRedirect("/LoveSportsORM/UserProfile.jsp?name=" + user.getUsername());
			}
		}
	}
	%>
	
	<div class="container">
	<h1 class="blog-header-show">Please check off to subscribe the news</h1>
	<form action="Subscription.jsp">
	<div class="row">
	<%
	for(Category cat : cdao.readAll()){
	%>
	<div class="col-lg-6">
			<div>
			<input type="checkbox" name="<%=cat.getTitle() %>" 
			<%
				if(sdao.read(user, cat) != null){
					out.println(" checked");
				}
			%>
			/>
				<h2 class="blog-header"><%=cat.getTitle() %></h2>
					<img src="<%=cat.getImgs().get(0).getUrl() %>" />
			</div>
	</div>
	<%
	}
	%>
	</div>
	<div class="row pull-right" style="margin:5%; margin-right:0">
	<button class="btn btn-create" name="action" value="submit">Subscribe</button>
	<button class="btn btn-create" name="action" value="cancel">Cancel</button>
	</div>
	</form>
	</div>
</body>
</html>