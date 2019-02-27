<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>M.I - MUCH INFORMATION</title>

  <!-- Font Awesome Icons -->
  <link href="./Resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet">
  <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>

  <!-- Plugin CSS -->
  <link href="./Resources/vendor/magnific-popup/magnific-popup.css" rel="stylesheet">

  <!-- Theme CSS - Includes Bootstrap -->
  <link href="./Resources/css/creative.min.css" rel="stylesheet">
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
      alert("아이디를 입력하세요 :(");
      $('[name=memberId]').focus();
      return false;
   }
   if (pwVal.trim().length == 0) {
      alert("비밀번호를 입력하세요 :(");
      $('[name=password]').focus();
      return false;
   }
   return true;
}
</script>  
</head>

<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="<%=request.getContextPath()%>/index.jsp">Much Information</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto my-2 my-lg-0">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/index.jsp">About</a>
          </li>
          <%if(loginMember==null){ %>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/loginAlert">Calendar</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/loginAlert">Schedule</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/loginAlert">Group</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/loginAlert">Chat</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/loginJoin">Login</a>
          </li>
          <%}else{ %>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/showCalendar?memberId=<%=loginMember.getMemberId()%>">Calendar</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/detailAll?memberId=<%=loginMember.getMemberId()%>">Schedule</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath() %>/groupView?memberId=<%=loginMember.getMemberId()%>">Group</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath() %>/chatroomList?memberId=<%=loginMember.getMemberId()%>">Chat</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/updateMember?memberId=<%=loginMember.getMemberId()%>">My page</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/logout">Logout</a>
          </li>
          
          <%} %>
        </ul>
      </div>
    </div>
  </nav>
<%-- <header class="masthead">
    <div class="container h-100">
      <div class="rightContainer">
        <div id="innerContainer">

          <h1 id="mi">[WELCOME TO M.I]</h1>
          <hr class="divider my-4">
        </div>
        <div class="inner2Container" >
          <p class="text-white-75 font-weight-light mb-5">Change your life with Much Information!</p> 
          <p class="text-white-75 font-weight-light mb-5">If you are not our family,</p> 
          <a class="btn btn-primary btn-xl js-scroll-trigger" href="<%=request.getContextPath()%>/memberJoin">JOIN</a>
        </div>
      </div>
   </div>
  </header> --%>
  
<style>
	.rightContainer{
		margin-top:200px;
		textalign:center;
		width:50%;
		height:100%;
		float:right;
	}
	#innerContainer{
		display:inline-block;
	}
	#inner2Container{
		textalign:center;
	}
	#mi{
		text-align:center;
		font-family:Merriweather Sans;
		font-weight:bold;
	}
</style>

<!-- Bootstrap core JavaScript -->
  <script src="./Resources/vendor/jquery/jquery.min.js"></script>
  <script src="./Resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="./Resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="./Resources/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="./Resources/js/creative.min.js"></script>

