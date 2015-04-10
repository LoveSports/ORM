<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Hello</h1>
	<% 
	SubscriptionDAO sdao = new SubscriptionDAO();
	CategoryDAO cdao = new CategoryDAO();
	UserDAO udao = new UserDAO();
	Category c = cdao.read(2);
	User u = udao.read("steven05jiang@gmail.com");
	List<Subscription> subs = sdao.readByUser("steven05jiang@gmail.com");
	for (Subscription sub : subs){
		out.println(sub.getUser().getUsername()+" ");
		out.println(sub.getCategory().getTitle());
	}
	
	sdao.delete(u, c);
	
	%>
</body>
</html>