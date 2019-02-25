package com.mi.chat.model.vo;

public class Chatroom {

	private int chatroomId;
	private String chatroomName, chatroomAdmin;

	public Chatroom() {
		// TODO Auto-generated constructor stub
	}

	public Chatroom(int chatroomId, String chatroomName, String chatroomAdmin) {
		super();
		this.chatroomId = chatroomId;
		this.chatroomName = chatroomName;
		this.chatroomAdmin = chatroomAdmin;
	}

	public int getChatroomId() {
		return chatroomId;
	}

	public void setChatroomId(int chatroomId) {
		this.chatroomId = chatroomId;
	}

	public String getChatroomName() {
		return chatroomName;
	}

	public void setChatroomName(String chatroomName) {
		this.chatroomName = chatroomName;
	}

	public String getChatroomAdmin() {
		return chatroomAdmin;
	}

	public void setChatroomAdmin(String chatroomAdmin) {
		this.chatroomAdmin = chatroomAdmin;
	}

	@Override
	public String toString() {
		return "Chatroom [chatroomId=" + chatroomId + ", chatroomName=" + chatroomName + ", chatroomAdmin="
				+ chatroomAdmin + "]";
	}
	
	
}
