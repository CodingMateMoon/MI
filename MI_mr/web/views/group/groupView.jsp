<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import=" java.util.*, com.mi.group.model.vo.Group"%>
<%@ include file="/views/common/header.jsp" %>
<%
String memberId=(String)request.getAttribute("memberId");
List<Group> groupList=(List)request.getAttribute("groupList");
String groupId=(String)request.getAttribute("groupId");

%>
<style>
 #teduri{
  	 position: absolute;
  width: 675px;
  height: 400px;
  z-index: 15;
  top: 45%;
  left: 32%;
  margin: -200px 0 0 -150px;
  border: 1px solid gray;
  
  }
 
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
 	width:290px;
 	height : 40px;
 	font-size: 1.5em;
 }
 #data{
  RepeatLayout : RepeatLayout.table;
 }
 a{
 	text-decoration:none;
 }
 a:link{ color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
#delete-btn{ display:none; }
table#gList-table tr:hover button#delete-btn{display:inline;}
table#gList-table tr td.gList-td {width: 50px; height: 35px;}
</style>
<section id="groupUpdate-container">
	<div id="teduri" name="teduri">
		<div class="inline" id="glist">
		<table id="gList-table">
			<tr>
				<th id="gth">그룹 목록</th>
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
					<a href="javascript:void(0)" onclick="fn_addGroup()"><img src="<%=request.getContextPath() %>/views/group/plus.png" width="30px" id="plus"></a>
				</td>
			</tr>
				
		</table>
		</div>
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


</section>
<%@ include file="/views/common/footer.jsp" %>