package edu.neu.cs5200.spur.subclass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import org.json.*;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GetPlayerInfor {
	
	private final String FIND_TEAMINFOR_BY_ID = "http://api.sportradar.us/nba-t3/zh/teams/TEAM_ID/profile.json?api_key=smucb9h4a4bwey25cj9cwnd9";

	public ArrayList<Player> findTeamById(String id){
		
		String urlStr = FIND_TEAMINFOR_BY_ID.replace("TEAM_ID", id);
        
		String json = getJsonStringForCoachUrl(urlStr);
		
		JSONObject obj;
		//JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);
			
			ArrayList<Player> players = new ArrayList<Player>();
			
			ObjectMapper mapper = new ObjectMapper();
			
			JSONArray arr = obj.getJSONArray("players");
			for (int i = 0; i < arr.length(); i++)
			{
			    String player_id = arr.getJSONObject(i).getString("id");
			    String status = arr.getJSONObject(i).getString("status");
			    String full_name = arr.getJSONObject(i).getString("full_name");
			    String first_name = arr.getJSONObject(i).getString("first_name");
			    String last_name = arr.getJSONObject(i).getString("last_name");
			    String abbr_name = arr.getJSONObject(i).getString("abbr_name");
			    Long height = arr.getJSONObject(i).getLong("height");
			    Long weight = arr.getJSONObject(i).getLong("weight");
			    String position = arr.getJSONObject(i).getString("position");
			    String primary_position = arr.getJSONObject(i).getString("primary_position");
			    String jersey_number = arr.getJSONObject(i).getString("jersey_number");
			    String experience = arr.getJSONObject(i).getString("experience");
			    //String college = arr.getJSONObject(i).getString("college");
			    String birth_place = arr.getJSONObject(i).getString("birth_place");
			    String birthdate = arr.getJSONObject(i).getString("birthdate");
			    
			    
				JSONObject mySingleJsonObj = new JSONObject();
			    mySingleJsonObj.put("id", player_id);
			    mySingleJsonObj.put("status", status);
			    mySingleJsonObj.put("full_name", full_name);
			    mySingleJsonObj.put("first_name", first_name);
			    mySingleJsonObj.put("last_name", last_name);
			    mySingleJsonObj.put("abbr_name", abbr_name);
			    mySingleJsonObj.put("height", height);
			    mySingleJsonObj.put("weight", weight);
			    mySingleJsonObj.put("position", position);
			    mySingleJsonObj.put("primary_position", primary_position);
			    mySingleJsonObj.put("jersey_number", jersey_number);
			    mySingleJsonObj.put("experience", experience);
			    //mySingleJsonObj.put("college", college);
			    mySingleJsonObj.put("birth_place", birth_place);
			    mySingleJsonObj.put("birthdate", birthdate);
			    String myNewData = mySingleJsonObj.toString();
			    players.add(mapper.readValue(myNewData, Player.class));			    
			}
			return players;
		} 
		catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return null;

	}

	
	public static String getJsonStringForCoachUrl(String urlStr1) {
		try {
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
		return null;
	}
	
	public static void main(String[] args) {
		GetPlayerInfor client = new GetPlayerInfor();
		
		ArrayList<Player> players = client.findTeamById("583ecd4f-fb46-11e1-82cb-f4ce4684ea4c");
		for(Player player : players){
			System.out.println("Player ID: " + player.getId());
			System.out.println("Status: " + player.getStatus());
			System.out.println("Full Name: " + player.getFull_name());
			System.out.println("First Name: " + player.getFirst_name());
			System.out.println("Last Name: " + player.getLast_name());
			System.out.println("Abbr Name: " + player.getAbbr_name());
			System.out.println("Height: " + player.getHeight());
			System.out.println("Weight: " + player.getWeight());
			System.out.println("Position: " + player.getPosition());
			System.out.println("Primary Position: " + player.getPrimary_position());
			System.out.println("Jersey Number: " + player.getJersey_number());
			System.out.println("Experience: " + player.getExperience());
			System.out.println("College: " + player.getCollege());
			System.out.println("Birth Place: " + player.getBirth_place());
			System.out.println("Brithdate: " + player.getBirthdate());
		}

	}

}
