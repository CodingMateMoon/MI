package com.mi.chat.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.mi.chat.model.service.ChatService;



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
		request.setCharacterEncoding("UTF-8");
		String chatroomName = request.getParameter("chatroomName");
		String[] members = request.getParameterValues("members[]");
		String admin = request.getParameter("admin");
		
		// 아이디 중복 검사
		Set<String> check = new HashSet<>();
		for (String s : members) {
			check.add(s);
		}
		String[] checkMembers = check.toArray(new String[check.size()]);
		int lastChatroomId = new ChatService().findLastChatroomId();
		int result = new ChatService().addChatroom(lastChatroomId + 1, chatroomName, admin);
		int result2 = new ChatService().addChatroomByMember(lastChatroomId + 1, checkMembers, admin);
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("chatroomName", chatroomName);
		if (result2 > 0) {
			result2 = new ChatService().findLastChatroomId(); 
			jsonobj.put("chatroomId", result2);
		}
		
		
		/*request.setAttribute("msg", "채팅방 등록!");
		request.setAttribute("loc", "/");
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);*/
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().println(jsonobj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
