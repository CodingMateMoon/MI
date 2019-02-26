package com.mi.member.model.service;

import java.sql.Connection;

import com.mi.member.model.dao.MemberDao;
import com.mi.member.model.vo.Member;

import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;
import static common.JDBCTemplate.close;

public class MemberService {
	
	private MemberDao dao=new MemberDao();
	
	public int insertMember(Member m) {
		Connection conn=getConnection();
		int result=dao.insertMember(conn, m);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Member selectOne(Member m) {
		Connection conn=getConnection();
		Member result=dao.selectOne(conn,m);
		close(conn);
		return result;
	}
	public int updateMember(Member m) {
		Connection conn=getConnection();
		int result=dao.updateMember(conn, m);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		return result;
	}
	public int updatePassword(Member m)
	{
		Connection conn=getConnection();
		int result=dao.updatePassword(conn,m);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	public int deleteMember(String userId) {
		Connection conn=getConnection();
		int result=dao.deleteMember(conn, userId);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public Member FindId(Member m) {
		Connection conn=getConnection();
		Member result=dao.FindId(conn,m);
		close(conn);
		return result;
	}
	
	public Member FindPw(Member m) {
		Connection conn=getConnection();
		Member result=dao.FindPw(conn,m);
		close(conn);
		return result;
	}
	
	public int PwFindChange(Member m) {
		Connection conn=getConnection();
		int result=dao.PwFindChange(conn,m);
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
