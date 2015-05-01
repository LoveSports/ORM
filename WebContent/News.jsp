<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="edu.neu.lovesports.orm.dao.*, java.util.Date, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="css/lovesports.css">
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
<script>
function reply(seq) {
	target = document.getElementById('commentTitle');
	target.setAttribute('value', seq);
	window.location.hash = null;
	window.location.hash = '#comments';
}
</script>
</head>
<body style="padding-top: 70px;">
<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String href = request.getParameter("href");
		UserDAO udao = new UserDAO();
		CommentDAO cmtdao = new CommentDAO();

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/News.jsp?href="+href);
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/News.jsp?href="+href);
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
								<form id="form" action="News.jsp">
									<input class="form-control" name="username" type="text"
										placeholder="Email" /> <input class="form-control"
										name="password" type="password" placeholder="Password" />
									<button class="btn btn-login" type="submit" name="action"
										value="login">Log In</button>
									<button class="btn btn-login" name="action" value="signup">Sign
										Up</button>
									<input type="hidden" name="href" value="<%=href%>" />
								</form>
							</div>
							<%
								} else {
							%>
							<div id="login" class="navbar-form pull-right">
								<form action="News.jsp">
									<strong><a
										href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
											<%=user.getNickname()%>!
									</a></strong>
									<button type="submit" name="action" value="logout"
										class="btn btn-logout">Log Out</button>
									<input type="hidden" name="href" value="<%=href%>" />
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
<div class="row">
<iframe id="news" src=<%=href %> class="form-control" style="height:900px"></iframe>
</div>
			<%
				List<Comment> comments = cmtdao.readByNews(href);
			%>
		<div class="row" style="margin-top:30px">
		<h2 id="comments">Comments</h2>
		</div>
		<div class="row" style="margin-top:15px">
			<div>
				<form action="News.jsp">
					<input type="hidden" name="href" value="<%=href%>" /> <input
						id="commentTitle" type="text" name="title"
						placeholder="Enter title" class="form-control"/><br /> 
						<textarea name="text" required="required" placeholder="Enter comment" class="form-control" ></textarea>
						<br />
					<button name="action" value="postComment" class="btn btn-create">Submit</button>
					<button type="reset" class="btn btn-create">Reset</button>
				</form>
			</div>
			<div>
				<%
					int n = 0;
					if (request.getParameter("commentPage") != null)
						n = (Integer.parseInt(request.getParameter("commentPage")) - 1) * 10;
				%>
				<ul class="list">
					<%
						for (int i = 0; i < 10; i++) {
							if (comments.size() == 0)
								break;
							else {
								Comment comment = comments.get(i + n);
					%>
					<li>
						<div>
							<strong id="seq"># <%=1 + i + n%></strong>
							<h3>
								Title:
								<%=comment.getTitle()%></h3>
							<i>Author: <a
								href="/LoveSportsORM/UserProfile.jsp?name=<%=comment.getUser().getUsername()%>">
									<%=comment.getUser().getNickname()%></a></i><br />
							<tt><%=comment.getCreateDate()%></tt>
							<p><%=comment.getText()%></p>
							<div class="row" style="margin-left:0px">
							<div class="col-lg-1" style="padding:0">
							<button onclick="reply('Reply to #<%=1 + i + n%>:')" class="btn btn-create">Reply</button>
							</div>
							<div class="col-lg-1" style="padding:0">
							<form action="News.jsp">
								<%
									if (user != null) {
												if (comment.getUser().getUsername()
														.equals(user.getUsername())) {
								%>
								<button name="action" value="removeComment" class="btn btn-create">Delete</button>
								<input type="hidden" name="commentId"
									value="<%=comment.getId()%>" />
								<%
									}
											}
								%>
								<input type="hidden" name="href" value="<%=href %>" />
							</form>
							</div>
							</div>
						</div>
						<hr />
					</li>
					<%
						if ((i + n) == (comments.size() - 1))
									break;
							}
						}
					%>
				</ul>
				<p class="page" style="margin-left:0">
					Page
					<%
					int pageNum = (int) (comments.size() / 10) + 1;
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
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>">&gt&gt</a>
					<%
						} else if (i < 6) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>"><%=i%></a>
					<%
						}
								} else if (pageNow > (pageNum - 2)) {
									if (i == (pageNum - 5)) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>">&lt&lt</a>
					<%
						} else if (i > (pageNum - 5)) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>"><%=i%></a>
					<%
						}
								} else {
									if (i == (pageNow - 3)) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>">&lt&lt</a>
					<%
						} else if (i == (pageNow + 3)) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>">&gt&gt</a>
					<%
						} else if (((pageNow - 3) < i) && (i < (pageNow + 3))) {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>"><%=i%></a>
					<%
						}
								}
							} else {
					%>
					<a
						href="/LoveSportsORM/News.jsp?href=<%=href%>&commentPage=<%=i%>"><%=i%></a>
					<%
						}
						}
					%>
				</p>
			</div>
		</div>

	</div>
			<%
		String commentTitle = request.getParameter("title");
		String commentText = request.getParameter("text");
		if (action != null) {
			if (user != null) {
				 if ("postComment".equals(action)) {
					if (commentText != "") {
						Date date = new Date();
						Comment comment = new Comment(null, commentTitle, commentText, date, user, null, href);
						cmtdao.create(comment);
					}
				} else if ("removeComment".equals(action)
						&& cmtdao
								.read(Integer.parseInt(request
										.getParameter("commentId")))
								.getUser().getUsername()
								.equals(user.getUsername())) {
					cmtdao.delete(Integer.parseInt(request
							.getParameter("commentId")));
				}
				 response.sendRedirect("/LoveSportsORM/News.jsp?href="+href);
			}
			else{
				%>
				<script>
				alert("Please log in before comment.");
				</script>
				<%
			}
		}
	%>
		<div class="return_to_top">
		<a href="#top"> <img
			src="http://www.flamingobeachcr.com/images/icon-back-to-top.jpg"
			width="50" height="50">
		</a>
	</div>
</body>
</html>