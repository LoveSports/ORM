package edu.neu.cs5200.mlb.main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

//import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import edu.neu.cs5200.mlb.subclass.Team;
//import edu.neu.cs5200.spur.subclass.Spur;

//Get the information of a special MLB team with TEAM_ID
//http://api.sportradar.us/mlb-t5/teams/aa34e0ed-f342-4ec6-b774-c79b47b60e2d/profile.json?api_key=q3ez7avdpc3dnhe8kszv9aqc
public class GetMLBTeamInfor {
	
	static String FIND_TEAMINFOR_BY_ID = "http://api.sportradar.us/mlb-t5/teams/TEAM_ID/profile.json?api_key=q3ez7avdpc3dnhe8kszv9aqc";

	
	
	
	public static String findTeamById(String team_id) {
		String urlStr = FIND_TEAMINFOR_BY_ID.replace("TEAM_ID", team_id);
		String json = getJsonStringForMLBUrl(urlStr);
		return json;
	}

	public static String getJsonStringForMLBUrl(String urlStr1) {
		try 
		{
			// create a url object to represent the string.
			URL url = new URL(urlStr1);
			// open a connection to the URL and convert it to a HTTP protocal
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			// We need to say what we want to do with this URL
			connection.setRequestMethod("GET");
			// give me back what I want, open a stream and steam back the data
			InputStream in = connection.getInputStream();
			// buffer the information
			InputStreamReader isr = new InputStreamReader(in);
			BufferedReader reader = new BufferedReader(isr);
			String out;
			StringBuffer json = new StringBuffer();
			while ((out = reader.readLine()) != null) {
				json.append(out);
			}
			// System.out.println(json);
			return json.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{};
		return null;
	}

	public static void main(String[] args) {
		//GetMLBTeamInfor test = new GetMLBTeamInfor();
		Gson gson = new Gson();
		String json = findTeamById("aa34e0ed-f342-4ec6-b774-c79b47b60e2d");

		Team team = gson.fromJson(json, Team.class);
		System.out.println(team.getVenue().getCountry());
	}
}
