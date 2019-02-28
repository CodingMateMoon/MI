<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.mi.member.model.vo.Member" %>
<%
	Member logginMember=(Member)session.getAttribute("loginMember");
%>    
<style>
	#teduri2{	
		/* border: 1px solid black; */
 		width: 180px;
		height: 390px;
		padding-left:5px;
	}
	#mList
	{
		/* border: 1px solid red; */
		width: 160px;
		height: 290px;
		display: inline-block;
	}
	#addM
	{
		/* border: 1px solid blue; */
		width: 150px;
		height: 300px;
		display: inline-block
	}

	#anteduri
	{
		/* border: 1px solid green; */
		width: 350px;
		height: 330px;
	}
	#gNamebar
	{
		width:150px;
		height: 40px;
		outline: 0;
  		border-right:0px;
  		border-top:0px; 
  		border-left:0px;
		border-bottom:1px solid gray;
	}
	#gUpdate
	{
		width: 60px;
  		height: 40px;
  		background-color: #f4623a; 
  		color: white;
  		border: 0;
  		border-radius: 3px;
	}
	td{
		padding-left:5px;
	}
	h4{
	margin:0;
	}
	#addmember
	{
		width:150px;
		height: 170px;
		/* border: 2px solid black; */
		overflow-x: hidden; 
	}
	#searchId{background: url(<%=request.getContextPath() %>/views/group/search6.png) no-repeat;
				padding-left:25px;
				width: 150px;
  				height: 35px;
  				outline: 0;
  				border-right:0px;
  				border-top:0px; 
  				border-left:0px;
				border-bottom:1px solid gray;
				}
	#btnDiv{
		/* border: 2px solid blue; */
		text-align:right;
	}
.addGroupMember{border:2px solid white;
				width: 90px;
  				height: 30px;
  				text-align: center;
				border-radius: 15px;
				background-color: #f4623a; 
  				color: white;
  				 border-collapse: separate;
  				border-spacing: 0 10px;
  				font-size: 17px;
}

</style>

<div id="teduri2">
		<input type="text" id="gNamebar" required placeholder="그룹 이름" autocomplete="off"/>
		<br/>
		<br/>
		<!-- <div id="anteduri" > -->
		<div id="mList">
			<!-- <h4>아이디검색/추가</h4> -->
			<input type="search" name="serachId" id="searchId" list="datalist" placeholder="아이디검색" autocomplete="off"/>
		<datalist id="datalist">
		</datalist>
		<br/><br/>
		<!-- <h4>추가된 회원</h4> -->
		<div id="addmember"></div>
				</div>
		<div id='btnDiv'>
		<button type="button" id="gUpdate">저장</button>
		</div>
<!-- </div> -->
</div>
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
					 //else{alert("아이디를 전부입력하세요");}
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


