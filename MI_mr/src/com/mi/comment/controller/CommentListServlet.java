package com.mi.comment.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mi.comment.model.service.CommentService;
import com.mi.comment.model.vo.EventComment;

/**
 * Servlet implementation class CommentListServlet
 */
@WebServlet("/eventComment/commentList.do")
public class CommentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String eventId = request.getParameter("eventId");
		
		System.out.println(eventId);
		List<EventComment> list= new CommentService().commentList(eventId);
		System.out.println(list);
		/*Map map=new HashMap();
		List<Map>transList=new ArrayList();
		for(EventComment c : list) {
			map.put("eventCommentWriter",c.getEventCommentWriter());
			map.put("eventCommentContent", c.getEventCommentContent());
			map.put("eventCommentNo",c.getEventCommentNo());
			String eventCommentDate=new SimpleDateFormat("yyyy-MM-dd").format(c.getEventCommentDate());
			map.put("eventCommentDate",eventCommentDate);
			transList.add(map);
		}*/
		response.setContentType("application/json;charset=UTF-8");
		new Gson().toJson(list,response.getWriter());
	
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
