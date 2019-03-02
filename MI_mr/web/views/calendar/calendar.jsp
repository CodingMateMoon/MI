<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.mi.event.model.vo.*, com.mi.group.model.vo.* " %>
<%@ include file="/views/common/header.jsp" %>
<link href='<%=request.getContextPath() %>/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='<%=request.getContextPath()%>/css/bootstrap.css' rel='stylesheet'/>
<script src='<%=request.getContextPath() %>/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/js/jquery.min.js'></script>
<script src='<%=request.getContextPath() %>/js/fullcalendar.min.js'></script>
<script src='<%=request.getContextPath() %>/js/moment.js'></script>
<script src='<%=request.getContextPath() %>/js/bootstrap.min.js'></script>


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
   htmlStr+="<li><span onclick='fn_groupCal_ajax()' style='color:"+map.get(g.getGroupId())+"; cursor:pointer';>"+g.getGroupId()+":"+g.getGroupName()+"</span></li>";
   }
   htmlStr+="</ul>";
   htmlStr+="</li>";
   htmlStr+="</ul>";
   htmlStr+="</td>";
   htmlStr+="<td>";
   htmlStr+="<div id='calendar'></div>";
   htmlStr+="</td>";
   htmlStr+="</tr>";
   htmlStr+="<div id='fullCalModal' class='modal fade'>";
   htmlStr+="<div class='modal-dialog'>";
   htmlStr+="<div class='modal-content'>";
   htmlStr+="<div class='modal-header'>";
   htmlStr+="<h3 id='modalTitle' class='modal-title'></h3>";
   htmlStr+="<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>×</span> <span class='sr-only'>close</span></button>";
   htmlStr+=" </div>";
   htmlStr+=" <div id='modalBody' class='modal-body'>";
   htmlStr+="<h5 id='modalDate'></h5>";
   htmlStr+="<h5 id='modalGroup'></h5>";
   htmlStr+="<div id='memoContainer' style='height:100px; border-top:1px solid lightgray'>";
   htmlStr+="<h5>메모</h5>";
   htmlStr+="<p id='modalMemo'></p>";
   htmlStr+="<input type='hidden' id='getEventId'/>";
   htmlStr+="</div>";
   htmlStr+="</div>";
   htmlStr+="<div class='modal-footer'>";
   htmlStr+="<button class='btn btn-primary' data-dismiss='modal' style='background-color: #f4623a;border:#f4623a;''><a id='eventUrl' target='_blank' color='white'>Close</a></button>";
   htmlStr+="</div>";
   htmlStr+="</div>";
   htmlStr+="</div>";

%>

  $(document).ready(function() {
     
   var eventDataset=[
      <%
      String gName="";
         
         for(int i=0;i<eventList.size();i++){
            if(i<eventList.size()-1){
               String gId=eventList.get(i).getGroupId();
               
               for(int j=0;j<groupList.size();j++){
                  if(gId.equals(groupList.get(j).getGroupId())){
                     gName=groupList.get(j).getGroupName();
                  }   
               }
               
      %>
               {
                  "id":'<%=eventList.get(i).getEventId()%>',
                  "title":'<%=eventList.get(i).getTitle()%>',
                  "start":'<%=eventList.get(i).getStartDate()%>',
                  "end":'<%=eventList.get(i).getEndDate()%>',
                  "color":'<%=map.get(eventList.get(i).getGroupId())%>',
                  "discription":'<%=eventList.get(i).getMemo()%>',
                  "resourceId":'<%=gName%>'
               },
               <%
               }else{%>
               {
                  "id":'<%=eventList.get(i).getEventId()%>',
                  "title":'<%=eventList.get(i).getTitle()%>',
                  "start":'<%=eventList.get(i).getStartDate()%>',
                  "end":'<%=eventList.get(i).getEndDate()%>',
                  "color":'<%=map.get(eventList.get(i).getGroupId())%>',
                  "discription":'<%=eventList.get(i).getMemo()%>',
                  "resourceId":'<%=gName%>'
               }
            <%}
         }%>
      ];
   
    
    var htmlStr="";

   <%-- $('.content_container').html("<%=htmlStr%>"); --%>
   
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
        eventClick: function(event, jsEvent, view) {
           var eventEnd=moment(event.end).format('YYYY.MM.DD(ddd)');
           var eventId=event.id;
           if(event.end==null){eventEnd=moment(event.start).format('YYYY.MM.DD(ddd)');}
           var groupName=event.id;
           console.log(event);
            $('#modalTitle').html(event.title);
             $('#modalDate').html("날짜 : "+moment(event.start).format('YYYY.MM.DD(ddd)')+" - "+eventEnd);
             $('#modalGroup').html("그룹 : "+event.resourceId)
             $("#modalMemo").html(event.description);
             $("#getEventId").val(event.id);
             $('#eventUrl').attr('href',event.url);
             $('#fullCalModal').modal();
           },
         dayClick:function(date, allDay, isEvent, view){
            var yy=date.format("YYYY");
            var mm=date.format("MM");
            var dd=date.format("DD");
            console.log(yy+"-"+mm+"-"+dd);
            location.replace('<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>');
            
         }
      });
  });

   
</script>
<style>

 body {
    margin: 20px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif,Merriweather Sans;
    font-size: 14px;
  }

  #calendar {
    max-width:80%;
    padding-left:70px;
    margin: 10px 20px;
    display:inline-block;
  }
  .content_container{
     width:100%;
     height:100%;
  }
  #choice_GroupMember{
     display:block;
     overflow-y:scroll;
     width:400px;
     heigth:500px;
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
     font-size : 14px;
     text-decoration:none;
  }
  .choice_container ul.choice_GroupMember li span:hover, ul.choice_GroupMember li span:focus {
     
     border:1px solid lightgray;
     font:bold;
  }
  .choice_container ul.choice_GroupMember li span.now {
   border:1px solid #f40;
}

.choice_container ul.choice_GroupMember li ul li{
   display: none;
}
.choice_container ul.choice_GroupMember li ul li span{
font-size:12px;   
}
.group_container{
   display: none;
}
.choice_container ul li#groupSchedule{ transition:all 0.5s;}
.choice_container ul li#groupSchedule:hover ul li{ transition: all 0.5s; display:block; }
.btn btn-primary{
  font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  color: white;
  border-radius: 3px;
  width: 80px;
  height:30px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}
     

</style>
</head>



<body>
<h1 style="text-align:center;font-family:Merriweather Sans;">MY CALENDAR</h1>
<hr class="divider my-4">
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
         <li><span onclick="fn_groupCal_ajax()" style="color:<%=map.get(g.getGroupId())%>; cursor:pointer;"><%=g.getGroupId() %>:<%=g.getGroupName() %></span></li>
         <%} %>
         </ul>
      </li>
   </ul>
   
</td>
<td>
     <div id='calendar'></div>
     
     

</td>
</tr>
     <!-- 모달창 -->
<div id="fullCalModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
             <h3 id="modalTitle" class="modal-title"></h3>
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
            </div>
            <div id="modalBody" class="modal-body">
                 <h5 id="modalDate"></h5>
               <h5 id="modalGroup"></h5>
               <div id="memoContainer" style="height:100px; border-top:1px solid lightgray">
               <h5>메모</h5>
                <p id="modalMemo"></p>
                <input type="hidden" id="getEventId"/>
                </div>
            </div>
            <div class="modal-footer">
                 <button class="btn btn-primary" data-dismiss="modal" style="background-color: #f4623a;border:#f4623a;"><a id="eventUrl" target="_blank" color="white">Close</a></button>
 
            </div>
        </div>
    </div>
</div>
</table>

<script>
function fn_groupCal_ajax(){
   var groupHtml=event.srcElement.innerHTML;
   var groupSplit=groupHtml.split(":");
   var groupId=groupSplit[0];
   $.ajax({
      type:"get",
      url:"<%=request.getContextPath()%>/calendar/groupAjax.do",
      data:{"memberId":'<%=loginMember.getMemberId()%>',"groupId":groupId},
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
                  "color":colorMap[data.eventJArr[i].groupId],
                  "discription":data.eventJArr[i].memo,
                  "resourceId":data.eventJArr[i].groupId
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
              eventClick: function(event, jsEvent, view) {
                 var eventEnd=moment(event.end).format('YYYY.MM.DD(ddd)');
                 var eventId=event.id;
                 if(event.end==null){eventEnd=moment(event.start).format('YYYY.MM.DD(ddd)');}
                 var groupName=event.id;
                 console.log(event);
                  $('#modalTitle').html(event.title);
                   $('#modalDate').html("날짜 : "+moment(event.start).format('YYYY.MM.DD(ddd)')+" - "+eventEnd);
                   $('#modalGroup').html("그룹 : "+event.resourceId)
                   $("#modalMemo").html(event.description);
                   $("#getEventId").val(event.id);
                   $('#eventUrl').attr('href',event.url);
                   $('#fullCalModal').modal();
                 },
               dayClick:function(date, allDay, isEvent, view){
                  var yy=date.format("YYYY");
                  var mm=date.format("MM");
                  var dd=date.format("DD");
                  console.log(yy+"-"+mm+"-"+dd);
                  location.replace('<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>');
                  
               }
            });
         
      },
      error:function(request,status,error){
         alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리

      }
   }); 
   }
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
            if(groupId==null){
               Gcolor="#44B3C2";
               colorMap['<%=loginMember.getMemberId()%>']=Gcolor;}
            else{
               switch(groupId){
               case "G1" : Gcolor="#F1A94E"; colorMap["G1"]=Gcolor;break;
               case "G2" : Gcolor="#E45641"; colorMap["G2"]=Gcolor;break;
               case "G3" : Gcolor="#5D4C46"; colorMap["G3"]=Gcolor;break;
               case "G4" : Gcolor="#7B8D8E"; colorMap["G4"]=Gcolor;break;
               case "G5" : Gcolor="#6F3662"; colorMap["G5"]=Gcolor;break;
               case "G6" : Gcolor="#90909D"; colorMap["G6"]=Gcolor;break;
               }
            }
            if(groupId==null){
               memberEventDataset.push({
                  "id":data.eventJArr[i].eventId,
                  "title":data.eventJArr[i].title,
                  "start":moment(data.eventJArr[i].startDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
                  "end":moment(data.eventJArr[i].endDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
                  "color":colorMap['<%=loginMember.getMemberId()%>'],
                  "discription":data.eventJArr[i].memo,
                  "resourceId":data.eventJArr[i].groupId
               });
            }else{
               memberEventDataset.push(
                  {
                  "id":data.eventJArr[i].eventId,
                  "title":data.eventJArr[i].title,
                  "start":moment(data.eventJArr[i].startDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
                  "end":moment(data.eventJArr[i].endDate,"M월 DD,YYYY").format("YYYY-MM-DD"),
                  "color":colorMap[data.eventJArr[i].groupId],
                  "discription":data.eventJArr[i].memo,
                  "resourceId":data.eventJArr[i].groupId
                  }
               );
            }
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
              eventClick: function(event, jsEvent, view) {
                 var eventEnd=moment(event.end).format('YYYY.MM.DD(ddd)');
                 var eventId=event.id;
                 if(event.end==null){eventEnd=moment(event.start).format('YYYY.MM.DD(ddd)');}
                 var groupName=event.id;
                 console.log(event);
                  $('#modalTitle').html(event.title);
                   $('#modalDate').html("날짜 : "+moment(event.start).format('YYYY.MM.DD(ddd)')+" - "+eventEnd);
                   $('#modalGroup').html("그룹 : "+event.resourceId)
                   $("#modalMemo").html(event.description);
                   $("#getEventId").val(event.id);
                   $('#eventUrl').attr('href',event.url);
                   $('#fullCalModal').modal();
                 },
               dayClick:function(date, allDay, isEvent, view){
                  var yy=date.format("YYYY");
                  var mm=date.format("MM");
                  var dd=date.format("DD");
                  console.log(yy+"-"+mm+"-"+dd);
                  location.replace('<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>');
                  
               }
            });
         
      },
      error:function(request,status,error){
         alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리

      }
   }); 
   }
function fn_groupsCal_ajax(){
   var groupName=$(this).attr("id");
   console.log(groupName);
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
                  "color":colorMap[data.eventJArr[i].groupId],
                  "discription":data.eventJArr[i].memo,
                  "resourceId":data.eventJArr[i].groupId
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
              eventClick: function(event, jsEvent, view) {
                 var eventEnd=moment(event.end).format('YYYY.MM.DD(ddd)');
                 var eventId=event.id;
                 if(event.end==null){eventEnd=moment(event.start).format('YYYY.MM.DD(ddd)');}
                 var groupName=event.id;
                 console.log(event);
                  $('#modalTitle').html(event.title);
                   $('#modalDate').html("날짜 : "+moment(event.start).format('YYYY.MM.DD(ddd)')+" - "+eventEnd);
                   $('#modalGroup').html("그룹 : "+event.resourceId)
                   $("#modalMemo").html(event.description);
                   $("#getEventId").val(event.id);
                   $('#eventUrl').attr('href',event.url);
                   $('#fullCalModal').modal();
                 },
               dayClick:function(date, allDay, isEvent, view){
                  var yy=date.format("YYYY");
                  var mm=date.format("MM");
                  var dd=date.format("DD");
                  console.log(yy+"-"+mm+"-"+dd);
                  location.replace('<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>');
                  
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
                     "color":'#44B3C2',
                     "discription":data.eventJArr[i].memo,
                     "resourceId":data.eventJArr[i].groupId
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
                 eventClick: function(event, jsEvent, view) {
                    var eventEnd=moment(event.end).format('YYYY.MM.DD(ddd)');
                    var eventId=event.id;
                    if(event.end==null){eventEnd=moment(event.start).format('YYYY.MM.DD(ddd)');}
                    var groupName=event.id;
                    console.log(event);
                     $('#modalTitle').html(event.title);
                      $('#modalDate').html("날짜 : "+moment(event.start).format('YYYY.MM.DD(ddd)')+" - "+eventEnd);
                      $('#modalGroup').html("그룹 : "+event.resourceId)
                      $("#modalMemo").html(event.description);
                      $("#getEventId").val(event.id);
                      $('#eventUrl').attr('href',event.url);
                      $('#fullCalModal').modal();
                    },
                  dayClick:function(date, allDay, isEvent, view){
                     var yy=date.format("YYYY");
                     var mm=date.format("MM");
                     var dd=date.format("DD");
                     console.log(yy+"-"+mm+"-"+dd);
                     location.replace('<%=request.getContextPath()%>/event?memberId=<%=loginMember.getMemberId()%>');
                     
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