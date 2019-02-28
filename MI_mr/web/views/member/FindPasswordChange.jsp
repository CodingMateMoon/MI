<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/views/common/header.jsp" %>
    <%@ page import="com.mi.member.model.vo.Member" %>
    <%
    String memberId=(String)request.getAttribute("memberId");
    String email=(String)request.getAttribute("email");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
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
<style>
form input[type=submit] {
/* margin-left:12%; */
  font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  padding: 10px 15px;
  color: white;
  border-radius: 3px;
  width: 150px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}
   table{
      padding-top:30px;
      margin-left:35%;
   }
   table tr td{
      height:50px;
      padding-left:10px;
   }
   .pwchange {text-align:center; width:100%; margin-top:20px;}
</style>
<div class="pwchange">
 <form method="post" action="<%=request.getContextPath()%>/pwChangeEnd">
      </br>
        <fieldset>
          <legend>비밀번호 재설정</legend>
            <table>
              <tr>
                <td>변경할 비밀번호</td>
                <td><input type="password" name="password_new" id="password_new" required /></td>
                <input type="hidden" name="memberId" value="<%=memberId%>"/>
                <input type="hidden" name="email" value="<%=email%>"/>
              </tr>
              <tr>
                <td>비밀번호 확인</td>
                <td>
                <input type="password" name="password_ck" id="password_ck" required />
                </td>
              </tr>
            </table>
          <input type="submit" value="비밀변호 변경"/>
      </fieldset>
    </form>
    </div>
</body>
</html>
<%@ include file="/views/common/footer.jsp" %>