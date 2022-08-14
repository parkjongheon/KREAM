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
.btn {
  border: 2px solid;
  background-color: white;
  color: black;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}

/* Green */
.success {
  border-color: #04AA6D;
  color: green;
}
/* Blue */
.info {
  border-color: #2196F3;
  color: dodgerblue;
}
.info:hover {
  background: #2196F3;
  color: white;
}
.success:hover {
  background-color: #04AA6D;
  color: white;
}
/* Gray */
.default {
  border-color: #e7e7e7;
  color: black;
}

.default:hover {
  background: #e7e7e7;
}
.brandTitle{
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	padding-top: 1px;
	font-size: 18px;
	font-weight : 700;
	border-bottom: 2px solid;
	border-bottom-color: #222; 
}
.productEtitle{
	font-size: 18px;
	letter-spacing: -.09px;
	font-weight: 400;
	margin-bottom: 4px;
}
.productKtitle{
	line-height: 17px;
	font-size: 14px;
	letter-spacing: -.15px;
	margin-top: 4px;
}
.sprice{
	display: inline-block;
	line-height: 26px;
	font-size: 20px;
	letter-spacing: -.1px;
}
.countsprice{
	display: inline-block;
	line-height: 26px;
	font-size: 20px;
	letter-spacing: -.1px;
	text-decoration: line-through;
	text-decoration-color: red;
}
.subtitle{
	line-height: 22px;
	padding-bottom: 12px;
	font-size: 18px;
	letter-spacing: -.27px;
}
.subBody{
	font-size: 13px;
	letter-spacing: -.07px;
}
.selectBox{
	border-color: #6d8764;
	border-style: solid;
	border-width: 2px;
	border-radius: 10px;
	padding: 13px;
	height: 50px;
	margin-bottom: 2%;
}
.itemTitle{
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	padding-top: 1px;
	font-size: 15px;
	font-weight : 700;
	width: 10%;
	color: gray;
}
.itemSize{
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	padding-top: 1px;
	font-size: 14px;
	font-weight : 600;
	width: 10%;
}
.itemCounter{
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	padding-top: 1px;
	font-size: 15px;
	font-weight : 700;
	margin-left : 20%;
	width: 30%;
}
.itemPrice{
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	padding-top: 1px;
	font-size: 15px;
	font-weight : 700;
	width: 20%;
}
.itemDel{
	float: right!important;
	display: inline-block;
	vertical-align: top;
	line-height: 19px;
	font-size: 15px;
	font-weight : 700;
	width: 5%;
}
.countBox{
	margin-left: 4px;
	margin-right: 4px;
}

</style>
<script type="text/javascript">
	'use strict';
	
	let totPrice = 0;
	let cnt = 1;
	let realPrice = '${vo.SPrice}';
	let salePersent = '${vo.prdSale}'
	//let prdPrice = '${vo.SPrice}';
	let prdPrice = Number(realPrice) - (Number(realPrice) * (Number(salePersent) / 100));
	
	function demoshow(no){
		$("#demoShow"+no).hide();
		$("#demoHide"+no).show();
	}
	function demohide(no){
		$("#demoShow"+no).show();
		$("#demoHide"+no).hide();
	}
	
	
	function sizeShow(no){
		if(no == 1){
			$("#prdSizeShow").hide();
			$("#prdSizeHide").show();
		}
		else{
			$("#prdSizeShow").show();
			$("#prdSizeHide").hide();
		}
	}
	function detailShow(no){
		if(no == 1){
			$("#prdDetailShow").hide();
			$("#prdDetailHide").show();
		}
		else{
			$("#prdDetailShow").show();
			$("#prdDetailHide").hide();
		}
	}
	function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
  }
	function selectBox(size,price){
		$("#no"+size).attr('disabled',true);
		$("#prdSizeShow").show();
		$("#prdSizeHide").hide();
		totPrice = totPrice + Number(prdPrice);
		
		let foPrice = addComma(String(prdPrice));
		let tfoPrice = addComma(String(totPrice));
		
		let data = '<div class="selectBox" id="selectItem'+cnt+'">';
		    data += '<span class="itemTitle">사이즈</span>';
		    data += '<span class="itemSize">'+size+'</span>';
		    data += '<div class="itemCounter">';
		    data += '<a href="javascript:countDown('+cnt+')"><i class="fa fa-caret-square-o-down" aria-hidden="true"></i></a>';
		    data += '<span class="countBox" id="selectCount'+cnt+'">1</span>';
		    data += '<a href="javascript:countUp('+cnt+')"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></div>';
		    data += '<span class="itemPrice" id="itemPrice'+cnt+'">'+foPrice+'원</span>';
		    data += '<span class="itemDel"><a href="javascript:itemDelete('+cnt+')"><i class="fa fa-times" aria-hidden="true"></i></a></span>';
		    data += '<input type="hidden" id="itemSize'+cnt+'" value="'+size+'" name="itemSize">';
		    data += '<input type="hidden" id="itemCount'+cnt+'" value="1" name="itemCount">';
		    data += '<input type="hidden" id="prdIdx'+cnt+'" value="${param.prdIdx}" name="prdIdx">';
		    data += '</div>';
		$("#selectBox").append(data);
		$("#totPrice").html(tfoPrice+"원");
		let Point = Math.floor(totPrice * 0.01);
		$("#totPoint").html(Point+" P");
		cnt = cnt+1;
	}
	function itemDelete(no){
		let count = $("#itemCount"+no).val();
		let size = $("#itemSize"+no).val();
		let prdCount = count * prdPrice;
		totPrice = totPrice - Number(prdCount);
		let Point = Math.floor(totPrice * 0.01);
		let tfoPrice = addComma(String(totPrice));
		$("#totPrice").html(tfoPrice+"원");
		$("#totPoint").html(Point+" P");
		$("#selectItem"+no).remove();
		
		$("#no"+size).attr('disabled',false);
	}
	
	function countDown(no){
		let test = $("#itemCount"+no).val();
		if(test == 1){
			return;
		}
		else{
			$("#selectCount"+no).html(Number(test)-1);
			$("#itemCount"+no).val(Number(test)-1);
			let nowPrice = prdPrice * (Number(test)-1);
			$("#itemPrice"+no).html(addComma(nowPrice.toString())+"원");
			totPrice = totPrice - Number(prdPrice);
			let Point = Math.floor(totPrice * 0.01);
			let tfoPrice = addComma(String(totPrice));
			$("#totPrice").html(tfoPrice+"원");
			$("#totPoint").html(Point+" P");
		}
	}
	function countUp(no){
		let test = $("#itemCount"+no).val();
		if(test == 5){
			return;
		}
		$("#selectCount"+no).html(Number(test)+1);
		$("#itemCount"+no).val(Number(test)+1);
		let nowPrice = prdPrice * (Number(test)+1);
		$("#itemPrice"+no).html(addComma(nowPrice.toString())+"원");
		totPrice = totPrice + Number(prdPrice);
		let Point = Math.floor(totPrice * 0.01);
		let tfoPrice = addComma(String(totPrice));
		$("#totPrice").html(tfoPrice+"원");
		$("#totPoint").html(Point+" P");
	}
	
	function orderCheck(){
		let size = $("input[name='itemSize']").length;
		let data = "";
		let myData = new FormData($("#myForm")[0]);
		
		for(let i = 0; i<size; i++){
			data += $("input[name='itemSize']").eq(i).attr("value");
		}
		if(data.trim() == ""){
			alert("옵션을 선택해주세요");
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/product/cartCheck",
				data : myData,
				contentType : false,
				processData : false,
				success : function(vos){
					myForm.submit();
				},
				error : function(){
					alert("서버오류");
				}
			});
		}
	}
	function cartCheck(){
		let size = $("input[name='itemSize']").length;
		let data = "";
		let myData = new FormData($("#myForm")[0]);
		
		
		
		for(let i = 0; i<size; i++){
			data += $("input[name='itemSize']").eq(i).attr("value");
		}
		if(data.trim() == ""){
			alert("옵션을 선택해주세요");
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/product/cartInput",
				data : myData,
				contentType : false,
				processData : false,
				success : function(vos){
					let ans = confirm("장바구니에 상품을 등록하였습니다 장바구니로 이동하시겠습니까?");
					if(ans == true){
						location.href="${ctp}/product/productCartPage";
					}
				},
				error : function(){
					alert("서버오류");
				}
			});
		}
	}
	function wishUp(res){
		let mid = '${sIdx}';
		let prdIdx = res;
		if(mid == ''){
			Swal.fire({
				  position: 'top',
				  icon: 'warning',
				  title: '로그인후 이용해주세요',
				  showConfirmButton: false,
				  timer: 1000
			}).then(function(){
			location.href = '${ctp}/log/login?url=productMain';							
			});
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/product/wishUp",
				data : {
					memIdx : mid,
					prdIdx : prdIdx
				},
				success : function(){
					location.reload();
				}
			});
		}
		
	}
	
	function wishDown(res){
		let mid = '${sIdx}';
		let prdIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/product/wishDown",
			data : {
				memIdx : mid,
				prdIdx : prdIdx
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
<div class="w3-content" style="max-width:2000px;max-height:9000px;margin-top:120px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1300px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-center">
			<c:choose>
				    	<c:when test="${vo.ebrName == 'Nike'}">
				    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 550px;height: 550px;background-color: #EBF0F5">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Jordan'}">
				    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 550px;height: 550px;background-color: #F6EEED">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Adidas'}">
				    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 550px;height: 550px;background-color: #F1F1EA">
				    	</c:when>
				    	<c:otherwise>
				    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 550px;height: 550px;background-color: #F5F5F5">
				    	</c:otherwise>
				    </c:choose>
			</div>
			<div class="w3-half w3-border-left" style="padding-left: 30px">
				<div class="w3-container">
				<h5><a class="brandTitle">${vo.ebrName}</a></h5>
				<p class="productEtitle">${vo.eprdName}</p>
				<p class="productKtitle"><font color="gray">${vo.kprdName}</font></p>
				<br>
				<p><span><font class="productKtitle">모델번호</font></span><span class="w3-right">${vo.prdNum}</span></p>
				<hr>
				<p><span><font class="productKtitle">색상</font></span><span class="w3-right">${vo.color}</span></p>
				<hr>
				<c:if test="${empty vos}">
				<p><span class="w3-right"><b>상품준비중 입니다.</b></span></p><br>
				<hr>
				</c:if>
				<c:if test="${not empty vos}">
				<p id="prdSizeShow" style="height: 30px">
				<span>
					<font class="productKtitle">사이즈</font></span><span class="w3-right"><a href="javascript:sizeShow(1)">사이즈 선택 <i class="fa fa-angle-down" aria-hidden="true"></i></a>
					<br><font color="gray"><b></b><small>(최대 5개 가능)</small></font>
				</span>
				</p>
				<p id="prdSizeHide" class="w3-white" style="display: none">
				<span><font class="productKtitle">사이즈</font></span>
				<span class="w3-right">
					<a href="javascript:sizeShow(2)">사이즈 선택 <i class="fa fa-angle-up" aria-hidden="true"></i></a>
					<br><font color="gray"><b></b><small>(최대 5개 가능)</small></font>
				</span><br><br><br>
				<c:forEach var="opvo" items="${vos}">
					<%-- <a href="javascript:selectBox('${opvo.size}','${vo.SPrice}')" id="no${opvo.size}" class="w3-button w3-border w3-round-large w3-margin-bottom"><small><b>${opvo.size}</b></small><br><small>수량 : ${opvo.count}</small></a> --%>
					<button type="button" onclick="selectBox('${opvo.size}','${vo.SPrice}')" id="no${opvo.size}" class="w3-button w3-border w3-round-large w3-margin-bottom" <c:if test="${opvo.count == 0}">disabled</c:if>><small><b>${opvo.size}</b></small><br><small>수량 : ${opvo.count}</small></button>
				</c:forEach>
				</p>
				<hr>
				</c:if>
				<c:if test="${vo.prdSale == 0}">
				<p><span class="productKtitle">가격 정보</span><span class="w3-right"><b class="sprice">${vo.formatPrice}원</b>
				<br><font color="gray"><b></b><small>할인율 ${vo.prdSale}%</small></font></span></p><br>
				</c:if>
				<c:if test="${vo.prdSale != 0}">
				<c:set var="prdSalePrice" value="${vo.SPrice - (vo.SPrice * (vo.prdSale / 100))}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdSalePrice}" var="commaPrice"/>
				<p><span class="productKtitle">가격 정보</span><span class="w3-right"><b class="countsprice">${vo.formatPrice}원</b><br><b class="sprice">${commaPrice}원</b>
				<br><font color="gray"><b></b><small>할인율 ${vo.prdSale}%</small></font></span></p><br>
				</c:if>				
				<br>
				<br>
				<form id="myForm" name="myForm" action="${ctp}/product/productSellPage" method="post">
				<div id="selectBox">
				</div>
				
				</form>
					<hr>
					<p>
					<span class="productKtitle">총 가격</span>
					<span class="w3-right">
					<b class="sprice" id="totPrice">0원</b>
					</span>
					</p>
					<p>
					<span class="productKtitle"><font color="gray">예상 적립금( 1 % )</font></span>
					<span class="w3-right">
					<b class="productKtitle" id="totPoint">0 P</b>
					</span>
					</p>
					<br>
				<c:if test="${not empty sMid}">
				<div class="w3-center">
					<c:if test="${empty wvos }">
				      <button type="button" onclick="wishUp(${vo.prdIdx})" class="btn default w3-round-large" style="width: 20%;height: 60px"><i class="fa fa-bookmark-o" aria-hidden="true"></i></button>
				      </c:if>
				      <c:if test="${not empty wvos }">
				      <c:set var="flag" value="false"/>
				      <c:forEach var="wvo" items="${wvos}" varStatus="stss">
				      <c:if test="${wvo.memIdx == sIdx and wvo.prdIdx == vo.prdIdx}">
				      	<button type="button" onclick="wishDown(${vo.prdIdx})" class="btn default w3-round-large w3-light-gray" style="width: 20%;height: 60px"><i class="fa fa-bookmark" aria-hidden="true"></i></button>
				        <c:set var="flag" value="true"/>
				      </c:if>
				      <c:if test="${not flag}">
				      <c:if test="${stss.last}">
				      	<button type="button" onclick="wishUp(${vo.prdIdx})" class="btn default w3-round-large" style="width: 20%;height: 60px"><i class="fa fa-bookmark-o" aria-hidden="true"></i></button> 
				      </c:if>				      	
				      </c:if>
				      </c:forEach>
				      </c:if>
				      <c:if test="${vo.sellStop != 0 }">
								<input type="button" onclick="orderCheck()" class="btn info w3-round-large" value="구매하기" style="width: 45%;height: 60px">
								<input type="button" onclick="cartCheck()" class="btn success w3-round-large" value="장바구니" style="width: 30%;height: 60px">
				      </c:if>
				      <c:if test="${vo.sellStop == 0 }">
								<input type="button" class="btn info w3-round-large w3-disabled" disabled="disabled" value="상품준비중" style="width: 75%;height: 60px">
				      </c:if>
				</div>
				</c:if>
				<c:if test="${empty sMid}">
				<div class="w3-center">
					<input type="button" onclick="location.href='${ctp}/log/login?url=product&tag=${vo.prdIdx}';" class="w3-button w3-large w3-border w3-round-large w3-margin-bottom w3-ios-grey" value="로그인 후 이용해주세요" style="width: 95%;height: 60px">
				</div>
				</c:if>
				
				<br><br><br>
				<p><span class="subtitle"><strong>구매 전 꼭 확인해주세요!</strong></span></p>
				<hr>
				<div id="demoShow1">
				<p><a href="javascript:demoshow(1)"><span class="productKtitle">배송 기간 안내</span><span class="w3-right"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a></p>
				<hr>
				</div>
				<div id="demoHide1" style="display: none">
				<p><a href="javascript:demohide(1)"><span class="productKtitle"><b>배송 기간 안내</b></span><span class="w3-right"><i class="fa fa-angle-up" aria-hidden="true"></i></span></a></p>
				<hr style="background-color: black;height: 2px">
				<p class="subBody"><strong>KREAM#은 최대한 빠르게 모든 상품을 배송하기 위해 노력하고 있습니다.</strong></p>
				<p class="subBody">- 오늘(오후 11:59까지) 결제하면 내일 바로 출고되어 빠른 배송이 가능합니다. (연휴 및 공휴일, 천재지변, 택배사 사유 등 예외적으로 출고일이 변경될 수 있습니다</p>
				<p class="subBody">- 상품 종류 및 상태에 따라 검수 소요 시간은 상이할 수 있으며, 구매의사 확인에 해당할 경우 구매자와 상담 진행으로 인해 지연이 발생할 수 있습니다</p>
				<p class="subBody">- 검수센터 출고는 매 영업일에 진행하고 있으며, 출고 마감시간은 오후 5시입니다. 출고 마감시간 이후 검수 완료건은 운송장번호는 입력되지만 다음 영업일에 출고됩니다.</p>
				<hr>
				</div>
				<div id="demoShow2">
				<p><a href="javascript:demoshow(2)"><span class="productKtitle">구매 환불/취소/교환 안내</span><span class="w3-right"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a></p>
				<hr>
				</div>
				<div id="demoHide2" style="display: none">
				<p><a href="javascript:demohide(2)"><span class="productKtitle"><b>구매 환불/취소/교환 안내</b></span><span class="w3-right"><i class="fa fa-angle-up" aria-hidden="true"></i></span></a></p>
				<hr style="background-color: black;height: 2px">
				<p class="subBody"><strong>KREAM#은 직접판매를 하고 구매자가 최상의 상태의 제품을 받을수있도록 노력하고있습니다.</strong></p>
				<p class="subBody">- 단순 변심이나 실수에 의한 취소/교환/반품이 불가능합니다.</p>
				<p class="subBody">- 상품 수령 후, 이상이 있는 경우 KREAM 고객센터로 문의해주시기 바랍니다</p>
				<hr>
				</div>
				</div>
			</div>
		</div>
		<div class="w3-container" style="width:1300px;margin: auto;margin-top:100px;padding-top:10px;padding: auto">
			<div id="prdDetailShow" class="w3-center">
			<h4 class="w3-left-align"><b>상세정보</b></h4>
			<hr style="border-color: black">
				<a href="javascript:detailShow(1)" class="w3-button w3-white w3-hover-white w3-margin-top w3-margin-bottom"><font size="5px">상세정보 펼치기 <i class="fa fa-angle-double-down" aria-hidden="true"></i></font></a>
			</div>
			<div id="prdDetailHide" class="w3-container w3-center" style="display: none">
				<h4 class="w3-left-align"><b>상세정보</b></h4>
				<hr style="border-color: black">
				<a href="javascript:detailShow(2)" class="w3-button w3-white w3-hover-white w3-margin-top w3-margin-bottom"><font size="5px">상세정보 접기 <i class="fa fa-angle-double-up" aria-hidden="true"></i></font></a>
				${vo.prdContent}
				<a href="javascript:detailShow(2)" class="w3-button w3-white w3-hover-white w3-margin-top w3-margin-bottom"><font size="5px">상세정보 접기 <i class="fa fa-angle-double-up" aria-hidden="true"></i></font></a>
			</div>
			<div class="w3-center">
			<h4 class="w3-left-align"><b>관련 FEED</b></h4>
			<hr style="border-color: black">
			
			<div class="w3-row" style="padding: 30px 40px;">
					<c:if test="${empty bvos}">
					<div class="w3-center"><b>해당 상품을 태그한 피드가 없습니다.</b></div>
					</c:if>
					<c:if test="${not empty bvos}">
					<div class="w3-row">
					<c:forEach var="bvo" items="${bvos}">
					<div class="card w3-col m3" style="width: 280px;height:550px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/board/content?boIdx=${bvo.boIdx}&memIdx=${bvo.bo_memIdx}';">
								<c:set var="fNames" value="${fn:split(bvo.bo_fName,'/')}" />
								<c:if test="${fn:length(fNames) != 1}">
								<div class="img_tag">
									<span class="img_Cnt">+${fn:length(fNames)}</span>	
								</div>
								</c:if>								
				    		<img class="card-img-top w3-round-large" src="${ctp}/board/${fNames[0]}" alt="Card image" style="width: 279px;height:336px;background-color: #EBF0F5">
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
				      </c:if>
		  			</div>
					</c:forEach>
					</div>
					<div class="w3-center" style="height: 50px">
						<a href="${ctp}/board/feedProduct?pag=1&pageSize=16&prdIdx=${vo.prdIdx}" class="w3-button w3-border w3-round-large w3-hover-white">더보기</a>
					</div>
					</c:if>
				</div>
			</div>
			<div class="w3-row">
			<h4 class="w3-left-align"><b>${vo.ebrName}</b>의 다른상품</h4>
			<hr style="border-color: black">
					<c:if test="${empty brvos}">
					<div class="w3-center" style="height: 200px"><b>${vo.ebrName}</b>의 다른상품이 없습니다.</div>
					</c:if>
					<c:if test="${not empty brvos}">
					<div class="w3-row">
					<c:forEach var="brvo" items="${brvos}">
					<div class="card w3-col m2" style="height: 480px;width: 230px;margin-right: 10px;margin-left: 10px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${brvo.prdIdx}';">
				    <c:choose>
				    	<c:when test="${brvo.ebrName == 'Nike'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${brvo.prdfName}" alt="Card image" style="width: 230px;height: 230px;background-color: #EBF0F5">
				    	</c:when>
				    	<c:when test="${brvo.ebrName == 'Jordan'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${brvo.prdfName}" alt="Card image" style="width: 230px;height: 230px;background-color: #F6EEED">
				    	</c:when>
				    	<c:when test="${brvo.ebrName == 'Adidas'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${brvo.prdfName}" alt="Card image" style="width: 230px;height: 230px;background-color: #F1F1EA">
				    	</c:when>
				    	<c:otherwise>
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${brvo.prdfName}" alt="Card image" style="width: 230px;height: 230px;background-color: #F5F5F5">
				    	</c:otherwise>
				    </c:choose>
				    <div class="card-body text-center">
				      <h4 class="card-title"><font color="black" size="2px"><b>${brvo.ebrName}</b></font></h4>
				      <p class="card-text"><font color="black" size="2px">${brvo.eprdName}</font><br>
							<font color="gray" size="2px">${brvo.kprdName}</font><br></p>
							<c:if test="${brvo.prdSale == 0}">
					      <font color="black" size="2px"><b>${brvo.formatPrice}원</b></font><br><font color="gray" size="2px">판매 가격</font>
							</c:if>
							<c:if test="${vo.prdSale != 0}">
								<c:set var="brvoSalePrice" value="${brvo.SPrice - (brvo.SPrice * (brvo.prdSale / 100))}"/>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${brvoSalePrice}" var="brvocommaPrice"/>
					      <font color="black" size="2px"><b style="text-decoration: line-through;text-decoration-color:red;">${brvo.formatPrice}원</b></font><br>
					      <font color="black" size="2px"><b>${brvocommaPrice}원</b></font><br>
					      <font color="gray" size="2px">판매 가격</font>
					      <span class="w3-right">${brvo.prdSale}%</span>
							</c:if>
				    </div>
		   		 </div>
		  		</div>
					</c:forEach>
					</div>
					<div class="w3-center" style="height: 50px">
						<a href="${ctp}/product/productMain?pag=1&pageSize=16&brand=${vo.ebrName}&sort=desc" class="w3-button w3-border w3-round-large w3-hover-white">더보기</a>
					</div>
					</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>