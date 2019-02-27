package com.mi.comment.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import static common.JDBCTemplate.close;

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
	
	public int deleteComment(Connection conn, int delNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteComment");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, delNo);
			pstmt.executeQuery();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	

}
