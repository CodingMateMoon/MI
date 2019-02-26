package com.mi.chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;



/**
 * Servlet implementation class AddChatroomEndServlet
 */
@WebServlet("/addChatroomEnd")
public class AddChatroomEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddChatroomEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		String memberIdList = request.getParameter("memberIdList");
		System.out.println("addChatroomEnd---");
		System.out.println(memberIdList);
		
		if (memberIdList != null) {
			JSONParser jsonParser = new JSONParser();
	
	    	// 클라이언트에서 받은 JSON 형식의 객체를 String으로 받은 다음 JSONParser로 파싱하여 JSONObject로 변환
	    	JSONObject jsonObject = null;
			try {
				jsonObject = (JSONObject) jsonParser.parse(memberIdList.toString());
				System.out.print(jsonObject.toJSONString());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("msg", "채팅방 등록!");
		request.setAttribute("loc", "/");
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
