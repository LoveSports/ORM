<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="ISO-8859-1" import="edu.neu.cs5200.spur.main.*"
	import="com.google.gson.Gson" import="edu.neu.cs5200.spur.subclass.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		SpurTest test = new SpurTest();
		Gson gson = new Gson();
		String json = test.findTeamById("583ece50-fb46-11e1-82cb-f4ce4684ea4c");

		Spur spur = gson.fromJson(json, Spur.class);
	%>
	<table style="width: 100%">
			<tr>
				<th colspan="4">Team Information</th>
			</tr>
			<tr>
				<th colspan="2">Team ID</th>
				<td><%=spur.getId()%></td>
			</tr>
			<tr>
				<th colspan="2">Team Name</th>
				<td><%=spur.getName()%></td>
			</tr>
			<tr>
				<th colspan="2">Team Alias</th>
				<td><%=spur.getAlias()%></td>
			</tr>
			<tr>
				<th colspan="2">Team Founded</th>
				<td><%=spur.getFounded()%></td>
			</tr>
			<tr>
				<th colspan="2">Market</th>
				<td><%=spur.getMarket()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue ID</th>
				<td><%=spur.getVenue().getId()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue Name</th>
				<td><%=spur.getVenue().getName()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue Capacity</th>
				<td><%=spur.getVenue().getCapacity()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue Address</th>
				<td><%=spur.getVenue().getAddress()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue City</th>
				<td><%=spur.getVenue().getCity()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue State</th>
				<td><%=spur.getVenue().getState()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue Zip</th>
				<td><%=spur.getVenue().getZip()%></td>
			</tr>
			<tr>
				<th colspan="2">Venue Country</th>
				<td><%=spur.getVenue().getCountry()%></td>
			</tr>
			<tr>
				<th colspan="2">League ID</th>
				<td><%=spur.getLeague().getId()%></td>
			</tr>
			<tr>
				<th colspan="2">League Alias</th>
				<td><%=spur.getLeague().getAlias()%></td>
			</tr>
			<tr>
				<th colspan="2">League Name</th>
				<td><%=spur.getLeague().getName()%></td>
			</tr>
			<tr>
				<th colspan="2">Conference ID</th>
				<td><%=spur.getConference().getId()%></td>
			</tr>
			<tr>
				<th colspan="2">Conference Name</th>
				<td><%=spur.getConference().getName()%></td>
			</tr>
			<tr>
				<th colspan="2">Conference Alias</th>
				<td><%=spur.getConference().getAlias()%></td>
			</tr>
			<tr>
				<th colspan="2">Division ID</th>
				<td><%=spur.getDivision().getId()%></td>
			</tr>
			<tr>
				<th colspan="2">Division Name</th>
				<td><%=spur.getDivision().getName()%></td>
			</tr>
			<tr>
				<th colspan="2">Division Alias</th>
				<td><%=spur.getDivision().getAlias()%></td>
			</tr>
	</table>
</body>
</html>