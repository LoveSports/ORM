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
<link rel="stylesheet" href="../css/lovesports.css">
<script type="text/javascript" src="js/jquery-2.1.3.js"></script>
</head>
<body style="padding-top: 70px;">
<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");


		if (action != null) {
			if ("signup".equals(action)) {
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			} else if ("logout".equals(action)) {
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/NBATeam/NBATeamsInfor.jsp");
				action = null;
			} else if ("login".equals(action)) {
				if (username == "" || password == "")
					out.println("Please enter account and password.");
				else if (check.Login(request, response, username, password)) {
					response.sendRedirect("/LoveSportsORM/NBATeam/NBATeamsInfor.jsp");
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
							<form id="form" action="NBATeamsInfor.jsp">
								<input class="form-control" name="username" type="text"
									placeholder="Email" /> <input class="form-control"
									name="password" type="password" placeholder="Password" />
								<button class="btn btn-login" type="submit" name="action"
									value="login">Log In</button>
								<button class="btn btn-login" name="action" value="signup">Sign
									Up</button>
							</form>
						</div>
						<%
							} else {
						%>
						<div id="login" class="navbar-form pull-right">
							<form action="NBATeamsInfor.jsp">
								<strong><a
									href="/LoveSportsORM/UserProfile.jsp?name=<%=user.getUsername()%>">Hello
										<%=user.getNickname()%>!
								</a></strong>
								<button type="submit" name="action" value="logout"
									class="btn btn-logout">Log Out</button>
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
	<table class="table">
		<tr>
			<th colspan="5" style="text-align:center"><h1>Choose A Team to See It's Information</h1></th>
		</tr>
		<tr>
			<td><a href="BlazersTeamInfor.jsp">Portland Trail Blazers</a></td>
			<td><a href="BucketsTeamInfor.jsp">Milwaukee Bucks</a></td>
			<td><a href="BullsTeamInfor.jsp">Chicago Bulls</a></td>
			<td><a href="CavaliersTeamInfor.jsp">Cleveland Cavaliers</a></td>
			<td><a href="CelticsTeamInfor.jsp">Boston Celtics</a></td>
		</tr>
		<tr>
			<td><a href="ClippersTeamInfor.jsp">Los Angeles Clippers</a></td>
			<td><a href="GrizzliesTeamInfor.jsp">Memphis Grizzlies</a></td>
			<td><a href="HawksTeamInfor.jsp">Atlanta Hawks</a></td>
			<td><a href="HeatsTeamInfor.jsp">Miami Heats</a></td>
			<td><a href="HornetsTeamInfor.jsp">Charlotte Hornets</a></td>
		</tr>
		<tr>
			<td><a href="JazzTeamInfor.jsp">Utah Jazz</a></td>
			<td><a href="KingsTeamInfor.jsp">Sacramento Kings</a></td>
			<td><a href="LakersTeamInfor.jsp">Los Angeles Lakers</a></td>
			<td><a href="MagicTeamInfor.jsp">Orlando Magic</a></td>
			<td><a href="MavericksTeamInfor.jsp">Dallas Mavericks</a></td>
		</tr>
		<tr>
			<td><a href="NetsTeamInfor.jsp">Brooklyn Nets</a></td>
			<td><a href="NicksTeamInfor.jsp">New York Knicks</a></td>
			<td><a href="NuggetsTeamInfor.jsp">Denver Nuggets</a></td>
			<td><a href="PacersTeamInfor.jsp">Indiana Pacers</a></td>
			<td><a href="PelicansTeamInfor.jsp">New Orleans Pelicans</a></td>
		</tr>
		<tr>
			<td><a href="PistonsTeamInfor.jsp">Detroit Pistons</a></td>
			<td><a href="RaptorsTeamInfor.jsp">Toronto Raptors</a></td>
			<td><a href="RocketsTeamInfor.jsp">Houston Rockets</a></td>
			<td><a href="SixersTeamInfor.jsp">Philadelphia 76ers</a></td>
			<td><a href="SpurTeamInfor.jsp">San Antonio Spurs</a></td>
		</tr>
		<tr>
			<td><a href="SunsTeamInfor.jsp">Phoenix Suns</a></td>
			<td><a href="ThundersTeamInfor.jsp">Oklahoma City Thunder</a></td>
			<td><a href="TimberwolvesTeamInfor.jsp">Minnesota Timberwolves</a></td>
			<td><a href="WarriorsTeamInfor.jsp">Golden State Warriors</a></td>
			<td><a href="WizardsTeamInfor.jsp">Washington Wizards</a></td>
		</tr>
	</table>
</div>
</body>
</html>