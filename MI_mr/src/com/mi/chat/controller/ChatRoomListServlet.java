package com.mi.chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.chat.model.service.ChatService;
import com.mi.chat.model.vo.Chatroom;
import com.mi.chat.model.vo.ChatroomByMember;

/**
 * Servlet implementation class ChatListServlet
 */
@WebServlet("/chatroomList")
public class ChatRoomListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatRoomListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("memberId");
		System.out.println(id);
		List<Chatroom> list = new ChatService().selectAllChatroom(id);
		List<ChatroomByMember> cbmList = new ChatService().selectAllChatroomByMember(id);
		System.out.println(cbmList);
		String msg = "";
		String loc = "/";
		String view;
		
		if (list.size() > 0) {
			view = "/views/chat/chatList.jsp";
		} else {
			msg = "등록된 그룹이 없습니다.";
			view = "/views/common/msg.jsp";
		}
		request.setAttribute("list", list);
		request.setAttribute("cbmList", cbmList);
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
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
