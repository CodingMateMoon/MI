package com.mi.event.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.event.model.service.EventService;
import com.mi.event.model.vo.Event;
import com.mi.member.model.vo.Member;

/**
 * Servlet implementation class EventDeleteServlet
 */
@WebServlet("/eventDelete")
public class EventDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String eventId=request.getParameter("eventId");

		//넘겨줄게 많으면 객체를 선언해서 넘겨주면 되는데 eventId만 넘겨줘서 삭제해주면 되는거라 객체 선언 필요 X
		//Event e=new Event();

		int result=new EventService().deleteEvent(eventId);

		Member m= (Member)request.getSession().getAttribute("loginMember");
		String memberId=m.getMemberId();

		List<Event> list = new EventService().selectAllEvent(memberId);


		String msg="";
		String loc="";
		String view="/views/common/msg.jsp";
		if(result>0)
		{
			msg="일정이 삭제되었습니다.";
			loc="/views/detail/detailAll.jsp";
		}
		else {
			msg="일정 삭제 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.setAttribute("memberId", memberId);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/detail/detailAll.jsp").forward(request, response);


		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
