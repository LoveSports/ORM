package edu.neu.cs5200.mlb.main;

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

import edu.neu.cs5200.spur.subclass.Away;
import edu.neu.cs5200.spur.subclass.Games;
import edu.neu.cs5200.spur.subclass.Home;
import edu.neu.cs5200.spur.subclass.Venue;

//Get the schedule of all games of the given regular season from the following link: http://api.sportradar.us/nba-t3/zh/games/2014/reg/schedule.json?api_key=smucb9h4a4bwey25cj9cwnd9

public class GetMLBInfor {

	private final String FIND_SCHEDULE_BY_SEASON = "http://api.sportradar.us/nba-t3/zh/games/SEASON/reg/schedule.json?api_key=smucb9h4a4bwey25cj9cwnd9";

	public ArrayList<Games> findGamesBySeason(String season) {

		String urlStr = FIND_SCHEDULE_BY_SEASON.replace("SEASON", season);

		String json = getJsonStringForCoachUrl(urlStr);

		JSONObject obj;
		// JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);

			ArrayList<Games> games = new ArrayList<Games>();

			ObjectMapper mapper = new ObjectMapper();

			JSONArray arr = obj.getJSONArray("games");

			for (int i = 0; i < arr.length(); i++) {
				//Get all the information from the array;
				String id = arr.getJSONObject(i).getString("id");
				String status = arr.getJSONObject(i).getString("status");
				String coverage = arr.getJSONObject(i).getString("coverage");
				String scheduled = arr.getJSONObject(i).getString("scheduled");

				//build my own JsonObject;
				JSONObject mySingleJsonObj = new JSONObject();

				//put all the information into this JSONObject
				mySingleJsonObj.put("id", id);
				mySingleJsonObj.put("status", status);
				mySingleJsonObj.put("coverage", coverage);
				mySingleJsonObj.put("scheduled", scheduled);

				String myNewData = mySingleJsonObj.toString();
				// System.out.println(xiongData);

				games.add(mapper.readValue(myNewData, Games.class));
			}
			return games;
		} catch (JSONException e1) {
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

	public ArrayList<Venue> findVenueBySeason(String season) {
		String urlStr = FIND_SCHEDULE_BY_SEASON.replace("SEASON", season);

		String json = getJsonStringForCoachUrl(urlStr);

		JSONObject obj;
		// JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);

			ArrayList<Venue> venue = new ArrayList<Venue>();

			ObjectMapper mapper = new ObjectMapper();

			JSONArray arr = obj.getJSONArray("games");

			for (int i = 0; i < arr.length(); i++) {
				String venue_id = arr.getJSONObject(i).getJSONObject("venue").getString("id");
				String name = arr.getJSONObject(i).getJSONObject("venue").getString("name");
				Long capacity = arr.getJSONObject(i).getJSONObject("venue").getLong("capacity");
				String venue_address = arr.getJSONObject(i).getJSONObject("venue").getString("address");
				String venue_city = arr.getJSONObject(i).getJSONObject("venue").getString("city");
				// String venue_state =
				// arr.getJSONObject(i).getJSONObject("venue").getString("state");
				// String venue_zip =
				// arr.getJSONObject(i).getJSONObject("venue").getString("zip");
				String venue_country = arr.getJSONObject(i).getJSONObject("venue").getString("country");

				JSONObject venueObject = new JSONObject();

				venueObject.put("venue_id", venue_id);
				venueObject.put("name", name);
				venueObject.put("capacity", capacity);
				venueObject.put("address", venue_address);
				venueObject.put("city", venue_city);
				// xiong.put("state", venue_state);
				// xiong.put("zip", venue_zip);
				venueObject.put("country", venue_country);

				String venueData = venueObject.toString();
				// System.out.println(xiongData);

				venue.add(mapper.readValue(venueData, Venue.class));
			}
			return venue;
		} catch (JSONException e1) {
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

	public ArrayList<Home> findHomeBySeason(String season) {
		String urlStr = FIND_SCHEDULE_BY_SEASON.replace("SEASON", season);

		String json = getJsonStringForCoachUrl(urlStr);

		JSONObject obj;
		// JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);

			ArrayList<Home> home = new ArrayList<Home>();

			ObjectMapper mapper = new ObjectMapper();

			JSONArray arr = obj.getJSONArray("games");

			for (int i = 0; i < arr.length(); i++) {
				String home_name = arr.getJSONObject(i).getJSONObject("home").getString("name");
//				String home_alias = arr.getJSONObject(i).getJSONObject("home")
//						.getString("alias");
				String home_id = arr.getJSONObject(i).getJSONObject("home").getString("id");

				JSONObject homeObject = new JSONObject();

				homeObject.put("name", home_name);
				//homeObject.put("alias", home_alias);
				homeObject.put("id", home_id);

				String homeData = homeObject.toString();
				// System.out.println(xiongData);

				home.add(mapper.readValue(homeData, Home.class));
			}
			return home;
		} catch (JSONException e1) {
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
	
	public ArrayList<Away> findAwayBySeason(String season) {
		String urlStr = FIND_SCHEDULE_BY_SEASON.replace("SEASON", season);

		String json = getJsonStringForCoachUrl(urlStr);

		JSONObject obj;
		// JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);

			ArrayList<Away> away = new ArrayList<Away>();

			ObjectMapper mapper = new ObjectMapper();

			JSONArray arr = obj.getJSONArray("games");

			for (int i = 0; i < arr.length(); i++) {
				String away_name = arr.getJSONObject(i).getJSONObject("away").getString("name");
//				String home_alias = arr.getJSONObject(i).getJSONObject("home")
//						.getString("alias");
				String away_id = arr.getJSONObject(i).getJSONObject("away").getString("id");

				JSONObject awayObject = new JSONObject();

				awayObject.put("name", away_name);
				//homeObject.put("alias", home_alias);
				awayObject.put("id", away_id);

				String awayData = awayObject.toString();
				// System.out.println(xiongData);

				away.add(mapper.readValue(awayData, Away.class));
			}
			return away;
		} catch (JSONException e1) {
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
		GetMLBInfor client = new GetMLBInfor();

//		ArrayList<Home> homes = client.findHomeBySeason("2014");
//		for (Home home : homes) {
//			System.out.println(home.getAlias());
//			System.out.println(home.getId());
//		}

//		ArrayList<Games> games = client.findGamesBySeason("2014");
//		for (Games game : games) {
//			System.out.println(game.getScheduled());
//			System.out.println(game.getId());
//		}
		
		ArrayList<Away> aways = client.findAwayBySeason("2014");
		for (Away away : aways) {
			System.out.println(away.getId());
			System.out.println(away.getName());
		}

	}

}
