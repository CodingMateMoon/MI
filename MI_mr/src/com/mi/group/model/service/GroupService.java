package com.mi.group.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.mi.group.model.dao.GroupDao;
import com.mi.group.model.vo.Group;

public class GroupService {
	private GroupDao dao=new GroupDao();
	
	public List<Group> selectAllGroup(String memberId){
		Connection conn=getConnection();
		
		List<Group> groupList=dao.selectAllGroup(conn,memberId);
		close(conn);
		return groupList;
	}
	
	public String selectGroupId(String groupName) {
		Connection conn=getConnection();
		String groupId=dao.selectGroupId(conn,groupName);
		close(conn);
		return groupId;
	}

}
