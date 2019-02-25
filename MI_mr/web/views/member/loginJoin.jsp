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

<style>
body {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-family: 'Source Sans Pro', sans-serif;
  color: white;
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
  background: linear-gradient(to bottom right, #d0d0d0 0%, #000000 100%);
  position: absolute;
  top: 45%;
  left: 0;
  width: 100%;
  height: 400px;
  margin-top: -200px;
  overflow: hidden;
}
.wrapperjw.form-success .container h1 {
  -webkit-transform: translateY(85px);
      -ms-transform: translateY(85px);
          transform: translateY(85px);
}
.containerjw {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px 0;
  height: 400px;
  text-align: center;
}
.containerjw h1 {
  margin:10px;
  font-size: 35px;
  font-weight: 200;
}
form {
  padding: 20px 0;
  position: relative;
  z-index: 2;
}
form input[type=text],[type=password],[type=submit],[type=button] {
  appearance: none;
  outline: 0;
  border: 1px solid rgba(255, 255, 255, 0.4);
  background-color: rgba(255, 255, 255, 0.2);
  width: 250px;
  border-radius: 3px;
  padding: 10px 15px;
  margin: 0 auto 10px auto;
  display: block;
  text-align: center;
  font-size: 12px;
  color: white;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
  font-weight: 300;
}
#saveId{

}
#idjw, #pwjw, #loginjoinjw, #loginjw{
width:200px;
}
#loginjoinjw, #loginjw{
background-color: #383e4896;
}
form input:hover {
  background-color: rgba(255, 255, 255, 0.4);
}
form input:focus {
  background-color: white;
  width: 300px;
  color: #000;
}
form input[type=submit],[type=button] {
  appearance: none;
  outline: 0;
  background-color: white;
  border: 0;
  padding: 10px 15px;
  color: #000;
  border-radius: 3px;
  width: 250px;
  cursor: pointer;
  font-size: 12px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}

</style>

  <script src='js/jquery.jin.js'></script>
  <script>
    if (document.location.search.match(/type=embed/gi)) {
      window.parent.postMessage('resize', "*");
    }
  </script>

  <script src="js/timeout.jin.js"></script>
  <script>
    $('#loginjoinjw').click(function (event) {
    event.preventDefault();
    $('form').fadeOut(1000);
    $('.wrapperjw').addClass('form-success');
});

  </script>
  
<div class="wrapperjw">
<div class="containerjw">
	<h1>Welcome</h1>
 <form class="form" id="loginFrm" action="<%=request.getContextPath()%>/login" method="post" onsubmit="return validate();">

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
			</form>
			
			</div>
			</div>

</body>
</html>

<%@ include file="/views/common/footer.jsp" %>