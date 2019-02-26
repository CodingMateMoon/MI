package com.mi.comment.model.vo;

import java.io.Serializable;
import java.util.Date;

//서블릿상에서 주고받는 데이터가 있는 객체들은 Serializable(직렬화)을 해줘야함
public class EventComment implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7162396369414443643L;
	private int eventCommentNo;
	private int eventCommentLevel;
	private String eventCommentWriter;
	private String eventCommentContent;
	private String eventRef;
	private int eventCommentRef;
	private Date eventCommentDate;
	
	public EventComment() {
		// TODO Auto-generated constructor stub
	}
	
	public EventComment(int eventCommentNo, int eventCommentLevel, String eventCommentWriter,
			String eventCommentContent, String eventRef, int eventCommentRef, Date eventCommentDate) {
		super();
		this.eventCommentNo = eventCommentNo;
		this.eventCommentLevel = eventCommentLevel;
		this.eventCommentWriter = eventCommentWriter;
		this.eventCommentContent = eventCommentContent;
		this.eventRef = eventRef;
		this.eventCommentRef = eventCommentRef;
		this.eventCommentDate = eventCommentDate;
	}


	public int getEventCommentNo() {
		return eventCommentNo;
	}

	public void setEventCommentNo(int eventCommentNo) {
		this.eventCommentNo = eventCommentNo;
	}

	public int getEventCommentLevel() {
		return eventCommentLevel;
	}

	public void setEventCommentLevel(int eventCommentLevel) {
		this.eventCommentLevel = eventCommentLevel;
	}

	public String getEventCommentWriter() {
		return eventCommentWriter;
	}

	public void setEventCommentWriter(String eventCommentWriter) {
		this.eventCommentWriter = eventCommentWriter;
	}

	public String getEventCommentContent() {
		return eventCommentContent;
	}

	public void setEventCommentContent(String eventCommentContent) {
		this.eventCommentContent = eventCommentContent;
	}

	public String getEventRef() {
		return eventRef;
	}

	public void setEventRef(String eventRef) {
		this.eventRef = eventRef;
	}

	public int getEventCommentRef() {
		return eventCommentRef;
	}

	public void setEventCommentRef(int eventCommentRef) {
		this.eventCommentRef = eventCommentRef;
	}

	public Date getEventCommentDate() {
		return eventCommentDate;
	}

	public void setEventCommentDate(Date eventCommentDate) {
		this.eventCommentDate = eventCommentDate;
	}



	@Override
	public String toString() {
		return "EventComment [eventCommentNo=" + eventCommentNo + ", eventCommentLevel=" + eventCommentLevel
				+ ", eventCommentWriter=" + eventCommentWriter + ", eventCommentContent=" + eventCommentContent
				+ ", eventRef=" + eventRef + ", eventCommentRef=" + eventCommentRef + ", eventCommentDate="
				+ eventCommentDate + "]";
	}
	
	
	

}
