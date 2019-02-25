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
<style>
input[type="checkbox"]#menu_state {
  display: none;
}
input[type="checkbox"]:checked ~ nav {
  width: 210px;
}
input[type="checkbox"]:checked ~ nav label[for="menu_state"] i::before {
  content: "\f053";
}
input[type="checkbox"]:checked ~ nav ul {
  width: 100%;
}
input[type="checkbox"]:checked ~ nav ul li a i {
  border-right: 1px solid #2f343e;
}
input[type="checkbox"]:checked ~ nav ul li a span {
  opacity: 1;
  transition: opacity 0.25s ease-in-out;
}
input[type="checkbox"]:checked ~ main {
  left: 250px;
}
nav {
  position: fixed;
  z-index: 9;
  top: 0;
  left: 0;
  bottom: 0;
  background: #383e49;
  color: #9aa3a8;
  width: 50px;
  font-family: 'Bahnschrift', sans-serif;
  font-weight: lighter;
  font-size:12px;
  transition: all 0.15s ease-in-out;
}
nav label[for="menu_state"] i {
  cursor: pointer;
  position: absolute;
  top: 50%;
  right: -8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  background: #fff;
  font-size: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 15px;
  width: 15px;
  border-radius: 50%;
  border: 1px solid #ddd;
  transition: width 0.15s ease-in-out;
  z-index: 1;
}
nav label[for="menu_state"] i::before {
  margin-top: 2px;
  content: "\f054";
}
nav label[for="menu_state"] i:hover {
  box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
}
nav ul {
  overflow: hidden;
  display: block;
  width: 50px;
  list-style-type: none;
  padding: 0;
  margin: 0;
}
nav ul li {
  border: 1px solid #2f343e;
  position: relative;
}
nav ul li.unread:after {
  content: attr(data-content);
  position: absolute;
  top: 10px;
  left: 25px;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 15px;
  height: 15px;
  border-radius: 50%;
  color: #fff;
  background: #ef5952;
  font-size: 8px;
}
nav ul li:not(:last-child) {
  border-bottom: none;
}
nav ul li.active a {
  background: #4c515d;
  color: #fff;
}
nav ul li a {
  position: relative;
  display: block;
  white-space: nowrap;
  text-decoration: none;
  color: #9aa3a8;
  height: 50px;
  width: 100%;
  transition: all 0.15s ease-in-out;
}
nav ul li a:hover {
  background: #4c515d;
  color: #fff;
}
nav ul li a * {
  height: 100%;
  display: inline-block;
}
nav ul li a i {
  text-align: center;
  width: 50px;
  z-index: 999999;
}
nav ul li a i.fa {
  line-height: 50px;
}
nav ul li a span {
  padding-left: 25px;
  opacity: 0;
  line-height: 50px;
  transition: opacity 0.1s ease-in-out;
}

nav ul ul li a span {
   color: #9aa3a8;
   /* text-decoration: none;
   line-height: 27px;
   display: block;
   padding: 0 15px;  */
   -webkit-transition: all 0.15s;
   -moz-transition: all 0.15s;
   -o-transition: all 0.15s;
   -ms-transition: all 0.15s;
   transition: all 0.15s;
}
nav ul li ul li{
   display: none;
}
nav ul li.calendarMenu{ transition:all 0.5s;}
nav ul li.calendarMenu:hover ul li{ transition: all 0.5s; display:block; background:rgb(40,50,59); }

nav ul ul li a:hover {
   background: #003545;
   color:white;
}
nav ul ul li a:hover span {
   color:white;
}

main {
  position: absolute;
  transition: all 0.15s ease-in-out;
  top: 0;
  left: 50px;
}
main header {
  position: absolute;
  z-index: -1;
  top: 0;
  left: 0;
  right: 0;
  height: 400px;
  background: url("http://www.blueb.co.kr/SRC2/_image/01.jpg");
  background-size: cover;
  background-position: 50% 50%;
  background-repeat: no-repeat;
}
main section {
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  background: #fff;
  padding: 25px;
  font-family: helvetica;
  font-weight: lighter;
  padding: 50px;
  margin: 150px 75px;
  transition: all 0.15s ease-in-out;
}
main section:hover {
  box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
}
main section h1 {
  padding-top: 0;
  margin-top: 0;
  font-weight: lighter;
}


</style>
<link rel='stylesheet' href='<%=request.getContextPath()%>/css/style.css' type='text/css' />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<input type="checkbox" id="menu_state" checked>
<nav>
   <label for="menu_state"><i class="fa"></i></label>
   <ul>
   <li>
   </li>
      <li data-content="5" class="active unread">
         <a href="<%=request.getContextPath()%>/muchInformation">
            <i class="fas fa-users"></i>
            <span>Much Information</span>
         </a>
      </li>
      <%if(loginMember==null){ %>
      <li>
         <a href="<%=request.getContextPath()%>/loginJoin">
            <i class="fas fa-key"></i>
            <span>Login/Join</span>
         </a>
      </li>
      <li>
         <a href="<%=request.getContextPath()%>/IdPwForget">
            <i class="fas fa-key"></i>
            <span>Id/Password Forgot</span>
         </a>
      </li>
      <li>
         <a href="<%=request.getContextPath()%>/loginAlert">
            <i class="fas fa-calendar-times"></i>
            <span>My Calendar</span>
         </a>
      </li>
      <li>
         <a href="<%=request.getContextPath()%>/loginAlert">
            <i class="fas fa-users"></i>
            <span>My Group</span>
         </a>
      </li>
      <li>
         <a href="<%=request.getContextPath()%>/loginAlert">
            <i class="fas fa-comments"></i>
            <span>Chat</span>
         </a>
      </li>
      <li data-content="2" class="unread">
         <a href="<%=request.getContextPath()%>/loginAlert">
            <i class="fa fa-trash"></i>
            <span>추가할거있으면 ㄱㄱ</span>
         </a>
      </li>
      <%}else{ %>
      <li>
         <a href="<%=request.getContextPath()%>/logout">
            <i class="fas fa-unlock-alt"></i>
            <span>Logout</span>
         </a>
      </li>
      
      <li>
         <a href='<%=request.getContextPath()%>/updateMember?memberId=<%=loginMember.getMemberId()%>'>
            <i class="fas fa-user"></i>
            <span>My page</span>
         </a>
      </li>
      <li class="calendarMenu">
         <a href="<%=request.getContextPath()%>/showCalendar?memberId=<%=loginMember.getMemberId()%>">
            <i class="fas fa-calendar-alt"></i>
            <span>My Calendar</span>
         </a>
         <ul>
            <li>
               <a href="<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>">
               <i class="fas fa-calendar-plus"></i>
               <span>Schedule Addition</span>
               </a>
            </li>
            <li>
               <a href="<%=request.getContextPath()%>/detailSchedule?memberID=<%=loginMember.getMemberId()%>">
               <i class="fas fa-clipboard-list"></i>
               <span>detailed Schedule</span>
               </a>
            </li>
            
         </ul>
      </li>
      <li>
         <a href="<%=request.getContextPath() %>/groupView">
            <i class="fas fa-users"></i>
            <span>My Group</span>
         </a>
      </li>
      <li>
         <a href="<%=request.getContextPath() %>/chatroomList?memberId=<%=loginMember.getMemberId()%>">
            <i class="fas fa-comments"></i>
            <span>Chat</span>
         </a>
      </li>
      <li data-content="2" class="unread">
         <a href="javascript:void(0)">
            <i class="fa fa-trash"></i>
            <span>추가할거있으면 ㄱㄱ</span>
         </a>
      </li>
      <%} %>
   </ul>
</nav>

</header>