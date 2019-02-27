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
  	 position: absolute;
  width: 550px;
  height: 400px;
  z-index: 15;
  top: 45%;
  left: 40%;
  margin: -200px 0 0 -150px;
  border: 2px solid gray;
  }
  #title{
  	width: 230px;
  	height: 30px; 
  }
  .btn{
  	width: 50px;
  	height: 30px;
  	background-color: #DCF3ED;
  }
  .dayday{
  	height: 25px;
  	width: 146px;
  }
  #inteduri{
  /*  border: 2px solid red;  */
   height: 200px;
  }
  #area{
  	width: 230px;
  	height: 30px;
  }
  #memberSel
  {
  	 /* border: 1px solid black;  */
  	height:100px;
  }
  #date-container
  {
  	/* border: 1px solid blue; */
  	width : 540px;
  	overflow-x:hidden;
  }
  #nameUpdate
  {
  	/* border: 1px solid green; */
  	width : 330px;
  	height: 150px;
  	
  }
	#btndiv
	{
		/* border: 1px solid red; */
		width: 133px;
  		height: 40px;
  		float:right;
  		
	}
	#images{
	margin-left:5px;
	height:80px;width:70%;
	 overflow-x:hidden;
	 float:left;
	 
	 
	}
</style>
<section id="calUpdate-container">
<div id="teduri">
	<div id="nameUpdate" >
	<input type="hidden" id="memberId" name="memberId" value=<%=memberId %> />
		제목 <input type="text" id="title" name="title" autocomplete="off"/>
		<br/>
		<br/>
		<input type="date" id="startDate" name="startDate" class="dayday" />
		-
		<input type="date" id="endDate" name="endDate" class="dayday" />
		<table id="member-container">
			<tr>
				<th>그룹 선택</th>
			</tr>
			<tr>
				<td>
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
		</table>
	</div>

	<hr>
	<div  id="date-container" >
		<table id="tbl-date">
			<tr>
				<th>메 모</th>
				<td>
					<textarea id="memo" name="memo" style="resize: none; overflow-y:scroll"
					 cols="60" rows="7" ></textarea>
				</td>
			</tr>
			<tr>
			<tr>
				<th>파일업로드</th>
				<td>
					<input id='up_file' type="file" name="up_file" multiple />
				</td>
			</tr>
		</table>
	</div>
	<div id="images"></div>
	<div id="btndiv">
	<input type="button" id="eUpdate" class="btn" value="저장"/>
	&nbsp
	<input type="button" id="backBtn" class="btn" value="취소" onclick="location.href='<%=request.getContextPath()%>/'" />
	</div>
</div>
</section>
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
