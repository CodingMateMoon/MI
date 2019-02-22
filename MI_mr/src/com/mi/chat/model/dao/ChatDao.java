package com.mi.chat.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mi.chat.model.vo.Chat;
import com.mi.chat.model.vo.Chatroom;

public class ChatDao {
	
	Properties prop = new Properties();
	
	public ChatDao() {
		String fileName = ChatDao.class.getResource("/sql/chat/chat-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Chatroom> selectAllChatroom(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = prop.getProperty("selectAllChatroom");
		List<Chatroom> list = new ArrayList<Chatroom>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Chatroom room = new Chatroom();
				room.setChatroomId(rs.getInt("chatroom_id"));
				room.setChatroomName(rs.getString("chatroom_name"));
				room.setChatroomAdmin(rs.getString("chatroom_admin"));
				list.add(room);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
//	selectAllChat = SELECT MEMBER_ID, MEMBER_NAME, CHAT_CONTENT, CHATROOM_ID, TO_CHAR(CHAT_TIME, 'RRRR-MM-DD HH24:MI:SS') AS TIME FROM CHAT JOIN MEMBER USING(MEMBER_ID) WHERE CHATROOM_ID = ? ORDER BY TIME;
	public List<Chat> selectAllChat(Connection conn, int chatroomId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = prop.getProperty("selectAllChat");
		List<Chat> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chatroomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Chat c = new Chat();
				c.setChatContent(rs.getString("chat_content"));
				c.setChatTime(rs.getString("time"));
				c.setChatroomId(rs.getInt("chatroom_id"));
				c.setMemberId(rs.getString("member_id"));
				c.setMemberName(rs.getString("member_name"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
}
