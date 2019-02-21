<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.mi.chat.model.vo.Chatroom"%>
<%@ include file="/views/common/header.jsp" %>
<% List<Chatroom> list =  (List<Chatroom>) request.getAttribute("list"); %>
<style>
 #teduri{
	/* position: relative; */
	/* width: 50%;
	height: 50%;
	top: 10%;
	margin:0 auto; */
	
	/* border: 2px solid red; */
	overflow: scroll;
  }
 
 #glist
 {
 	overflow-x:hidden;
 	width: 300px;
 	height: 400px;
 	border: 2px solid blue;
 }
 #changeView{
 	width:350px;
 	height: 400px;
 	border: 2px solid yellow;
 }
 .inline
 {
 	display: inline-block;
 	/* margin: 1em; */
 }
 #gth{
 	width:290px;
 	height : 40px;
 	font-size: 1.5em;
 }
 
 table#chatTable {
 	position: relative;
	width: 50%;
	height: 50%;
	
	margin: 5% auto;
 	text-align: center;
 	border:1px solid black; 
 	border-collapse:collapse;
 	
 }
 
 table#chatTable tr td{
 	border:1px solid black;
 }
</style>
	<div id="teduri">
		<table id="chatTable">
			<tr id="gtr">
				<th id="gth">채팅 목록</th>
			</tr>
			
			<tr>
				<td align='right' cellpadding=0 cellspacing=0 >
					<img src="<%=request.getContextPath() %>/views/image/plus.png" width="30px" id="plus"/>
				</td>
			</tr>
			
			<%for (Chatroom room : list) { %>
			<tr class="chatroom">
				<td >
					<%=room.getChatroomName() %>
				</td>
				<input type="hidden" value="<%=room.getChatroomId()%>"/>
			</tr>
			
			<%} %>
			<tr>
				<td>Test</td>
			<tr>
				
		</table>
	</div>
	<script>
		$(".chatroom").click(function(){
			console.log($(this).children("td").text());
			console.log($(this).children("input").val());
		})
	</script>
<%@ include file="/views/common/footer.jsp" %>