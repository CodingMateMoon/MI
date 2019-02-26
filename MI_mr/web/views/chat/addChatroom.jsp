<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="com.mi.member.model.vo.Member" %>
 
<!DOCTYPE html>
<html>
<head>
<%
	Member loginMember=(Member)session.getAttribute("loginMember");
%>   
<meta charset="UTF-8">
<title>채팅방 추가</title>
<style>
	#mList
	{
		/* border: 1px solid red; */
		width: 180px;
		height: 300px;
		display: inline-block;
	}
	#addM
	{
		/* border: 1px solid blue; */
		width: 150px;
		height: 300px;
		display: inline-block
	}
	#teduri2{	
		/* border: 1px solid black;
 */		width: 350px;
		height: 400px;
		padding-left:5px;
	}
	
	#anteduri
	{
		/* border: 1px solid green; */
		width: 350px;
		height: 330px;
	}
	#gNamebar
	{
		width:170px;
		height: 30px;
	}
	#gUpdate
	{
		height:35px;
	}
	td{
		padding-left:5px;
	}
	h4{
	margin:0;
	}
</style>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
   


<div id="teduri2">
		<input type="text" id="gNamebar" required placeholder="채팅방 이름" autocomplete="off"/>
		<button type="button" id="save">저장</button>
		
		<br/>
		<br>
		<div id="anteduri" >
			<div id="mList">
				<h4>아이디검색/추가</h4> 
				<input type="search" name="searchId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
				
			<datalist id="datalist">
			</datalist>
			<br/><br/>
			<h4>추가된 회원</h4>
			<div id="addmember">
				<tr><td></td></tr>
			</div>
		</div>
		
</div>
<form name="chatroomForm" action="<%=request.getContextPath()%>/addChatroomEnd">
	<input type="hidden" id="memberId" value="<%=loginMember.getMemberId()%>"/>
</form>
	<script>
		$(function(){
			
			$("#searchId").change(function(){
				var value=$(this).val();
				var flag=false;
				//console.log($('#datalist').children())
				 $.each($('#datalist').children(),function(index,item){
					console.log(item);
					if(value==item.innerHTML)
					{
						flag=true;
					}
					 
				});
				if(flag){
					$('#addmember').append($('<tr><td class="addChatroomMember">'+value+'</td></tr>'));
					$(this).val("");
					
					$('.addChatroomMember').click(function(){
						
						// td 부모인 tr 삭제
						$(this).parent().remove();					
					
					});
				}
			});
			
			$("#searchId").keyup(function(){
				$.ajax({
					url:"<%=request.getContextPath()%>/member/selectId.do",
					type:"post",
					data:{"search":$("#searchId").val()},
					success:function(data){
							var html="";
							for(var i=0;i<data.length;i++)
							{
								html+='<option>'+data[i]+"</option>";
							}
						$('#datalist').html(html);
					}
				});
			});
		});	
		
		$("button#save").click(function(){
			var memberList = [];
			$(".addChatroomMember").each(function(index, item) {
				memberList.push(item.innerHTML);
			});
			if(memberList.length > 0) {
				
			}
		});
	
	</script>
</body>
</html>