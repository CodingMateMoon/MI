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
 * Servlet implementation class ShowCalendarServlet
 */
@WebServlet("/showCalendar")
public class ShowCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowCalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		request.getRequestDispatcher("/views/calendar/calendar.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
