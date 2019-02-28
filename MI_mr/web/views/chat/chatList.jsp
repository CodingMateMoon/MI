<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.mi.chat.model.vo.*"%>
<%@ include file="/views/common/header.jsp" %>
<% 
	List<Chatroom> chatroomList =  (List<Chatroom>) request.getAttribute("list");
	List<ChatroomByMember> cbmList = (List<ChatroomByMember>) request.getAttribute("cbmList");
%>
<style>
#teduri{
/* position: relative; */
/* width: 50%;
height: 50%;
top: 10%;
margin:0 auto; */

/* border: 2px solid red; */
overflow: auto;
 }
 
.roomListBorder {
	width: 800px;
	margin: 0 auto;
	/* margin-top: 50px; */
}

.roomBorder {
    width: 250px;
    background: #0F1012;
    color: #f9f9f9;
    float: left;
    border-radius: 5%;
    margin: 1%;
    text-align: center;
}

.deal {
    padding: 10px 0 0 0;
}

.deal span {
    display: block;
    text-align: center;
}

.deal span:first-of-type {
    font-size: 23px;
}

.deal span:last-of-type {
    font-size: 13px;
}

.roomBorder .roomName {
    display: block;
    width: 250px;
    background: #292b2e;
    margin: 15px 0 10px 0;
    text-align: center;
    font-size: 23px;
    padding: 17px 0 17px 0;
}


ul {
    display: block;
    margin: 20px 0 10px 0;
    padding: 0;
    list-style-type: none;
    text-align: center;
    color: #999999;
}

li {
    display: block;
    margin: 10px 0 0 0;
}

button {
    border: none;
    border-radius: 40px;
    background: #292b2e;
    color: #f9f9f9;
    padding: 10px 37px;
    margin-bottom: 5%;
    /* margin: 10px 0 20px 60px; */
    /* text-align: center; */
}

#imageContainer {
            margin: 0 auto;
        }
#plus {
   
    margin-left:100px;
    margin-top: 3%;
    /* margin-top: 20%; */
}
</style>
	<div id="teduri">
		<div id="imgContainer">
			<img src="<%=request.getContextPath() %>/views/image/plus.png" onclick="addChatroom();" width="30px" id="plus"/>
        </div>
        <div class="roomListBorder">
            <%for (Chatroom room : chatroomList) { 
            int count = 0;
            boolean flag = true;
            %>
			<div class="roomBorder">
                <span class="roomName"><%=room.getChatroomName() %></span>
                <ul class="memberList">
                <%for (ChatroomByMember cbm : cbmList) {
                	if (cbm.getChatroomId() == room.getChatroomId()) {
                		if (flag) {
	                		if (count < 4 && flag) {
                %>
	                    <li><%=cbm.getMemberName() %></li>
                <%  
	                		} else { %>
	                	<li>...more</li>
		                	<%flag = false;} 
	                		count++;
                		}
                	}
                }
                while (count < 5) {%>
                	<li><br></li>
                <%
                	count++;
                } %>
                </ul>
                <button class="chatroom" value="<%=room.getChatroomId()%>">join</button>
            </div>
            <%} %>
        </div>    
    </div>
	<%-- <div id="teduri">
		<table id="chatTable">
			<tr id="gtr">
				<th id="gth">채팅 목록</th>
			</tr>
			
			<tr>
				<td align='right' cellpadding=0 cellspacing=0 >
					<img src="<%=request.getContextPath() %>/views/image/plus.png" onclick="addChatroom();" width="30px" id="plus"/>
				</td>
			</tr>
			
			<%for (Chatroom room : chatroomList) { %>
			<tr >
				<td class="chatroom">
					<%=room.getChatroomName() %>
				</td>
				<input type="hidden" value="<%=room.getChatroomId()%>"/>
			</tr>
			
			<%} %>
			<tr id="last">
				<td><br></td>
			<tr>
				
		</table>
	</div> --%>
	<script>
		
		$(document).on("click",".chatroom",function(event){
			// 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.
			//var chatroomId = $(this).siblings("input").val();
			var chatroomId = $(this).val();
			var url = "<%=request.getContextPath()%>/chatroom?chatroomId=" + chatroomId;
			console.log(url);
			var option = "left=100px, top=0px, width=500px, height=700px, menubar=no, toolbar=no, status=no, scrollbars=yes";		
			window.open(url, "", option);
		})

		function addChatroom(){
			var url = "<%=request.getContextPath()%>/addChatroom";
			var option = "left=100px, top=0px, width=500px, height=700px, menubar=no, toolbar=no, status=no, scrollbars=yes";		
			window.open(url, "", option);
		}
	</script>
<%@ include file="/views/common/footer.jsp" %>