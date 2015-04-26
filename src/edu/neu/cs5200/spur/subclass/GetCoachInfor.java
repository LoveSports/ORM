package edu.neu.cs5200.spur.subclass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
//import java.util.ArrayList;

import org.json.*;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GetCoachInfor {
	
	private final String FIND_TEAMINFOR_BY_ID = "http://api.sportradar.us/nba-t3/zh/teams/TEAM_ID/profile.json?api_key=smucb9h4a4bwey25cj9cwnd9";

	public Coach[] findTeamById(String id){
		
		String urlStr = FIND_TEAMINFOR_BY_ID.replace("TEAM_ID", id);
        
		String json = getJsonStringForCoachUrl(urlStr);
		
		JSONObject obj;
		JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);
			
			//ArrayList<String> coaches = new ArrayList<String>();
			
			JSONArray arr = obj.getJSONArray("coaches");
			for (int i = 0; i < arr.length(); i++)
			{
			    String coach_id = arr.getJSONObject(i).getString("id");
			    String full_name = arr.getJSONObject(i).getString("full_name");
			    String first_name = arr.getJSONObject(i).getString("first_name");
			    String last_name = arr.getJSONObject(i).getString("last_name");
			    String position = arr.getJSONObject(i).getString("position");
			    String experience = arr.getJSONObject(i).getString("experience");
			    
				JSONObject mySingleJsonObj = new JSONObject();
			    mySingleJsonObj.put("id", coach_id);
			    mySingleJsonObj.put("full_name", full_name);
			    mySingleJsonObj.put("first_name", first_name);
			    mySingleJsonObj.put("last_name", last_name);
			    mySingleJsonObj.put("position", position);
			    mySingleJsonObj.put("experience", experience);
			    myArrayJsonObj.put(mySingleJsonObj);
			}
			
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String myNewData = myArrayJsonObj.toString();
		
		ObjectMapper mapper = new ObjectMapper();
		
		
	    try {
			return mapper.readValue(myNewData, Coach[].class);
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
		GetCoachInfor client = new GetCoachInfor();
		
		Coach[] coaches = client.findTeamById("583ecd4f-fb46-11e1-82cb-f4ce4684ea4c");
		for(Coach coach : coaches){
			System.out.println("Coach ID: " + coach.getId());
			System.out.println("Full Name: " + coach.getFull_name());
			System.out.println("First Name: " + coach.getFirst_name());
			System.out.println("Last Name: " + coach.getLast_name());
			System.out.println("Position: " + coach.getPosition());
			System.out.println("Experience: " + coach.getExperience());
		}

	}

}
