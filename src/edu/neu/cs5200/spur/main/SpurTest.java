package edu.neu.cs5200.spur.main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import edu.neu.cs5200.spur.subclass.Spur;

public class SpurTest {
	
	static String FIND_TEAMINFOR_BY_ID = "http://api.sportradar.us/nba-t3/zh/teams/TEAM_ID/profile.json?api_key=smucb9h4a4bwey25cj9cwnd9";

	
	
	
	public static String findTeamById(String team_id) {
		String urlStr = FIND_TEAMINFOR_BY_ID.replace("TEAM_ID", team_id);
		//Spur spur = new Spur();
		//SpurTest test = new SpurTest();
		ObjectMapper mapper = new ObjectMapper();
		String json = getJsonStringForSpurUrl(urlStr);
		return json;
	}

	public static String getJsonStringForSpurUrl(String urlStr1) {
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
		SpurTest test = new SpurTest();
		Gson gson = new Gson();
		String json = findTeamById("583ecd4f-fb46-11e1-82cb-f4ce4684ea4c");

		Spur spur = gson.fromJson(json, Spur.class);
		System.out.println(spur.getVenue().getZip());
		
//		ArrayList<Spur> retSpur = gson.fromJson(json, new TypeToken<ArrayList<Spur>>() {}.getType());  
//        for (Spur spur : retSpur) {  
//            System.out.println(spur.getAlias());
//            System.out.println(spur.getFounded());
//        }  
		//		Spur spur_infor = gson.fromJson(json, Spur.class);
//		//Spur spur = gson.fromJson(spur_infor, Spur.class);
//		System.out.println(spur_infor.getLeague());
//		
//		
//		
//		
//		List<Coaches> coachinfor = gson.fromJson(spur_infor, new TypeToken<List<Coaches>>() {}.getType());
//		for(int i = 0; i < coachinfor.size(); i++)
//		{
//			Coaches entityData = coachinfor.get(i);
//			String coachinfor_name = entityData.getCoaches();
//			List coachinfor_entity = entityData.getCoachData();
//			String s2 = gson.toJson(coachinfor_entity);
//			if (coachinfor_name.equals("coaches")) {  
//                System.out.println("coaches");  
//                List<Coaches> retStuList = gson.fromJson(s2,  
//                        new TypeToken<List<Coaches>>() {  
//                        }.getType());  
//                for (int j = 0; j < retStuList.size(); j++) {  
//                    System.out.println(retStuList.get(j));  
//                }  
//  
//            } else if (coachinfor_name.equals("players")) {  
//                System.out.println("players");  
//                List<Players> retTchrList = gson.fromJson(s2,  
//                        new TypeToken<List<Players>>() {  
//                        }.getType());  
//                for (int j = 0; j < retTchrList.size(); j++) {  
//                    System.out.println(retTchrList.get(j));  
//                }  
//            }  
//		}
	}
}
