package com.mi.group.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mi.event.model.dao.EventDao;
import com.mi.group.model.vo.Group;
import static common.JDBCTemplate.close;
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
	
}
