package com.mi.calendar.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.event.model.service.EventService;
import com.mi.event.model.vo.Event;
import com.mi.group.model.service.GroupService;
import com.mi.group.model.vo.Group;

/**
 * Servlet implementation class CalendarDefaultServlet
 */
@WebServlet("/calendar/defaultAjax.do")
public class CalendarDefaultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarDefaultServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String memberId=request.getParameter("memberId");
		List<Event> eventList=new EventService().selectAllEvent(memberId);
		List<Group> groupList=new GroupService().selectAllGroup(memberId);
		
		
		Date today=new Date();
		SimpleDateFormat defaultDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String defaultToday="";
		
		try {
			defaultToday=defaultDateFormat.format(today);
		}catch(Exception e) {e.printStackTrace();}
		
		request.setAttribute("defaultToday", defaultToday);
		request.setAttribute("memberId", memberId);
		request.setAttribute("eventList",eventList);
		request.setAttribute("groupList",groupList);
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
