package com.mi.group.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

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
		String admin = members[0];
		System.out.println(gName);
		Set<String> check = new HashSet<>();
		for (int i = 1; i < members.length; i++) {
			check.add(members[i]);
		}
		String[] chatMembers = check.toArray(new String[check.size()]);
		check.add(admin);
		String[] newMembers = check.toArray(new String[check.size()]);
		
		
		int result=new GroupService().addGroup(gName,newMembers);
		int result2 = 0;
		String lastGroupId;
		if (result > 0) {
			lastGroupId = new GroupService().findLastGroupId();
			result2=new GroupService().addGroupMember(lastGroupId, newMembers);
		}
		
		int lastChatroomId = new ChatService().findLastChatroomId();
		int result3 = new ChatService().addChatroom(lastChatroomId + 1, gName, admin);
		
		
		int result4 = new ChatService().addChatroomByMember(lastChatroomId + 1, chatMembers, admin);
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
