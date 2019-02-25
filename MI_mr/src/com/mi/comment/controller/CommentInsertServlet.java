package com.mi.comment.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.comment.model.service.CommentService;
import com.mi.comment.model.vo.EventComment;

/**
 * Servlet implementation class CommentInsertServlet
 */
@WebServlet("/commentInsert")
public class CommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String eventRef=request.getParameter("eventRef");
		String eventCommentWriter = request.getParameter("eventCommentWriter");
		String eventCommentContent = request.getParameter("eventCommentContent");
		int eventCommentLevel = Integer.parseInt(request.getParameter("eventCommentLevel"));
		int eventCommentRef = Integer.parseInt(request.getParameter("eventCommentRef"));
		
		EventComment comment = new EventComment();
		System.out.println("servlet에서 찍은 eventId : "+eventRef);
		comment.setEventRef(eventRef);
		comment.setEventCommentContent(eventCommentContent);
		comment.setEventCommentLevel(eventCommentLevel);
		comment.setEventCommentRef(eventCommentRef);
		comment.setEventCommentWriter(eventCommentWriter);
		
		int result = new CommentService().insertComment(comment);
		
		String msg="";
		String view="/views/common/msg.jsp";
		String loc="/detail/detailAll?no="+eventRef;
		if(result>0) {
			msg="등록 성공";
		}
		else {
			msg="등록 실패";
		}
	
		
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
