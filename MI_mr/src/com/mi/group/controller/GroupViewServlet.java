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

/**
 * Servlet implementation class GroupViewServlet
 */
@WebServlet("/groupView")
public class GroupViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String memberId=request.getParameter("memberId");
	String groupId=request.getParameter("groupId");	
		List<Group> groupList=new GroupService().selectAllGroup(memberId);
		
		request.setAttribute("groupId", groupId);
		request.setAttribute("memberId", memberId);
		request.setAttribute("groupList",groupList);
		
		
		request.getRequestDispatcher("/views/group/groupView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
