<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.mi.group.model.vo.Group"%>
<%@ include file="/views/common/header.jsp" %>
<%
String memberId=(String)request.getAttribute("memberId");
List<Group> groupList=(List)request.getAttribute("groupList");
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
  border: 2px solid red;
  }
 
 #glist
 {
 	overflow-x:hidden;
 	width: 300px;
 	height: 400px;
 	border: 2px solid blue;
 }
 #changeView{
 	width:350px;
 	height: 400px;
 	border: 2px solid yellow;
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
</style>
<section id="groupUpdate-container">
<form action="<%=request.getContextPath()%>/groupList" method="post">
	<div id="teduri" name="teduri">
	<input type="hidden" id="memberId" name="memberId" value=<%=memberId %> />
		<div class="inline" id="glist">
		<table width="295px"; height="45px";>
			<tr id="gtr">
				<th id="gth">그룹 목록</th>
			</tr>
			<tr>
				<td align="center">
					<input type="text" name="groupList" list="data"/>
				</td>
			</tr>
                <datalist id="data">
                <%
                	for(int i=0; i<groupList.size();i++){
                %>
                	<option value=<%=groupList.get(i).getGroupName()%>></option>
                <%} %>
                </datalist>
			<tr>
				<td align='right' cellpadding=0 cellspacing=0 >
					<a href="<%=request.getContextPath()%>/groupUpdate"><img src="<%=request.getContextPath() %>/views/group/plus.png" width="30px" id="plus"></a>
				</td>
			</tr>
				
		</table>
		</div>
	<div class="inline" id="changeView">
	
	</div>
	</div>
</form>
</section>
<%@ include file="/views/common/footer.jsp" %>