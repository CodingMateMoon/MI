package com.mi.event.model.service;

import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;
import java.sql.Connection;
import java.util.List;

import com.mi.event.model.dao.EventDao;
import com.mi.event.model.vo.Event;

public class EventService {
	private EventDao dao=new EventDao();
	
	public List<Event> selectAllEvent(String memberId){
		Connection conn=getConnection();
		List<Event> list=dao.selectAllEvent(conn, memberId);
		close(conn);
		return list;
	}
	
	public Event detailEvent(String eventId)
	{
		Connection conn=getConnection();
		Event e=dao.detailEvent(conn, eventId);
		close(conn);
		return e;
	}
	
	public int insertEvent(Event e)
	{
		Connection conn=getConnection();
		int result=dao.insertEvent(conn,e);
		if(result>0)
		{
			commit(conn);
		}
		else
		{
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int deleteEvent(String eventId) {
		Connection conn=getConnection();
		int result=dao.deleteEvent(conn,eventId);
		if(result>0)
		{
			commit(conn);
		}
		else
		{
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	
	/*
	 * public List<Event> detailEvent(String eventId){ Connection
	 * conn=getConnection(); List<Event> list = dao.detailEvent(conn, eventId);
	 * close(conn); return list; }
	 */
	
	public List<Event> selectMemberEvent(String memberId){
		Connection conn=getConnection();
		List<Event> list=dao.selectMemberEvent(conn,memberId);
		close(conn);
		return list;
	}
	public List<Event> selectGroupsEvent(String memberId){
		Connection conn=getConnection();
		List<Event> list=dao.selectGroupsEvent(conn,memberId);
		close(conn);
		return list;
	}
	public List<Event> selectGroupEvent(String memberId, String groupId){
		Connection conn=getConnection();
		List<Event> list=dao.selectGroupEvent(conn, memberId,groupId);
		close(conn);
		return list;
	}
	
}
