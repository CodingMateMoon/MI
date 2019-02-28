package com.mi.chat.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Chat implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7277890475837822969L;
	/**
	 * 
	 */
	private int chatId;
	private String chatContent;
	private String chatTime;
	private int chatroomId;
	private String memberId;
	private String memberName;
	
	public Chat() {
	}

	public Chat(int chatId, String chatContent, String chatTime, int chatroomId, String memberId) {
		super();
		this.chatId = chatId;
		this.chatContent = chatContent;
		this.chatTime = chatTime;
		this.chatroomId = chatroomId;
		this.memberId = memberId;
	}

	public int getChatId() {
		return chatId;
	}

	public void setChatId(int chatId) {
		this.chatId = chatId;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	public String getChatTime() {
		return chatTime;
	}

	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}

	public int getChatroomId() {
		return chatroomId;
	}

	public void setChatroomId(int chatroomId) {
		this.chatroomId = chatroomId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	@Override
	public String toString() {
		return "Chat [chatId=" + chatId + ", chatContent=" + chatContent + ", chatTime=" + chatTime + ", chatroomId="
				+ chatroomId + ", memberId=" + memberId +", memberName=" + memberName + "]";
	}
	
}
