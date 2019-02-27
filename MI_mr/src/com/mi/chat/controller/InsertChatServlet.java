package com.mi.chat.controller;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.chat.model.service.ChatService;
import com.mi.chat.model.vo.Chat;

/**
 * Servlet implementation class InsertChatServlet
 */
@WebServlet("/insertChat")
public class InsertChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertChatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String chatContent = request.getParameter("chatContent");
		int chatroomId = Integer.parseInt(request.getParameter("chatroomId"));
		String memberId = request.getParameter("memberId");
		String temp = chatContent + " : " + chatroomId + " : " + memberId + "test";
		chatContent= chatContent.replaceAll("'","′"); // 작은 따옴표를 ′로 치환
		Chat c = new Chat();
		c.setChatContent(chatContent);
		c.setChatroomId(chatroomId);
		c.setMemberId(memberId);
		
		int result = new ChatService().insertChat(c);
		
		response.setContentType("text/csv;charset=UTF-8");
		response.getWriter().append(temp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
