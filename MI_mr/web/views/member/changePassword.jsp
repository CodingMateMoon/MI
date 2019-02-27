<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String memberId = request.getParameter("memberId");
%>

<style>

div#changePassword-container table {
	margin: 0 auto;
	border-spacing: 20px;
}

div#changePassword-container table tr:last-of-type td {
	text-align: center;
}
</style>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id='changePassword-container'>
	<form name="changePassword" action="<%=request.getContextPath() %>/changePasswordEnd" method="post">
		<table>
			<tr>
				<th>현재비밀번호</th>
				<td><input type="password" name="password" id="password"
					required /></td>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td><input type="password" name="password_new" id="password_new"
						required /></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="password_ck" required /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"
					onclick="return password_validate()" value="변경" /> &nbsp; <input
					type="button" onclick="self.close()" value="닫기" /></td>
			</tr>
		</table>
		<input type="hidden" name="memberId" value="<%=memberId %>"/>
		</form>
	</div>
   <script>
      function password_validate(){
         var pwNew=$('#password_new').val();
         var pwCk=$('#password_ck').val();
         if(pwNew!=pwCk)
         {
            alert('패스워드가 다르네??다시한번 생각해보자');
            $('#password_new').select();
            return false;
         }
         return true;
      }
      
      $(function(){
         $('#password_ck').blur(function(){
            var password_new=$('#password_new').val();
            var password_ck=$('#password_ck').val();
            var passwordFlag=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

            if(!passwordFlag.test($('#password_new').val())){
               alert('적어도 하나 이상의 영문 소문자, 숫자, 특수문자가 포함되어야 하며 길이는 8~15글자입니다.');
               $('#password_new').val('');
                  $('#password_ck').val('');
                  $('#password_new').focus();
               }
            if(password_new.trim()!=password_ck.trim()){
               alert("비밀번호가 다릅니다.");
               $('#password_new').focus();
               $('#password_new').val('');
               $('#password_ck').val('');
            }
         });
      });
   </script>

</body>
</html>