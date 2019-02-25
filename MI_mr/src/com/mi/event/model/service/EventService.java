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
	
	public Event detailEvent(String eventId){
		Connection conn=getConnection();
		Event e = dao.detailEvent(conn, eventId);
		close(conn);
		return e;
	}
	
}
