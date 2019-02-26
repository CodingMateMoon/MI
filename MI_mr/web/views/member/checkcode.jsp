<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	<form id="form2" action="javascript:getPassword()">
		<table>
			<tr>
				<td><span>인증번호</span></td>
				<td><input type="text" name="code" id="code" onkeyup="checkCode()" placeholder="인증번호를 입력하세요."/>
				<div id="checkCode"></div></td>
				<td><input type="hidden" readonly="readonly" name="code_check" id="code_check" value="<%=request.getAttribute("code") %>"/></td>
			</tr>
		</table>
		<input id="codecheck" type="hidden" value='인증하기' onclick="codesuc();"/>
	</form>
	<script>
		function checkCode(){
			var v1=form2.code_check.value;
			var v2=form2.code.value;
			if(v1==v2){
				document.getElementById('checkCode').style.color="blue";
				document.getElementById('checkCode').innerHTML="인증되었습니다.";
				makeReal();
			}
			else{
				document.getElementById('checkCode').style.color="red";
				document.getElementById('checkCode').innerHTML="잘못된 인증번호입니다.";
			}
		}
		function makeReal(){
			var codecheck=document.getElementById("codecheck");
			codecheck.type="button";
		}
		//인증하기 버튼
		function codesuc(){
			opener.document.memberEnrollFrm.mailcode_btn.style.display="none";
			opener.document.memberEnrollFrm.mailcodeEnd_span.style.display="inline-block";
			opener.document.memberEnrollFrm.email.readOnly = true;
			window.close();
		}
	</script>
</body>
</html>