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
<link rel="stylesheet" href="css/lovesports.css">
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
<script>
	$(function(){
		$('#del').click(function(){
			var result = confirm('Are you sure to delete this blog?');
			if(result == true){
				var href = 'Blog.jsp?blogId=' + '<%=request.getParameter("blogId")%>'
								+ '&action=removeBlog';
						window.location.href = href;
					}
				});

		$('#commentButton').click(function() {
			$("#comment").slideToggle("slow");
			window.location.hash = null;
			window.location.hash = '#stampForm';
		});

		$('#skipToComment').click(function() {
			window.location.hash = null;
			window.location.hash = '#stampForm';
			$("#comment").slideDown("slow");
		});

		$(document).ready(function() {
			if (window.location.hash == '#stampForm')
				$('#comment').show();
		});
	});
	function reply(seq) {
		target = document.getElementById('commentTitle');
		target.setAttribute('value', seq);
		window.location.hash = null;
		window.location.hash = '#comment';
	}
</script>
</head>
<body style="padding-top: 70px;">
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String blogId = request.getParameter("blogId");
		BlogDAO bdao = new BlogDAO();
		CollectionDAO cltdao = new CollectionDAO();
		UserDAO udao = new UserDAO();
		Blog blog = null;
		if (blogId != null)
			blog = bdao.read(Integer.parseInt(blogId));

		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="
						+ blogId);
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="
							+ blogId);
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
								<form id="form" action="Blog.jsp">
									<input class="form-control" name="username" type="text"
										placeholder="Email" /> <input class="form-control"
										name="password" type="password" placeholder="Password" />
									<button class="btn btn-login" type="submit" name="action"
										value="login">Log In</button>
									<button class="btn btn-login" name="action" value="signup">Sign
										Up</button>
									<input type="hidden" name="blogId" value="<%=blogId%>" />
								</form>
							</div>
							<%
								} else {
							%>
							<div id="login" class="navbar-form pull-right">
								<form action="Blog.jsp">
									<strong><a
										href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
											<%=user.getNickname()%>!
									</a></strong>
									<button type="submit" name="action" value="logout"
										class="btn btn-logout">Log Out</button>
									<input type="hidden" name="blogId" value="<%=blogId%>" />
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

	<div id="content" class="container">
		<div id="blog">
		 <div class="row">
			<h1 class="blog-header-show"><%=blog.getTitle()%></h1>
			</div>
			<div class="row">
			<p>
				<strong> Written by: </strong><i><a
					href="/LoveSportsORM/UserProfile.jsp?name=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a></i>
			</p>
			</div>
			<div class="row">
			<p>
				<tt>
					Created on
					<%=blog.getCreateDate()%></tt>
			</p>
			</div>
			<%
				if (blog.getModifyDate() != null) {
			%>
			<div class="row">
			<p>
				<tt>
					Modified on
					<%=blog.getModifyDate()%></tt>
			</p>
			</div>
			<%
				}
				if (user != null) {
					if (blog.getUser().getUsername().equals(user.getUsername())) {
			%>
			<div class="row">
			<div class="col-lg-1" style="padding: 0">
				<form action="Blog.jsp">
					<button name="action" value="editBlog" class="btn btn-create"
						style="padding-right: 30px; padding-left: 30px">Edit</button>
					<input type="hidden" name="blogId" value="<%=blogId%>" />
				</form>
			</div>
			<div class="col-lg-1" style="padding-left: 0">
				<button id="del" class="btn btn-create"
					style="padding-right: 25px; padding-left: 25px">Delete</button>
			</div>
			</div>
			<%
				}
				}
			%>
			<div class="row">
			<div class="col-lg-2" style="padding: 0; margin-top: 10px">
				<button id="skipToComment" class="btn btn-create">Skip to Comment</button>
			</div>
			<%
			if(!user.getUsername().equals(blog.getUser().getUsername())){
			%>
			<form action="Blog.jsp">
			<%
			if(cltdao.read(bdao.read(blog.getId()), udao.read(user.getUsername())) == null) {
			%>
			<div class="col-lg-1" style="padding: 0; margin-top: 10px">
				<button id="collectButton" name="action" value="collect" class="btn btn-create">COLLECT
				</button>
				</div>
				<div class="col-lg-3" style="padding: 0; margin-top: 10px">
					<input name="note" placeholder="Enter notes for your collection." class="form-control">
				</div>
			<%
			}else{
			%>
			<div class="col-lg-1" style="padding: 0; margin-top: 10px">
				<button class="btn" name="action" value="cancelCollect">COLLECTED
				</button>
			</div>
			<%
			}
			%>
			<input type="hidden" name="blogId" value="<%=blogId%>" />
			</form>

			<%
			}
			%>
			</div>
			<hr />
			<div class="row">
			<div class="blog-text" style="margin-top: 20px">
				<%
				String content = blog.getText();
				String text = content.replace("<img ", "<img class=\"blog-img-show\" ");
				out.print(text);
				%>
			</div>
			</div>
			<hr />
			<div class="row" style="margin-top:20px; margin-bottom:20px">
			<%
				List<Stamp> stamps = bdao.read(Integer.parseInt(blogId))
						.getStamps();
			%>
			<div class="col-lg-1" style="padding-left: 0">
			<form id="stampForm" action="Blog.jsp">
				<button id="stampButton" type="submit" name="action" value="like" class="btn btn-create"><%=stamps.size()%>LIKES
				</button>
				<input type="hidden" name="blogId" value="<%=blogId%>" />
			</form>
			</div>
			<%
				List<Comment> comments = bdao.read(Integer.parseInt(blogId))
						.getComments();
			%>
			<div class="col-lg-1" style="padding-left: 0">
			<button id="commentButton" class="btn btn-create"><%=comments.size()%>COMMENTS
			</button>
			</div>
		</div>
		</div>
		<div id="comment" class="row" style="display: none">
			<div>
				<form action="Blog.jsp">
					<input type="hidden" name="blogId" value="<%=blogId%>" /> <input
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
							<form action="Blog.jsp">
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
								<input type="hidden" name="blogId" value="<%=blogId%>" />
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
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm">&gt&gt</a>
					<%
						} else if (i < 6) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm"><%=i%></a>
					<%
						}
								} else if (pageNow > (pageNum - 2)) {
									if (i == (pageNum - 5)) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm">&lt&lt</a>
					<%
						} else if (i > (pageNum - 5)) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm"><%=i%></a>
					<%
						}
								} else {
									if (i == (pageNow - 3)) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm">&lt&lt</a>
					<%
						} else if (i == (pageNow + 3)) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm">&gt&gt</a>
					<%
						} else if (((pageNow - 3) < i) && (i < (pageNow + 3))) {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm"><%=i%></a>
					<%
						}
								}
							} else {
					%>
					<a
						href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId%>&commentPage=<%=i%>#stampForm"><%=i%></a>
					<%
						}
						}
					%>
				</p>
			</div>
		</div>

	</div>
		<%
		StampDAO stdao = new StampDAO();
		CommentDAO cmtdao = new CommentDAO();
		String commentTitle = request.getParameter("title");
		String commentText = request.getParameter("text");
		String note = request.getParameter("note");
		if (action != null) {
			if (user != null) {
				if ("like".equals(action)) {
					if (stdao.read(blog, user) == null){
						stdao.create(blog, user);
					}
					else{
						stdao.delete(blog, user);
					}
				} else if ("postComment".equals(action)) {
					if (commentText != "") {
						Date date = new Date();
						Comment comment = new Comment(null, commentTitle,
								commentText, date, user, blog);
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
				else if("collect".equals(action)&&(!user.getUsername().equals(blog.getUser().getUsername()))){
						if(cltdao.read(blog, user) == null){
							Collection clt = new Collection(null, note, user, blog);
							cltdao.create(clt);
						}
				}else if("cancelCollect".equals(action)){
					cltdao.delete(user, blog);
					
				}
				else if (blog.getUser().getUsername().equals(user.getUsername())) {
					if ("editBlog".equals(action)) {
						response.sendRedirect("/LoveSportsORM/BlogEditor.jsp?blogId="
								+ blogId);
					} else if ("removeBlog".equals(action)) {
						String groupName = blog.getGroup().getName();
						bdao.delete(blog.getId());
						blog = null;
						response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
								+ groupName);
			}
				}
			}
					
			if ((!"editBlog".equals(action))
					&& (!"removeBlog".equals(action)))
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="
						+ blogId);
		}
	%>
</body>
</html>