<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.cs5200.spur.main.*"  import="edu.neu.cs5200.spur.subclass.*"
    import="com.google.gson.Gson" import="com.google.gson.reflect.TypeToken" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>

</head>
<body>

<script>

<%
SpurTest client = new SpurTest();
String keyword = request.getParameter("keyword");

Gson gson = new Gson();
String json = client.findTeamById(keyword);

Spur spur = gson.fromJson(json, Spur.class);
out.print("document.write(\""+"Address: "+spur.getVenue().getAddress()+"<br>\");\n");
out.print("document.write(\""+"Capacity: "+spur.getVenue().getCapacity()+"<br>\");\n");
out.print("document.write(\""+"Country: "+spur.getVenue().getCountry()+"<br>\");\n");
out.print("document.write(\""+"Zipcode: "+spur.getVenue().getZip()+"<br>\");\n");





%>





</script>



</body>
</html>

