<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.mi.event.model.vo.*, com.mi.group.model.vo.* " %>
<%@ include file="/views/common/header.jsp" %>
<link href='<%=request.getContextPath() %>/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='<%=request.getContextPath() %>/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/js/jquery.min.js'></script>
<script src='<%=request.getContextPath() %>/js/fullcalendar.min.js'></script>

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
			Gcolor="lightcoral";
			map.put(memberId, Gcolor);
		}
		else{
			switch(eventList.get(i).getGroupId()){
			case "G1" : Gcolor="lightgreen"; break;
			case "G2" : Gcolor="lightblue"; break;
			case "G3" : Gcolor="lightseagreen"; break;
			case "G4" : Gcolor="lightpink"; break;
			case "G5" : Gcolor="ligthgray"; break;
			case "G6" : Gcolor="lightslategrey"; break;
			}
			map.put(eventList.get(i).getGroupId(), Gcolor);
		}
		
	}
%>
<script>
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

  $(document).ready(function() {

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
  ul li{
  	padding:6px;
  }
  ul li a{
  	padding:3px; 
  	font-size : 14px;
  	text-decoration:none;
  }
  ul li a:hover, ul li a:focus {
  	border:1px solid lightgray;
  	font:bold;
  }
  ul li a.now {
	color:#fff;
	background-color:#f40;
	border:1px solid #f40;
}
  	

</style>
</head>



<body>
<table class="content_container">
<tr>
<td>
	<ul id="group_container">
		<li><span><b>Group List</b></span></li>
		<li><a href="#" style="color:<%=map.get(memberId)%>">My schedule</a></li>
		<%
			for(Group g : groupList){
		%>
		<li ><a href="#" style="color:<%=map.get(g.getGroupId())%>;"><%=g.getGroupName() %></a></li>
		<%} %>
	</ul>
</td>
<td>
  	<div id='calendar'></div>
</td>
</tr>
</table>
</body>

<%@ include file="/views/common/footer.jsp" %>

</html>
