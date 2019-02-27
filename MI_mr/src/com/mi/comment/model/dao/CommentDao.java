package com.mi.comment.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mi.comment.model.vo.EventComment;

public class CommentDao {
	
	private Properties prop=new Properties();

	public CommentDao() {
		try {
			String filename=CommentDao.class.getResource("/sql/comment/comment-query.properties").getPath();
			prop.load(new FileReader(filename));
		}
		catch(IOException e)
		{e.printStackTrace();}
	}
	
	public int insertComment(Connection conn, EventComment comment) {
		PreparedStatement pstmt=null;
		int result = 0;
		String sql=prop.getProperty("insertComment");
		System.out.println(sql+":"+comment);
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, comment.getEventCommentLevel());
			pstmt.setString(2, comment.getEventCommentWriter());
			pstmt.setString(3, comment.getEventCommentContent());
			pstmt.setString(4, comment.getEventRef());
			//5번이 중요한데 여기에다가 null값을 넣어야함 숫자는 null이 없음 그래서 string으로 넣을겁니다
			pstmt.setString(5, comment.getEventCommentRef()==0?null:String.valueOf(comment.getEventCommentRef()));
			//pstmt.setInt(5, comment.getEventCommentRef());
			result=pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	public int deleteComment(Connection conn, int eventCommentNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteComment");
		System.out.println("delectDao"+sql+" : "+eventCommentNo);
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, eventCommentNo);
			result=pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	public List<EventComment> commentList(Connection conn, String eventId){
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<EventComment> list=new ArrayList<>();
		String sql=prop.getProperty("commentList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, eventId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				EventComment ec=new EventComment();
				ec.setEventCommentNo(rs.getInt("event_comment_no"));
				ec.setEventCommentLevel(rs.getInt("event_comment_level"));
				ec.setEventCommentWriter(rs.getString("event_comment_writer"));
				ec.setEventCommentContent(rs.getString("event_comment_content"));
				ec.setEventRef(rs.getString("event_ref"));
				ec.setEventCommentRef(rs.getInt("event_comment_ref"));
				ec.setEventCommentDate(rs.getDate("event_comment_date"));
				list.add(ec);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	

}
