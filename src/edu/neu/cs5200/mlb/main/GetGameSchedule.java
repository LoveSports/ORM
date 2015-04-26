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

//Get the schedule of all games of the given regular season from the following link: http://api.sportradar.us/mlb-t5/games/2014/REG/schedule.json?api_key=q3ez7avdpc3dnhe8kszv9aqc

public class GetGameSchedule {

	private final String FIND_SCHEDULE_BY_SEASON = "http://api.sportradar.us/mlb-t5/games/SEASON/REG/schedule.json?api_key=q3ez7avdpc3dnhe8kszv9aqc";

	public ArrayList<Games> findGamesBySeason(String season) {

		String urlStr = FIND_SCHEDULE_BY_SEASON.replace("SEASON", season);

		String json = getJsonStringForCoachUrl(urlStr);

		JSONObject obj;
		// JSONArray myArrayJsonObj = new JSONArray();
		try {
			obj = new JSONObject(json);

			ArrayList<Games> games = new ArrayList<Games>();

			ObjectMapper mapper = new ObjectMapper();

			JSONArray gm = obj.getJSONObject("league").getJSONObject("season").getJSONArray("games");

			for (int i = 0; i < gm.length(); i++) {
				String id = gm.getJSONObject(i).getString("id");

				String status = gm.getJSONObject(i).getString("status");
				String coverage = gm.getJSONObject(i).getString("coverage");
				String scheduled = gm.getJSONObject(i).getString("scheduled");

				JSONObject mySingleJsonObj = new JSONObject();

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

			JSONArray gm = obj.getJSONObject("league").getJSONObject("season").getJSONArray("games");

			for (int i = 0; i < gm.length(); i++) {
				String venue_id = gm.getJSONObject(i).getJSONObject("venue")
						.getString("id");
				String name = gm.getJSONObject(i).getJSONObject("venue")
						.getString("name");
				Long capacity = gm.getJSONObject(i).getJSONObject("venue")
						.getLong("capacity");
				String venue_address = gm.getJSONObject(i)
						.getJSONObject("venue").getString("address");
				String venue_city = gm.getJSONObject(i).getJSONObject("venue")
						.getString("city");
				// String venue_state =
				// gm.getJSONObject(i).getJSONObject("venue").getString("state");
				// String venue_zip =
				// gm.getJSONObject(i).getJSONObject("venue").getString("zip");
				String venue_country = gm.getJSONObject(i)
						.getJSONObject("venue").getString("country");

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

			JSONArray gm = obj.getJSONObject("league").getJSONObject("season").getJSONArray("games");

			for (int i = 0; i < gm.length(); i++) {
				String home_name = gm.getJSONObject(i).getJSONObject("home")
						.getString("name");
				String home_id = gm.getJSONObject(i).getJSONObject("home")
						.getString("id");

				JSONObject homeObject = new JSONObject();

				homeObject.put("name", home_name);
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

			JSONArray gm = obj.getJSONObject("league").getJSONObject("season").getJSONArray("games");

			for (int i = 0; i < gm.length(); i++) {
				String away_name = gm.getJSONObject(i).getJSONObject("away")
						.getString("name");
				String away_id = gm.getJSONObject(i).getJSONObject("away")
						.getString("id");

				JSONObject awayObject = new JSONObject();

				awayObject.put("name", away_name);
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
		GetGameSchedule client = new GetGameSchedule();

		ArrayList<Home> homes = client.findHomeBySeason("2014");
		for (Home home : homes) {
			System.out.println(home.getAlias());
			System.out.println(home.getId());
		}

//		ArrayList<Games> games = client.findGamesBySeason("2014");
//		for (Games game : games) {
//			System.out.println(game.getScheduled());
//			System.out.println(game.getId());
//		}

	}

}
