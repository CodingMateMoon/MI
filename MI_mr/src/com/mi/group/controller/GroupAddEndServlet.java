package com.mi.group.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.chat.model.service.ChatService;
import com.mi.group.model.service.GroupService;

/**
 * Servlet implementation class GroupAddEndServlet
 */
@WebServlet("/addGroupEnd.do")
public class GroupAddEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GroupAddEndServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String gName = request.getParameter("gName");
		String[] members = request.getParameterValues("members[]");
		System.out.println(gName);
		for (String m : members)
		{
			System.out.println(m);
			
		}
		
		int result=new GroupService().addGroup(gName,members);
		int result2 = 0;
		String lastGroupId;
		if (result > 0) {
			lastGroupId = new GroupService().findLastGroupId();
			result2=new GroupService().addGroupMember(lastGroupId, members);
		}
		
		int lastChatroomId = new ChatService().findLastChatroomId();
		int result3 = new ChatService().addChatroom(lastChatroomId + 1, gName, members[0]);
		String[] chatMembers = new String[members.length - 1];
		for (int i = 0; i < chatMembers.length; i++) {
			chatMembers[i] = members[i + 1];
		}
		int result4 = new ChatService().addChatroomByMember(lastChatroomId + 1, chatMembers, members[0]);
		String msg="";
		String loc="";
		if(result2>0)
		{
			msg="그룹생성 완료";
			loc="/groupView";
		}
		else
		{
			msg="그룹생성 실패";
			loc="/groupView";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
