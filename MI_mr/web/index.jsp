<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<style>
.container1{
margin-left: 5%;
text-align: center;
background-image : url("<%=request.getContextPath()%>/views/image/about-bg.png");
background-repeat:no-repeat;
background-size: 100% 100%;
padding: 140px 0px;
width: 100%;
height: 25%;

}

.container2{
margin-left: 5%;
}

body{
margin-top: 0px;
margin-right: 0px;
}

</style>

<body>
 <div class="overlay"></div>
    <div class="container1" >
    	<div class-"container11">
            <h1>Much Information</h1>
            <span class="subheading">Let's share my schedule</span>
    	</div>
	</div>
    <div class="container2">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
        <div class="post-preview">
        <div class="Selectlanguage">
        	<h1>
        		인사말
        	</h1>
            <h2 class="post-title">
              	홈페이지 방문을 진심으로 환영합니다.
            </h2>
            <h3 class="post-subtitle">
              M.I는 사람들의 스케줄을 공유하며 정보를 챙기기 위해 만들어진 기업입니다.
            </h3>
          <p class="post-meta">
          	계획적인 시간관리를 필요로 하는 여러분에게 서로 공유하면서 많은 정보들을 얻어 나의 삶을 바꿔볼 수 있으며,
          	바쁜 현대인들에게 놓치기 쉬운 일정들을 스마트하게 알려주고 서로 공유까지 할 수 있는 너무나도 편리한 M.I 사용해 보시기 바랍니다.<br>
          	홈페이지가 아직 완벽하지 않으니 불편하시더라도 조금만 참아주세요~~
          </p>
          <h4>대표 김 미 리</h4>
        </div>
        <hr>
        <div class="post-preview">
            <h2 class="post-title">
              조직도
            </h2>
         <img src="<%=request.getContextPath()%>/views/image/조직도.PNG"><br>
        </div>
        <!-- Pager -->
        <div class="clearfix">
        </div>
      </div>
    </div>
  </div>
</body>

<%@ include file="/views/common/footer.jsp" %>
