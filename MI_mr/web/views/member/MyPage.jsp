<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="/views/common/header.jsp" %>
<%
	Member m=(Member)request.getAttribute("member");
	
%>
<style>
	#memberId_{
		background-color:lightgray;
	}
	#email{
		background-color:lightgray;
	}
	#enroll-container{
	 position: absolute;
  width: 260px;
  height: 250px;
  z-index: 15;
  top: 50%;
  left: 51%;
  margin: -200px 0 0 -150px;
  text-align: center;
  border: 2px solid black;
  }
  
</style>
<body>
<section id="enroll-container">
	<h2>회원정보 수정</h2>
	<form name="memberFrm"action="<%=request.getContextPath() %>/memberUpdateEnd" onsubmit="return fn_enroll_validate()" method="post">
	<table>
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
	<input type="button" value="수정" onclick="fn_updateMember();"/>
	<input type="button" onclick="fn_changePw()" value="비밀번호 변경"/>
	<input type="button" value="탈퇴" onclick="fn_deleteMember();"/>
	</form>
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

</section>
    <%@ include file="/views/common/footer.jsp" %>