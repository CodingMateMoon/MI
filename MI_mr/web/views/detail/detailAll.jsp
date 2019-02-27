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
div.inline {display: inline-block;}
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
.view {cursor: pointer;}
a{color:black;text-decoration:none;}
table#list{margin-bottom:10px;width:100%;}
</style>



<%if (loginMember != null) {%>
<input type="button" value="등록" id="btn-add" onclick="fn_detailAdd()" />
<input type="button" value="삭제" id="btn-del" onclick="fn_detailDelete()" />
<%}%>
<div id="container" style="overflow: auto;">
	<div id="d1" style="overflow: auto;">
		<!-- 제목을 눌렀을 때 ajax통신으로 아래에 받아주면 됨 -->
		<table>
			<tr>
				<th>시작날짜</th>
				<th>일정제목</th>
			</tr>
			<%	for (Event e : list) {	%>
			<tr>
				<td><%=e.getStartDate()%></td>
				<td class="view"><b><%=e.getTitle()%></b></td>
				<input type="hidden" value="<%=e.getEventId() %>"/>
			</tr>
			<%}	%>
		</table>
	</div>

	<div id='d2'>
		<table id="list">	
		</table>
		<div id="commentContainer">
		</div>
	</div>
</div>

<script>
		var eventId="";

		function fn_detailAdd(){
			location.href="<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>";
		}
		// div(id='d1')안에 td(view클래스)를 클릭했을 때 발생하는 이벤트 - ajax
		$(function(){
			$('.view').on('click',function(){
				console.log($(this));
				eventId=$(this).siblings("input").val();
			//	console.log("상세일정"+eventId);
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
					//true일때 태그가 생성되고 false일땐 태그 생성 x 즉, 값이 있을땐 태그 생성 없을땐 생성 x
							if((Object.keys(data)).includes("groupId")){
								th+="<th>그룹</th>";
							}
							//console.log((Object.keys(data)).includes("memo"));
							if((Object.keys(data)).includes("memo")){
								th+="<th>내용</th>";
							}
								
								console.log("data check : "+(Object.keys(data)));
								console.log((Object.keys(data)).includes("filePath"));
							
								if((Object.keys(data)).includes("filePath")){
								console.log(data["filePath"]);
								th+="<th>첨부파일</th>";

								var filePath=data['filePath'];
								var fileSplit=filePath.split('.');
								var fileValue=filePath.value;
								console.log("변수 테스트(path) : "+filePath);
								console.log("변수 테스트(split) : "+fileSplit);
								console.log("변수 테스트(확장자) : "+fileSplit[1]);
								
								/*이미지 파일일때는 이미지를 출력해주기*/
								
								if(fileSplit[1]=="jpg"&&fileSplit[1]=="png"){
							//split으로 나눈 파일경로들을 배열로 저장한 후 파일들이 사진인지 검사해서 다시 저장하고 출력
							//		var file[]=filePath;
							
								}
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
							 	console.log('<%=request.getContextPath()%>/fileDownLoad?filePath='+data[a]);
							 	//key:value형식으로 된 객체안에     a가 key값,  data[a]가 변수안에 들어있는 value값 
							 	td.append($("<a href='<%=request.getContextPath()%>/fileDownLoad?filePath="+data[a]+"'>"+data[a]+"</a>")); 
							}
							else if(a=="eventId")
							{	//eventId를 key로 했을 때 eventId에 맵핑된 값을 가져와야함
								td=$("<input type='hidden' id='eventId' value='"+data[a]+"'>");
								
								//continue;
							}
							else {
								td=$("<td>"+data[a]+"</td>");
							}
							tr2.append(td);
						}
						$('#list').append(tr2);
						var commentArea=$("<textarea cols='50' rows='3' name='comment' id='commentArea'></textarea>");
						var button=$("<button class='comment-btn'></button>").html("댓글등록");	
						//var button=$("<button class='comment-btn'></button>").html("댓글삭제");
						$('#commentContainer').html(commentArea.append(commentList));
						$('#commentArea').after(button);
						var commentList=$("<ul id='commentList'></ul>");
						//fn_commentEvent(eventCode);
						
				}
			});
		});
	});
			
			$(document).on('click',".comment-btn", function(){
				console.log("댓글등록버튼클릭");
				fn_commentInsert();
			});
			
				//fn_commentDelete();
		//댓글 등록 구현
		function fn_commentInsert(eventCode)
		{
			$.ajax({
				url:"<%=request.getContextPath()%>/commentInsert",
				type : "post",
				dataType:"json",
				data : {"eventCommentLevel" : 1,"eventCommentWriter" : "<%=loginMember.getMemberId()%>",
					"eventCommentContent" : $("#commentArea").val(), "eventCommentRef" : 0
					, "eventRef" : eventId},
				/* server에서 request.getParameter("commentLevel") 하면 값 넣어준 1이 들어옴 */
				success:function(data){
					console.log("댓글"+data);
					var commentList=$('#commentList');
					var li=$("<li></li>");
				}
			});
		} 
		
		//댓글 삭제 구현
		function fn_commentDelete(eventCode)
		{
			$.ajax({
				url:"<%=request.getContextPath()%>/commentDelete",
				type : "post",
				dataType:"json",
				//서버에다가 넘겨주는 것
				data : { "eventId" : $('#eventId').val() 
				},
				success:function(data){
					var commentList=$('#commentList');
					var li=$();
				}
			});
		}  
</script>
<%@ include file="/views/common/footer.jsp"%>