<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mi.event.model.vo.Event"%>
<%@page import="java.util.List"%>
    
<%  
	String eventId=(String)request.getAttribute("eventId");
//	parameter는 String형식으로 전달하고 받는다 / int형은 integer.parseInt로 바꿈
	List<Event> list=(List<Event>)request.getAttribute("list");
	
%>

<%@ include file="/views/common/header.jsp" %>
	<script>
		function fn_detailForm(){
			location.href="<%=request.getContextPath()%>/detail/detailForm";
		}
	</script>
	
	<%if(loginMember!=null){ %>
	<input type="button" value="등록" id="btn-add" onclick="fn_detailForm()" />
	<%} %>
	
		<table>
			<tr>
				<th>일정이름</th>
				<th>일정제목</th>
				<th>시작날짜</th>
				<th>끝날짜</th>
				<th>그룹아이디</th>
				<th>일정내용</th>
				<th>첨부파일</th>
				<th>작성자</th>
			</tr>
		<%for(Event e : list){ %>
			<tr>
				<td><%=e.getEventId() %></td>
				<td><%=e.getTitle() %></td>
				<td><%=e.getStartDate() %></td>
				<td><%=e.getEndDate() %></td>
				<td><%=e.getGroupId() %></td>
				<td><%=e.getMemo() %></td>
				<td>
				<%if(e.getFilePath()!=null){ %>
					<img alt='클립' src="<%=request.getContextPath()%>/image/clip.jpg" width='13px'>
				<%} %>
				</td>
				<td><%=e.getPrepairingId() %></td>
			</tr>
			
			<%} %>
		</table>
	



<%@ include file="/views/common/footer.jsp" %>