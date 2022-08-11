<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>

.selectBox{
	border-color: #eee;
	border-style: solid;
	border-width: 2px;
	border-radius: 10px;
	padding: 13px;
	margin-bottom: 2%;
}
.selectItemBox{
	border-right-color:#eee;
	border-right-style : solid;
	border-right-width: 1px;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;max-height:5000px;margin-top:120px;margin-bottom: 50px">
	<div class="w3-container" style="width:100%;height: 100%">
	<form action="${ctp}/product/productOrderOk" method="post" name="myForm">
		<div class="w3-container" style="width:1500px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-container" >
	  	
	  	<div class="w3-container w3-center" style="height: 400px">
	  		<div class="w3-container mb-4">
	  			<div class="" style="margin-bottom: 50px">
		  			<img src="${ctp}/logo/logo2.png" style="height: 70px">
	  			</div>
	  			<h4><b>주문이 완료되었습니다.</b></h4>
	  			<br><br><br>
	  			<p>자세한 주문현황은 마이페이지에서 확인해주세요</p>
	  		</div>
	  		<div class="w3-container">
	  			<input type="button" class="w3-button w3-gary w3-border w3-round-large" onclick="location.href='${ctp}/product/productMain?pag=1&pageSize=16&sort=desc';" value="쇼핑하기"/>
	  			<input type="button" class="w3-button w3-gary w3-border w3-round-large" onclick="location.href='${ctp}/mem/myPage';" value="마이페이지"/>
	  		</div>
	  	</div>
	  </div>
		</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>