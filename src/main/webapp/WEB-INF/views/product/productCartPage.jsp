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
<style>

.hrline{
	height: 5px;
	background-color: #545454;
	width: 97%
}
.totalboxitem{
	font-family: 'HelveticaNeueLTStd' !important;
	font-size: 24px;
	font-weight: bold !important;
}
.selectBox{
	border-color: #eee;
	border-style: solid;
	border-right-width: 2px;
	border-radius: 10px;
	padding: 5px;
	margin-bottom: 2%;
}
.selectItemBox{
	border-right-color:#eee;
	border-right-style : solid;
	border-right-width: 1px;
}
.totalbox{
	
}
.checkbox{
	border-radius: 5px;
	background-color: black;
}
</style>
<script type="text/javascript">
	'use strict';
	
	//let userPoint = ${logvo.point};
	
	
	function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
  }
	
	function itemDelete(no){
		let ans = confirm("상품을 삭제하시겠습니까?");
		let idx = no;
		/* let prdCount = $("#prdCount"+no).val(); //상품수량

		let prdTotalPrice = $("#prdTotalPrice"+no).val(); // 상품 총금액
		let prdSale = $("#prdSale"+no).val(); // 상품 할인가
		let prdRealPrice = $("#prdRealPrice"+no).val(); // 상품 원가
		
		
		let totalPrice = $("#totalPrice").val(); // 최종금액
		let realTotPrice = $("#realTotPrice").val(); // 원가 총액
		let totSalePrice = $("#totSalePrice").val(); // 할인가 총액
		
		let nowtotPrice = Number(totalPrice) - Number(prdTotalPrice);
		let nowrealTotPrice = Number(realTotPrice) - Number(prdRealPrice * prdCount);
		let nowtotSalePrice = Number(totSalePrice) - Number(prdSale * prdCount); */
		
		
		if(ans == true){
			$.ajax({
				type : "post",
				url : "${ctp}/product/deleteCart",
				data : {
					idx : idx
				},
				success : function(){
					location.reload();
					/* $("#totalPrice").val(nowtotPrice);
					$("#realTotPrice").val(nowrealTotPrice);
					$("#totSalePrice").val(nowtotSalePrice);
					
					$("#frealTotPrice").html(addComma(nowrealTotPrice.toString()));
					$("#ftotSalePrice").html(addComma(nowtotSalePrice.toString()));
					$("#ftotalPrice").html(addComma(nowtotPrice.toString()));
						
					$("#selectItem"+no).remove(); */
				}
			});
		}
	}
	
	function countDown(no){
		let idx = no;
		let test = $("#prdCount"+no).val();
		if(test == 1){
			return;
		}
		$.ajax({
			type : "post",
			url : "${ctp}/product/optionCountDown",
			data : {
				idx : idx
			},
			success : function (){
				location.reload();
			}
		});
		/* let test = $("#prdCount"+no).val();
		let prdTotalPrice = $("#prdTotalPrice"+no).val();
		let prdPrice = $("#prdPrice"+no).val(); // 최종 상품가
		let prdSale = $("#prdSale"+no).val(); // 상품 할인가
		let prdRealPrice = $("#prdRealPrice"+no).val(); // 상품 원가
		
		let totalPrice = $("#totalPrice").val(); // 최종금액
		let realTotPrice = $("#realTotPrice").val(); // 원가 총액
		let totSalePrice = $("#totSalePrice").val(); // 할인가 총액
		if(test == 1){
			return;
		}
		$("#selectCount"+no).html(Number(test)-1);
		$("#prdCount"+no).val(Number(test)-1);
		let nowPrice = prdPrice * (Number(test)-1);
		$("#prdtotprice"+no).html(addComma(nowPrice.toString())+" 원");
		
		
		
		let nowtotPrice = (Number(totalPrice) - Number(prdPrice));
		let nowrealTotPrice = (Number(realTotPrice) - Number(prdRealPrice));
		let nowtotSalePrice = (Number(totSalePrice) - Number(prdSale));
		
		$("#prdTotalPrice"+no).val(nowPrice);
		$("#totalPrice").val(nowtotPrice);
		$("#realTotPrice").val(nowrealTotPrice);
		$("#totSalePrice").val(nowtotSalePrice);
		
		
		
		$("#frealTotPrice").html(addComma(nowrealTotPrice.toString()));
		$("#ftotSalePrice").html(addComma(nowtotSalePrice.toString()));
		$("#ftotalPrice").html(addComma(nowtotPrice.toString())); */
		
	}
	function countUp(no){
		let idx = no;
		let test = $("#prdCount"+no).val();
		if(test == 5){
			return;
		}
		$.ajax({
			type : "post",
			url : "${ctp}/product/optionCountUp",
			data : {
				idx : idx
			},
			success : function (){
				location.reload();
			}
		});
		/* let test = $("#prdCount"+no).val();
		let prdTotalPrice = $("#prdTotalPrice"+no).val();
		let prdPrice = $("#prdPrice"+no).val(); // 최종 상품가
		let prdSale = $("#prdSale"+no).val(); // 상품 할인가
		let prdRealPrice = $("#prdRealPrice"+no).val(); // 상품 원가
		
		let totalPrice = $("#totalPrice").val(); // 최종금액
		let realTotPrice = $("#realTotPrice").val(); // 원가 총액
		let totSalePrice = $("#totSalePrice").val(); // 할인가 총액
		if(test == 5){
			return;
		}
		$("#selectCount"+no).html(Number(test)+1);
		$("#prdCount"+no).val(Number(test)+1);
		let nowPrice = prdPrice * (Number(test)+1);
		$("#prdtotprice"+no).html(addComma(nowPrice.toString())+" 원");
		
		
		
		let nowtotPrice = (Number(totalPrice) + Number(prdPrice));
		let nowrealTotPrice = (Number(realTotPrice) + Number(prdRealPrice));
		let nowtotSalePrice = (Number(totSalePrice) + Number(prdSale));
		
		$("#prdTotalPrice"+no).val(nowPrice);
		$("#totalPrice").val(nowtotPrice);
		$("#realTotPrice").val(nowrealTotPrice);
		$("#totSalePrice").val(nowtotSalePrice);
		
		
		
		$("#frealTotPrice").html(addComma(nowrealTotPrice.toString()));
		$("#ftotSalePrice").html(addComma(nowtotSalePrice.toString()));
		$("#ftotalPrice").html(addComma(nowtotPrice.toString())); */
	}
	function totalCheck(){
		let ans = $('#totalCheck').is(':checked');
		let totalPrice = $("#totalPrice1").val(); // 최종금액
		let realTotPrice = $("#realTotPrice1").val(); // 원가 총액
		let totSalePrice = $("#totSalePrice1").val(); // 할인가 총액
		if(ans == false){
			
			$("#frealTotPrice").html('0');
			$("#ftotSalePrice").html('0');
			$("#ftotalPrice").html('0');
			
			$('input:checkbox[name=itemCheck]').prop('checked',false);
			
		}
		else{
			$("#frealTotPrice").html(addComma(realTotPrice.toString()));
			$("#ftotSalePrice").html(addComma(totSalePrice.toString()));
			$("#ftotalPrice").html(addComma(totalPrice.toString()));
			
			$('input:checkbox[name=itemCheck]').prop('checked',true);
			
		}
	}
	function itemSelectCheck(no){
			let checked = $('#itemCheck'+no).is(':checked');
			
			let prdCount = $("#prdCount"+no).val(); //상품수량
			let prdTotalPrice = $("#prdTotalPrice"+no).val(); // 상품 총금액
			let prdSale = $("#prdSale"+no).val(); // 상품 할인가
			let prdRealPrice = $("#prdRealPrice"+no).val(); // 상품 원가
			
			let totalPrice = $("#totalPrice").val(); // 최종금액
			let realTotPrice = $("#realTotPrice").val(); // 원가 총액
			let totSalePrice = $("#totSalePrice").val(); // 할인가 총액
			
			
		if(checked == false){
			$('#totalCheck').prop('checked',false);
			let nowtotPrice = Number(totalPrice) - Number(prdTotalPrice);
			let nowrealTotPrice = Number(realTotPrice) - Number(prdRealPrice * prdCount);
			let nowtotSalePrice = Number(totSalePrice) - Number(prdSale * prdCount);
			
			$("#totalPrice").val(nowtotPrice);
			$("#realTotPrice").val(nowrealTotPrice);
			$("#totSalePrice").val(nowtotSalePrice);
			
			$("#frealTotPrice").html(addComma(nowrealTotPrice.toString()));
			$("#ftotSalePrice").html(addComma(nowtotSalePrice.toString()));
			$("#ftotalPrice").html(addComma(nowtotPrice.toString()));
		}
		else{
			let nowtotPrice = Number(totalPrice) + Number(prdTotalPrice);
			let nowrealTotPrice = Number(realTotPrice) + Number(prdRealPrice * prdCount);
			let nowtotSalePrice = Number(totSalePrice) + Number(prdSale * prdCount);
			
			$("#totalPrice").val(nowtotPrice);
			$("#realTotPrice").val(nowrealTotPrice);
			$("#totSalePrice").val(nowtotSalePrice);
			
			$("#frealTotPrice").html(addComma(nowrealTotPrice.toString()));
			$("#ftotSalePrice").html(addComma(nowtotSalePrice.toString()));
			$("#ftotalPrice").html(addComma(nowtotPrice.toString()));
		}
	}
	
	function orderCheck(){
		let size = $('input:checkbox[name=itemCheck]:checked').length;
		
		let idx = 0;
		for(let i = 0; i<size; i++){
			idx = $('input:checkbox[name=itemCheck]:checked').eq(i).attr("value");
			$("#prdIdx"+idx).attr("disabled",false);
			$("#prdSize"+idx).attr("disabled",false);
			$("#prdCount"+idx).attr("disabled",false);
		}
		$("#myForm").submit();
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;max-height:5000px;margin-top:120px;margin-bottom: 50px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1100px;margin: auto;padding-top:10px;padding: auto">
		<div class="w3-center" style="padding-top: 50px;margin-bottom: 100px">
		    <h2><b><i class="fa fa-shopping-cart" aria-hidden="true"></i>
		     CART</b></h2>
  	</div>
			<div class="w3-center" style="width:100%;">
			<div class="selectBox w3-row" style="height:50px;margin-right: 30px;background-color: #f9f9f9">
				<div class="w3-col w3-container w3-center selectItemBox" style="width:5%;height: 35px;padding-top: 7px">
					<input class="checkbox" id="totalCheck" type="checkbox" name="totalCheck" onclick="totalCheck()" checked="checked">
				</div>
				<div class="w3-col w3-container w3-center selectItemBox" style="width:55%;height: 35px;padding-top: 7px">
					<span>상품 정보</span>
				</div>
				<div class="w3-col w3-container w3-center selectItemBox" style="width:15%;height: 35px;padding-top: 7px">
					<span>수량</span>
				</div>
				<div class="w3-col w3-container w3-center" style="width:15%;height: 35px;padding-top: 7px">
					<span>가격</span>
				</div>
				<div class="w3-col w3-container w3-right" style="width:5%;height: 35px;padding-top: 7px">
				</div>
			</div>
			<c:if test="${empty vos}">
				<div class="w3-center">
				<h5>장바구니 목록이 없습니다</h5><br>
				<input type="button" onclick="location.href='${ctp}/product/productMain?pag=1&pageSize=16&sort=desc';" class="w3-button w3-white w3-border w3-border-gray w3-hover-white w3-round-large" value="상품 구매하러 가기">
				</div>
			</c:if>
			<form id="myForm" name="myForm" method="post" action="${ctp}/product/productSellPage">
			<c:forEach var="vo" items="${vos}" varStatus="st">
			<div class="selectBox w3-row" id="selectItem${vo.idx}" style="margin-right: 30px;">
			<div class="w3-col w3-container w3-center" style="width:5%;height: 130px;padding-top: 50px">
			<input class="checkbox" type="checkbox" id="itemCheck${vo.idx}" onclick="itemSelectCheck(${vo.idx})" name="itemCheck" value="${vo.idx}" checked="checked">
			</div>
				<div class="w3-col" style="width:15%;height: 130px;border-color: white">
					<c:choose>
			    	<c:when test="${vo.ebrName == 'Nike'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 130px;height: 130px;background-color: #EBF0F5">
			    	</c:when>
			    	<c:when test="${vo.ebrName == 'Jordan'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 130px;height: 130px;background-color: #F6EEED">
			    	</c:when>
			    	<c:when test="${vo.ebrName == 'Adidas'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 130px;height: 130px;background-color: #F1F1EA">
			    	</c:when>
			    	<c:otherwise>
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 130px;height: 130px;background-color: #F5F5F5">
			    	</c:otherwise>
					 </c:choose>
				</div>
				<div class="w3-col w3-left" style="width:40%;height: 130px;padding-left: 10px;padding-right: 10px">
				<p style="text-align: left;margin-top: 0px">
				<b>${vo.eprdName}</b><br>
				<font color="gray">${vo.kprdName}</font><br>
				<font color="gray">선택 옵션 : <b>${vo.prdoption}</b></font>
				</p>
				<c:set var="prdtotPrice" value="${(vo.SPrice - (vo.SPrice * (vo.prdSale / 100))) * vo.prdCount}"/>
				<c:set var="prdRealtotPrice" value="${vo.SPrice * vo.prdCount}"/>
				<c:set var="prdtotSalePrice" value="${(vo.SPrice * (vo.prdSale / 100)) * vo.prdCount}"/>
				<c:set var="prdSalePrice" value="${vo.SPrice - (vo.SPrice * (vo.prdSale / 100))}"/>
				<c:set var="prdPrice" value="${vo.SPrice}"/>
				<c:set var="prdSale" value="${vo.SPrice * (vo.prdSale / 100)}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdtotPrice}" var="fprdtotPrice"/>		
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdSalePrice}" var="fprdSalePrice"/>		
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdPrice}" var="fprdPrice"/>	
				<c:if test="${vo.prdSale != 0}">
					<span class="w3-right"><font color="gray"><small>상품 가격</small></font> <font style="text-decoration: line-through;text-decoration-color:red">${fprdPrice} </font>원</span><br>
					<span class="w3-right"><font color="gray"><small>할인율(${vo.prdSale}%)</small></font> ${fprdSalePrice} 원</span>
				</c:if>
				<c:if test="${vo.prdSale == 0}">
					<br>
					<span class="w3-right"><font color="gray"><small>상품 가격</small></font> ${fprdSalePrice} 원</span>
				</c:if>
				
				</div>
				<div class="w3-col w3-container w3-center" style="width:15%;height: 130px;padding-top: 50px">
				<a href="javascript:countDown(${vo.idx})"><i class="fa fa-caret-square-o-down" aria-hidden="true"></i></a>
		    <span id="selectCount${vo.idx}">${vo.prdCount}</span>
		    <a href="javascript:countUp(${vo.idx})"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a>
				</div>
				<div class="w3-col w3-container" style="width:15%;height: 130px;padding-top: 50px">
					<span id="prdtotprice${vo.idx}" style="margin-top: 35px">${fprdtotPrice} 원</span>
				</div>
				<div class="w3-col w3-container" style="width:10%;height: 130px;padding-top: 0px">
					<span class="w3-right"><a href="javascript:itemDelete(${vo.idx})"><i class="fa fa-times" aria-hidden="true"></i></a></span>
				</div>
				  <input type="hidden" id="prdIdx${vo.idx}" name="prdIdx" value="${vo.prdIdx}" disabled="disabled">
				  <input type="hidden" id="prdCount${vo.idx}" name="itemCount" value="${vo.prdCount}" disabled="disabled">
				  <input type="hidden" id="prdSize${vo.idx}" name="itemSize" value="${vo.prdoption}" disabled="disabled">
				  <input type="hidden" id="prdPrice${vo.idx}" name="prdPrice" value="${prdSalePrice}" disabled="disabled">
				  <input type="hidden" id="prdRealPrice${vo.idx}" name="prdRealPrice" value="${prdPrice}" disabled="disabled">
				  <input type="hidden" id="prdSale${vo.idx}" name="prdSale" value="${prdSale}" disabled="disabled">
				  <input type="hidden" id="prdRealtotPrice${vo.idx}" name="prdRealtotPrice" value="${prdRealtotPrice}" disabled="disabled">
				  <input type="hidden" id="prdtotSalePrice${vo.idx}" name="prdtotSalePrice" value="${prdtotSalePrice}" disabled="disabled">
				  <input type="hidden" id="prdTotalPrice${vo.idx}" name="prdTotalPrice" value="${prdtotPrice}" disabled="disabled">
				  <input type="hidden" id="prdOption${vo.idx}" name="prdOption" value="${vo.prdoption}" disabled="disabled">
		  <c:set var="totalPrices" value="${totalPrices = totalPrices + prdtotPrice}"/>
		  <c:set var="realTotPrices" value="${realTotPrices = realTotPrices + prdRealtotPrice}"/>
		  <c:set var="totSalePrices" value="${totSalePrices = totSalePrices + prdtotSalePrice}"/>
		  </div>
			</c:forEach>
			</form>
		  <%-- <fmt:parseNumber var="totalPoint" value="${totalPrices * (1 / 100)}" integerOnly="true"/> --%>
		  <fmt:parseNumber var="totalPrice" value="${totalPrices}" integerOnly="true"/>
		  <fmt:parseNumber var="realTotPrice" value="${realTotPrices}" integerOnly="true"/>
		  <fmt:parseNumber var="totSalePrice" value="${totSalePrices}" integerOnly="true"/>
		  <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
		  <input type="hidden" id="realTotPrice" name="realTotPrice" value="${realTotPrice}">
		  <input type="hidden" id="totSalePrice" name="totSalePrice" value="${totSalePrice}">
		  <input type="hidden" id="totalPrice1" name="totalPrice1" value="${totalPrice}">
		  <input type="hidden" id="realTotPrice1" name="realTotPrice1" value="${realTotPrice}">
		  <input type="hidden" id="totSalePrice1" name="totSalePrice1" value="${totSalePrice}">
		  <fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" var="ftotalPrice"/>	
		  <fmt:formatNumber type="number" maxFractionDigits="3" value="${realTotPrice}" var="frealTotPrice"/>	
		  <fmt:formatNumber type="number" maxFractionDigits="3" value="${totSalePrice}" var="ftotSalePrice"/>	
			</div>
			<hr class="hrline">
			<div class="w3-row" style="width:97%;background-color: #f9f9f9">
				<div class="w3-col w3-container w3-center" style="width:20%;height: 135px;padding-top: 30px">
					<span class="totalbox"><font color="gray"><small><b>상품 가격</b></small></font></span><br>
					<c:if test="${not empty vos}">
					<span class="totalboxitem" id="frealTotPrice">${frealTotPrice}</span>원
					</c:if>
					<c:if test="${empty vos}">
					<span class="totalboxitem" id="frealTotPrice">0</span>원
					</c:if>
				</div>
				<div class="w3-col w3-container w3-center" style="width:5%;height: 135px;padding-top: 50px">
					<span class="totalbox"><img alt="" src="${ctp}/logo/icon-minus.png" style="width: 30px;height: 30px"></span>
				</div>
				<div class="w3-col w3-container w3-center" style="width:20%;height: 135px;padding-top: 30px">
					<span class="totalbox"><font color="gray"><small><b>할인 금액</b></small></font></span><br>
					<c:if test="${not empty vos}">
					<span class="totalboxitem" id="ftotSalePrice">${ftotSalePrice}</span>원
					</c:if>
					<c:if test="${empty vos}">
					<span class="totalboxitem" id="ftotSalePrice">0</span>원
					</c:if>
				</div>
				<div class="w3-col w3-container w3-center" style="width:5%;height: 135px;padding-top: 50px">
					<span class="totalbox"><img alt="" src="${ctp}/logo/icon-plus.png" style="width: 30px;height: 30px"></span>
				</div>
				<div class="w3-col w3-container w3-center" style="width:20%;height: 135px;padding-top: 30px">
					<span class="totalbox"><font color="gray"><small><b>배송비</b></small></font></span><br>
					<span class="totalboxitem">무료 배송</span>
				</div>
				<div class="w3-col w3-container w3-center" style="width:5%;height: 135px;padding-top: 50px">
					<span class="totalbox"><img alt="" src="${ctp}/logo/icon-equals.png" style="width: 30px;height: 30px"></span>
				</div>
				<div class="w3-col w3-container w3-center" style="width:20%;height: 135px;padding-top: 30px">
					<span class="totalbox"><font color="gray"><small><b>총 결제 금액</b></small></font></span><br>
					<c:if test="${not empty vos}">
						<span class="totalboxitem" style="color : red" id="ftotalPrice">${ftotalPrice}</span>원
					</c:if>
					<c:if test="${empty vos}">
						<span class="totalboxitem" style="color : red" id="ftotalPrice">0</span>원
					</c:if>
				</div>
			</div>
				<div class="w3-container w3-center">
				<c:if test="${not empty vos}">
					<input type="button" id="orderOk" onclick="orderCheck()" class="w3-button w3-brown w3-hover-brown w3-round-large w3-margin-bottom" value="주문 하기" style="width: 50%;margin-top: 50px;height: 50px">
				</c:if>
				<c:if test="${empty vos}">
					<input type="button" id="orderOk" onclick="orderCheck()" class="w3-button w3-brown w3-hover-brown w3-round-large w3-margin-bottom" disabled="disabled" value="주문 하기" style="width: 50%;margin-top: 50px;height: 50px">
				</c:if>
				</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>