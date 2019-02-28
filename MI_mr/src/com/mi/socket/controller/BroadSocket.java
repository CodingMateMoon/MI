package com.mi.socket.controller;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
 
@ServerEndpoint("/broadsocket")
public class BroadSocket {
    //유저 집합 리스트
    static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
     
    /**
     * 웹 소켓이 접속되면 유저리스트에 세션을 넣는다.
     * @param userSession 웹 소켓 세션
     */
    @OnOpen
    public void handleOpen(Session userSession){
        sessionUsers.add(userSession);
        String username = userSession.getQueryString().split("=")[1];
        userSession.getUserProperties().put("username", username);
        System.out.println("socketId : " + username);
    }
    /**
     * 웹 소켓으로부터 메시지가 오면 호출한다.
     * @param message 메시지
     * @param userSession
     * @throws IOException
     */
    @OnMessage
    public void handleMessage(String message,Session userSession) throws IOException{
    	System.out.println(message);
    	String username = (String)userSession.getUserProperties().get("username");
    	JSONParser jsonParser = new JSONParser();

    	// 클라이언트에서 받은 JSON 형식의 객체를 String으로 받은 다음 JSONParser로 파싱하여 JSONObject로 변환
    	JSONObject jsonObject = null;
		try {
			jsonObject = (JSONObject) jsonParser.parse(message);
//			System.out.print(jsonObject.toJSONString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
        //username이 있으면 전체에게 메시지를 보낸다. (JSON 형식)
        Iterator<Session> iterator = sessionUsers.iterator();
        while(iterator.hasNext()){
            iterator.next().getBasicRemote().sendText(jsonObject.toJSONString());
        }
    }
    /**
     * 웹소켓을 닫으면 해당 유저를 유저리스트에서 뺀다.
     * @param userSession
     */
    @OnClose
    public void handleClose(Session userSession){
        sessionUsers.remove(userSession);
    }
    /**
     * json타입의 메시지 만들기
     * @param username
     * @param message
     * @return
     */
    public String buildJsonData(String username,String message){
        JsonObject jsonObject = Json.createObjectBuilder().add("username", username)
        		.add("message", message)
        		.build();
//    	JSONObject jsonObject = new JSONObject();
        StringWriter stringwriter =  new StringWriter();
        try(JsonWriter jsonWriter = Json.createWriter(stringwriter)){
                jsonWriter.write(jsonObject);
        };
        return stringwriter.toString();
    }
}


