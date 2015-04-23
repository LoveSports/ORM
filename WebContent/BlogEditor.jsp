<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.Date, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
<script type="text/javascript">
	$(function() {
		$d = $("#editor")[0].contentWindow.document; 
		$d.designMode = "on";
		$d.contentEditable = true;
		$d.open();
		$d.close();

		$(document).ready(function(){
			$('#editor').contents().find('body').html($('#oldText').val());
		});
		$('#insertImg').click(function() {                                
			var img = '<img src="' + $('#path').val() + '" />';
			$("body", $d).append(img);
		});

/* 		$('#preview').click(function() {
			alert($('#editor').contents().find('body').html());
			$('#preview_area').html($('#editor').contents().find('body').html());
				}); */
		
		$('#postBlog').click(function(){
			if(($('#titleHolder').val() == "")||($('#editor').contents().find('body').html() == null)){
				$('#titleHolder').focus();
				$('#alert').html("Title and content cannot leave blank.");
			}
			else{
			$('#text').val($('#editor').contents().find('body').html());
			$('#title').val($('#titleHolder').val());
			}
			});
				
		$('#cancel').click(function(){
			$('#text').val('text');
			$('#title').val('title');
			});
	});
</script>
</head>
<body>
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String blogId = request.getParameter("blogId");
		String groupName = request.getParameter("groupName");
		User user = (User) session.getAttribute("User");
		BlogDAO bdao = new BlogDAO();
		GroupDAO gdao = new GroupDAO();
		Blog blog = null;
		Group group = null;
		if (blogId != null) {
			if(bdao.read(Integer.parseInt(blogId)).getUser().getUsername().equals(user.getUsername()))
				blog = bdao.read(Integer.parseInt(blogId));
		}
		else if((groupName != null)&&(groupName != "null")){
				group = gdao.read(groupName);
		}

		if (action != null) {
			if ("logout".equals(action)) {
				session.removeAttribute("User");
				action = null;
				if (blog != null)
					response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="
							+ blogId);
				else
					response.sendRedirect("/LoveSportsORM/Group.jsp?groupName="
							+ groupName);
			}
		}
	%>
	<div id="top">
		<a href="/LoveSportsORM/Homepage.jsp">Homepage</a>
		<a href="/LoveSportsORM/Group.jsp?groupName=Forum">Forum</a>
		<div id="login">
			<strong><a href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello <%=user.getNickname()%>!</a></strong>
			<form action="BlogEditor.jsp">
				<button type="submit" name="action" value="logout">Log Out</button>
				<%
					if (blog != null) {
				%>
				<input type="hidden" name="blogId" value="<%=blogId%>" />
				<%
					}
				%>
				<input type="hidden" name="groupName" value="<%=groupName%>" />
			</form>
		</div>
	</div>
	<%
	String title = request.getParameter("title");
	String text = request.getParameter("text");
	if(action != null){
		if(blog != null){
			if("postBlog".equals(action)){
				Date date = new Date();
				blog.setTitle(title);
				blog.setText(text);
				blog.setModifyDate(date);
				bdao.update(blog);
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId=" + blogId);
			}
			else if("cancel".equals(action)){
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId=" + blogId);
			}
		}
		else if(group !=null){
			if("postBlog".equals(action)){
				Date date = new Date();
				Blog newBlog = new Blog(null, title, text, date, null, user, group);
				blogId = bdao.create(newBlog).getId().toString();
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId=" + blogId);
			}
			else if("cancel".equals(action)){
				response.sendRedirect("/LoveSportsORM/Group.jsp?groupName=" + groupName);
			}
		}
	}
	
	%>
	<div>
		<div>
			<%
				if (blog != null) {
			%>
			<p>
			<input type="text" placeholder="Blog title" id="titleHolder" value="<%=blog.getTitle()%>" />
			<textarea id="oldText" style="display:none"><%=blog.getText() %></textarea>
			</p>
			<%
				}
				else{
					%>
					<p>
					<input type="text" placeholder="Blog title" id="titleHolder" />
					<textarea id="oldText" style="display:none"></textarea>
					<%
				}
			%>
			</p>
			<input id="path" placeholder="Copy image URL here" type="text" name="url"/>
			<button id="insertImg" value="insertPicture">Insert Picture</button>
			<p>
			<iframe id="editor"></iframe>
			</p>
		</div>
		<div>
			<form action="BlogEditor.jsp">
			<p>
			<button id="postBlog" name="action" value="postBlog">Post</button>
			<button id="cancel" name="action" value="cancel">Cancel</button>
			<strong id="alert"></strong>
			</p>
			<%
			if(blog != null){
				%>
				<input type="hidden" name="blogId" value="<%=blogId%>" />
				<%
			}
			%>
			<textarea id="text" name="text" style="display:none" required></textarea>
			<input type="hidden" id="title" name="title"  required />
			<input type="hidden" name="groupName" value="<%=groupName%>" />
			<strong id="alert"></strong>
			</form>
		</div>
	</div>
</body>
</html>