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
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function delCheck(){
	let delCheck = $("#delCheck").is(':checked');
	if(delCheck == false){
		alert("탈퇴 동의 체크후 시도해주세요")
	}
	else{
		location.href="${ctp}/mem/userDelOk";
	}
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:5000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;height:800px;margin: auto;padding-top:10px;padding: auto">
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
				  <a href="${ctp}/mem/myHistory" class="w3-bar-item"><font color="gray">히스토리</font></a>
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red"><b>회원탈퇴</b></font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1100px;margin-bottom: 100px">
				<div class="w3-container">
					<h3 id="title"><b>회원 탈퇴</b></h3>
					<hr style="border-width: 3px;border-color: black">
				</div>
				<div class="w3-container">
					<h4><b>회원탈퇴에 앞서 아래 내용을 반드시 확인해 주세요.</b></h4>
					<div class="w3-border w3-round-large w3-padding">
						<h5><b>KREAM#</b>을 탈퇴하면 회원 정보 및 서비스 이용 기록이 삭제됩니다.</h5>
						<p>내 프로필, 거래내역(구매/판매), 관심상품, 보유상품, STYLE 게시물(게시물/댓글), 미사용 보유 포인트 등 사용자의 모든 정보가 사라지며 재가입 하더라도 복구가 불가능합니다</p>
						<p>탈퇴 14일 이내 재가입할 수 없으며, 탈퇴 후 동일 이메일로 재가입할 수 없습니다</p>
						<h5><b>관련 법령 및 내부 기준에 따라 별도 보관하는 경우에는 일부 정보가 보관될 수 있습니다.</b></h5>
						<p><b>1. 전자상거래 등 소비자 보호에 관한 법률</b></p>
						<p>계약 또는 청약철회 등에 관한 기록: 5년 보관</p>
						<p>대금결제 및 재화 등의 공급에 관한 기록: 5년 보관</p>
						<p>소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관</p>
						<p><b>2. 통신비밀보호법</b></p>
						<p>접속 로그 기록: 3개월 보관</p>
						<p><b>3. 내부 기준에 따라 별도 보관</b></p>
						<p>부정이용 방지를 위해 이름, 이메일(로그인ID), 휴대전화번호, CI/DI: 3년 보관</p><br>
						<h5><b>KREAM# 탈퇴가 제한된 경우에는 아래 내용을 참고하시기 바랍니다.</b></h5>
						<p>진행 중인 주문이 있을 경우: 해당 거래 종료 후 탈퇴 가능</p>
					</div>
					<input type="checkbox" class="w3-check" id="delCheck"> 회원탈퇴 안내를 모두 확인하였으며 탈퇴에 동의합니다.
				</div>
				<div class="w3-center w3-margin-top">
					<input type="button" onclick="delCheck()" class="w3-button w3-ripple w3-black w3-hover-black w3-border w3-round-large" value="탈퇴하기">
					<input type="button" onclick="location.href='${ctp}/mem/myPage';" class="w3-button w3-hover-white w3-ripple w3-border w3-round-large" value="취소하기">
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
