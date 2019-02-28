<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import=" java.util.*, com.mi.group.model.vo.Group"%>
<%@ include file="/views/common/header.jsp" %>
<%
String memberId=(String)request.getAttribute("memberId");
List<Group> groupList=(List)request.getAttribute("groupList");
String groupId=(String)request.getAttribute("groupId");

%>
<style>
 body {
    margin: 20px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif,Merriweather Sans;
    font-size: 14px;
    /* border: 2px solid red; */
  }
 #teduri{
  /* position: absolute; */
  /* left: 50%;
 top: 50%; */
 margin-left: 250px;
 /*margin-top: -250px; */
  width: 700px;
  height: 410px;
  /* z-index: 15; */
 /*  border: 2px solid blue; */
  
  }
/*   #contentContainer{
  	width:60%;
  	height:60%;
  	margin:auto; 
  	display:inline;
  	align: center;
  	border: 2px solid green;
  } */
 
 #glist
 {
 	overflow-x:hidden;
 	width: 300px;
 	height: 400px;
 	/* border: 2px solid blue; */
 }
 #changeView{
 	width:350px;
 	height: 400px;
 	/* border: 2px solid yellow; */
 	position:absolute;
 	margin-left: 1em;
 	
 }
 .inline
 {
 	display: inline-block;
 	/* margin: 1em; */
 }
 #gth{
 	width:200px;
 	height : 40px;
 	font-size: 1.5em;
 	text-align:center
 }
 

 #data{
  RepeatLayout : RepeatLayout.table;
 }
 a{
 	text-decoration:none;
 }
 a:link{ color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
/* #delete-btn{ display:none; } */
table#gList-table{width:290px;
 				  height : 40px;}
/* table#gList-table tr:hover button#delete-btn{display:inline;} */
table#gList-table tr td.gth{}
table#gList-table tr td.gList-td {width: 50px; height: 35px;}
#gAddBtn{width: 60px;
  		height: 40px;
  		background-color: #f4623a; 
  		color: white;
  		border: 0;
  		border-radius: 3px;
  		}
a:hover{color: #f4623a;}
</style>
<body>
<h1></h1>
<h3></h3>
<h1 style="text-align:center; ">MANAGE GROUP</h1>
<hr class="divider my-4">
	<div id="teduri" name="teduri">
		<!-- <div id="contentContainer"> -->
		<div class="inline" id="glist">
			<table id="gList-table">
				<tr id="gtr">
					<th id="gth">Group List</th>
				</tr>
	                <%
	                	for(Group g : groupList){
	                %>
	                <tr>
	                	<td align="center" class="gList-td">
	                	<%-- <a href='<%=request.getContextPath()%>/memberView.do' onclick="fn_memberList()"><%=g.getGroupName() %></a> --%>
	                	<a href='javascript:void(0)' onclick="fn_memberList()"><%=g.getGroupId()%>:<%=g.getGroupName() %></a>
	                	</td>
	                	<!-- <td class="gList-td">
	                		<button id="delete-btn" value="" onclik="fn_deleteGroup">삭제</button>
	                	</td> -->
	                </tr>
	                <%} %>
				<tr>
					<td id="add-btn" align='right' cellpadding=0 cellspacing=0 >
						<%-- <a href="javascript:void(0)" onclick="fn_addGroup()"><img src="<%=request.getContextPath() %>/views/group/plus.png" width="30px" id="plus"></a> --%>
						<!-- <a href="javascript:void(0)" onclick="fn_addGroup()"><input type="button" id="gAddBtn" value="추가"></a> -->
						<button type="button" id="gAddBtn" onclick="fn_addGroup()">추가</button>
					</td>
				</tr>
					
			</table>
		</div>
		<!-- </div> -->
	<div class="inline" id="changeView">
	
	</div>
	</div>
<script>
	function fn_addGroup(){
		$.ajax({
			url:"<%=request.getContextPath()%>/addGroup.do",
			success:function(data){
				$('#changeView').html(data);
			}
		})
	};

	function fn_memberList(){
		var groupNameStr=event.srcElement.innerHTML;
		var StrArr=groupNameStr.split(":");
		var groupId=StrArr[0];
		$.ajax({
			url:"<%=request.getContextPath()%>/memberView.do?groupId="+groupId,
			/* data:{"groupName":groupNameStr}, */
			<%-- type:"get",
			data:{"memberId":'<%=loginMember.getMemberId()%>',"groupName":groupNameStr},
			dataType:"json",
			contentType:'application/json', --%>
			success:function(data){
				console.log(data);
				$('#changeView').html(data);
			}
		})
	};
	
/* 	function fn_deleteGroup(){
		
		var flag=confirm("그룹을 삭제하시겠습니까??");
		if(flag)
			{
				location.href="http//:www.naver.com";
			}
		else
			{
				return;
			}
		
	}
 */
</script>


</body>
<%@ include file="/views/common/footer.jsp" %>