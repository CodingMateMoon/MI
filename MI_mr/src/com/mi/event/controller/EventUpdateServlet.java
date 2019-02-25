package com.mi.event.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mi.event.model.service.EventService;
import com.mi.event.model.vo.Event;
import com.mi.group.model.service.GroupService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
/**
 * Servlet implementation class CalendarUpdateServlet
 */
@WebServlet("/eventUpDate")
public class EventUpdateServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      String dir=getServletContext().getRealPath("/");
      System.out.println(dir);
      String filePath=dir+"upload" + File.separator + "event";
  
      int maxSize=1024*1024*10;
      
      MultipartRequest mr=new MultipartRequest(request,dir,maxSize,"UTF-8",new DefaultFileRenamePolicy());
      
      Event e=new Event();
      
      e.setEventId(mr.getParameter("eventId"));
      e.setTitle(mr.getParameter("title"));
      String memberId=mr.getParameter("memberId");
      e.setPrepairingId(memberId);
        try {
           java.util.Date util_startDate=new SimpleDateFormat("yy-MM-dd").parse(mr.getParameter("startDate"));
            java.sql.Date sql_startDate=new java.sql.Date(util_startDate.getTime());
           e.setStartDate(sql_startDate); 
            
            }
           catch
           (ParseException e1) { // TODO Auto-generated catch block
           e1.printStackTrace(); 
           }
      
       try {
          java.util.Date util_endDate=new SimpleDateFormat("yy-MM-dd").parse(mr.getParameter("endDate"));
          java.sql.Date sql_endDate=new java.sql.Date(util_endDate.getTime());
          e.setEndDate(sql_endDate);

       }
       catch (Exception e1) {e1.printStackTrace(); }
       
       String groupId=new GroupService().selectGroupId(mr.getParameter("groupList"));
       System.out.println("group_id:::::::::::::::::"+groupId);
      e.setGroupId(groupId);
      e.setMemo(mr.getParameter("memo"));
      e.setFilePath(mr.getParameter("filePath"));
      e.setPrepairingId(mr.getParameter("memberId"));
      
      String fileName=mr.getFilesystemName("up_file");
      
      File f=mr.getFile("up_file");
      if(f!=null&&f.length()>0)
      {
         File deleFile=new File(filePath+"/"+mr.getParameter("old_file"));
         boolean result=deleFile.delete();
      }
      else
      {
         fileName=mr.getParameter("old_file");
      }
      
      e.setFilePath(fileName);
      
      System.out.println(e);
      int result=new EventService().insertEvent(e);
      System.out.println("결과::"+result);
      String msg="";
      System.out.println(request.getContextPath()+"/showCalendar?memberId="+memberId);
       String loc="/showCalendar?memberId="+memberId; 
      /* String loc="/views/event/eventView"; */
      if(result>0)
      {
         msg="이벤트 등록성공";
      }
      else
      {
         msg="이벤트 등록 실패";
      }
      System.out.println(e);
      
      
      
      request.setAttribute("msg", msg);
      request.setAttribute("loc", loc);
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