<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.mi.chat.model.vo.Chat, com.mi.member.model.vo.Member"%>
<!DOCTYPE html>
<html>
<head>
<% 
	List<Chat> list = (List<Chat>) request.getAttribute("list"); 
	int chatroomId = Integer.parseInt(request.getParameter("chatroomId"));
	System.out.println("chatroomId : " + chatroomId);
  	Member loginMember = (Member) session.getAttribute("loginMember");
  	
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/chatroom.css">
<title>JSP Ajax 실시간 채팅</title>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>채팅방</title>
</head>
<style>

	div#chatroomBorder {
		overflow: scroll;
	}
	#sender { padding: 3px; position: fixed; bottom: 0; width: 100%;}
      
	#messageText{
		border: 1px solid blue; padding: 10px; width: 90%; margin-right: .5%;
	}
	
	/* #send {
		width: 9%; background: rgb(130, 224, 255); border: none; padding: 10px;
	} */
	
	
</style>
<script>
	$(function(){
		
		<%for (Chat c : list) {
			 String tempContent = c.getChatContent();
			 // tempContent = tempContent.replaceAll("′","'"); // 치환된 작은따옴표 원래 작은따옴표로 환원처리
			 tempContent = tempContent.replaceAll("\n","<br>"); // 줄바꿈처리
			 tempContent = tempContent.replaceAll("\u0020","&nbsp;"); // 스페이스바로 띄운 공백처리
		%>
		addChat('<%=c.getMemberName()%>', '<%=tempContent%>','<%=c.getChatTime()%>');
		<%} %>
	});
</script>
<body>
	
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4><i class="fa fa-circle text-green">실시간 채팅창</i></h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
						</div>
						<div class="portlet-footer">
							<!-- <div class="row">
								<div class="form-group col-xs-4">
									<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">
								</div>
							</div> -->
							<div class="row" style="height: 90px;">
								<div class="form-group col-xs-10">
									<textarea style="height: 80px;" id="messageText" class="form-control" placeholder="메세지를 입력하세요." maxlength="100"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" id="send" class="btn btn-default pull-right" onclick="sendMessage();">전송</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%-- <div id="chatroomBorder">
		<table id="chatroom">
		<%for (Chat c : list) {%>
		<tr>
			<td><%=c.getMemberName() %></td>
			<td><%=c.getChatContent() %></td>
			<td><%=c.getChatTime() %></td>
		</tr>
		<%} %>
		</table>
	</div> --%>
	
    <!-- <div id="sender">
	    송신 메시지 텍스트박스
	    <input type="text" id="messageText" size="50" />
	    송신 버튼
	    <input type="button" value="Send" onclick="sendMessage()" id="send"/>
	</div> -->
	
	
	<% if (loginMember != null) { %>
    <script type="text/javascript">
    
        //웹소켓 초기화
        var url = "ws://" + document.location.host +"/MI_mr/broadsocket?username=<%=loginMember.getMemberId()%>";
        console.log(url);
        var webSocket = new WebSocket(url);
        <%-- var webSocket = new WebSocket("ws://localhost:9090/MI_mr/broadsocket?username=<%=loginMember.getMemberId()%>"); --%>
        var messageTextArea = document.getElementById("messageTextArea");
        //메시지가 오면 messageTextArea요소에 메시지를 추가한다.
        webSocket.onmessage = function processMessge(message){
        	console.log(message);
        	/*
        	MessageEvent
				bubbles: false
				cancelBubble: false
				cancelable: false
				composed: false
				currentTarget: WebSocket {url: "ws://localhost:9090/MI_mr/broadsocket?username=miri", readyState: 1, bufferedAmount: 0, onopen: null, onerror: null, …}
				data: "{"username":"miri","message":"sadf"}"
				defaultPrevented: false
				eventPhase: 0
				isTrusted: true
				lastEventId: ""
				origin: "ws://localhost:9090"
        	*/
            //Json 풀기
            var jsonData = JSON.parse(message.data);
        	console.log(jsonData.chatroomId + " : " + <%=chatroomId%>);
        	if (jsonData.chatroomId == <%=chatroomId%>) {
	           	switch(jsonData.type) {
	           	case "message":
	           		var lastTr = $("#chatroom tr:last-child");
	           		console.log(lastTr);
	           		addChat(jsonData.name, jsonData.content, jsonData.time);
	           	}
        	}
        }
        //메시지 보내기
        function sendMessage(){
            var messageText = document.getElementById("messageText");
            // ajax 활용 chat 데이터 insert, type: message/alarm 중 message로 데이터 전송
            webSocket.send(JSON.stringify({"type" : "message", "chatroomId" : <%=chatroomId%>,"name" : "<%=loginMember.getMemberName()%>","content" : messageText.value, "time" : getTimeStamp()}));
            $.ajax({
				url: "<%=request.getContextPath()%>/insertChat",
				type: "post",
				data: {"chatContent" : messageText.value, "chatroomId" : <%=chatroomId%>, "memberId" : "<%=loginMember.getMemberId()%>"},
				
				success: function(data) {
					console.log(data); 
					// 서버에서 인코딩한 뒤 보낸 데이터 : %EC%9C%A0%EB%B3%91%EC%8A%B9 
					// console.log(data['userId']);
					// 서버에서 인코딩한 뒤 보낸 데이터를 decode 처리 : 유병승
					//console.log(decodeURI(data['userId']));
					/* console.log(data.name + " type : " + typeof data.name);
					console.log(data.height + " type : " + typeof data.height);
					console.log(data.weight + " type : " + typeof data.weight); */
					/* var user = "";
					for (var i = 0; i < data.length; i++) {
						console.log(data[i]);
						
						 for (var a in data[i]) {
							console.log(a + " : " + data[i][a]);
							user += a + " : " + data[i][a] + "\n";
						 } 
					}
					$("#mydiv").html(user); */
				}
			});
            messageText.value = "";
        }
        
        $("#messageText").keyup(function(){
        	if (event.key == "Enter") {
        		$("#send").trigger("click");
        	}
        });
        
        function getTimeStamp() {
        	  var d = new Date();

        	  var s =
        	    leadingZeros(d.getFullYear(), 4) + '-' +
        	    leadingZeros(d.getMonth() + 1, 2) + '-' +
        	    leadingZeros(d.getDate(), 2) + ' ' +
        	    leadingZeros(d.getHours(), 2) + ':' +
        	    leadingZeros(d.getMinutes(), 2) + ':' +
      	 	    leadingZeros(d.getSeconds(), 2);

        	  return s;
        }

       	function leadingZeros(n, digits) {
       	  var zero = '';
       	  n = n.toString();
       	  if (n.length < digits) {
       	    for (i = 0; i < digits - n.length; i++)
       	      zero += '0';
       	  }
       	  
       	  return zero + n;
       	}
    </script>
    <%} %>
	
	<script>
	function addChat2(name, content, time) {
		/* 스크롤바 위치 위에서부터 scrollHeight만큼 내림
		$("#chatroomBorder").scrollTop($("#chatroomBorder")[0].scrollHeight); */ 
		var newTr = $("<tr></tr>");
   		var html = "<td>" + name + "</td>";
   		html += "<td>" + content + "</td>";
   		html += "<td>" + time + "</td>";
   		newTr.html(html)
   		$("#chatroom").append(newTr);
   		/* var scrollPosition = $("#send").offset().top; */
   		/* document.body.scrollTop = document.body.scrollHeight; */
   		$("#chatroomBorder").scrollTop($("#chatroomBorder")[0].scrollHeight);
	}
	
	function addChat(chatName, chatContent, chatTime){
		$("#chatList").append('<div class="row">' +
			'<div class="col-lg-12">' +
			'<div class="media">' +
			'<a class="pull-left" href="#">' +
			'<img class="media-object" img-circle" style="width:30px; height: 30px" src="views/image/icon.png" alt="">' +
			'</a>' +
			'<div class="media-body">' +
			'<h4 class="media-heading">' +
			chatName +
			'<span class="small pull-right">' +
			chatTime +
			'</span>' +
			'</h4>' +
			'<p>' +
			chatContent +
			'</p>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<hr>');
		
	$("#chatList").scrollTop($("#chatList")[0].scrollHeight); 
	}
	
	</script>
</body>
</html>