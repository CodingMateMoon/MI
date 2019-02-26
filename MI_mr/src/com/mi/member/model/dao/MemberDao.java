package com.mi.member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.mi.member.model.vo.Member;


public class MemberDao {
	
private Properties prop=new Properties();
	
	public MemberDao() {
		try {
			String fileName=MemberDao.class.getResource("./member.properties").getPath();
			prop.load(new FileReader(fileName));
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
	}
	public int insertMember(Connection conn,Member m) {
		PreparedStatement pstmt=null;
		String sql=prop.getProperty("insertMember");
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getMemberId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getMemberName());
			pstmt.setString(4, m.getPhone());
			pstmt.setString(5, m.getEmail());
			result=pstmt.executeUpdate();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
}
	public Member selectOne(Connection conn,Member m)
	{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=prop.getProperty("selectOne");
		Member result=null;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getMemberId());
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				result=new Member();
				result.setMemberId(rs.getString("member_id"));
				result.setPassword(rs.getString("password"));
				result.setMemberName(rs.getString("member_name"));
				result.setEmail(rs.getString("email"));
				result.setPhone(rs.getString("phone"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	public int updateMember(Connection conn,Member m) {
		PreparedStatement pstmt=null;
		String sql=prop.getProperty("updateMember");
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getMemberName());
			pstmt.setString(2, m.getEmail());
			pstmt.setString(3, m.getPhone());
			pstmt.setString(4, m.getMemberId());
			result=pstmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	public int updatePassword(Connection conn, Member m) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updatePassword");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getPassword());
			pstmt.setString(2, m.getMemberId());
			result=pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	public int deleteMember(Connection conn, String memberId) {
		PreparedStatement pstmt=null;
		String sql=prop.getProperty("deleteMember");
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			result=pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	public Member FindId(Connection conn,Member m)
	{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=prop.getProperty("findId");
		Member result=null;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getMemberName());
			pstmt.setString(2, m.getEmail());
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				result=new Member();
				result.setMemberId(rs.getString("member_id"));
				result.setMemberName(rs.getString("member_name"));
				result.setEmail(rs.getString("email"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	public int PwFindChange(Connection conn, Member m) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("PwFindChange");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getPassword());
			pstmt.setString(2, m.getMemberId());
			pstmt.setString(3, m.getEmail());
			result=pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	public Member FindPw(Connection conn,Member m)
	{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=prop.getProperty("findPw");
		Member result=null;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getMemberId());
			pstmt.setString(2, m.getEmail());
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				result=new Member();
				result.setMemberId(rs.getString("member_id"));
				result.setEmail(rs.getString("email"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
}
