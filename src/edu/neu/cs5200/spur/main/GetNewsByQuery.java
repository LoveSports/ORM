package edu.neu.cs5200.spur.main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GetNewsByQuery {

	static String FIND_TEAMINFOR_BY_ID = "https://ajax.googleapis.com/ajax/services/search/news?v=1.0&q=QUERY";
	
	public static String[][] findNewsByQuery(String query) {
		String urlStr = FIND_TEAMINFOR_BY_ID.replace("QUERY", query);
		//Spur spur = new Spur();
		//SpurTest test = new SpurTest();
		ObjectMapper mapper = new ObjectMapper();
		String json = getNewsByUrl(urlStr);
		String link[][] = new String[4][10];
		//return json;
		try {
			JSONObject obj = new JSONObject(json);
			JSONObject responseData = obj.getJSONObject("responseData");
			JSONArray array = responseData.getJSONArray("results");
			
			for(int i = 0; i < array.length(); i++)
			{
				link[i][0] = array.getJSONObject(i).getString("unescapedUrl");
				link[i][1] = array.getJSONObject(i).getString("titleNoFormatting");
			}
			return link;
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	
	
	
	public static String getNewsByUrl(String urlStr) {
		try 
		{
			// create a url object to represent the string.
			URL url = new URL(urlStr);
			// open a connection to the URL and convert it to a HTTP protocal
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
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
		//GetNewsByQuery news = new GetNewsByQuery();
		String link[][] = findNewsByQuery("James");
		for(int i = 0; i < link.length; i++)
		{
			System.out.println(link[i][0] + "\n");
			System.out.println(link[i][1] + "\n");
		}
		//System.out.println(link);

	}

}
