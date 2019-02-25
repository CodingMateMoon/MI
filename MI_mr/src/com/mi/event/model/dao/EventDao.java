package com.mi.event.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mi.event.model.vo.Event;
public class EventDao {
	private Properties prop=new Properties();
	public EventDao() {
		try {
			String fileName=EventDao.class.getResource("/sql/event/event-query.properties").getPath();
			prop.load(new FileReader(fileName));
		}catch(Exception e) {e.printStackTrace();}
	}
	
	public List<Event> selectAllEvent(Connection conn,String memberId){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
 		List<Event> list=new ArrayList<Event>();
		String sql=prop.getProperty("selectAllEvent");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Event e=new Event();
				e.setEventId(rs.getString("event_id"));
				e.setTitle(rs.getString("title"));
				e.setStartDate(rs.getDate("start_date"));
				e.setEndDate(rs.getDate("end_date"));
				e.setGroupId(rs.getString("group_id"));
				e.setMemo(rs.getString("memo"));
				e.setFilePath(rs.getString("file_path"));
				e.setPrepairingId(rs.getString("prepairing_id"));
				list.add(e);
			}
		}catch(Exception e) {e.printStackTrace();}
		finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	public int insertEvent(Connection conn,Event e)
	{
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertEvent");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, e.getTitle());
			pstmt.setDate(2, (Date) e.getStartDate());
			pstmt.setDate(3, (Date)e.getEndDate());
			pstmt.setString(4, e.getGroupId());
			pstmt.setString(5, e.getMemo());
			pstmt.setString(6, e.getFilePath());
			pstmt.setString(7, e.getPrepairingId());
			
			result=pstmt.executeUpdate();
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			close(pstmt);
		}
		return result;
	}
	
	
	public Event detailEvent(Connection conn, String eventId){
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		Event e =null;
		String sql=prop.getProperty("detailEvent");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, eventId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				e=new Event();
				e.setEventId(rs.getString("event_id"));
				e.setTitle(rs.getString("title"));
				e.setStartDate(rs.getDate("start_date"));
				e.setEndDate(rs.getDate("end_date"));
				e.setGroupId(rs.getString("group_id"));
				e.setMemo(rs.getString("memo"));
				e.setFilePath(rs.getString("file_path"));
				e.setPrepairingId(rs.getString("prepairing_id"));
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return e;
	}
	
	
}
