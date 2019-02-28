package com.mi.chat.model.vo;

public class ChatroomByMember {
	private String memberId, chatroomId;
	
	public ChatroomByMember() {
		// TODO Auto-generated constructor stub
	}

	public ChatroomByMember(String memberId, String chatroomId) {
		super();
		this.memberId = memberId;
		this.chatroomId = chatroomId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getChatroomId() {
		return chatroomId;
	}

	public void setChatroomId(String chatroomId) {
		this.chatroomId = chatroomId;
	}
	
	
}
