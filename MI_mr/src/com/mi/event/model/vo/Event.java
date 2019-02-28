package com.mi.event.model.vo;

import java.sql.Date;
import java.util.List;

public class Event {
	private String eventId;
	private String title;
	private Date startDate;
	private Date endDate;
	private String groupId;
	private String memo;
	private String filePath;
	private String prepairingId;
	
	public Event() {
		// TODO Auto-generated constructor stub
	}

	public Event(String eventId, String title, Date startDate, Date endDate, String groupId, String memo,
			String filePath, String prepairingId) {
		super();
		this.eventId = eventId;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.groupId = groupId;
		this.memo = memo;
		this.filePath = filePath;
		this.prepairingId = prepairingId;
	}

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getPrepairingId() {
		return prepairingId;
	}

	public void setPrepairingId(String prepairingId) {
		this.prepairingId = prepairingId;
	}

	@Override
	public String toString() {
		return "Event [eventId=" + eventId + ", title=" + title + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", groupId=" + groupId + ", memo=" + memo + ", filePath=" + filePath + ", prepairingId="
				+ prepairingId + "]";
	}

	
	
}
