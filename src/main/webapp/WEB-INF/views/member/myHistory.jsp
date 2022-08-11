<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
.tooltip {
  position: relative;
  display: inline-block;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 190px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -60px;
  opacity: 0;
  transition: opacity 0.3s;
}

.tooltip .tooltiptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
  opacity: 1;
}
.selectBox{
	/* border-color: #eee;
	border-style: solid;
	border-width: 2px;
	border-radius: 10px; */
	padding: 13px;
}
.selectItemBox{
	border-right-color:#eee;
	border-right-style : solid;
	border-right-width: 1px;
}
.top{
		overflow: hidden;
    position: relative;
    width: 100%;
}
.left{
    height: 100%;
    padding:auto;
    position: absolute;
    right: 0;
    top: 0;
}
</style>
<script type="text/javascript">
	function msgDelete(res){
		let msgIdx = res;
		
		$.ajax({
			type : "post",
			url : "${ctp}/msgDelete",
			data : {
				msgIdx : msgIdx
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
<div class="w3-content" style="max-width:5000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;height:700px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-cell" style="height: 100%;width: 220px;margin-left: 40px">
				<div class="w3-bar-block">
				  <h3><a href="${ctp}/mem/myPage" class="w3-bar-item"><b>마이 페이지</b></a></h3>
				  <h5 class="w3-bar-item"><b>쇼핑 정보</b></h5>
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="gray">구매 내역</font></a>
				  <a href="${ctp}/mem/myReturnList" class="w3-bar-item"><font color="gray">환불 내역</font></a>
				  <a href="${ctp}/mem/myWishList" class="w3-bar-item"><font color="gray">관심 상품</font></a>
				</div>
				<div class="w3-bar-block">
				  <h5 class="w3-bar-item"><b>내 정보</b></h5>
				  <a href="${ctp}/mem/myPage/profile" class="w3-bar-item"><font color="gray">프로필 정보</font></a>
				  <a href="${ctp}/mem/myAddressList" class="w3-bar-item"><font color="gray">주소록</font></a>
				  <a href="${ctp}/mem/myDeclaration" class="w3-bar-item"><font color="gray">신고 내역</font></a>
				  <a href="${ctp}/mem/myHistory" class="w3-bar-item"><font color="black"><b>히스토리</b></font></a>
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red">회원탈퇴</font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1100px;margin-bottom: 100px">
				<div class="w3-container">
					<h3 id="title"><b>알림 내역</b></h3>
					<hr style="border-width: 3px;border-color: black">
					<ul class="w3-ul w3-round-large">
					<c:forEach var="vo" items="${vos}">
					<li class="w3-bar w3-center" style="padding:3px 0px">
						<div class="w3-bar-item" style="width: 100%;padding-left:10px">
							<span class="w3-left userName" style="font-size: 13px">${vo.msg_content}</span><br>
							<span class="w3-right userName w3-small" style="width:50px;font-size: 13px;color:gray">
							<a href="javascript:msgDelete(${vo.msgIdx })">삭제</a>
							</span>
							<span class="w3-right userName w3-small" style="font-size: 13px;color:gray">
							<a href="javascript:msgGoUrl(${vo.msgIdx })">보기</a>
							</span>
						</div>
					</li>
					</c:forEach>
					</ul>
				</div>
				<div class="w3-container w3-center">
					<div class="w3-bar text-center">
				  <c:if test="${not empty vos}">
				  <c:if test="${pagevo.pag != 1}">
				  <a href="${ctp}/mem/myHistory?pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
				  </c:if>
				  <c:if test="${pagevo.pag == 1}">
				  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
				  </c:if>
				  <c:if test="${pagevo.curBlock > 1 }">
				  <a href="${ctp}/mem/myHistory?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
				  </c:if>
				  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
					<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
					<c:forEach var="i" begin="${no}" end="${size}">
						<c:choose>
							<c:when test="${i > pagevo.totPage}"></c:when>
							<c:when test="${i == pagevo.pag}">
								<a href="${ctp}/mem/myHistory?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-light-gray">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="${ctp}/mem/myHistory?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
						<a href="${ctp}/mem/myHistory?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
					</c:if>
					<c:if test="${pagevo.pag != pagevo.totPage}">
						<a href="${ctp}/mem/myHistory?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
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
