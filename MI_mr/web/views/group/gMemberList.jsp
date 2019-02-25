<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String memberId=(String)request.getAttribute("memberId");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#addMember
	{
		width: 290px;
		height: 150px;
		border: 2px solid red;
		overflow-x:hidden;
	}
	#gMemberList
	{
		width: 290px;
		height: 200px;
		border: 2px solid blue;
		overflow-x: hidden;
	}
	#gMemberPlus
	{
 /* 	position: relative;
		top:50%;
		left:50%;
		/* margin-top:-25px;
		margin-left:-25px; */ */
		
	}
	#teduri3
	{
		width: 300px;
		height: 400px;
		border: 1px solid green;
	}
h4{
	margin : 0%
}
#btnDiv{
	border: 1px solid yellow;
	width: 50px;
	float:right;
}
</style>
<body>
<div id="teduri3">
	<div id="gMemberList">
	<table>
		<tr>
			<th>멤버 목록</th>
		</tr>
		<tr>
			<td>
			
			</td>
		</tr>
	</table>
	</div>
	<div id="addMember">
		<h4>멤버 추가</h4>
			<input type="search" name="serachId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
		<datalist id="datalist">
		</datalist>
		
		
		
		<!-- <img src="/views/group/plus.png" width="30px" id="gMemberPlus"/> -->
	</div>
	<div id="btnDiv">
		<input type="submit" id="addMemberBtn" value="등록"/>
		<!-- <input type="button" id="deleGroup" value="삭제"/> -->
	
	</div>
</div>
<script>
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




</script>
</body>
</html>