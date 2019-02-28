<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.mi.event.model.vo.Event, java.util.*, com.mi.group.model.vo.Group"%>
<%@ include file="/views/common/header.jsp" %>
<%
   Event e=(Event)request.getAttribute("event");
   String memberId=(String)request.getAttribute("memberId");
   List<Group> groupList=(List)request.getAttribute("groupList");
   
%>


<style>
  #teduri{
  width: 100%;
  height: 80%;

  }
  #title{
     width: 230px;
     height: 20px; 
  }

  .dayday{
     height: 25px;
     width: 170px;
  }
  #inteduri{
   height: 200px;
  }
  #area{
     width: 230px;
     height: 30px;
  }
  #memberSel
  {
     height:100px;
  }
  #date-container
  {
     width : 540px;
     overflow-x:hidden;
  }
  #nameUpdate
  {
     width : 330px;
     height: 150px;
     
  }
     #btndiv{
  width:300px;
  padding-top:30px;
  padding-left:20px;
  margin:auto;
  }
   #images{
   margin-left:5px;
   height:80px;width:70%;
    overflow-x:hidden;
    float:left;
   }
   form input[type=submit],[type=button] {
  font-family:Merriweather Sans;
  appearance: none;
  outline: 0;
  background-color: #f4623a;
  border: 0;
  padding: 10px 15px;
  color: white;
  border-radius: 3px;
  width: 100px;
  margin:10px;
  cursor: pointer;
  font-size: 16px;
  -webkit-transition-duration: 0.25s;
          transition-duration: 0.25s;
}
table{
      padding-top:30px;
      
   }
   table tr td{
      height:50px;
      padding-left:10px;
      padding-top:10px;
   }
</style>
<body>
<h1 style="text-align:center;font-family:Merriweather Sans; padding-top:15px;">NEW SCHEDULE</h1>
<hr class="divider my-4">
<div id="teduri">

   <input type="hidden" id="memberId" name="memberId" value=<%=memberId %> />
      
      <table align="center">
         <tr>
            <th>일정</th>
            <td style="colspan='3';"><input type="text" id="title" name="title" autocomplete="off"/></td>
         </tr>
         <tr style="border-bottom:1px solid lightgray;">
            <th>날짜</th>
            <td>
               <input type="date" id="startDate" name="startDate" class="dayday" />-
               <input type="date" id="endDate" name="endDate" class="dayday" />
            </td>
            <td>
               <span style="font-family:Merriweather Sans">Group</span>
               <input type="text" id='groupList' name="groupList" list="data" autocomplete="off"/>
                     <datalist id="data">
                      <%
                      for(int i=0; i<groupList.size();i++){
                      %>
                      <option value="<%=groupList.get(i).getGroupId()%> : <%=groupList.get(i).getGroupName()%>"></option>
                      <%} %>
                   </datalist>
            </td>
         </tr>
         <tr>
            <th>메모</th>
            <td colspan="3">
               <textarea id="memo" name="memo" style="resize: none; overflow-y:scroll" cols="50" rows="5" ></textarea>
            </td>
         </tr>
         <tr>
            <th>파일</th>
            <td colspan="">
               <input id='up_file' type="file" name="up_file" multiple />
            </td>
         </tr>
         <tr>
            <td colspan='4'>
            <div id="images" style="border:1px solid lightgray;padding-left:10px;"></div>
            </td>
         </tr>
      </table>
      
   
   <div id="btndiv">
   <input type="button" id="eUpdate" class="btn" value="저장"/>
   <input type="button" id="backBtn" class="btn" value="취소" onclick="location.href='<%=request.getContextPath()%>/showCalendar?memberId=<%=loginMember.getMemberId()%>'" />
   </div>
</div>

</body>
<script>
   function fn_calUpdate(){
      var title=$('[name=title]').val();
      
      if(title.trim().length==0)
         {
            alert("제목을 입력하세요");
            return false;
         }
      return true;
   }


   $(function(){
      $("[name=up_file]").change(function(){
         var iputFiles=document.getElementById('up_file');
         console.log(iputFiles.files);
         $.each(iputFiles.files, function(index, item){
            console.log(item);
         var reader = new FileReader();
         reader.onload=function(e){
            var img = $("<img></img>").attr("src",e.target.result).css({'width':'90px','height':'80px'});
            $('#images').append(img);
                  
         }
         reader.readAsDataURL(item);
      });
      });
      $('#eUpdate').on("click", function(){
         console.log($('#groupList').val()+":"+typeof $('#groupList').val() )
         console.log("eUpdate----------등록 저장");
         var fd=new FormData();
         fd.append('memo',$('#memo').val());
         fd.append('title',$('#title').val());
         fd.append('startDate',$('#startDate').val());
         fd.append('endDate',$('#endDate').val());
         fd.append('groupList',($('#groupList').val().split(":")[0]));
         fd.append('memberId','<%=memberId%>');
         $.each(document.getElementById('up_file').files, function(i, item){
            fd.append("test"+i,item);
         });
         $.ajax({
            url: "<%=request.getContextPath()%>/eventUpDate",
            data : fd,
            type : "post",
            processData : false,
            contentType : false,
            success : function(data) {
            alert("업로드 완료");
            $('#images').html('');
            $('[name=up_file]').val('');
            location.href="<%=request.getContextPath()%>/showCalendar?memberId=<%=memberId%>";
         }
      });
   });
});
</script>
<%@ include file="/views/common/footer.jsp" %>