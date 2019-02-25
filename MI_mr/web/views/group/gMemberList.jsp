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
	#gName
	{
		width: 290px;
		height: 150px;
		/* border: 2px solid red; */
		overflow-x:hidden;
	}
	#gMemberList
	{
		width: 290px;
		height: 200px;
		/* border: 2px solid blue; */
		overflow-x: hidden;
	}
	#gMemberPlus
	{
 	position: relative;
		top:50%;
		left:50%;
		/* margin-top:-25px;
		margin-left:-25px; */
		
	}
	#teduri3
	{
		width: 300px;
		height: 370px;
		/* border: 1px solid green; */
	}
h4{
	margin : 0%
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
	<div id="gName">
		<h4>아이디검색/추가</h4>
			<input type="search" name="serachId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
		<datalist id="datalist">
		</datalist>
		
		
		
		<img src="/views/group/plus.png" width="30px" id="gMemberPlus"/>
	</div>
</div>
</body>
</html>