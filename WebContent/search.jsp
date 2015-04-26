<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.cs5200.spur.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Homepage</title>


</head>
<body ng-app="MovieApp">
 <!--    <div ng-controller="MovieController" class="container">
        <h1>I Love Sports Client</h1>
        <h1>Please give the id of the NBA Team you want to search</h1>
        <form action="Result.jsp" method="GET">
        <input type="text" name="keyword" class="form-control" ng-model="searchByTitle">
        <input type="submit" value="Submit" class="btn btn-primary" ng-click="searchMovies()">Search</button>
        </form> -->
        
        
        
    <div>
    	<h1>Please click the year of the schedule you want to search</h1>
    	<input type="button" value="2013 Schedule" onclick="window.location.href='2013schedule.jsp'">
    	<input type="button" value="2014 Schedule" onclick="window.location.href='2014schedule.jsp'">
    </div>
</body>
</html>

