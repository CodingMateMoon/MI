package com.mi.comment.model.service;

import java.sql.Connection;

import com.mi.comment.model.dao.CommentDao;
import com.mi.comment.model.vo.EventComment;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;

public class CommentService {

	private CommentDao dao=new CommentDao();

	public int insertComment(EventComment comment) {
		Connection conn=getConnection();
		int result= dao.insertComment(conn, comment);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int deleteComment(int delNo) {
		Connection conn=getConnection();
		int result = dao.deleteComment(conn, delNo);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		close(conn);
		return result;
	}






}
