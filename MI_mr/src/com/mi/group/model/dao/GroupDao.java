package com.mi.group.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mi.event.model.dao.EventDao;
import com.mi.group.model.vo.Group;
import com.mi.group.model.vo.GroupByMember;
public class GroupDao {
	private Properties prop=new Properties();
	
	public GroupDao() {
		try {
			String fileName=EventDao.class.getResource("/sql/group/group-query.properties").getPath();
			prop.load(new FileReader(fileName));
		}catch(Exception e) {e.printStackTrace();}
	}
	public List<Group> selectAllGroup(Connection conn, String memberId){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=prop.getProperty("selectAllGroup");
		List<Group> list=new ArrayList<Group>();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Group g=new Group();
				g.setGroupId(rs.getString("group_id"));
				g.setGroupName(rs.getString("group_name"));
				g.setGroupCaptin(rs.getString("group_captin"));
				list.add(g);
			}
		}catch(Exception e) {e.printStackTrace();}
		finally {
			close(rs);
		}
		return list;
	}
	
	public List<GroupByMember> groupMemberList(Connection conn,String groupId)
	{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=prop.getProperty("groupMemberList");
		List<GroupByMember> list=new ArrayList<GroupByMember>();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, groupId);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				GroupByMember gbm=new GroupByMember();
				/* gbm.setGroupId(rs.getString("group_id")); */
				gbm.setMemberId(rs.getString("member_id"));
				list.add(gbm);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	
	
	public List<String> selectId(Connection conn, String search)
	{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<String> list=new ArrayList();
		String sql=prop.getProperty("selectUserId");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				list.add(rs.getString("member_id"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try {
				rs.close();
				pstmt.close();
				conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int deleteGroup(Connection conn, String groupId)
	{
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteGroup");
		try
		{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, groupId);
			result=pstmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			close(pstmt);
		}
		return result;
	}
	
	public int addGroup(Connection conn, String gName,String[] members)
	{
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("addGroup");
		try
		{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gName);
			pstmt.setString(2, members[0]);
			result=pstmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		finally
		{
			close(pstmt);
		}
		
		return result;
	}
	
	public int addGroupMember(Connection conn, String gName, String[] members)
	{
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("addGroupMember");
		try
		{
			for(String s : members) {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gName);
			pstmt.setString(2, s);
			result=pstmt.executeUpdate();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		finally
		{
			close(pstmt);
		}
		
		return result;
	}
	
	public int memberUpdate(Connection conn, String groupId, String[] members)
	{
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateMember");
		try
		{
			for(String s : members) {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, groupId);
			pstmt.setString(2, s);
			result=pstmt.executeUpdate();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		finally
		{
			close(pstmt);
		}
		
		return result;
	}
	
	 public String selectGroupId(Connection conn, String groupName) {
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      String sql=prop.getProperty("selectGroupId");
	      String groupId="";
	      try {
	         pstmt=conn.prepareStatement(sql);
	         pstmt.setString(1, groupName);
	         rs=pstmt.executeQuery();
	         while(rs.next()){
	            groupId=rs.getString("group_id");
	         }
	      }catch(Exception e) {e.printStackTrace();}
	      finally {
	         close(rs);
	      }
	      return groupId;
	   }
	 
	 public String findLastGroupId(Connection conn) {
		 PreparedStatement pstmt = null;
		 String result = null;
		 ResultSet rs = null;
		 String sql = prop.getProperty("findLastGroupId");
		 try {
			 pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 if (rs.next()) {
				 result = rs.getString(1);
			 }
		 } catch (SQLException e) {
			 e.printStackTrace();
		 } finally {
			 close(rs);
			 close(pstmt);
		 }
		 return result;
	 }

}
