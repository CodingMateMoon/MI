<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.mi.event.model.vo.Event"%>
<%@page import="java.util.List"%>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<%
	String eventId = (String) request.getAttribute("eventId");
	//	parameter는 String형식으로 전달하고 받는다 / int형은 integer.parseInt로 바꿈
	List<Event> list = (List<Event>) request.getAttribute("list");
%>

<%@ include file="/views/common/header.jsp"%>
<style>
div.inline {
	display: inline-block;
}

#d1 {
	background-color: lavender;
	position: absolute;
	width: 30%;
	height: 70%;
	margin-left: 5px
}

#d2 {
	background-color: lightgoldenrodyellow;
	position: absolute;
	width: 50%;
	height: 70%;
	margin-left: 300px;
}

.view {
	cursor: pointer;
}
a{
	color:black;
	text-decoration:none;
}
table#list{
	margin-bottom:10px;
	width:100%;
}

</style>


<script>
		function fn_detailAdd(){
			location.href="<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>";
		}
		// div(id='d1')안에 td(view클래스)를 클릭했을 때 발생하는 이벤트 - ajax
		$(function(){
			$('.view').on('click',function(){
				console.log($(this));
				$.ajax({
					url:"<%=request.getContextPath()%>/detail/ajaxView.do",
					type : "post",
					dataType:"json",
				//key : value형식 데이터와 함께 서버에 요청을 보냄
					data : {"eventId" : $(this).siblings("input").val()},
				// 서블릿이 응답해서 건네주는 부분
					success : function(data) {
						var tr=$("<tr></tr>");
						var th="<th>제목</th>";
							th+="<th>시작일자</th>";
							th+="<th>끝일자</th>";
							th+="<th>내용</th>";
							if((Object.keys(data)).includes("filePath")){
								th+="<th>첨부파일</th>";
								/*이미지 파일일때는 이미지를 출력해주기
								if(){
									
								}*/
							}
							th+="<th>작성자</th>";
							tr.html(th);	
						$('#list').html(tr);
						var eventCode=data['eventId'];
						var tr2=$("<tr></tr>");
						for(var a in data){
							var td="";
							if(a=="filePath"){
							 	td=$("<td></td>");
							 	td.append($("<a href='<%=request.getContextPath()%>/fileDownLoad'>"+data[a]+"</a>"));
							}
							else if(a=="eventId")
							{
								continue;
							}
							else {
								td=$("<td>"+data[a]+"</td>");
							}
							tr2.append(td);
						}
						$('#list').append(tr2);
						var commentArea=$("<textarea cols='50' rows='3' name='comment' id='commentArea'></textarea>");
						var button=$("<button class='comment-btn'></button>").html("댓글등록");
						$('#commentContainer').html(commentArea.append(commentList));
						$('#commentArea').after(button);
						var commentList=$("<ul id='commentList'></ul>");
						fn_commentEvent(eventCode);
				}
			});
		});
	});
		function fn_commentEvent(eventCode)
		{
			$.ajax({
				
				success:function(data){
					var commentList=$('#commentList');
					var li=$()
				}
			});
		}
</script>

<%
	if (loginMember != null) {
%>
<input type="button" value="등록" id="btn-add" onclick="fn_detailAdd()" />
<input type="button" value="삭제" id="btn-del" onclick="fn_detailDelete()" />

<%
	}
%>
<div id="container" style="overflow: auto;">
	<div id="d1" style="overflow: auto;">
		<!-- 제목을 눌렀을 때 ajax통신으로 아래에 받아주면 됨 -->
		<table>
			<tr>
				<th>시작날짜</th>
				<th>일정제목</th>
			</tr>
			<%
				for (Event e : list) {
			%>
			<tr>
				<td><%=e.getStartDate()%></td>
				<td class="view"><b><%=e.getTitle()%></b></td>
				<input type="hidden" value="<%=e.getEventId() %>"/>
			</tr>
			<%
				}
			%>
		</table>
	</div>

	<div id='d2'>
		<table id="list">	
		</table>
		<div id="commentContainer">
		</div>
	</div>
</div>



<%@ include file="/views/common/footer.jsp"%>