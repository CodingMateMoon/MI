<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



 <form id="loginFrm" action="<%=request.getContextPath()%>/login" method="post" onsubmit="return validate();">

				<table>
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
						<td><input id="loginjw" type="button" value="join" onclick="location.href='<%=request.getContextPath()%>/memberJoin'" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type='checkbox' name="saveId"
							id="saveId"  <%=saveId != null ? "checked" : ""%> /> <label for="saveId">아이디저장</label></td>
					</tr>
				</table>
			</form>

</body>
</html>

<%@ include file="/views/common/footer.jsp" %>