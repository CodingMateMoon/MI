package com.mi.group.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.mi.group.model.service.GroupService;
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
		String groupId=request.getParameter("groupId");
		List<GroupByMember> groupMemberList=new GroupService().groupMemberList(groupId);
		
		/* System.out.println(groupId); */
		/*
		 * JSONArray groupMemberArr=new JSONArray(); for(GroupByMember
		 * gm:groupMemberList) { JSONObject jo=new JSONObject();
		 * jo.put("groupId",gm.getGroupId()); jo.put("memberId",gm.getMemberId());
		 * groupMemberArr.add(jo);
		 * 
		 * } response.setContentType("application/json;charset=UTF-8");
		 * 
		 * JSONObject json=new JSONObject(); json.put("memberId", memberId);
		 * json.put("groupName",groupName); json.put("groupMemberArr",groupMemberArr);
		 * new Gson().toJson(json,response.getWriter());
		 */
		request.setAttribute("memberId", memberId);
		request.setAttribute("groupId", groupId);
		request.setAttribute("groupMemberList", groupMemberList);
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
