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





</header>