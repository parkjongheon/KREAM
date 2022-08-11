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
	'use strict';
	
	let totCount = ${totCount};
	let userPoint = ${logvo.point};
	
	
	function keyCheck(){
		let key = $("#userPoint").val();
		let totalPrice = $("#totalPrice").val();
		
		
		
		if(key.replace(/[0-9]/g, "").length > 0) {
			$("#userPoint").val($("#userPoint").val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
    }
		else if(key > userPoint){
			$("#userPoint").val(userPoint);
			$("#setPoint").val(userPoint);
			let ovPoint1 = totalPrice - $("#setPoint").val();
			let Point1 = Math.floor(ovPoint1 * 0.01);
			$("#strtotalPrice").html(addComma(ovPoint1.toString())+" 원");
			$("#strPoint").html('<small>- '+userPoint+' P</small>');
		}
		else if(key == 0){
			$("#setPoint").val(0);
			$("#strtotalPrice").html(addComma($("#totalPrice").val().toString())+" 원");
			$("#strPoint").html('<small>- '+0+' P</small>');
		}
		else{
			$("#setPoint").val(key);
			let ovPoint2 = totalPrice - $("#setPoint").val();
			let Point2 = Math.floor(ovPoint2 * 0.01);
			$("#strtotalPrice").html(addComma(ovPoint2.toString())+" 원");
			$("#strPoint").html('<small>- '+key+' P</small>');
		}
	}
	
	
	function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
  }
	
	let IMP = window.IMP;
	IMP.init('imp21064327');
	
	function orderCheck(){
		let price = $("#totalPrice").val();
		let point = $("#setPoint").val();
		let count = $("#itemCount").val();
		let totalPrice = price - point;
		let title = $("#itemName0").val();
		if(count != 1){
			title ="상품 "+totCount+"건";
		}
		
		IMP.request_pay({
			pg : 'html5_inicis',
			pay_method : 'card',
			merchant_uid : 'kr#_' + new Date().getTime(),
			name : title,
			amount : 100,
			buyer_email : '${logvo.email}',
			buyer_name : '${logvo.name}',
			buyer_tel : '${logvo.tel}',
			buyer_addr : '${logvo.address}',
			buyer_postcode : '${logvo.post}',
		}, function(rsp) {
			if( rsp.success ){
				$("#pay_marchantId").val(rsp.merchant_uid);
				myForm.submit();
			}
			else{
				alert(rsp.error_msg);
			}
		});
	}
	
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;max-height:5000px;margin-top:120px;margin-bottom: 50px">
	<div class="w3-container" style="width:100%;height: 100%">
	<form action="${ctp}/product/productOrderOk" method="post" name="myForm">
		<div class="w3-container" style="width:1500px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-center" style="width:55%;">
			<c:forEach var="vo" items="${vos}" varStatus="st">
			<input type="hidden" id="itemName${st.index}" value="${vo.kprdName}">
			<input type="hidden" id="itemCount" value="${st.index}">
			<div class="selectBox w3-row w3-border-top w3-border-bottom" id="selectItem${st.index}" style="margin-right: 30px;">
				<div class="w3-col selectItemBox" style="width:20%;height: 130px;border-color: white">
					<c:choose>
			    	<c:when test="${vo.ebrName == 'Nike'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 120px;height: 120px;background-color: #EBF0F5">
			    	</c:when>
			    	<c:when test="${vo.ebrName == 'Jordan'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 120px;height: 120px;background-color: #F6EEED">
			    	</c:when>
			    	<c:when test="${vo.ebrName == 'Adidas'}">
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 120px;height: 120px;background-color: #F1F1EA">
			    	</c:when>
			    	<c:otherwise>
			    		<img class="w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 120px;height: 120px;background-color: #F5F5F5">
			    	</c:otherwise>
					 </c:choose>
				</div>
				<div class="w3-col w3-left selectItemBox" style="width:45%;height: 130px;padding-left: 10px;padding-right: 10px">
				<p style="text-align: left;margin-top: 0px">
				<b>${vo.eprdName}</b><br>
				<font color="gray">${vo.kprdName}</font><br>
				<font color="gray">선택 옵션 : </font><b>${vo.prdoption}</b>
				</p>
				<c:set var="prdtotPrice" value="${(vo.SPrice - (vo.SPrice * (vo.prdSale / 100))) * vo.prdCount}"/>
				<c:set var="prdSalePrice" value="${vo.SPrice - (vo.SPrice * (vo.prdSale / 100))}"/>
				<c:set var="prdPrice" value="${vo.SPrice}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdtotPrice}" var="fprdtotPrice"/>		
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdSalePrice}" var="fprdSalePrice"/>		
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdPrice}" var="fprdPrice"/>	
				<c:if test="${vo.prdSale != 0}">
				<span class="w3-right"><font color="gray"><small>상품 가격</small></font> <font style="text-decoration: line-through;text-decoration-color:red">${fprdPrice} </font>원</span><br>
				<span class="w3-right"><font color="gray"><small>할인율(${vo.prdSale}%)</small></font> ${fprdSalePrice} 원</span>
				</c:if>	
				<c:if test="${vo.prdSale == 0}">
				<span class="w3-right"><font color="gray"><small>상품 가격</small></font> ${fprdSalePrice} 원</span>
				</c:if>	
				
				</div>
				<div class="w3-col w3-container w3-center selectItemBox" style="width:15%;height: 130px;padding-top: 50px">
				
		    <span id="selectCount${st.index}">수량 : <b>${vo.prdCount}</b></span>
		    
				</div>
				<div class="w3-col w3-container" style="width:20%;height: 130px;padding-top: 50px">
					<span id="prdtotprice${st.index}" style="margin-top: 35px"><b>${fprdtotPrice}</b> 원</span>
				</div>
		  <input type="hidden" id="prdIdx${st.index}" name="prdIdx" value="${vo.prdIdx}">
		  <input type="hidden" id="prdCount${st.index}" name="prdCount" value="${vo.prdCount}">
		  <fmt:parseNumber var="prdSalePrice" value="${prdSalePrice}" integerOnly="true"/>
		  <input type="hidden" id="prdPrice${st.index}" name="prdPrice" value="${prdSalePrice}">
		  <fmt:parseNumber var="prdTotalPoint" value="${prdtotPrice * (1 / 100)}" integerOnly="true"/>
		  <input type="hidden" id="prdTotalPrice${st.index}" name="prdTotalPrice" value="${prdtotPrice}">
		  <input type="hidden" id="prdOption${st.index}" name="prdOption" value="${vo.prdoption}">
		  <input type="hidden" id="prdTotalPoint${st.index}" name="prdTotalPoint" value="${prdTotalPoint}">
		  <c:set var="totalPrices" value="${totalPrice = totalPrice + prdtotPrice}"/>
		  </div>
			</c:forEach>
		  <fmt:parseNumber var="totalPoint" value="${totalPrice * (1 / 100)}" integerOnly="true"/>
		  <fmt:parseNumber var="totalPrice" value="${totalPrices}" integerOnly="true"/>
		  <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
		  <input type="hidden" id="totalPoint" name="totalPoint" value="${totalPoint}">
		  <fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" var="ftotalPrice"/>	
			</div>
			<div class="w3-half w3-border-left" style="width:40%;padding-left: 10px">
				<div class="w3-container">
				<h4><b>주문자 정보</b></h4>
				<p><span><font class="productKtitle">이름</font></span><span class="w3-right">${logvo.name}</span></p>
				<hr>
				<h4><b>배송 주소</b></h4><span class="w3-right"><a href="javascript:addressChange()" class="w3-button w3-border w3-round-large">변경하기</a></span>
				<div class="w3-cell" style="width: 100px">
					<div class="w3-bar-block">
						<p><span><font class="productKtitle">수령자</font></span></p>
					</div>
					<div class="w3-bar-block">
						<p><span><font class="productKtitle">연락처</font></span></p>
					</div>
					<div class="w3-bar-block">
						<p><span><font class="productKtitle">주소</font></span><br><br><br></p>
					</div>
					<div class="w3-bar-block">
						<p><span><font class="productKtitle">배송메세지</font></span></p>
					</div>
				</div>
				<div class="w3-cell">
					<div class="w3-bar-block">
						<p><span><font class="productKtitle" id="reUser">${logvo.name}</font></span></p>
						<input type="hidden" id="pay_getName" name="pay_getName" value="${logvo.name}">
					</div>
					<div class="w3-bar-block">
						<p><span><font class="productKtitle" id="reTel">${logvo.tel}</font></span></p>
						<input type="hidden" id="pay_getTel" name="pay_getTel" value="${logvo.tel}">
					</div>
					<div class="w3-bar-block">
						<c:set var="address" value="${fn:split(logvo.address,'/')}"/>
						<p><span><font class="productKtitle" id="reAddress">(${logvo.post})<br>${address[0]} ${address[1]}<br>${address[2]}</font></span></p>
						<input type="hidden" id="pay_getPost" name="pay_getPost" value="${logvo.post}">
						<input type="hidden" id="pay_getAddress" name="pay_getAddress" value="${address[0]} ${address[1]} ${address[2]}">
					</div>
					<div class="w3-bar-block">
						<p>
							<span>
								<select class="w3-select" id="postMsg">
									<option value="배송메세지 없음">배송메세지 없음</option>
									<option value="부재시 전화주세요.">부재시 전화주세요.</option>
									<option value="무인 택배함에 넣어주세요.">무인 택배함에 넣어주세요.</option>
								</select>
							</span>
						</p>
						<input type="hidden" name="pay_getPostMsg" value="배송메세지 없음">
						<input type="hidden" id="pay_marchantId" name="pay_marchantId" value="">
					</div>
				</div>
				<hr>
				<h4><b>포인트</b></h4><br>
				<input type="text" class="w3-input w3-border w3-small w3-round-large" id="userPoint" name="userPoint" placeholder="0" style="width: 200px;" oninput="keyCheck()">
				<input type="hidden" id="setPoint" name="setPoint" value="0">
				<label><small>보유포인트 <b>${logvo.point}</b>P</small></label>
				<hr>
				<h4><b>최종 주문 정보</b></h4>
				<div class="w3-container">
					<p>
						<span class="productKtitle">총 가격</span>
						<span class="w3-right"><b class="sprice" id="strtotalPrice">${ftotalPrice} 원</b><br></span>
					</p>
					<hr style="border-width: 3px">
					<p>
						<span class="productKtitle"><small>포인트 사용</small></span>
						<span class="w3-right"><b id="strPoint"><small>- 0 P</small></b><br></span>
					</p>
					<p>
						<span class="productKtitle"><small>배송비</small></span>
						<span class="w3-right"><b><small>무료</small></b><br></span>
					</p>
					<hr>
					<p>
						<span class="productKtitle"><small>예상 적립금</small></span>
						<span class="w3-right"><b id="strOvPoint"><small>+ ${totalPoint} P</small></b><br></span>
					</p>
				</div>
				<div class="w3-container">
					<input type="button" id="payOk" onclick="orderCheck()" class="w3-button w3-border w3-ios-deep-blue w3-round-large w3-hover-blue w3-margin-bottom" value="결제하기" style="width: 100%;margin-top: 50px;height: 50px">
				</div>
				</div>
			</div>
		</div>
		</form>
	</div>
</div>
<script>
 function addressChange(){
	 $.ajax({
		 type : "post",
		 url : "${ctp}/mem/getAdrInfo",
		 success : function(vos){
			 let data = '<ul class="w3-ul w3-round-large">';
			 for(let i = 0; i<vos.length; i++){
				 let adr = vos[i].adr_address.split('/');
			 		data +='<li class="w3-bar w3-center">';
			 		data +='<div class="w3-bar-item" style="width: 79%">';
			 		data +='<span class="w3-small w3-left"><b>'+vos[i].adr_name+'</b></span><br>';
			 		data +='<span class="w3-small w3-left">'+vos[i].adr_tel+'</span><br>';
			 		data +='<span class="w3-small w3-left">('+vos[i].adr_post+') '+adr[0]+adr[1]+'<br>'+adr[2]+'</span>';
			 		data +='</div>';
			 		data +='<div class="w3-bar-item" style="width: 20%">';
			 		data +='<a href="javascript:address(2,'+vos[i].adr_Idx+')" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">선택</a>';
			 		data +='</div>';
			 		data +='</li>';
			 }
			 data +='</ul>';
			 $("#addressbox").html(data);
		 }
	 });
	 $("#modal01").css('display','block');
	 $('html, body').css({'overflow': 'hidden'});
 }
 function addressClose(){
	 $("#modal01").css('display','none');
	 $('html, body').css({'overflow': 'auto'});
 }
 function address(no,res){
	 let flag = "";
	 if(no == 1){
		 flag = "main";
	 }
	 else{
		 flag = "sub";
	 }
	 let idx = res;
	 $.ajax({
		 type : "post",
		 url : "${ctp}/mem/getAdrCheck",
		 data : {
			 flag : flag,
			 idx : idx
		 },
		 success : function(vo){
			 let name = "";
			 let tel = "";
			 let post = "";
			 let adr = "";
			 
			 if(flag == "main"){
				 name = vo.name;
				 tel = vo.tel;
				 post = vo.post;
				 adr = vo.address;
			 }
			 else{
				 name = vo.adr_name;
				 tel = vo.adr_tel;
				 post = vo.adr_post;
				 adr = vo.adr_address;
			 }
			 let adrs = adr.split('/');
			 let address = adrs[0]+" "+adrs[1]+" "+adrs[2];
			 
			 $("#reUser").html(name);
			 $("#pay_getName").val(name);
			 
			 $("#reTel").html(tel);
			 $("#pay_getTel").val(tel);
			 
			 $("#reAddress").html('('+post+')<br>'+address);
			 $("#pay_getPost").val(post);
			 $("#pay_getAddress").val(address);
			 addressClose();
			 
		 }
	 });
 }
</script>
<div id="modal01" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 600px;height:600px">
      <div class="w3-container">
        <span onclick="addressClose()" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h3 id="msgTitle" style="text-align: center">주소록</h3>        
				<div class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 470px">
				<hr style="border-width: 3px;border-color: black">
					<ul class="w3-ul w3-round-large">
						<li class="w3-bar w3-center">
						<div class="w3-bar-item" style="width: 79%">
						<span class="w3-small w3-left w3-light-gray" style="width: 80px">기본배송지</span><br>
						<span class="w3-small w3-left"><b>${logvo.name}</b></span><br>
						<span class="w3-small w3-left">${logvo.tel}</span><br>
						<c:set var="add" value="${fn:split(logvo.address,'/')}"/>
						<span class="w3-small w3-left">(${logvo.post}) ${add[0]} ${add[1]}<br> ${add[2]}</span>
						</div>
						<div class="w3-bar-item" style="width: 20%">
						<a href="javascript:address(1,${logvo.idx})" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">선택</a>
						</div>
						</li>
					</ul>
					<hr style="border-width: 1px;border-color: gray">
					<div id="addressbox">
					
					</div>
				</div>
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>