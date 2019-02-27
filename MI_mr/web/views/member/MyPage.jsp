<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="/views/common/header.jsp" %>
<%
	Member m=(Member)request.getAttribute("member");
	
%>
<style>
 body {
    margin: 20px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif,Merriweather Sans;
    font-size: 14px;
  }
#memberId_{
		background-color:lightgray;
	}
	#email{
		background-color:lightgray;
	}

  .wrapperjw{
  	width:100%;
  	height:60%;
  }
  #buttonDiv{
  width:300px;
  padding-top:30px;
  padding-left:20px;
  margin:auto;
  }
  #buttonDiv input {
  /* font-family:'Source Sans Pro', sans-serif; */
  text-weight:bold;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  padding: 10px 15px;
  color: white;
  border-radius: 3px;
  /* width: 250px; */
  cursor: pointer;
  font-size: 15px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
	}
	.containerjw input[type="text"],[type="email"],[type="tel"]{
		border: 1px solid gray;
  		background-color: white;
  		width: 200px;
	}
	table{
		padding-top:30px;
	}
	table tr td{
		height:50px;
		padding-left:10px;
	}
 </style>
<body>
<h1></h1>
<h1 style="text-align:center;font-family:Merriweather Sans; padding-top:15px;">MY PAGE</h1>
<hr class="divider my-4">
<div class="wrapperjw">
<div class="containerjw">
<!-- <section id="enroll-container"> -->
	
	<form name="memberFrm"action="<%=request.getContextPath() %>/memberUpdateEnd" onsubmit="return fn_enroll_validate()" method="post">
	<table align="center">
		<tr>
			<th>
				아이디
			</th>
			<td>
				<input type="text" name="memberId" id="memberId_" readonly value="<%=m.getMemberId()%>"/>
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>
				<input type="text" name="memberName" id="memberName" required value="<%=m.getMemberName()%>"/>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" placeholder="abc@dse.com" name="email" id="email" value="<%=m.getEmail()%>" readonly/>
			</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td>
				<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required value="<%=m.getPhone()%>"/>
			</td>
		</tr>
	</table>
	<div id="buttonDiv">
	<input type="button" value="수정" onclick="fn_updateMember();"/>
	<input type="button" onclick="fn_changePw()" value="비밀번호 변경"/>
	<input type="button" value="탈퇴" onclick="fn_deleteMember();"/>
	</div>
	</form>
	</div>
	</div>
	</body>
	
	<script>
	
		function fn_changePw(){
			var url="<%=request.getContextPath()%>/changePassword?memberId=<%=m.getMemberId()%>";
			var title="changePassword";
			var option="left=500px, top=100px, width=480px, height=210px, menubar=no, status=no, scrollbars=yes";
			var popup=window.open(url,title,option);
			checkIdDuplicateFrm.password.value=password;
			checkIdDuplicateFrm.target=title;
			checkIdDuplicateFrm.action=url;
			checkIdDuplicateFrm.method="post";
			checkIdDuplicateFrm.submit();	
		}
		
		function fn_updateMember(){
			memberFrm.submit();
		}
		$(function(){
			$('#password_2').blur(function(){
				var pw1=$("#password_").val();
				var pw2=$("#password_2").val();
				if(pw1.trim()!=pw2.trim()){
					alert("뭐지??뭔가가 틀렸어...");
					$('#password_').val('');
					$('#password_2').val('');
					$('#password_').focus();
				}
			});
		})
		
		function fn_deleteMember(){
			var flag=confirm("다시한번 생각해보자...진심으로 탈퇴??");
			if(flag)
			{
				location.href="<%=request.getContextPath()%>/memberDelete?memberId=<%=m.getMemberId()%>";	
			}
			{
				
			}
		}
	
	</script>

<!-- </section> -->
    <%@ include file="/views/common/footer.jsp" %>