<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import=" java.util.*, com.mi.group.model.vo.GroupByMember"%>
<%@ page import="com.mi.member.model.vo.Member" %>
<%
String memberId=(String)request.getAttribute("memberId");
List<GroupByMember> groupMemberList=(List)request.getAttribute("groupMemberList");
Member logginMember=(Member)session.getAttribute("loginMember");
String groupId=(String)request.getAttribute("groupId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#addMemberview
	{
		width: 290px;
		height: 150px;
		/* border: 2px solid red; */
		overflow-x:hidden;
	}
	#gMemberList
	{
		width: 290px;
		height: 200px;
		/* border: 2px solid blue; */
		overflow-x: hidden;
	}
	#gMemberPlus
	{
 /* 	position: relative;
		top:50%;
		left:50%;
		/* margin-top:-25px;
		margin-left:-25px; */ */
		
	}
	#teduri3
	{
		width: 300px;
		height: 400px;
		/* border: 1px solid green; */
	}
h4{
	margin : 0%
}
#btnDiv{
	/* border: 1px solid yellow; */
	width: 120px;
	float:right;
}
/* #addmember{ border: 1px solid black;} */
</style>
<body>
<div id="teduri3">
	<div id="gMemberList">
	<table>
		<tr>
			<th>멤버 목록</th>
		</tr>
		  <%for(GroupByMember gbm : groupMemberList){%>
                <tr>
                	<td align="center">
                	<%=gbm.getMemberId() %>
                	</td>
                </tr>
                <%} %>
	</table>
	</div>
	<div id="addMemberview">
		<h4>멤버 추가</h4>
			<input type="search" name="serachId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
		<datalist id="datalist">
		</datalist>
		<div id="addmember"></div>
		
		
		<!-- <img src="/views/group/plus.png" width="30px" id="gMemberPlus"/> -->
	</div>
	<div id="btnDiv">
		<input type="submit" id="addMemberBtn" value="등록"/>
		<input type="button" id="deleteBtn" value="그룹제거"/>
	
	</div>
</div>
<script>
$(function(){
	
	$('#addMemberBtn').click(function(){
		
		var members=[];
		$.each($('.addGroupMember'),function(index,item){
			members.push(item.innerHTML);
		});
		$.ajax({
			url:"<%=request.getContextPath()%>/updateMember.do",
			data:{"addGroupId":'<%=groupId%>',"members":members},
			type:"post",
			success:function(data){
				console.log(data);
				location.href="<%=request.getContextPath()%>/groupView?memberId=<%=logginMember.getMemberId()%>";
			}
		})
	});
	$("#searchId").change(function(){
		var value=$(this).val();
		var flag=false;
		//console.log($('#datalist').children())
		 $.each($('#datalist').children(),function(index,item){
			console.log(item);
			 if(value==item.innerHTML)
			{
				flag=true;
			}
			 else{alert("아이디를 전부입력하세요");}
			 
			 //이쪽에서 아이디가 중복값인가 확인해놔야된다. 이쪽에 로직을 구현하자
		});
		if(flag){
			$('#addmember').append($('<tr><td class="addGroupMember">'+value+'</td></tr>'));
			$(this).val("");
			
			$('.addGroupMember').click(function(){
				if('<%=logginMember.getMemberId()%>'!=$(this).html()) 
				{
					$(this).parent().remove();					
				}
			});
		}
	});
	
	$("#searchId").keyup(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/member/selectId.do",
			type:"post",
			data:{"search":$("#searchId").val()},
			success:function(data){
					var html="";
					for(var i=0;i<data.length;i++)
					{
						html+='<option>'+data[i]+"</option>";
					}
				$('#datalist').html(html);
			}
		});
	});
	
	$('#deleteBtn').click(function(){
		var conf = confirm("정말 삭제하시겠습니까?")
		if (conf === true){
			$.ajax({
				url:"<%=request.getContextPath()%>/deleteGroup.do",
				data:{"delGroupId":'<%=groupId%>'},
				type:"post",
				success:function(data){
					console.log(data);
					location.href="<%=request.getContextPath()%>/groupView?memberId=<%=logginMember.getMemberId()%>";
				}
			})
		}
	})
	
	
	
	
});	



</script>
</body>
</html>