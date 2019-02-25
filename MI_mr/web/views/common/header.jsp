<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%@ page import="com.mi.member.model.vo.Member" %>

	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	Cookie[] cookies = request.getCookies();
	String saveId = null;
	if (cookies != null) {
		for (Cookie c : cookies) {
			String key = c.getName();
			String value = c.getValue();
			if (key.equals("saveId")) {
				saveId = value;
				break;
			}
		}
	}
%>

<script>
function validate() {
	var idVal = $('[name=memberId]').val();
	var pwVal = $('[name=password]').val();
	if (idVal.trim().length == 0) {
		alert("하...아이디입력...");
		$('[name=memberId]').focus();
		return false;
	}
	if (pwVal.trim().length == 0) {
		alert("하...비번입력...");
		$('[name=password]').focus();
		return false;
	}
	return true;
}

</script>
<link rel='stylesheet' href='<%=request.getContextPath()%>/css/style.css' type='text/css' />
<section>
<button id="toggle">▤</button>
	<div id="accordian">
		<ul>
		<h1>M.I</h1>

<% if(loginMember == null) {%>
			<form id="loginFrm" action="<%=request.getContextPath()%>/login" method="post" onsubmit="return validate();">

				<table>
					<!-- 회원가입 : 아이디 비밀번호 생년월일 이름 이메일 전화번호 -->
					<tr>
						<td><input id="idjw" type="text" name="memberId"
							placeholder="아이디" value="<%=saveId != null ? saveId : ""%>" /></td>
						<td></td>
					</tr>
					<tr>
						<td><input id="pwjw" type="password" name="password"
							placeholder="비밀번호" /></td>
					</tr>
					<tr>
						<td><input id="loginjoinjw" type="submit" value="login" /></td>
					</tr>
					<tr>
						<td><input id="loginjw" type="button" value="join"
							onclick="location.href='<%=request.getContextPath()%>/memberJoin'" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type='checkbox' name="saveId"
							id="saveId"  <%=saveId != null ? "checked" : ""%> /> <label for="saveId">아이디저장</label></td>
					</tr>
				</table>
			</form>
			<%}else{ %>
			<table id='Logged-in'>
				<tr>
					<td><%=loginMember.getMemberId()%>님 안녕하세요</td>
				</tr>
				<tr>
					<td>
						<input id="mypagejw" type="button" value="마이페이지"
						onclick="location.href='<%=request.getContextPath()%>/updateMember?memberId=<%=loginMember.getMemberId()%>'" />
						<input id="logoutjw" type="button" value="로그아웃"
						onclick="location.href='<%=request.getContextPath()%>/logout'" />
					</td>
				</tr>
			</table>
			<%} %>
			<li>
				<h3>
					<span class="icon-dashboard"></span>페이지소개
				</h3>
				<ul>
					<li><a href="#">CEO인사말</a></li>
					<li><a href="#">조직도</a></li>
					<li><a href="#">서비스 소개</a></li>
				</ul>
			</li>
			<li class="active">
				<h3>
					<span class="icon-tasks"></span>일정관리
				</h3>
				<ul>
				<%if(loginMember==null){ %>
					<li><a href="<%=request.getContextPath()%>/loginAlert" >일정보기</a></li>
					<li><a href="<%=request.getContextPath()%>/loginAlert">상세일정 관리</a></li>
					<li><a href="<%=request.getContextPath()%>/loginAlert">일정등록</a></li>
				<%} else{%>
					<li><a href="<%=request.getContextPath()%>/showCalendar?memberId=<%=loginMember.getMemberId()%>">일정보기</a></li>
					<li><a href="<%=request.getContextPath()%>/detailSchedule?memberID=<%=loginMember.getMemberId()%>">상세일정 관리</a></li>
					<li><a href="<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>">일정등록</a></li>

					<%} %>
				</ul>
			</li>
			<li>
				<h3>
					<span class="icon-calendar"></span>그룹관리
				</h3>
				<ul>

					<li><a href="<%=request.getContextPath() %>/groupView">그룹관리</a></li>
					<%if(loginMember!=null){ %>
					<li><a href="<%=request.getContextPath() %>/chatroomList?memberId=<%=loginMember.getMemberId()%>">채팅관리</a></li>
					<%} else { %>
					<li><a href="<%=request.getContextPath() %>/loginAlert">채팅관리</a></li>
					
					<%} %>
					<li><a href="#">투표관리</a></li>
				</ul>
			</li>
			<li>
				<h3>
					<span class="icon-heart"></span>작성할사람 작성~~
				</h3>
				<ul>
					<li><a href="#">기타1</a></li>
					<li><a href="#">기타2</a></li>
					<li><a href="#">기타3</a></li>
					<li><a href="#">기타4</a></li>
				</ul>
			</li>
		</ul>
	</div>
	</section>
	<!-- 홈으로 돌아가기 -->
	<h1>
		<a href="<%=request.getContextPath()%>">
		<span id="milogo">Much Information</span>
		</a>
	</h1>
	<style>
	#milogo{
	position: absolute;
	z-index: 15;
	top: 29%;
	left: 51%;
	margin: -200px 0 0 -150px;
	text-align: center;
	color:black;
  }
  #mypagejw {
	background: gray;
	color:white;
	border: none;
}
#logoutjw {
	background: gray;
	color:white;
	border: none;
}
  </style>


	<script>
		/* h3클릭시 슬라이드 내려오기(ul내용 보여주기) */
		$(function() {
			$("#accordian h3").click(function() {
				$("#accordian ul ul").slideUp();
				if (!$(this).next().is(":visible")) {
					$(this).next().slideDown();
				}
			});
		});
		/* 버튼으로 왼쪽 div화면 숨기기 */
		$(function(){
			$("#toggle").click(function(){
				$("#accordian").toggle(1000);
			})
		})
	</script>
</header>