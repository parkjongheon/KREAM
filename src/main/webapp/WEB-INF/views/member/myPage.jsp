<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 1000px">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-cell" style="height: 700px;width: 220px;margin-left: 40px">
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
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red">회원탈퇴</font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 700px;width: 1000px">
				<div class="w3-container">
					<div class="w3-border w3-round-large" style="height: 150px;width: 965px;margin-top: 20px;margin-bottom: 50px">
						<div class="w3-cell w3-left" style="width: 150px;height: 140px">
							<div class="box" style="margin: auto;margin-top: 20px">
							    <%-- <img class="profile" src="${ctp}/member/noimage.png"> --%>
							    <img class="profile" src="${ctp}/member/${vo.photo}">
							</div>
						</div>
						<div class="w3-cell w3-left" style="width: 230px;height: 140px">
							<div class="w3-bar-block" style="margin-top: 18px">
								<font size="4px"><b>@${vo.nickName}</b></font>
							</div>
							<div class="w3-bar-block">
								<font color="gray">${vo.mid}</font>
							</div>
							<div class="w3-bar-block">
								<div class="w3-cell">
									<a href="${ctp}/mem/myPage/profile" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" style="margin-top: 10px;margin-right: 5px">프로필 수정</a>
								</div>
								<div class="w3-cell">
									<a href="${ctp}/board/userFeed?memIdx=${sIdx}" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" style="margin-top: 10px">내 피드</a>
								</div>
							</div>
						</div>
						<div class="w3-cell w3-right" style="width: 150px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 45px">
								<font size="3px"><b>${vo.point}P</b></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font color="gray"><small>포인트</small></font>
							</div>
						</div>
						<div class="w3-cell w3-right" style="width: 150px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 45px">
								<font size="3px"><b>${sStrGrade}</b></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font color="gray"><small>회원등급</small></font>
							</div>
						</div>
					</div>
					<h5 style="margin-bottom: 0px"><b>구매 내역</b></h5>
					<p style="width: 100%;text-align: right;margin-top: 0px;margin-bottom: 0px"><a href="${ctp}/mem/myOrderList" class="w3-small"><font color="gray">더보기</font></a></p>
					<div class="w3-round-large w3-theme-l5" style="height: 100px;width: 965px;margin-top: 20px;margin-bottom: 50px">
						<div class="w3-cell" style="width: 240px;height: 140px;margin: auto">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>전체</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${ordercnt}</b></font>
							</div>
						</div>
						
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>배송중</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${dlvcnt}</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>구매 확정</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${confirmcnt }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>환불/취소 진행</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px" color="red"><b>${returncnt}</b></font>
							</div>
						</div>
					</div>
					<h5 style="margin-bottom: 0px"><b>환불/취소 내역</b></h5>
					<p style="width: 100%;text-align: right;margin-top: 0px;margin-bottom: 0px"><a href="${ctp}/mem/myReturnList" class="w3-small"><font color="gray">더보기</font></a></p>
					<div class="w3-round-large w3-pale-green" style="height: 100px;width: 965px;margin-top: 20px">
						<div class="w3-cell" style="width: 240px;height: 140px;margin: auto">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>전체</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returnAllcnt }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>주문 취소</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returncnt1 }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>환불</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returncnt2 }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>완료</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px" color="red"><b>${returnClearcnt }</b></font>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
