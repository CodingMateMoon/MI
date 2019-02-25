package com.mi.comment.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.comment.model.service.CommentService;

/**
 * Servlet implementation class CommentDeleteServlet
 */
@WebServlet("/commentDelete")
public class CommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		delNo은 삭제할 댓글 번호
		int delNo=Integer.parseInt(request.getParameter("delNo"));
//		이벤트 아이디		
		int eventId=Integer.parseInt(request.getParameter("eventId"));

		
	
		int result = new CommentService().deleteComment(delNo);
		
		String msg="";
		String loc="";
		String view="/views/common/msg.jsp";
		if(result>0) {
			msg="댓글이 삭제되었습니다.";
		//	loc="/detail/detailAll?no="+??;
		}
		else {
			msg="댓글 삭제가 실패하였습니다.";
		//	loc="/detail/detailAll?no="+??;
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
