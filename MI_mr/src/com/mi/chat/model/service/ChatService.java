package com.mi.chat.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.mi.chat.model.dao.ChatDao;
import com.mi.chat.model.vo.Chat;
import com.mi.chat.model.vo.Chatroom;
import com.mi.chat.model.vo.ChatroomByMember;

public class ChatService {
	
	private ChatDao dao = new ChatDao();

	public List<Chatroom> selectAllChatroom(String memberId) {
		Connection conn = getConnection();
		List<Chatroom> list = dao.selectAllChatroom(conn, memberId);
		close(conn);
		return list;
	}
	
	public List<ChatroomByMember> selectAllChatroomByMember(String memberId) {
		Connection conn = getConnection();
		List<ChatroomByMember> cbmList = dao.selectAllChatroomByMember(conn, memberId);
		close(conn);
		return cbmList;
	}
	
	public List<Chat> selectAllChat(int chatroomId) {
		Connection conn = getConnection();
		List<Chat> list = dao.selectAllChat(conn, chatroomId);
		close(conn);
		return list;
	}
	
	public int insertChat(Chat c) {
		Connection conn = getConnection();
		int result = dao.insertChat(conn, c);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int addChatroom(int chatroomId, String chatroomName, String admin) {
		Connection conn = getConnection();
		int result = dao.addChatroom(conn, chatroomId, chatroomName, admin);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int findLastChatroomId() {
		Connection conn = getConnection();
		int result = dao.findLastChatroomId(conn);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int addChatroomByMember(int chatroomId, String[] members, String admin) {
		Connection conn = getConnection();
		int result = dao.addChatroomByMember(conn, chatroomId, members, admin);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}
