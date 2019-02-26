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
</body>
</html>
<%@ include file="/views/common/footer.jsp" %>