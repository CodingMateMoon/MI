<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.mi.event.model.vo.*, com.mi.group.model.vo.* " %>
<%@ include file="/views/common/header.jsp" %>
<link href='<%=request.getContextPath() %>/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='<%=request.getContextPath() %>/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/js/jquery.min.js'></script>
<script src='<%=request.getContextPath() %>/js/fullcalendar.min.js'></script>
<script src='<%=request.getContextPath() %>/js/moment.js'></script>

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
 

String htmlStr="";
	htmlStr+="<tr>";
	htmlStr+="<td class='choice_container'>";
	htmlStr+="<ul id='choice_GroupMember'>";
	htmlStr+="<li><span onclick='fn_defaultCal_ajax()' style='cursor:pointer;font:16px;'>Schedule</span></li>";
	htmlStr+="<li><span onclick='fn_memberCal_ajax()' style='color:"+map.get(memberId)+";cursor:pointer'>My schedule</span> </li>";
	htmlStr+="<li id='groupSchedule'><span onclick='fn_groupsCal_ajax()' style='cursor:pointer;font:16px'>Group Schedule</span>";
	htmlStr+="<ul id='group_container'>";
	for(Group g : groupList){
	htmlStr+="<li><span style='color:"+map.get(g.getGroupId())+"; cursor:pointer'>"+g.getGroupName()+"</span></li>";
}
	htmlStr+="</ul>";
	htmlStr+="</li>";
	htmlStr+="</ul>";
	htmlStr+="</td>";
	htmlStr+="<td>";
	htmlStr+="<div id='calendar'></div>";
	htmlStr+="</td>";
	htmlStr+="</tr>";
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

   <%-- 	$('.content_container').html("<%=htmlStr%>");
    --%>
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
  #choice_GroupMember{
  	display:block;
  	border:1px solid lightgray;
  }
  .choice_container ul {
  	display:block;
  	list-style:none;
  	max-width:150px;
  	height:180px;
  	text-align : center;
  	width:100%;
  	margin:0px;
  	padding:0px;
  }
  .choice_container ul li{
  	padding:6px;
  }
  .choice_container ul li span{
  	width:150px; 
  	font-size : 15px;
  	text-decoration:none;
  }
  .choice_container ul li span:hover, ul li span:focus {
  	border:1px solid lightgray;
  	font:bold;
  }
  .choice_container ul li span.now {
	border:1px solid #f40;
}

.choice_container ul li ul li{
	display: none;
}
.group_container{
	display: none;
}
.choice_container ul li#groupSchedule{ transition:all 0.5s;}
.choice_container ul li#groupSchedule:hover ul li{ transition: all 0.5s; display:block; }

  	

</style>
</head>



<body>
<table class="content_container">
<tr>
<td class="choice_container">
	<ul id="choice_GroupMember">
		<li><span onclick="fn_defaultCal_ajax()" style="cursor:pointer;font:16px;">Schedule</span></li>
		<li><span onclick="fn_memberCal_ajax()" style="color:<%=map.get(memberId)%>;cursor:pointer;font:16px">My schedule</span> </li>
		<li id="groupSchedule"><span onclick="fn_groupsCal_ajax()" style="cursor:pointer;font:16px">Group Schedule</span>
			<ul id="group_container">
			<%
				for(Group g : groupList){
			%>
			<li ><span style="color:<%=map.get(g.getGroupId())%>; cursor:pointer"><%=g.getGroupName() %></span></li>
			<%} %>
			</ul>
		</li>
	</ul>
	
</td>
<td>
  	<div id='calendar'></div>
</td>
</tr>
</table>
<script>
function fn_defaultCal_ajax(){
	$.ajax({
		type:"get",
		url:"<%=request.getContextPath()%>/calendar/defaultAjax.do",
		data:{"memberId":'<%=loginMember.getMemberId()%>'},
		dataType:"json",
		contentType:'application/json',
		success:function(data){
			var memberEventDataset=[];
			var colorMap={};
			
			for(var i=0; i<data.eventJArr.length;i++){
				var groupId=data.eventJArr[i].groupId;
				switch(groupId){
				case "G1" : Gcolor="#F1A94E"; colorMap["G1"]=Gcolor;break;
				case "G2" : Gcolor="#E45641"; colorMap["G2"]=Gcolor;break;
				case "G3" : Gcolor="#5D4C46"; colorMap["G3"]=Gcolor;break;
				case "G4" : Gcolor="#7B8D8E"; colorMap["G4"]=Gcolor;break;
				case "G5" : Gcolor="#6F3662"; colorMap["G5"]=Gcolor;break;
				case "G6" : Gcolor="#90909D"; colorMap["G6"]=Gcolor;break;
				}
				memberEventDataset.push(
					{
						"id":data.eventJArr[i].eventId,
						"title":data.eventJArr[i].title,
						"start":moment(data.eventJArr[i].startDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
						"end":moment(data.eventJArr[i].endDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
						"color":colorMap[data.eventJArr[i].groupId]
					}
					);
			}
			
		   	$('.content_container').html("<%=htmlStr%>");
		   
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
			
		},
		error:function(request,status,error){
			alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리

		}
	}); 
	}
function fn_groupsCal_ajax(){
	$.ajax({
		type:"get",
		url:"<%=request.getContextPath()%>/calendar/groupsAjax.do",
		data:{"memberId":'<%=loginMember.getMemberId()%>'},
		dataType:"json",
		contentType:'application/json',
		success:function(data){
			var memberEventDataset=[];
			var colorMap={};
			
			for(var i=0; i<data.eventJArr.length;i++){
				var groupId=data.eventJArr[i].groupId;
				switch(groupId){
				case "G1" : Gcolor="#F1A94E"; colorMap["G1"]=Gcolor;break;
				case "G2" : Gcolor="#E45641"; colorMap["G2"]=Gcolor;break;
				case "G3" : Gcolor="#5D4C46"; colorMap["G3"]=Gcolor;break;
				case "G4" : Gcolor="#7B8D8E"; colorMap["G4"]=Gcolor;break;
				case "G5" : Gcolor="#6F3662"; colorMap["G5"]=Gcolor;break;
				case "G6" : Gcolor="#90909D"; colorMap["G6"]=Gcolor;break;
				}
				memberEventDataset.push(
					{
						"id":data.eventJArr[i].eventId,
						"title":data.eventJArr[i].title,
						"start":moment(data.eventJArr[i].startDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
						"end":moment(data.eventJArr[i].endDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
						"color":colorMap[data.eventJArr[i].groupId]
					}
					);
			}
			
		   	$('.content_container').html("<%=htmlStr%>");
		   
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
			
		},
		error:function(request,status,error){
			alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리

		}
	}); 
	}


	function fn_memberCal_ajax(){
		
		$.ajax({
			type:"get",
			url:"<%=request.getContextPath()%>/calendar/memberAjax.do",
			data:{"memberId":'<%=loginMember.getMemberId()%>'},
			dataType:"json",
			contentType:'application/json',
			success:function(data){
				var memberEventDataset=[];
				for(var i=0; i<data.eventJArr.length;i++){
					var groupId=data.eventJArr[i].groupId;
					memberEventDataset.push(
						{
							"id":data.eventJArr[i].eventId,
							"title":data.eventJArr[i].title,
							"start":moment(data.eventJArr[i].startDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
							"end":moment(data.eventJArr[i].endDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
							"color":'#44B3C2'
						}
						);
				}
				
				console.log(data.eventJArr[1].startDate);
			 	console.log(moment(data.eventJArr[1].startDate,"M월 DD,YYYY").format("YYYY-MM-DD")); 
				console.log(memberEventDataset);
				
			   	$('.content_container').html("<%=htmlStr%>");
			   
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
