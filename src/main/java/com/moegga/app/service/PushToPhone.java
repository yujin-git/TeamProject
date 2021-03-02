package com.moegga.app.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class PushToPhone {
	private ArrayList<String> tokens = new ArrayList<String>();  	
	 
	//Firebase Console->프로젝트 선택->설정->프로젝트 설정
	//->클라우드 메시징->서버키 복사
	private final String apiKey = "AAAAKpQ58yM:APA91bEkKB4QGfs218eEQwYvpxvaIRqbyky95vliuAPCoE4hXR3IUmBWEunfyProQgxThDbvpQ17C4tWfbOkeVgUaS-pr_eubuyAXqQS3OzaFAJOmKZsW3VGVOLF29R-_6ybuEp7uGEF";
	private String gcmURL ="https://fcm.googleapis.com/fcm/send";	
	private JSONArray resultArray = new JSONArray();
	
	public void requestToFCMServer(String title,String message,String token){
		try{	
			URL url = new URL(gcmURL);
		    HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
		    httpConn.setDoOutput(true);
		    httpConn.setRequestMethod("POST");
		    httpConn.setRequestProperty("Content-Type", "application/json");
		    httpConn.setRequestProperty("Authorization", "key=" + apiKey);
		   
			String msg =String.format("{\"data\":{\"dataTitle\":\"%s\",\"dataBody\":\"%s\"},\"to\":\"%s\"}",title,message,token);
		    OutputStream os = httpConn.getOutputStream();
		    
		    os.write(msg.getBytes("UTF-8"));
		    os.flush();
		    os.close();
		    
			//요청 보내기
		    int responseCode = httpConn.getResponseCode();      
		    //서버에서 보낸 응답 결과 받기
		    BufferedReader reader = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
		    String responseString; 	
		    while ((responseString = reader.readLine()) != null) { 
		    	System.out.println(responseString);
		    	JSONParser parser = new JSONParser();
		    	JSONObject object=(JSONObject)parser.parse(responseString);		    	
		    	resultArray.add(object);   
		    }
		    reader.close();  	    
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}////////////////////
}
