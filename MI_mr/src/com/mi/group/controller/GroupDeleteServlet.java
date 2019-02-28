package com.mi.group.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.group.model.service.GroupService;

/**
 * Servlet implementation class GroupDeleteServlet
 */
@WebServlet("/deleteGroup.do")
public class GroupDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String groupId=request.getParameter("delGroupId");
		System.out.println(groupId);
		
		int result=new GroupService().deleteGroup(groupId);
		String msg="";
		String loc="";
		if(result>0) { 
			
			msg="그룹수정 완료"; loc="/groupView";
		} else
		{ 
			msg="그룹수정 실패"; loc="/groupView"; 
			}

		request.setAttribute("msg", msg); request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
