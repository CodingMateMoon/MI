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
	background-color: white;
	position: absolute;
	width: 30%;
	height: 70%;
	margin-left: 50px
}

#d2 {
	background-color: white;
	position: absolute;
	width: 70%;
	height: 70%;
	margin-left: 300px;
}

.view {
	cursor: pointer;
}

a {
	color: black;
	text-decoration: none;
}

table#list {
	margin-bottom: 10px;
	width: 100%;
}

table tr td{
      height:30px;
      padding-left:10px;
   }
th {
	text-align: center;
}

td {
	text-align: center;
}

.slide {
	width: 500px;
	height: 330px;
	overflow: hidden;
	position: relative;
	margin: 0 auto;
}

.slide ul {
	width: 5000px;
	position: absolute;
	top: 0;
	left: 0;
	font-size: 0;
}

.slide ul li {
	display: inline-block;
}

#back {
	position: absolute;
	top: 100px;
	left: 0;
	cursor: pointer;
	z-index: 1;
}

#next {
	position: absolute;
	top: 100px;
	right: 0;
	cursor: pointer;
	z-index: 1;
}

#activeTest:active {
	font-weight: bold font-size: 15px;
	color: crimson;
}

#btn-add {
font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  color: white;
  border-radius: 3px;
  width: 80px;
  height:30px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}

form input[type=button] {
	font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  color: white;
  border-radius: 3px;
  width: 80px;
  height:30px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;}
          button{font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  color: white;
  border-radius: 3px;
  width: 80px;
  height:30px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
          } 
</style>


<section>
	<h1
		style="text-align: center; font-family: Merriweather Sans; padding-top: 15px;">SCHEDULE</h1>
	<hr class="divider my-4">
	<%if (loginMember != null) {%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<input type="button" value="일정등록" id="btn-add" onclick="fn_detailAdd()" />
	<button id="btn-del" onclick="fn_detailDelete();">일정삭제</button>
	<%}%>
	<div id="container" style="overflow: auto;">
		<div id="d1"
			style="overflow: auto; margin-right: 10px; margin-bottom: 10px;">
			<!-- 제목을 눌렀을 때 ajax통신으로 아래에 받아주면 됨 -->
			<table>
				<tr>
					<th>시작일</th>
					<th>일정제목</th>
				</tr>
				<%	for (Event e : list) {	%>
				<tr>
					<td><%=e.getStartDate()%></td>
					<td class="view" id="activeTest"><b><%=e.getTitle()%></b></td>
					<input type="hidden" value="<%=e.getEventId() %>" />
				</tr>
				<%}	%>
			</table>
		</div>

		<div id='d2'>
			<table id="list">
			</table>
			<div id="commentContainer"></div>
		</div>
	</div>

	<script>
		var eventId="";
		
		//일정 등록 버튼
		function fn_detailAdd(){
			location.href="<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>";
		}
		
		//일정 삭제 버튼
		function fn_detailDelete(){
			location.href="<%=request.getContextPath()%>/eventDelete?eventId="+eventId;
		}
		
		/* 이미지 슬라이드 정의하기 */
		$(function(){
			 var imgs;
			    var img_count;
			    var img_position = 1;

			    imgs = $(".slide ul");
			    img_count = imgs.children().length;

			    //버튼을 클릭했을 때 함수 실행
			$(document).on('click',".back", function(){
           		 console.log("back버튼클릭");
         });
		
			    /* $('#back').click(function () {
			    	console.log("back");
			      back();
			    }); */
			    $('#next').click(function () {
			    	console.log("next");
			      next();
			    });
			    function back() {
			        if (1 < img_position) {
			          imgs.animate({
			            left: '+=400px'
			          });
			          img_position--;
			        }
			      }
			      function next() {
			        if (img_count > img_position) {
			          imgs.animate({
			            left: '-=400px'
			          });
			          img_position++;
			        }
			      }
		});
		
		// div(id='d1')안에 td(view클래스)를 클릭했을 때 발생하는 이벤트 - ajax
		$(function(){
			$('.view').on('click',function(){
				console.log($(this));
				eventId=$(this).siblings("input").val();
				$.ajax({
					url:"<%=request.getContextPath()%>/detail/ajaxView.do",
					type : "post",
					dataType:"json",
				//key : value형식 데이터와 함께 서버에 요청을 보냄
					data : {"eventId" : $(this).siblings("input").val()},
				// 서블릿이 응답해서 건네주는 부분
					success : function(data) {
						console.log(data);
						var tr=$("<tr></tr>");
						var th="<th>제목</th>";
							th+="<th>시작일</th>";
							th+="<th>마감일</th>";
					//true일때 태그가 생성되고 false일땐 태그 생성 x 즉, 값이 있을땐 태그 생성 없을땐 생성 x
							if((Object.keys(data)).includes("groupId")){
								th+="<th>그룹</th>";
							}
							//console.log((Object.keys(data)).includes("memo"));
							if((Object.keys(data)).includes("memo")){
								th+="<th>내용</th>";
							}
							/*  console.log("data check : "+(Object.keys(data)));
								console.log((Object.keys(data)).includes("filePath")); */
								if((Object.keys(data)).includes("filePath")){
								th+="<th>첨부파일</th>";
								var filePath=data['filePath'];
								
								
								var filePathList =filePath.split(",");
								console.log(filePath);
								var container=$('<div class="slide"></div>');
								var back=$('<img id="back"></img>').attr({"src":"https://cdn.icon-icons.com/icons2/1496/PNG/512/goprevious_103394.png","width":"20"});
								$("#back").click(function(){
									console.log("back");
								});
								var ul=$("<ul></ul>");
								for(var i=0;i<filePathList.length;i++)
								{
									var fileSplit=filePathList[i].indexOf('.');
									//console.log(fileSplit+":"+filePath.length);
									var fileValue=filePathList[i].substr(fileSplit+1,filePathList[i].length);
									console.log("이미지 확장자 : "+fileValue);
									if(fileValue=='jpg'||fileValue=='png'||fileValue=='gif')
									{
										var li1=$("<li></li>");
										var img=$("<img></img>").attr({'width':'500','height':'300','src':'<%=request.getContextPath()%>/upload/event/'+filePathList[i]});
										li1.append(img);
										ul.append(li1);
									}	
								}
								var next=$('<img id="next"></img>').attr({"src":"https://cdn.icon-icons.com/icons2/1496/PNG/512/gonext_103393.png","width":"20"})
								container.append(back).append(next).append(ul);
								$('#list').parent().children('.slide').remove();
								$('#list').after(container);
							/*  console.log("변수 테스트(path) : "+filePath);
								console.log("변수 테스트(split) : "+fileSplit);
								console.log("변수 테스트(확장자) : "+fileSplit[1]); */
								}
							
							th+="<th>작성자</th>";
							tr.html(th);	
							$('#list').html(tr);

							//파일다운로드 관련
						var eventCode=data['eventId'];
						var tr2=$("<tr></tr>");
						
						for(var a in data){
							var td="";
							if(a=="filePath"){
							 	td=$("<td></td>");
							 	console.log('<%=request.getContextPath()%>/fileDownLoad?filePath='+filePathList[0]);
							 	//key:value형식으로 된 객체안에     a가 key값,  data[a]가 변수안에 들어있는 value값 
							 	td.append($("<a href='<%=request.getContextPath()%>/fileDownLoad?filePath="+filePathList[0]+"'>"+filePathList[0]+"</a>")); 
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
						var commentArea=$("<textarea cols='40' rows='1' name='comment' id='commentArea'></textarea>");
						var button=$("<button class='comment-btn'></button>").html("댓글등록");	
						var button1=$("<button class='comment-btn'></button>").html("댓글삭제");
						$('#commentContainer').html(commentArea);
						var commentList=$("<table id='commentList'></table>");
						$('#commentArea').after(commentList).after(button);
						
						fn_eventCommentList(eventId);
				}
			});
		});
	});
			$(document).on('click',".comment-btn", function(){
				console.log("댓글버튼클릭");
				fn_commentInsert();
			});
			
		//댓글 등록 구현
		function fn_commentInsert(eventCode)
		{
			$.ajax({
				url:"<%=request.getContextPath()%>/commentInsert",
				type : "post",
				dataType:"html",
				data : {"eventCommentLevel" : 1,"eventCommentWriter" : "<%=loginMember.getMemberId()%>",
					"eventCommentContent" : $("#commentArea").val(), "eventCommentRef" : 0
					, "eventRef" : eventId },
				/* server에서 request.getParameter("commentLevel") 하면 값 넣어준 1이 들어옴 */
				success:function(data){
					if(data!='1')
					{
						alert("댓글 입력 실패");	
					}
					else{
						alert("댓글 입력 성공");
					fn_eventCommentList(eventId);
					}
				}
			});
		} 
		function fn_eventCommentList(eventId)
		{
			$.ajax({
				url:"<%=request.getContextPath()%>/eventComment/commentList.do",
				data:{"eventId":eventId},
				dataType:"json",
				success:function(data){
					var lis=""
					var title="<tr><th>작성자</th><th>내용</th><th>작성일</th></tr>";
					$('#commentList').html(title);
					for(var i=0;i<data.length;i++)
					{
						var tr=$("<tr></tr>");
						var td="<td>"+data[i]['eventCommentWriter']+"</td>";
						td+="<td>"+data[i]['eventCommentContent']+"</td>";
						td+="<td>"+data[i]['eventCommentDate']+"</td>";
						td+="<td><button class='eventComment' value='"+data[i]['eventCommentNo']+"'>삭제</button></td>";
						tr.append(td);
						
						$('#commentList').append(tr);
					} 
				}
			});
		}
		
		//댓글 삭제 구현
		$(document).on('click','.eventComment', function(e){
			console.log("댓글 삭제 드러왔다~");
							console.log($(this).val());
							console.log(e.target);
							var del = e.target;
						$.ajax({
								url:"<%=request.getContextPath()%>/commentDelete",
				type : "post",
				dataType : "json",
				data : {
					"eventCommentNo" : $(this).val()
				},
				success : function(data) {
					del.parentElement.parentElement.remove();
				},
				error : function() {
					console.log("댓글 error");
				}
			});
		});
	</script>
</section>
<%@ include file="/views/common/footer.jsp"%>