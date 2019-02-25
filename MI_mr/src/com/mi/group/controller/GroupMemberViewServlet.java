package com.mi.group.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.group.model.service.GroupService;
import com.mi.group.model.vo.Group;
import com.mi.group.model.vo.GroupByMember;

/**
 * Servlet implementation class GroupMemberViewServlet
 */
@WebServlet("/memberView.do")
public class GroupMemberViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupMemberViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId=request.getParameter("memberId");
		String groupName=request.getParameter("groupName");
		System.out.println(groupName);
		List<GroupByMember> groupMemberList=new GroupService().groupMemberList(groupName);
		System.out.println(groupName);
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("groupName", groupName);
		request.setAttribute("groupName", groupName);
		request.getRequestDispatcher("/views/group/gMemberList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
