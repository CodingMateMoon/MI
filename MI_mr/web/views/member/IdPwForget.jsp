<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/views/common/header.jsp" %>
    <%@ page import="com.mi.member.model.vo.Member" %>
    <%Member m=(Member)request.getAttribute("member");%>
	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	var mailButtonCheck=0;

		function mailcheck(){
			mailButtonCheck++;
			var url="<%=request.getContextPath()%>/pwfindMailcheck";
			var title="mailcheck";
			var option="left=500px, top=100px, width=300px, height=150px, menubar=no, status=no, scrollbars=yes";
			var popup=window.open("",title,option);
			checkEmailDuplicateFrm.pwEmail.value=$("#pwEmail").val();
			checkEmailDuplicateFrm.code_check.value=$("#code_check").val();
			checkEmailDuplicateFrm.target=title;
			checkEmailDuplicateFrm.action=url;
			checkEmailDuplicateFrm.method="post";
			checkEmailDuplicateFrm.submit();
		}
		
		function pwFind_mailCheck(){
			if(mailButtonCheck==0)
			{
				alert("메일인증을 해주세요.");
				return false;
			}
			return true;
		}

	</script>
	<style>
  #mailcodeEnd_span{
  	border: 0px;
    pointer-events: none;
    color: blue;
    width: 60px;
  }
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>회원가입 폼</title>
<style>
* {margin: 0 auto;}
a {color:#333; text-decoration: none;}
.find {text-align:center; width:500px; margin-top:30px; }
</style>
</head>
<body>
  <div class="find">
    <form method="post" action="<%=request.getContextPath()%>/id_find">
      <h1>회원계정 찾기</h1>
      </br>
        <fieldset>
          <legend>아이디 찾기</legend>
            <table>
              <tr>
                <td>이름</td>
                <td><input type="text" size="35" name="memberName" id="memberName" placeholder="이름"></td>
              </tr>
              <tr>
                <td>이메일</td>
                <td>
                <input type="email" size="35" placeholder="abc@dse.com" name="email" id="email"/>
                </td>
              </tr>
            </table>
          <input type="submit" value="아이디 찾기"/>
      </fieldset>
    </form>
  </div>
  <div class="find">
      <form method="post" action="<%=request.getContextPath()%>/pwFind" name="pwFindFrm" onsubmit="return pwFind_mailCheck()">
        <fieldset>
          <legend>비밀번호 찾기</legend>
            <table>
              <tr>
                <td>아이디</td>
                <td><input type="text" size="35" name="memberId" id="memberId" placeholder="아이디"></td>
              </tr>
              <tr>
                <td>이메일</td>
                <td>
                <input type="email" size="35" placeholder="abc@dse.com" name="pwEmail" id="pwEmail"/>
                <input type="button" id="mailcode_btn" name="mailcode-btn" value="메일인증" onclick="mailcheck()"/>
				<input type="text" id="mailcodeEnd_span" name="mailcodeEnd-span" value="인증완료" style="display: none;"/>
				<input type="hidden" name="pwEmail">
				<input type="hidden" readonly="readonly" name="code_check" id="code_check" value="<%=getRandom() %>"/>
				<%! public int getRandom(){
					int random=0;
					random = (int)Math.floor((Math.random()*(99999-10000+1)))+10000;
					return random;
					}%>
                </td>
              </tr>
            </table>
          <input type="submit" value="비밀번호 재설정"/>
      </fieldset>
    </form>
    
    <form name="checkEmailDuplicateFrm" method="post">
		<input type="hidden" name="pwEmail"/>
		<input type="hidden" name="code_check"/>
	</form>
	
  </div>
</body>
</html>
<%@ include file="/views/common/footer.jsp" %>