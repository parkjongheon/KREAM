<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style type="text/css">
.box-sold {
	position: relative;
}
.img_box_sold > img {
	display: block;
    width: 11em;
    height: 11em;
}
.img_box_sold {
	filter: brightness(50%);
}
.text-sold {
	padding: 10px 20px;
	text-align: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
<script type="text/javascript">
function blikeUp(idx,mem){
	let msg_url = '/board/content?boIdx='+idx+'&memIdx='+mem;
	let msg_memIdx = mem;
	let bl_boardIdx = idx;
	
	let mid = '${sIdx}';
	if(mid == ''){
		Swal.fire({
			  position: 'top',
			  icon: 'warning',
			  title: '로그인후 이용해주세요',
			  showConfirmButton: false,
			  timer: 1000
		}).then(function(){
		location.href = '${ctp}/log/login';							
		});
	}
	else{
		$.ajax({
			type : "post",
			url : "${ctp}/board/boardLikeUp",
			data : {
				msg_url : msg_url,
				msg_memIdx : msg_memIdx,
				bl_boardIdx : bl_boardIdx
			},
			success : function(){
				location.reload();
			}
		});
	}
}
function blikeDown(idx){
	let boIdx = idx;
	$.ajax({
		type : "post",
		url : "${ctp}/board/boardLikeDown",
		data : {
			boIdx : boIdx
		},
		success : function(){
			location.reload();
		}
	});
}
function follow(res){
	let for_Idx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/mem/setfollow",
		data : {
			for_Idx : for_Idx
		},
		success : function(){
			location.reload();
		}
	});
}
function unfollow(res){
	let for_Idx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/mem/setUnfollow",
		data : {
			for_Idx : for_Idx
		},
		success : function(){
			location.reload();
		}
	});
}
function follower(res){
	let idx = res;
	$('html, body').css({'overflow': 'hidden'});
	$("#follow"+idx).css('display','block');
}
function followModalClose(res){
	let idx = res;
	$('html, body').css({'overflow': 'auto'});
	$("#follow"+res).css('display','none');
}
function contentModal(){
	$('html, body').css({'overflow': 'hidden'});
	$("#contentModal").css('display','block');	
}
function contentModalClose(){
	$('html, body').css({'overflow': 'auto'});
	$("#contentModal").css('display','none');	
}
function contentUpdate(){
	let con = $("#userContent").val();
	$.ajax({
		type : "post",
		url : "${ctp}/mem/setUserContent",
		data : {
			content : con
		},
		success : function(){
			location.reload();
		}
	});
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;margin-top:100px;max-height: 3000px;margin-bottom: 200px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-animate-opacity w3-center" style="height: 100%;width: 1400px">
				<div class="w3-container w3-center" style="width: 700px;padding: auto;margin: auto">
						<div class="box2" style="margin: auto;margin-top: 20px">
						    <img class="profile" src="${ctp}/member/${vo.photo}">
						</div>
						<div>
						<h3><span class="w3-center">${vo.nickName}</span></h3>
						<p><span class="w3-center" style="font-size: 14px;letter-spacing: -.21px;padding-top: 0px">${vo.mid}</span><br>
						<font color="gray">${vo.content }</font><br>
						<c:if test="${vo.idx == sIdx}">
						<a href="javascript:contentModal()"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
						</c:if>						
						</p>
						<c:if test="${not empty sIdx}">
					 	 	<c:if test="${vo.idx != sIdx}">
					 	 		<c:if test="${empty fvo}">
						 	 		<a href="javascript:follow(${vo.idx})" class="w3-button w3-ripple w3-black w3-hover-black w3-round-large w3-small">팔로우</a>
					 	 		</c:if>
					 	 		<c:if test="${not empty fvo}">
						 	 		<a href="javascript:unfollow(${vo.idx})" class="w3-button w3-ripple w3-light-gray w3-hover-light-gray w3-round-large w3-small">팔로잉</a>
					 	 		</c:if>
					 	 	</c:if>
					 	 	</c:if>
						</div>
						<div class="w3-margin-top">
						<a class="w3-button w3-white w3-hover-white">게시물 ${totSize}</a>
						<a href="javascript:follower(1)" class="w3-button w3-white w3-hover-white w3-ripple">팔로워 ${forcnt }</a>
						<a href="javascript:follower(2)" class="w3-button w3-white w3-hover-white w3-ripple">팔로잉 ${whocnt }</a>
						</div>
				</div>
				<hr>
				<div class="w3-container" style="width: 1400px;margin-bottom: 30px">
				<c:if test="${vo.idx == sIdx}">
				<span onclick="location.href='${ctp}/mem/myFeedInput';" class="w3-right w3-button w3-border w3-border-gray w3-round-large w3-hover-white"><i class="fa fa-plus" aria-hidden="true"></i> 글쓰기</span>
				</c:if>
				
				</div>
				<div class="w3-container" style="width: 1400px;height: 100%">
					<c:if test="${empty vos}">
					<div class="w3-center"><b>게시물이 없습니다.</b></div>
					</c:if>
					<c:if test="${not empty vos}">
					<c:forEach var="bvo" items="${vos}">
					<div class="card w3-quarter" style="height: 690px;width: 320px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/board/content?boIdx=${bvo.boIdx}&memIdx=${bvo.bo_memIdx}';">
								<c:set var="fNames" value="${fn:split(bvo.bo_fName,'/')}" />	
								<c:if test="${bvo.bo_val == 0}">
					    		<img class="card-img-top w3-round-large" src="${ctp}/board/${fNames[0]}" alt="Card image" style="width: 319px;height: 350px;background-color: #EBF0F5">
								</c:if>			    
								<c:if test="${bvo.bo_val == 1}">
	            	<div class="box-sold">
		            	<div class="img_box_sold">
		            		<img class="card-img-top w3-round-large" src="${ctp}/member/blur.png" alt="Card image" style="width: 319px;height: 350px;background-color: #EBF0F5">
		            	</div>
		            	<div class="text-sold">
		            		<h4 class="sold_complete" style="color: gray"><i class="fa fa-low-vision" aria-hidden="true"></i><br>관리자에 의해 차단되었습니다.</h4>
		            	</div>
	            	</div>
								</c:if>			    				    		
				    		<ul class="w3-ul" style="height: 31px">
									<li class="w3-bar" style="width: 100%;padding-left: 2px">
									  <img class="w3-circle w3-hide-small w3-left" style="width: 25px;height: 25px;margin-top: 5px" src="${ctp}/member/${bvo.photo}">
										<div class="w3-bar-item w3-left" style="padding-top: 5px;padding-left: 7px">
								    <span><font color="gray" size="2px">${bvo.nickName }</font></span>
								 	 	</div>
									</li>
								</ul>
				    <div class="card-body w3-left-align">
				      <p class="card-title"><font color="black" size="2px">${bvo.bo_content}</font></p>
				      <p class="card-text"><font color="black" size="2px">${bvo.bo_tag}</font><br>
							<%-- <font color="gray" size="2px">${bvo.kprdName}</font><br></p> --%>
				    </div>
		   		 </div>
				      <p class="w3-left-align">
				      <c:if test="${empty blvos }">
					      <a href="javascript:blikeUp(${bvo.boIdx},${bvo.bo_memIdx})">
				      		<i class="fa fa-heart-o w3-large" aria-hidden="true"></i>
				      	</a>
				      </c:if>
				      <c:if test="${not empty blvos }">
				      <c:set var="flag" value="false"/>
				      <c:forEach var="blvo" items="${blvos}" varStatus="stss">
				      <c:if test="${blvo.bl_memIdx == sIdx and blvo.bl_boardIdx == bvo.boIdx}">
				      	<a href="javascript:blikeDown(${bvo.boIdx})">
				      		<i class="fa fa-heart w3-large" style="color:red" aria-hidden="true"></i>
				      	</a>
				        <c:set var="flag" value="true"/>
				      </c:if>
				      <c:if test="${not flag}">
				      <c:if test="${stss.last}">
				      	<a href="javascript:blikeUp(${bvo.boIdx},${bvo.bo_memIdx})">
				      		<i class="fa fa-heart-o w3-large" aria-hidden="true"></i>
				      	</a>
				      </c:if>				      	
				      </c:if>
				      </c:forEach>
				      </c:if>
				        <font color="gray">${bvo.bo_likeCnt}</font>
				      		<i class="fa fa-commenting-o w3-large" aria-hidden="true"></i>
				        <font color="gray">${bvo.reCnt}</font>
				      </p>
				      <c:if test="${bvo.bo_prdIdx != 0}">
				        <p style="text-align: left;margin-bottom: 0px"><font color="gray" size="2px">태그 상품</font></p>
				  		<div style="cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${bvo.bo_prdIdx}';">
				  		<ul class="w3-ul w3-round-large" style="padding-left: 0px">
								<li class="w3-bar w3-left" style="padding-left: 0px">
								<div class="w3-bar-item" style="width: 20%;margin-right: 3%;padding-left: 0px">
								<img class="card-img-top w3-round-large" src="${ctp}/product/${bvo.prdfName}" alt="Card image" style="width: 50px;height: 50px;background-color: #EBF0F5">
								</div>
								<div class="w3-bar-item" style="width:77%;padding-left: 0px">
								<span class="w3-small w3-left-align">${bvo.eprdName}</span><br>
								<span class="w3-small w3-left-align">${bvo.kprdName}</span>
								</div>
								</li>
							</ul>
				  		</div>
				      </c:if>
							
		  			</div>
					</c:forEach>
					</c:if>
				</div>
				<div class="w3-container w3-center" style="margin-top: 10px">
						<div class="w3-bar text-center">
					  <c:if test="${not empty vos}">
					  <c:if test="${pagevo.pag != 1}">
					  <a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.pag == 1}">
					  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.curBlock > 1 }">
					  <a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
					  </c:if>
					  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
						<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
						<c:forEach var="i" begin="${no}" end="${size}">
							<c:choose>
								<c:when test="${i > pagevo.totPage}"></c:when>
								<c:when test="${i == pagevo.pag}">
									<a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-theme-l4">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
							<a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
						</c:if>
						<c:if test="${pagevo.pag != pagevo.totPage}">
							<a href="${ctp}/board/userFeed?memIdx=${param.memIdx}&pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
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
</div>
<div id="follow1" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 400px;height:500px">
      <div class="w3-container">
        <span onclick="followModalClose(1)" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h3 id="msgTitle" style="text-align: center">팔로워</h3>        
				<hr>
				<div id="followerbox" class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 390px">
					<c:forEach var="fwvo" items="${fwvos}">
					<ul class="w3-ul w3-round-large w3-margin-top">
						<li class="w3-bar w3-center" style="padding: 0px">
							<div style="cursor:pointer" onclick="location.href='${ctp}/board/userFeed?memIdx=${fwvo.idx}';">
								<div class="w3-bar-item" style="width: 10%;margin-right: 3%">
									<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 7px" src="${ctp}/member/${fwvo.photo}">
								</div>
								<div class="w3-bar-item" style="width: 55%">
									<span class="w3-left userName" style="font-size: 13px">${fwvo.nickName}</span><br>
									<span class="w3-left userName" style="font-size: 13px;color:gray">${fwvo.mid}</span>
								</div>
							</div>
							<div class="w3-bar-item" style="width: 31%">
								<c:if test="${not empty sIdx and fwvo.idx != sIdx}">
								<c:if test="${empty sfwvos }">
					      	<a href="javascript:follow(${fwvo.idx })" class="w3-button w3-ripple w3-black w3-hover-black w3-round-large w3-small">팔로우</a>
				      	</c:if>
					      <c:if test="${not empty sfwvos }">
					      <c:set var="flag" value="false"/>
					      <c:forEach var="sfwvo" items="${sfwvos}" varStatus="fst">
					      <c:if test="${sfwvo.for_Idx == fwvo.idx}">
					      	<a href="javascript:unfollow(${fwvo.idx })" class="w3-button w3-ripple w3-light-gray w3-hover-light-gray w3-round-large w3-small">팔로잉</a>
					        <c:set var="flag" value="true"/>
					      </c:if>
					      <c:if test="${not flag}">
					      <c:if test="${fst.last}">
					      	<a href="javascript:follow(${fwvo.idx })" class="w3-button w3-ripple w3-black w3-hover-black w3-round-large w3-small">팔로우</a>
					      </c:if>				      	
					      </c:if>
					      </c:forEach>
					      </c:if>
							</c:if>
							</div>
						</li>
					</ul>
					</c:forEach>
				</div>
      </div>
    </div>
  </div>
<div id="follow2" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 400px;height:500px">
      <div class="w3-container">
        <span onclick="followModalClose(2)" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h3 id="msgTitle" style="text-align: center">팔로잉</h3>        
				<hr>
				<div id="folloingbox" class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 390px">
					<c:forEach var="fgvo" items="${fgvos}">
					<ul class="w3-ul w3-round-large w3-margin-top">
						<li class="w3-bar w3-center" style="padding: 0px">
							<div style="cursor:pointer" onclick="location.href='${ctp}/board/userFeed?memIdx=${fgvo.idx}';">
								<div class="w3-bar-item" style="width: 10%;margin-right: 3%">
									<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 7px" src="${ctp}/member/${fgvo.photo}">
								</div>
								<div class="w3-bar-item" style="width: 55%">
									<span class="w3-left userName" style="font-size: 13px">${fgvo.nickName}</span><br>
									<span class="w3-left userName" style="font-size: 13px;color:gray">${fgvo.mid}</span>
								</div>
							</div>
							<div class="w3-bar-item" style="width: 31%">
								<c:if test="${not empty sIdx and fgvo.idx != sIdx}">
								<c:if test="${empty sfwvos }">
					      	<a href="javascript:follow(${fgvo.idx })" class="w3-button w3-ripple w3-black w3-hover-black w3-round-large w3-small">팔로우</a>
				      	</c:if>
					      <c:if test="${not empty sfwvos }">
					      <c:set var="flag" value="false"/>
					      <c:forEach var="sfwvo" items="${sfwvos}" varStatus="fst">
					      <c:if test="${sfwvo.for_Idx == fgvo.idx}">
					      	<a href="javascript:unfollow(${fgvo.idx })" class="w3-button w3-ripple w3-light-gray w3-hover-light-gray w3-round-large w3-small">팔로잉</a>
					        <c:set var="flag" value="true"/>
					      </c:if>
					      <c:if test="${not flag}">
					      <c:if test="${fst.last}">
					      	<a href="javascript:follow(${fgvo.idx })" class="w3-button w3-ripple w3-black w3-hover-black w3-round-large w3-small">팔로우</a>
					      </c:if>				      	
					      </c:if>
					      </c:forEach>
					      </c:if>
							</c:if>
							</div>
						</li>
					</ul>
					</c:forEach>
				</div>
      </div>
    </div>
  </div>
<div id="contentModal" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 600px;height:400px">
      <div class="w3-container">
        <span onclick="contentModalClose()" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h3 id="msgTitle" style="text-align: center">자기소개</h3>        
				<div class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 270px">
				<textarea id="userContent" class="w3-border w3-padding w3-round-large" rows="8" cols="57" style="resize: none"  placeholder="자기소개를 입력해주세요.">${vo.content}</textarea>
				</div>
				<div class="w3-center">
				<a href="javascript:contentUpdate()" class="w3-button w3-white w3-border w3-round-large w3-hover-white w3-ripple">수정 하기</a>
				</div>
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
