<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- Navbar -->
<div class="w3-top" style="">
  <div class="w3-bar w3-white w3-small">
  	<c:if test="${empty sMid}">
	    <a href="${ctp}/log/login" class="w3-bar-item w3-padding-large w3-right">로그인</a>
  	</c:if>
  	<c:if test="${not empty sMid}">
	    <a href="${ctp}/log/logout" class="w3-bar-item w3-padding-large w3-right">로그아웃</a>
	    <c:if test="${sGrade == 0}">
	  		<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-padding-large w3-right">관리자페이지</a>
	    </c:if>
  	</c:if>
  	<a href="${ctp}/mem/myPage" class="w3-bar-item w3-padding-large w3-right">마이페이지</a>
  	<c:if test="${not empty sMid}">
  	<a href="${ctp}/board/userFeed?memIdx=${sIdx}" class="w3-bar-item w3-padding-large w3-right">내 피드</a>
  	</c:if>
  	
  	<a href="${ctp}/product/productCartPage" class="w3-bar-item w3-padding-large w3-right">장바구니</a>
  	<a href="#" class="w3-bar-item w3-padding-large w3-right">고객센터</a>
  </div>
  <div class="w3-bar w3-white w3-border-top w3-large">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
  	
  	<a href="${ctp}/" class="w3-bar-item w3-padding-large w3-left"><img alt="" src="${ctp}/logo/logo1.png" ></a>
    <a href="javascript:void(0)" class="w3-padding-large w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  	<a href="#" class="w3-bar-item w3-padding-large w3-right">FEED</a>
  	<a href="${ctp}/product/productMain?pag=1&pageSize=16&sort=desc" class="w3-bar-item w3-padding-large w3-right w3-bottombar w3-border-black">SHOP</a>
  </div>
  <%-- <div class="w3-bar w3-white w3-large" style="height: 150px">
  	<div class="w3-center" style="padding-top: 50px;height: 150px">
			<c:if test="${empty param.brand || param.brand == ''}">
		    <h2><b>SHOP</b></h2>
			</c:if>
			<c:if test="${not empty param.brand}">
		    <h2><b>${param.brand}</b></h2>
			</c:if>  	

  	</div>
  </div> --%>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
</div>
<script>
// Automatic Slideshow - change image every 4 seconds
var myIndex = 0;


// Used to toggle the menu on small screens when clicking on the menu button
function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>