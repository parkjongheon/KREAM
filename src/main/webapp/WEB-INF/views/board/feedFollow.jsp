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

.tag{
    padding: 8px 10px;
    border: 1px solid #ebebeb;
    border-radius: 12px;
    font-size: 15px;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    font-family: -apple-system,BlinkMacSystemFont,Roboto,AppleSDGothicNeo-Regular,NanumBarunGothic,NanumGothic,나눔고딕,Segoe UI,Helveica,Arial,Malgun Gothic,Dotum,sans-serif;
}
.img_tag{
		position: absolute;
    background-color: rgba(34,34,34,.5);
    border-radius: 30px;
    font-size: 15px;
    margin-left: 240px;
    margin-top: 10px;
    padding-bottom: 1px;
		/* position: absolute;
    top: 8px;
    right: 8px;
    background-color: rgba(34,34,34,.5);
    border-radius: 30px; */
}
.img_Cnt{
    padding: 3px 6px;
    font-size: 12px;
    letter-spacing: -.33px;
    color: #fff;
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
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-top w3-white" style="margin-top: 100px;height: 60px">
  <div class="w3-white w3-center" style="margin-left: 32%">
   <div class="w3-container w3-center" style="width: 700px">
			<a href="${ctp}/board/feedAll?pag=1&pageSize=16" class="w3-button w3-white w3-hover-white w3-round-xlarge">최신</a>
			<a href="${ctp}/board/feedPapular?pag=1&pageSize=16" class="w3-button w3-white w3-hover-white w3-round-xlarge">인기</a>
			<a href="${ctp}/board/feedFollow?pag=1&pageSize=16" class="w3-button w3-black w3-hover-black w3-round-xlarge" style="font-weight: 700">팔로잉</a>
		</div>
  </div>
</div>
<div class="w3-content" style="max-width:2000px;margin-top:200px;max-height: 10000px;margin-bottom: 100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1280px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-animate-opacity w3-center" style="height: 100%;width: 1280px">
				<div class="w3-container w3-center" style="width: 1280px">
				</div>
				<div class="w3-container" style="width: 1280px;margin-bottom: 30px">
				
				</div>
				<div class="w3-container w3-row" style="width: 1280px;padding: 30px 40px;">
					<c:if test="${empty vos}">
					<div class="w3-center"><b>피드가 없습니다.</b></div>
					<div class="w3-center"><b>최신 피드에서 공감하고 친구를 만들어보세요</b></div>
					<div class="w3-center w3-margin-top">
						<a href="${ctp}/board/feedAll?pag=1&pageSize=16" class="w3-button w3-round-large w3-border w3-hover-white w3-ripple">최신 피드 바로가기</a>
					</div>
					</c:if>
					<c:if test="${not empty vos}">
					<c:forEach var="bvo" items="${vos}">
					<div class="card w3-col m3" style="width: 280px;height:720px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/board/content?boIdx=${bvo.boIdx}&memIdx=${bvo.bo_memIdx}';">
								<c:set var="fNames" value="${fn:split(bvo.bo_fName,'/')}" />
								<c:if test="${fn:length(fNames) != 1}">
								<div class="img_tag">
									<span class="img_Cnt">+${fn:length(fNames)}</span>	
								</div>
								</c:if>								
				    		<img class="card-img-top w3-round-large" src="${ctp}/board/${fNames[0]}" alt="Card image" style="width: 279px;height:376px;background-color: #EBF0F5">
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
				<div class="w3-container w3-center">
				<div class="w3-bar text-center">
			  <c:if test="${not empty vos}">
			  <c:if test="${pagevo.pag != 1}">
			  <a href="${ctp}/board/feedFollow?pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
			  </c:if>
			  <c:if test="${pagevo.pag == 1}">
			  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
			  </c:if>
			  <c:if test="${pagevo.curBlock > 1 }">
			  <a href="${ctp}/board/feedFollow?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
			  </c:if>
			  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
				<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
				<c:forEach var="i" begin="${no}" end="${size}">
					<c:choose>
						<c:when test="${i > pagevo.totPage}"></c:when>
						<c:when test="${i == pagevo.pag}">
							<a href="${ctp}/board/feedFollow?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-theme-l4">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="${ctp}/board/feedFollow?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
					<a href="${ctp}/board/feedFollow?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
				</c:if>
				<c:if test="${pagevo.pag != pagevo.totPage}">
					<a href="${ctp}/board/feedFollow?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
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
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
