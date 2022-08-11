<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.badge {
	font-family: Arial, Helvetica, sans-serif;
  background-color: gray;
  color: white;
  padding: 4px 8px;
  text-align: center;
  border-radius: 5px;
}
</style>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	'use strict';
	
</script>
<!-- Navbar -->
<div class="w3-sidebar w3-white w3-card " style="height: 1000px;width: 300px;z-index:2">
	<div class="w3-bar-block" style="margin-bottom: 60px">
			<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-padding-large w3-left"><img alt="" src="${ctp}/logo/logo1.png" ></a>
	</div>
	<div class="w3-theme-l5">
		<hr style="border-width: 2px">
		<div class="w3-bar-block ">
			<div class="box1" style="margin-left: 115px;margin-top: 20px">
			    <img class="profile" src="${ctp}/member/${vo.photo}">
			</div>
			<h4 class="w3-center"><b>@${vo.nickName}</b></h4>
			<p class="w3-center"><font color="gray"><b>${sStrGrade}</b></font></p>
		</div>
  <hr style="border-width: 2px">
	</div>
  <div class="w3-cell" style="margin-left: 40px;width: 300px">
		<div class="w3-bar-block">
		 <%--  <h3><a href="${ctp}/admin/adminMain" class="w3-bar-item"><b>관리자 페이지</b></a></h3> --%>
		  <h5 class="w3-bar-item"><b>회원관리</b></h5>
		  <div id="side1">
		  	<a href="${ctp}/admin/adMemberList?sort=desc&pag=1&pageSize=6" class="w3-bar-item"><font color="gray">회원 리스트</font></a>
		  </div>
		</div>
		<div class="w3-bar-block">
		  <h5 class="w3-bar-item"><b>상품관리</b></h5>
		  <div id="side2">
			  <a href="${ctp}/admin/adProductInput" class="w3-bar-item"><font color="gray">통합 등록</font></a>
			  <a href="${ctp}/admin/adProductList?sort=desc&pag=1&pageSize=6" class="w3-bar-item"><font color="gray">상품 리스트</font></a>
			  <a href="${ctp}/admin/adBrandCateUpdate" class="w3-bar-item"><font color="gray">브랜드/카테고리 수정</font></a>
			  <%-- <a href="${ctp}/admin/adBrandCateUpdate" class="w3-bar-item"><font color="gray">통계</font></a> --%>
			  <%-- <a href="${ctp}/log/test" class="w3-bar-item"><font color="gray">test</font></a> --%>
		  </div>
		</div>
		<div class="w3-bar-block">
		  <h5 class="w3-bar-item"><b>주문관리</b>
		  <c:if test="${adordercnt != 0 or adreturncnt != 0}">
		   <span class="badge w3-tiny">New</span>
		  </c:if>
		   </h5>
		  <div id="side3">
			  <a href="${ctp}/admin/adOrderList" class="w3-bar-item"><font color="gray">
			  주문 현황
			  <c:if test="${adordercnt != 0 }">
			   <span class="w3-badge w3-small w3-green" style="width:17px;height: 17px;padding-left: 5px;">${adordercnt}</span>
			  </c:if>
			  </font></a>
			  <a href="${ctp}/admin/adReturnList" class="w3-bar-item"><font color="gray">
			  환불 신청 내역
			  <c:if test="${adreturncnt != 0 }">
			   <span class="w3-badge w3-small w3-red" style="width:17px;height: 17px;padding-left: 5px">${adreturncnt}</span>
			  </c:if>
			  </font></a>
			  <%-- <a href="${ctp}/admin/adOrderChart" class="w3-bar-item"><font color="gray">매출 통계</font></a> --%>
		  </div>
		</div>
		<div class="w3-bar-block">
		  <h5 class="w3-bar-item"><b>게시판 관리</b></h5>
		  <div id="side2">
			  <a href="${ctp}/admin/feedList" class="w3-bar-item"><font color="gray">피드 리스트</font></a>
			  <a href="${ctp}/admin/decList" class="w3-bar-item"><font color="gray">피드 신고내역</font></a>
			  <!-- <a href="#" class="w3-bar-item"><font color="gray">공지사항 (준비중)</font></a>
			  <a href="#" class="w3-bar-item"><font color="gray">Q N A (준비중)</font></a> -->
		  </div>
		</div>
		<div class="w3-bar-block">
		  <h5 class="w3-bar-item"><a href="${ctp}/"><b>나가기</b></a></h5>
		</div>
	</div>
</div>
