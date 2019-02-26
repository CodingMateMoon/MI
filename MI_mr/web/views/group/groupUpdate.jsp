<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.mi.member.model.vo.Member" %>
<%
	Member logginMember=(Member)session.getAttribute("loginMember");
%>    
<style>
	#mList
	{
		/* border: 1px solid red; */
		width: 180px;
		height: 300px;
		display: inline-block;
	}
	#addM
	{
		/* border: 1px solid blue; */
		width: 150px;
		height: 300px;
		display: inline-block
	}
	#teduri2{	
		/* border: 1px solid black;
 */		width: 350px;
		height: 400px;
		
	}
	#teduri2{
		padding-left:5px;
	}
	#anteduri
	{
		/* border: 1px solid green; */
		width: 350px;
		height: 330px;
	}
	#gNamebar
	{
		width:170px;
		height: 30px;
	}
	#gUpdate
	{
		height:35px;
	}
	td{
		padding-left:5px;
	}
	h4{
	margin:0;
	}
</style>

<div id="teduri2">
		<input type="text" id="gNamebar" required placeholder="그룹 이름" autocomplete="off"/>
		<button type="button" id="gUpdate">저장</button>
		<br/>
		<br>
		<div id="anteduri" >
		<div id="mList">
			<h4>아이디검색/추가</h4>
			<input type="search" name="serachId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
		<datalist id="datalist">
		</datalist>
		<br/><br/>
		<h4>추가된 회원</h4>
		<div id="addmember"></div>

	<script>
		$(function(){
			//로그인한 사용자 처음부터 회원으로 등록
			$('#addmember').append($('<tr><td class="addGroupMember"><%=logginMember.getMemberId()%></td></tr>'));
			
			$('#gUpdate').click(function(){
				var gName=$('#gNamebar').val();
				console.log(gName);
				var members=[];
				$.each($('.addGroupMember'),function(index,item){
					members.push(item.innerHTML);
				});
				$.ajax({
					url:"<%=request.getContextPath()%>/addGroupEnd.do",
					data:{"gName":gName,"members":members},
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
		});	
	
	</script>
		</div>
</div>

