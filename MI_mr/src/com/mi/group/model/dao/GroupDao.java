package com.mi.group.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}
