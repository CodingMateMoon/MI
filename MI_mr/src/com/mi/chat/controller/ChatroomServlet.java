package com.mi.chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.chat.model.service.ChatService;
import com.mi.chat.model.vo.Chat;

/**
 * Servlet implementation class ChatRoomServlet
 */
@WebServlet("/chatroom")
public class ChatroomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatroomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int chatroomId = Integer.parseInt(request.getParameter("chatroomId"));
		System.out.println(chatroomId);
		List<Chat> list = new ChatService().selectAllChat(chatroomId);
		System.out.println(list);
		String msg = "";
		String loc = "/";
		String view;
		if (list.size() > 0) {
			
			view = "/views/chat/chatView.jsp?chatroomId=" + chatroomId;
		} else {
			msg = "채팅방이 존재하지 않습니다";
			view = "views/common/msg.jsp";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher(view).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
