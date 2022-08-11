<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript">
	'use strict';
	

	
	function showIcon(no){
		$("#icon"+no).hide();
		$("#hide"+no).show();
	}
	function hiddenIcon(no){
		$("#icon"+no).show();
		$("#hide"+no).hide();
	}
	function userInfor(data){
		$("#memberList").hide();
		$("#memberInfor").show();
		let mid = data;
		$.ajax({
			type : "post",
			url : "${ctp}/admin/userInfor",
			data : {
				mid : mid
			},
			success : function(vo){
				let grade = "";
				let lastDay = vo.lastDay.substring(0,10);
				
				
				if(vo.grade == 0) grade = "🌞관리자";
				else if(vo.grade == 1) grade = "🌜매니저";
				else if(vo.grade == 2) grade = "블랙라벨";
				else if(vo.grade == 3) grade = "우수회원";
				else if(vo.grade == 4) grade = "😊일반회원";
				
				$("#demo1").html('<img class="profile" src="${ctp}/member/'+vo.photo+'">');
				$("#demo2").html('<font size="3px">'+vo.idx+'</font>');
				$("#demo3").html('<font size="3px">'+vo.mid+'</font>');
				$("#demo4").html('<font size="3px">@'+vo.nickName+'</font>');
				$("#demo5").html('<font size="3px">'+vo.name+'</font>');
				$("#demo6").html('<font size="3px">'+vo.email+'</font>');
				$("#demo7").html('<font size="3px">'+vo.tel+'</font>');
				$("#demo8").html('<font size="3px">'+vo.content+'</font>');
				$("#demo9").html('<font size="3px">'+grade+'</font>');
				$("#demo10").html('<font size="3px">'+vo.gender+'</font>');
				$("#demo11").html('<font size="3px">'+vo.point+'P</font>');
				$("#demo12").html('<font size="3px">'+vo.post+'</font>');
				$("#demo13").html('<font size="3px">'+vo.address+'</font>');
				$("#demo14").html('<font size="3px">'+lastDay+'</font>');
			},
			error : function(){
				alert("에러");
			}
		});
	}
	function InforHide(){
		$("#memberList").show();
		$("#memberInfor").hide();
	}
	function searchInfor(){
		$("#searchDemo").html("");
		let mid = $("#searchString").val();
		
		if(mid.trim() == ""){
			$("#searchDemo").html('<font color="red"><b><small>값을 입력해주세요</small></b></font>');
			$("#searchString").focus();
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/admin/userInfor",
				data : {
					mid : mid
				},
				success : function(vo){
					if(vo != ""){
						$("#memberList").hide();
						$("#memberInfor").show();
						let grade = "";
						let lastDay = vo.lastDay.substring(0,10);
						
						
						if(vo.grade == 0) grade = "🌞관리자";
						else if(vo.grade == 1) grade = "🌜매니저";
						else if(vo.grade == 2) grade = "블랙라벨";
						else if(vo.grade == 3) grade = "우수회원";
						else if(vo.grade == 4) grade = "😊일반회원";
						
						$("#demo1").html('<img class="profile" src="${ctp}/member/'+vo.photo+'">');
						$("#demo2").html('<font size="3px">'+vo.idx+'</font>');
						$("#demo3").html('<font size="3px">'+vo.mid+'</font>');
						$("#demo4").html('<font size="3px">@'+vo.nickName+'</font>');
						$("#demo5").html('<font size="3px">'+vo.name+'</font>');
						$("#demo6").html('<font size="3px">'+vo.email+'</font>');
						$("#demo7").html('<font size="3px">'+vo.tel+'</font>');
						$("#demo8").html('<font size="3px">'+vo.content+'</font>');
						$("#demo9").html('<font size="3px">'+grade+'</font>');
						$("#demo10").html('<font size="3px">'+vo.gender+'</font>');
						$("#demo11").html('<font size="3px">'+vo.point+'P</font>');
						$("#demo12").html('<font size="3px">'+vo.post+'</font>');
						$("#demo13").html('<font size="3px">'+vo.address+'</font>');
						$("#demo14").html('<font size="3px">'+lastDay+'</font>');
					}
					else{
						$("#searchDemo").html('<font color="red"><b><small>등록되지않은 회원입니다</small></b></font>');
						$("#searchString").focus();
					}
				},
				error : function(){
					alert("에러");
				}
			});
		}
	}
</script>
</head>
<body class="w3-light-grey">
<%-- <jsp:include page="/WEB-INF/views/include/adNav.jsp" /> --%>
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div id="memberList" class="w3-card w3-round w3-white" style="width: 1590px;height: 120px;margin-top: 10px">
   <div class="w3-container">
    <h4><b>회원 관리</b></h4>
    <div class="w3-cell" style="width: 800px;height: 50px">
			<div class="w3-bar-block" style="width: 400px;height: 50px">
				<div class="w3-half">
					<input type="text" id="searchString" class="w3-input w3-border w3-round" placeholder="회원 검색">
				</div>
				<div class="w3-half">
					<input type="button" onclick="searchInfor()" class="w3-button w3-border w3-round"style="height: 41px" value="검색">
				</div>
				<div id="searchDemo">
				</div>
			</div>
		</div>
   </div>
 	</div>
	<div id="memberInfor" class="w3-card w3-round w3-white" style="display:none;width: 1590px;height: 300px;margin-top: 10px">
   <div class="w3-container">
    <h4><b>회원 정보</b></h4>
    <span class="w3-bar-item w3-white w3-xlarge w3-right">
			<a href="javascript:InforHide()"><span class="w3-right w3-white"><i class="fa fa-times" aria-hidden="true"></i></span></a>
		</span>
		<div class=" w3-round-large" style="height: 150px;width: 1500px;margin-top: 10px;margin-bottom: 50px">
			<div class="w3-cell w3-left" style="width: 150px;height: 140px">
				<div class="box" style="margin: auto;margin-top: 40px">
				    <div id="demo1"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 20px">
					<font color="gray"><small>회원번호</small></font><br>
					<div id="demo2"></div>
				</div>
			</div>
			<div class="w3-cell" style="width: 200px;height: 140px">
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>아이디</small></font><br>
					<div id="demo3"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>닉네임</small></font><br>
					<div id="demo4"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>이름</small></font><br>
					<div id="demo5"></div>
				</div>
			</div>
			<div class="w3-cell" style="width: 200px;height: 140px">
				<div class="w3-bar-block w3-center" style="margin-top: 45px">
					<font color="gray"><small>이메일</small></font><br>
					<div id="demo6"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>전화번호</small></font><br>
					<div id="demo7"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 20px">
					<font color="gray"><small>자기소개</small></font><br>
					<div id="demo8"></div>
				</div>
			</div>
			<div class="w3-cell" style="width: 150px;height: 140px">
				<div class="w3-bar-block w3-center" style="margin-top: 45px">
					<font color="gray"><small>등급</small></font><br>
					<div id="demo9"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>성별</small></font><br>
					<div id="demo10"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>포인트</small></font><br>
					<div id="demo11"></div>
				</div>
			</div>
			<div class="w3-cell" style="width: 600px;height: 140px">
				<div class="w3-bar-block w3-center" style="margin-top: 45px">
					<font color="gray"><small>우편번호</small></font><br>
					<div id="demo12"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>주소</small></font><br>
					<div id="demo13"></div>
				</div>
				<div class="w3-bar-block w3-center" style="margin-top: 15px">
					<font color="gray"><small>마지막접속</small></font><br>
					<div id="demo14"></div>
				</div>
			</div>
		</div>
   </div>
 	</div>
	<div class="w3-card w3-round w3-white" style="width: 1590px;height: 740px;margin-top: 10px">
   <div class="w3-container">
    <h4><b>회원 리스트</b></h4>
		<hr style="border-width: 3px;border-color: black">
    	<div class="w3-container" style="height: 580px">
    		<table class="w3-table w3-theme-l4 w3-round-large">
    			<tr>
    				<th style="width: 50px">번호</th>
    				<th style="width: 50px">사진</th>
    				<th style="width: 190px">아이디 / 이메일</th>
    				<th style="width: 50px">등급</th>
    				<th style="width: 55px">활동유무</th>
    				<th style="width: 640px"></th>
    				<th style="width: 40px">
    				<c:if test="${sort == 'desc'}">
	    				<a id="memSort" href="${ctp}/admin/adMemberList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
    				</c:if>
    				<c:if test="${sort == 'asc'}">
	    				<a id="memDesc" href="${ctp}/admin/adMemberList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
    				</c:if>
    				</th>
    			</tr>
    		</table>
			  <ul class="w3-ul">
			  	<c:forEach var="mvo" items="${vos}" varStatus="st">
			    <li class="w3-bar">
			    	<div id="icon${st.count}">
				      <span class="w3-bar-item w3-white w3-xlarge w3-right">
								<a href="javascript:showIcon(${st.count})"><i class="fa fa-cog" aria-hidden="true"></i></a>
							</span>
			    	</div>
			    	<div id="hide${st.count}" style="display: none">
				      <span class="w3-bar-item w3-white w3-xlarge w3-right">
								<a href="javascript:hiddenIcon(${st.count})"><i class="fa fa-cog" aria-hidden="true"></i></a>
							</span>
				    	<div class="w3-bar-item w3-right">
				    		<input type="button" value="상세보기" onclick="userInfor('${mvo.mid}')" class="w3-button w3-round w3-border">
				    		<c:if test="${sGrade == 0}">
					    		<input type="button" value="등급변경" onclick="userGrade()" class="w3-button w3-round w3-border">
					    		<input type="button" value="회원정지" class="w3-button w3-round w3-border">
				    		</c:if>
				      </div>
			    	</div>
			    	<div class="w3-bar-item w3-center" style="width: 30px">
			    		<br>${mvo.idx}
			    	</div>
			    	<div class="w3-bar-item">
				    	<div class="box4">
					      <img class="profile" src="${ctp}/member/${mvo.photo}" class=" w3-hide-small">
				    	</div>
			    	</div>
			      <div class="w3-bar-item" style="width: 250px">
			        <span class="w3-large">${mvo.mid}</span><br>
			        <span>${mvo.email}</span>
			      </div>
			      <div class="w3-bar-item w3-center" style="width: 100px">
			      	<c:if test="${mvo.grade == 0}">
			        <span class="w3-large">🌞</span><br>
			        <span><b>관리자</b></span>
			        </c:if>
			      	<c:if test="${mvo.grade == 1}">
			        <span class="w3-large">🌜</span><br>
			        <span><b>매니저</b></span>
			        </c:if>
			      	<c:if test="${mvo.grade == 2}">
			        <span class="w3-large"></span><br>
			        <span><b>블랙라벨</b></span>
			        </c:if>
			      	<c:if test="${mvo.grade == 3}">
			        <span class="w3-large"></span><br>
			        <span><b>우수회원</b></span>
			        </c:if>
			      	<c:if test="${mvo.grade == 4}">
			        <span class="w3-large">😊</span><br>
			        <span><b>일반회원</b></span>
			        </c:if>
			      </div>
			      <div class="w3-bar-item w3-center">
			      	<c:if test="${mvo.userDel == 'NO'}">
			        <span class="w3-large">✔</span><br>
			        <span><b>활동중</b></span>
			        </c:if>
			      	<c:if test="${mvo.userDel == 'OK'}">
			        <span class="w3-large">❌</span><br>
			        <span><b><font color="red">탈퇴대기</font></b></span>
			        </c:if>
			      </div>
			    </li>
			  	</c:forEach>			    
			  </ul>
			</div>
			<div class="w3-container w3-center">
				<div class="w3-bar text-center">
			  <c:if test="${not empty vos}">
			  <c:if test="${pagevo.pag != 1}">
			  <a href="${ctp}/admin/adMemberList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&laquo;</a>
			  </c:if>
			  <c:if test="${pagevo.pag == 1}">
			  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
			  </c:if>
			  <c:if test="${pagevo.curBlock > 1 }">
			  <a href="${ctp}/admin/adMemberList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">&laquo;</a>
			  </c:if>
			  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
				<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
				<c:forEach var="i" begin="${no}" end="${size}">
					<c:choose>
						<c:when test="${i > pagevo.totPage}"></c:when>
						<c:when test="${i == pagevo.pag}">
							<a href="${ctp}/admin/adMemberList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-theme-l4">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="${ctp}/admin/adMemberList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
					<a href="${ctp}/admin/adMemberList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}" class="w3-button">&raquo;</a>	
				</c:if>
				<c:if test="${pagevo.pag != pagevo.totPage}">
					<a href="${ctp}/admin/adMemberList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&raquo;</a>
				</c:if>
				<c:if test="${pagevo.pag == pagevo.totPage}">
					<a class="w3-button w3-xlarge w3-disabled">&raquo;</a>
				</c:if>
			  </c:if>		
				</div>
			</div>
   </div>
 </div>
</div>
</body>
</html>