package com.mi.group.model.vo;

public class GroupByMember {

	private String groupId;
	private String memberId;
	
	public GroupByMember() {
		// TODO Auto-generated constructor stub
	}

	public GroupByMember(String groupId, String memberId) {
		super();
		this.groupId = groupId;
		this.memberId = memberId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "GroupByMember [groupId=" + groupId + ", memberId=" + memberId + "]";
	}
	
	
}
