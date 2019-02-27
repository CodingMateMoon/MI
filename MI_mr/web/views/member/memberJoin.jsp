<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ include file="/views/common/header.jsp" %>

</head>
<body>
<script>
   var emailButtonCheck=0;
   var idButtonCheck=0;

   function fn_enroll_validate(){
      var memberId=$("#memberId_").val();
      if(memberId.trim().length<4){
         alert("아이디는 항상 4글자이상으로...ㅎㅎㅎ");
         $("#memberId_").focus();
         return false;
      }
      if(idButtonCheck==0)
      {
         alert("중복확인을 해주세요.");
         return false;
      }
      if(emailButtonCheck==0)
      {
         alert("메일인증을 해주세요.");
         return false;
      }
      return true;
      
   }
   
   function fn_checkIdDuplicate(){
      idButtonCheck++;
      var memberId=$("#memberId_").val().trim();
      if(!memberId||memberId.length<4)
         {
            alert("아이디는 항상 4글자이상으로...ㅎㅎㅎ");
            return;
         }
      var url="<%=request.getContextPath()%>/chekIdDuplicate";
      var title="checkIdDuplicate";
      var option="left=500px, top=100px, width=300px, height=200px, menubar=no, status=no, scrollbars=yes";
      var popup=window.open("",title,option);
      checkIdDuplicateFrm.memberId.value=memberId;
      checkIdDuplicateFrm.target=title;
      checkIdDuplicateFrm.action=url;
      checkIdDuplicateFrm.method="post";
      checkIdDuplicateFrm.submit();
   }
   function fn_mailcheck(){
      emailButtonCheck++;
      var email=$("#email").val().trim();
      if(email.length<8)
         {
            alert("메일을 입력해주세요.");
            return;
         }
      var url="<%=request.getContextPath()%>/mailcheck";
      var title="mailcheck";
      var option="left=500px, top=100px, width=300px, height=150px, menubar=no, status=no, scrollbars=yes";
      var popup=window.open("",title,option);
      checkEmailDuplicateFrm.email.value=$("#email").val();
      checkEmailDuplicateFrm.code_check.value=$("#code_check").val();
      checkEmailDuplicateFrm.target=title;
      checkEmailDuplicateFrm.action=url;
      checkEmailDuplicateFrm.method="post";
      checkEmailDuplicateFrm.submit();
   }
   function historyBack(){
      history.go(-1);
   }
    $(function(){
      $('#password_2').blur(function(){
         var password_=$('#password_').val();
         var password_2=$('#password_2').val();
         var passwordFlag=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

         if(!passwordFlag.test($('#password_').val())){
            alert('적어도 하나 이상의 영문 소문자, 숫자, 특수문자가 포함되어야 하며 길이는 8~15글자입니다.');
            $('#password_').val('');
               $('#password_2').val('');
               $('#password_').focus();
            }
         if(password_.trim()!=password_2.trim()){
            alert("비밀번호가 다릅니다.");
            $('#password_').focus();
            $('#password_').val('');
            $('#password_2').val('');
         }
      });
   });

</script>
<style>

body {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-family: 'Source Sans Pro', sans-serif;
  color: black;
  font-weight: 300;
}
body ::-webkit-input-placeholder {
  /* WebKit browsers */
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
  font-weight: 300;
}
body :-moz-placeholder {
  /* Mozilla Firefox 4 to 18 */
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
  opacity: 1;
  font-weight: 300;
}
body ::-moz-placeholder {
  /* Mozilla Firefox 19+ */
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
  opacity: 1;
  font-weight: 300;
}
body :-ms-input-placeholder {
  /* Internet Explorer 10+ */
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
  font-weight: 300;
}
 .wrapperjw {
  width: 100%;
  height: 70%;
} 
.wrapperjw.form-success .container h1 {
  -webkit-transform: translateY(85px);
      -ms-transform: translateY(85px);
          transform: translateY(85px);
}
.containerjw {
  max-width: 600px;
  margin: 0 auto;
  padding: 50px 0;
  height: 350px;
  text-align: center;
}
.containerjw h1 {
  margin:10px;
  font-size: 35px;
  font-weight: 200;
}
  
  #mailcodeEnd_span{
  	border: 0px;
    pointer-events: none;
    color: blue;
    width: 60px;
  }
  form input[type=button] ,[type=submit],[type=reset]{
  font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  color: white;
  border-radius: 3px;
  width: 80px;
  height:30px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}
 #buttonContainer{
 	padding-top:30px;
 	margin:auto;
 }
.containerjw input[type="text"],[type="password"],[type="email"],[type="tel"]{
		border: 1px solid gray;
  		background-color: white;
	}
		table{
		padding-top:20px;
	}
	table tr td{
		height:50px;
		padding-left:10px;
	}
</style>
<body>
<h1 style="text-align:center;font-family:Merriweather Sans; padding-top:15px;">SIGN UP</h1>
<hr class="divider my-4">
<div class="wrapperjw">
<div class="containerjw">
<!-- <section id="enroll-container"> -->
	<form name="memberEnrollFrm" id="memberEnrollFrm" action="<%=request.getContextPath() %>/memberJoinEnd" onsubmit="return fn_enroll_validate()" method="post">
	<table align="center">
		<tr>
			<th>
				아이디
			</th>
			<td>
				<input type="text" name="memberId" id="memberId_" required placeholder="4글자 이상 입력">
				<input type="button" value="중복검사" onclick="fn_checkIdDuplicate()" />
				<input type="hidden" name="memberId"/>
			</td>
		</tr>
		<tr>
			<th>
				패스워드
			</th>
			<td>
				<input type="password" name="password" id="password_" required/>
			</td>
		</tr>
		<tr>
			<th>패스워드 확인</th>
			<td>
				<input type="password" id="password_2" required/>
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>
				<input type="text" name="memberName" id="memberName" required/>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" placeholder="abc@dse.com" name="email" id="email"/>
				<input type="button" id="mailcode_btn" name="mailcode-btn" value="메일인증" onclick="fn_mailcheck()"/>
				<input type="text" id="mailcodeEnd_span" name="mailcodeEnd-span" value="인증완료" style="display: none;"/>
				<input type="hidden" name="email">
				<input type="hidden" readonly="readonly" name="code_check" id="code_check" value="<%=getRandom() %>"/>
				<%! public int getRandom(){
					int random=0;
					random = (int)Math.floor((Math.random()*(99999-10000+1)))+10000;
					return random;
					}%>
			</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td>
				<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required/>
			</td>
		</tr>

		
	</table>
	<div id="buttonContainer">
	<input type="submit" value="가입"/>
	<input type="reset" value="취소" onclick="historyBack()"/>
	</div>
	</form>
	</div>
	</div>
	<form name="checkIdDuplicateFrm" method="post">
		<input type="hidden" name="memberId"/>
	</form>
	
	<form name="checkEmailDuplicateFrm" method="post">
		<input type="hidden" name="email"/>
		<input type="hidden" name="code_check"/>
	</form>
</body>
	
<!-- </section> -->

<%@ include file="/views/common/footer.jsp" %>
