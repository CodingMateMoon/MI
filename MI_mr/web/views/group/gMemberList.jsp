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
		width: 150px;
		height: 150px;
		border: 2px solid red;
	}
	#gMemberList
	{
		width: 150px;
		height: 200px;
		border: 2px solid blue;
		overflow-x: hidden;
	}
	#gMemberPlus
	{
 	position: relative;
		top:50%;
		left:50%;
		margin-top:-25px;
		margin-left:-25px; 
		
	}
	#teduri
	{
		width: 160px;
		height: 360px;
		border: 1px solid yellow;
	}
</style>
<body>
<div id="teduri">
	<div id="gName">
		<img src="plus.png" width="30px" id="gMemberPlus"/>
	</div>
	<div id="gMemberList">
	
	</div>
</div>
</body>
</html>