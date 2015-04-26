<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.cs5200.spur.main.*"  import="edu.neu.cs5200.spur.subclass.*"
    import="com.google.gson.Gson" import="com.google.gson.reflect.TypeToken" import="edu.neu.cs5200.main.*" import="java.util.List" import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>2013 Schedule</title>
</head>
<body>
	<h1>The schedule of 2014 regular season is as following:</h1>
	<% 
	GetGameInforBySeason client = new GetGameInforBySeason();

	ArrayList<Games> games = client.findGamesBySeason("2014");
	for (Games game : games) {
		out.println("<br/>" + game.getScheduled()  + "<br/>");
		out.println("<br/>" + game.getId() + "<br/>");
	}
	ArrayList<Home> homes = client.findHomeBySeason("2014");
	for (Home home : homes) {
		out.println("<br/>" + home.getAlias()  + "<br/>");
		out.println("<br/>" + home.getName() + "<br/>");
	}
	%>
</body>
</html>