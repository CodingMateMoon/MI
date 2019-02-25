<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.mi.event.model.vo.*, com.mi.group.model.vo.* " %>
<%@ include file="/views/common/header.jsp" %>
<link href='<%=request.getContextPath() %>/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='<%=request.getContextPath() %>/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/js/jquery.min.js'></script>
<script src='<%=request.getContextPath() %>/js/fullcalendar.min.js'></script>


<script>
<%
String defaultToday=(String)request.getAttribute("defaultToday");
String memberId=(String)request.getAttribute("memberId");
List<Event> eventList=(List<Event>)request.getAttribute("eventList");
System.out.println(eventList);
List<Group> groupList=(List<Group>)request.getAttribute("groupList");
//그룹이름:색  key-value로 맵에 저장
Map<String, String> map=new HashMap<String, String>();
String Gcolor="";
for(int i=0;i<eventList.size();i++){
	if(eventList.get(i).getGroupId()==null){
		eventList.get(i).setGroupId(memberId);
		Gcolor="#44B3C2";
		map.put(memberId, Gcolor);
	}
	else{
		switch(eventList.get(i).getGroupId()){
		case "G1" : Gcolor="#F1A94E"; break;
		case "G2" : Gcolor="#E45641"; break;
		case "G3" : Gcolor="#5D4C46"; break;
		case "G4" : Gcolor="#7B8D8E"; break;
		case "G5" : Gcolor="#6F3662"; break;
		case "G6" : Gcolor="#90909D"; break;
		}
		map.put(eventList.get(i).getGroupId(), Gcolor);
	}
	
}
%>

  $(document).ready(function() {
	  
	var eventDataset=[
		<%
			for(int i=0;i<eventList.size();i++){
				if(i<eventList.size()-1){
		%>
					{
						"id":'<%=eventList.get(i).getEventId()%>',
						"title":'<%=eventList.get(i).getTitle()%>',
						"start":'<%=eventList.get(i).getStartDate()%>',
						"end":'<%=eventList.get(i).getEndDate()%>',
						"color":'<%=map.get(eventList.get(i).getGroupId())%>'
					},
					<%
					}else{%>
					{
						"id":'<%=eventList.get(i).getEventId()%>',
						"title":'<%=eventList.get(i).getTitle()%>',
						"start":'<%=eventList.get(i).getStartDate()%>',
						"end":'<%=eventList.get(i).getEndDate()%>',
						"color":'<%=map.get(eventList.get(i).getGroupId())%>'
					}
				<%}
			}%>
		];
	
    
    var htmlStr="";
    htmlStr+="<tr>";
   	htmlStr+="<td>";
   	htmlStr+="<ul id='group_container'>";
   	htmlStr+="<li><b>GroupList</b></li>";
   	htmlStr+="<li><span onclick='fn_memberCal_ajax()' style='color:<%=map.get(memberId)%>;cursor:pointer;'>My schedule</span> </li>";
   	<%for(Group g : groupList){%>
   	htmlStr+="<li ><span style='color:<%=map.get(g.getGroupId())%>; cursor:pointer'><%=g.getGroupName() %></span></li>";
   	<%}%>
   	htmlStr+="</ul>";
   	htmlStr+="</td>";
   	htmlStr+="<td>";
   	htmlStr+="<div id='calendar'></div>";
   	htmlStr+="</td>";
   	htmlStr+="</tr>";
   	$('.content_container').html(htmlStr);
   
   	$('#calendar').fullCalendar({
        header: {
          left: 'prev',
          center: 'title',
          right: 'today, next'
        },
        defaultDate: '<%=defaultToday%>',
        navLinks: false, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events:eventDataset,
        eventClick: function(event) {
      	    console.log(event);
      	    
      	  }
      });
  });
	
</script>
<style>

 body {
    margin: 20px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width:90%;
    max-width:600px;
    margin: 10px 20px;
    display:inline-block;
  }
  .content_container{
  	width:80%;
  	float:right;
  }
  #group_container{
  	display:inline-block;
  	border:1px solid lightgray;
  	list-style:none;
  	max-width:150px;
  	height:180px;
  	text-align : center;
  	width:100%;
  	margin:0px;
  	padding:0px;
  }
  #group_container li{
  	padding:6px;
  }
  #group_container li span{
  	width:150px; 
  	font-size : 14px;
  	text-decoration:none;
  }
  #group_container li span:hover, ul li span:focus {
  	border:1px solid lightgray;
  	font:bold;
  }
  #group_container li span.now {
	color:#fff;
	background-color:#f40;
	border:1px solid #f40;
}
  	

</style>
</head>



<body>
<table class="content_container">
<%-- <tr>
<td>
	<ul id="group_container">
		<li><b>Group List</b></li>
		<li><span onclick="fn_memberCal_ajax()" style="color:<%=map.get(memberId)%>;cursor:pointer;">My schedule</span> </li>
		<%
			for(Group g : groupList){
		%>
		<li ><span style="color:<%=map.get(g.getGroupId())%>; cursor:pointer"><%=g.getGroupName() %></span></li>
		<%} %>
	</ul>
</td>
<td>
  	<div id='calendar'></div>
</td>
</tr> --%>
</table>
<script>
	function fn_memberCal_ajax(){
		
		<%List<Event> memberEventList=new ArrayList<Event>();%>  
		
		$.ajax({
			type:"get",
			url:"<%=request.getContextPath()%>/calendar/memberAjax.do",
			data:{"memberId":'<%=loginMember.getMemberId()%>'},
			dataType:"json",
			contentType:'application/json',
			success:function(data){
				
				<%-- for(var i=0;i<data.eventJArr.length;i++){
					console.log(data.eventJArr[i].eventId);
					<% memberEventList.add(data.eventJArr[i]);%>
					
				} 
				<%System.out.println(memberEventList);%> --%>
				
			
<%-- 				var memberEventDataset=[
				
				
		<%
			for(int i=0;i<memberEventList.length;i++){
				if(i<memberEventList.length-1){
		%>
					{
						"id":"'"+data.eventJArr[i].eventId+"'",
						"title":"'"+data.eventJArr[i].title+"'",
						"start":"'"+data.eventJArr[i].startDate+"'",
						"end":"'"+data.eventJArr[i].endDate+"'",
						"color":"'"+map.get(data.eventJArr[i].groupId)%>+"'"
					},
					<%
					}else{%>
					{
						"id":"'"+data.eventJArr[i].eventId+"'",
						"title":"'"+data.eventJArr[i].title+"'",
						"start":"'"+data.eventJArr[i].startDate+"'",
						"end":"'"+data.eventJArr[i].endDate+"'",
						"color":"'"+map.get(data.eventJArr[i].groupId)%>+"'"
					}
				<%}
			}%>
		];
				
			    
			    var htmlStr="";
			    htmlStr+="<tr>";
			   	htmlStr+="<td>";
			   	htmlStr+="<ul id='group_container'>";
			   	htmlStr+="<li><b>GroupList</b></li>";
			   	htmlStr+="<li><span onclick='fn_memberCal_ajax()' style='color:<%=map.get(memberId)%>;cursor:pointer;'>My schedule</span> </li>";
			   	<%for(Group g : groupList){%>
			   	htmlStr+="<li ><span style='color:<%=map.get(g.getGroupId())%>; cursor:pointer'><%=g.getGroupName() %></span></li>";
			   	<%}%>
			   	htmlStr+="</ul>";
			   	htmlStr+="</td>";
			   	htmlStr+="<td>";
			   	htmlStr+="<div id='calendar'></div>";
			   	htmlStr+="</td>";
			   	htmlStr+="</tr>";
			   	$('.content_container').html(htmlStr);
			   
			   	$('#calendar').fullCalendar({
			        header: {
			          left: 'prev',
			          center: 'title',
			          right: 'today, next'
			        },
			        defaultDate: '<%=defaultToday%>',
			        navLinks: false, // can click day/week names to navigate views
			        editable: true,
			        eventLimit: true, // allow "more" link when too many events
			        events:memberEventDataset,
			        eventClick: function(event) {
			      	    console.log(event);
			      	    
			      	  }
			      });
			--%>	
			},
			error:function(request,status,error){
				alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리

			}
		}); 
 	}
	
</script>
</body>

<%@ include file="/views/common/footer.jsp" %>

</html>
