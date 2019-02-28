package com.mi.chat.model.vo;

public class ChatroomByMember {
	private String memberId, memberName, chatroomId;
	
	public ChatroomByMember() {
		// TODO Auto-generated constructor stub
	}

	public ChatroomByMember(String memberId, String memberName, String chatroomId) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
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

	public String getChatroomId() {
		return chatroomId;
	}

	public void setChatroomId(String chatroomId) {
		this.chatroomId = chatroomId;
	}

	@Override
	public String toString() {
		return "ChatroomByMember [memberId=" + memberId + ", memberName=" + memberName + ", chatroomId=" + chatroomId
				+ "]";
	}

}
