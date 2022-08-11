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
	'use strict';
	function cancelCheck(){
		let size = $('input:checkbox[name=cancelPrd]').length;
		let sizes = $('input:checkbox[name=cancelPrd]:checked').length;
		let retype = $('#return_type').val();
		let cnt = 0;
		let oricnt = 0;
		for(let i = 0; i<size; i++){
			oricnt += Number($('input[name=order_OriprdCount]').eq(i).attr("value"));
			if($('input:checkbox[name=cancelPrd]:checked').eq(i).is(":checked") == true){
				cnt = 1;
			}
		}
		if(cnt != 1){
			alert("최소 하나 이상의 상품을 선택해주세요");
			return;
		}
		else if(retype == null || retype == ""){
			alert("취소 사유를 선택해주세요");
			return;
		}
		else{
			let selectcnt = 0;
			let val = $("#order_val").val();
			for(let i = 0; i<sizes; i++){
				let idx = $('input:checkbox[name=cancelPrd]:checked').eq(i).attr("value");
				
				
				selectcnt += Number($("#order_prdCount"+idx).val());
				
				$("#order_prdIdx"+idx).attr("disabled",false);
				$("#order_subIdx"+idx).attr("disabled",false);
				$("#order_prdCount"+idx).attr("disabled",false);
				$("#order_prdOption"+idx).attr("disabled",false);
				$("#order_prdPrice"+idx).attr("disabled",false);
			}
			if(oricnt == selectcnt){
				if(val < 3){
					$("#return_status").val('전체취소');					
				}
				else{
					$("#return_status").val('전체환불');		
				}
			}
			else{
				if(val < 3){
					$("#return_status").val('부분취소');					
				}
				else{
					$("#return_status").val('부분환불');		
				}
			}
		}
		$("#return_marchantId").val('re#_' + new Date().getTime());
		cancleMyForm.submit();
	}
	// 구매확정
	function confirmCheck(){
		confirmMyForm.submit();
	}
	// 환불 개별체크
	function cancelPrdCheck(res){
		//$('input:checkbox[name=cancelTotal]').prop('checked',false); // 전체 체크하는 체크박스 해제
		let idx = res;
		let size = $('input:checkbox[name=cancelPrd]:checked').length; // for문으로 체크하기위한 모든 체크박스의 길이
		let cancelPrd = $("#cancelPrd"+idx).is(":checked"); // 체크한건지 해제한건지 의 값
		let totalCancelPrice = $("#totalCancelPrice").val(); // 총 누적 환불 금액 히든
		let count = $("#order_prdCount"+idx).val(); // 개별 수량 히든
		let price = $("#order_prdPrice"+idx).val(); // 개별 가격 히든
		let oriPoint = $("#orisetPoint").val();
		
		//addComma()
		let flag = 0;
		for(let i = 0; i<size; i++){
			if($('input:checkbox[name=cancelPrd]:checked').eq(i).is(":checked") == true){
				flag += 1;
			}
		}
		// 체크했을때
		if(cancelPrd == true){
			let prdPrice = Number(price)*Number(count);
			let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
			let salePrdPrice = Number(prdPrice) - oriPoint;
			let salenowTotal = Number(totalCancelPrice) + Number(salePrdPrice);
			if(flag == 1){
				$("#totalCancelPrice").val(salenowTotal);
				$("#orderTotalPay1").html(addComma(salenowTotal.toString()) +" 원");
			}
			else{
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");
			}
		}
		// 체크 해제 했을때
		else{
			let prdPrice = Number(price)*Number(count);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
			
			if(flag != 0){
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");
				
			}
			else{
				$("#totalCancelPrice").val(0);
				$("#orderTotalPay1").html("0 원");
			}
		}
	}
	function orderConfirm(res){
		let orderIdx = res;
		document.getElementById('id03').style.display='block'
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getOrderInfo",
			data : {
				orderIdx : orderIdx
			},
			success : function(vos){
				let value= "";
				let totalPrice = 0;
				$("#orderIdx2").html(vos[0].pay_marchantId);
				$("#orderDate2").html(vos[0].pay_orderDate);
				$("#orderName2").html(vos[0].name);
				
				if(vos[0].order_val == 0){
					value = "주문대기";
				}
				else if(vos[0].order_val == 1){
					value = "주문접수";
				}
				else if(vos[0].order_val == 2){
					value = "입금확인";
				}
				else if(vos[0].order_val == 3){
					value = "출고완료";
				}
				else if(vos[0].order_val == 4){
					value = "배송중";
				}
				else if(vos[0].order_val == 5){
					value = "배송완료";
				}
				
				$("#orderValue2").html(value);
				let hiddenbox = "";
				let point = 0;
				
				let data ='<tr>'
					//data += '<th style="width: 10%;color:gray;text-align: center"><input type="checkbox" checked="checked" id="cancelTotal" onclick="totalCheck()" name="cancelTotal"></th>';
					
					data += '<th style="width: 10%;color:gray;text-align: center">사진</th>';
					data += '<th style="width: 40%;color:gray;text-align: center">상품정보</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">개별가격</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">옵션</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">수량</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					point = point + vos[i].order_prdPoint;
					data += '<tr>';
					data +=	'<td style="width: 10%;text-align: center" class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>';
					data += '<td style="width: 40%;text-align: left">'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="width: 15%;text-align: center">'+addComma(vos[i].order_prdPrice.toString())+' 원</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdOption+'</td>';
					data += '<td style="width: 20%; text-align: center">'+vos[i].order_prdCount+'</td>';
					data +='</tr>';
					hiddenbox +='<input type="hidden" name="subIdx" value="'+vos[i].order_subIdx+'">';
				}
				$("#orderPoint2").html(point+" P");
				$("#infoTable2").html(data);
				$("#hiddenbox2").html(hiddenbox);
			}
		});
	}
	function orderCancel(res){
		let orderIdx = res;
		document.getElementById('id02').style.display='block'
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getOrderInfo",
			data : {
				orderIdx : orderIdx
			},
			success : function(vos){
				let value= "";
				let totalPrice = 0;
				$("#orderIdx1").html(vos[0].pay_marchantId);
				$("#orderDate1").html(vos[0].pay_orderDate);
				$("#orderName1").html(vos[0].name);
				$("#orderPoint1").html(vos[0].pay_setPoint+" P");
				if(vos[0].order_val == 0){
					value = "주문대기";
				}
				else if(vos[0].order_val == 1){
					value = "주문접수";
				}
				else if(vos[0].order_val == 2){
					value = "입금확인";
				}
				totalPrice = Number(vos[0].pay_price);
				
				$("#orderValue1").html(value);
				$("#orderTotalPay1").html(addComma(vos[0].pay_price.toString()) +" 원");
				let hiddenbox = "";
				hiddenbox +='<input type="hidden" id="totalCancelPrice" name="return_totalprice" value="'+totalPrice+'">';
				hiddenbox +='<input type="hidden" id="oritotalPrice" name="oritotalPrice" value="'+totalPrice+'" disabled="disabled">';
				hiddenbox +='<input type="hidden" id="orisetPoint" name="return_point" value="'+vos[0].pay_setPoint+'">';
				hiddenbox +='<input type="hidden" id="order_Idx" name="order_Idx" value="'+vos[0].orderIdx+'">';
				hiddenbox +='<input type="hidden" id="order_val" name="order_val" value="'+vos[0].order_val+'">';
				let data ='<tr>'
					//data += '<th style="width: 10%;color:gray;text-align: center"><input type="checkbox" checked="checked" id="cancelTotal" onclick="totalCheck()" name="cancelTotal"></th>';
					data += '<th style="width: 10%;color:gray;text-align: center">선택</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">사진</th>';
					data += '<th style="width: 40%;color:gray;text-align: center">상품정보</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">개별가격</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">옵션</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">수량</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					data += '<tr>';
					data += '<td style="width: 5%;text-align: center"><input type="checkbox" id="cancelPrd'+vos[i].order_subIdx+'" name="cancelPrd" value="'+vos[i].order_subIdx+'" checked="checked" onclick="cancelPrdCheck('+vos[i].order_subIdx+')"></td>';
					data +=	'<td style="width: 10%;text-align: center" class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>';
					data += '<td style="width: 40%;text-align: left">'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="width: 15%;text-align: center">'+addComma(vos[i].order_prdPrice.toString())+' 원</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdOption+'</td>';
					data += '<td style="width: 20%; text-align: center"><input type="number" id="cancelCnt'+vos[i].order_subIdx+'" min="1" max="'+vos[i].order_prdCount+'" value="'+vos[i].order_prdCount+'" oninput="keyCheck('+vos[i].order_subIdx+','+vos[i].order_prdCount+')"> / '+vos[i].order_prdCount+'</td>';
					data +='</tr>';
					hiddenbox +='<input type="hidden" id="order_subIdx'+vos[i].order_subIdx+'" name="order_subIdx" value="'+vos[i].order_subIdx+'" disabled="disabled">';
					hiddenbox +='<input type="hidden" id="order_prdIdx'+vos[i].order_subIdx+'" name="order_prdIdx" value="'+vos[i].order_prdIdx+'" disabled="disabled">';
					hiddenbox +='<input type="hidden" id="order_prdCount'+vos[i].order_subIdx+'" name="order_prdCount" value="'+vos[i].order_prdCount+'" disabled="disabled">';
					hiddenbox +='<input type="hidden" id="order_prdOption'+vos[i].order_subIdx+'" name="order_prdOption" value="'+vos[i].order_prdOption+'" disabled="disabled">';
					hiddenbox +='<input type="hidden" id="order_OriprdCount'+vos[i].order_subIdx+'" name="order_OriprdCount" value="'+vos[i].order_prdCount+'" disabled="disabled">';
					hiddenbox +='<input type="hidden" id="order_prdPrice'+vos[i].order_subIdx+'" name="order_prdPrice" value="'+vos[i].order_prdPrice+'" disabled="disabled">';
				}
				$("#infoTable1").html(data);
				$("#hiddenbox").html(hiddenbox);
			}
		});
	}
/* 	function totalCheck(){
		let ans = $('#cancelTotal').is(':checked');
		let oritotalprice = $("#oritotalPrice").val();
		if(ans == false){
			$('input:checkbox[name=cancelPrd]').prop('checked',false);
			$("#orderTotalPay1").html("0 원");
			$("#totalCancelPrice").val(0);
		}
		else{
			$('input:checkbox[name=cancelPrd]').prop('checked',true);
			$("#orderTotalPay1").html(addComma(oritotalprice.toString()) +" 원");
			$("#totalCancelPrice").val(oritotalprice);
		}
	} */
	
	function keyCheck(idx,cnt){
		let key = $("#cancelCnt"+idx).val();
		let price = $("#order_prdPrice"+idx).val(); // 개별 가격 히든
		let count = $("#order_prdCount"+idx).val();
		let oriCount = $("#order_OriprdCount"+idx).val(); // 개별 카운트 히든 ( 고정 )
		let totalCancelPrice = $("#totalCancelPrice").val();
		
		if(key < 1){
			if(count > key){
				let downcnt = count - 1; // 감소 수치
				let prdPrice = Number(price)*Number(downcnt);
				let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
				
				$("#cancelCnt"+idx).val(1);
				$("#order_prdCount"+idx).val(1);
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");
			}
	 	}
		else if(key > cnt){
			if(count < key){ // 증가
				let upcnt = cnt - count; // 증가 수치
				let prdPrice = Number(price)*Number(upcnt);
				let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
				
				$("#cancelCnt"+idx).val(cnt);
				$("#order_prdCount"+idx).val(cnt);
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");
			}
		}
		else if(count > key){ // 감소
			let downcnt = count - key; // 감소 수치
			let prdPrice = Number(price)*Number(downcnt);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);

	 		$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");
		}
		else if(count < key){ // 증가
			let upcnt = key - count; // 증가 수치
			let prdPrice = Number(price)*Number(upcnt);
			let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
			
			$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원");

		}

/* 			let prd = Number(oriCount) - Number(key);
			let prdPrice = Number(price)*Number(prd);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
			$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" 원"); */
		
	}
	
	function btDateCheck(){
		let start = $("#datepicker").val();
		let end = $("#datepicker1").val();
		let val = $("#searchVal").val();
		let btdate = start+"/"+end;
		if(val == null){
			location.href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate;
		}
		else{
			location.href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate+"&val="+val;			
		}
		
	}
	$(function(){
	    $('#datepicker').datepicker({
	    	dateFormat: 'yy-mm-dd' //달력 날짜 형태
	            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	            ,changeYear: true //option값 년 선택 가능
	            ,changeMonth: true //option값  월 선택 가능                          
	            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
	    
	    });
	    let dates = $("#datepicker").val();
	    $('#datepicker1').datepicker({
	    	dateFormat: 'yy-mm-dd' //달력 날짜 형태
	            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	            ,changeYear: true //option값 년 선택 가능
	            ,changeMonth: true //option값  월 선택 가능                          
	            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	            ,minDate: new Date(dates) //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
	    });
	    	$('#datepicker').datepicker('setDate','${startDate}');
	    	$('#datepicker1').datepicker('setDate','today');   
	  });
	function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
  }
	
	function orderInfor(res){
		let orderIdx = res;
		document.getElementById('id01').style.display='block'
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getOrderInfo",
			data : {
				orderIdx : orderIdx
			},
			success : function(vos){
				let value= "";
				let totalPrice = 0;
				$("#orderIdx").html(vos[0].pay_marchantId);
				$("#orderDate").html(vos[0].pay_orderDate);
				$("#orderName").html(vos[0].name);
				if(vos[0].order_val == 0){
					value = "주문접수";
				}
				totalPrice = Number(vos[0].pay_price) + Number(vos[0].pay_setPoint);
				
				$("#orderValue").html(value);
				$("#orderTotal").html(addComma(totalPrice.toString())+" 원");
				$("#orderPoint").html(vos[0].pay_setPoint+" P");
				$("#orderTotalPay").html(addComma(vos[0].pay_price.toString()) +" 원");
				$("#getName").html(vos[0].pay_getName);
				$("#getPost").html(vos[0].pay_getPost);
				$("#getAddress").html(vos[0].pay_getAddress);
				$("#getTel").html(vos[0].pay_getTel);
				$("#getPostMsg").html("["+vos[0].pay_getPostMsg+"]");
				let values = "";
				let data ='<tr>'
					data += '<th style="width: 10%;color:gray;text-align: center">사진</th>';
					data += '<th style="width: 50%;color:gray;text-align: center">상품정보</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">옵션</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">수량</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">상태</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					data += '<tr>';
					data +=	'<td class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>';
					data += '<td>'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdOption+'</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdCount+'</td>';
					if(vos[i].order_val == 0){
						values = "주문접수"
					}
					data += '<td>'+values+'</td>';
					data +='</tr>';
				}
				$("#infoTable").html(data);
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:5000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-cell" style="height: 100%;width: 220px;margin-left: 40px">
				<div class="w3-bar-block">
				  <h3><a href="${ctp}/mem/myPage" class="w3-bar-item"><b>마이 페이지</b></a></h3>
				  <h5 class="w3-bar-item"><b>쇼핑 정보</b></h5>
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="black"><b>구매 내역</b></font></a>
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
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1100px;margin-bottom: 100px">
				<div class="w3-container">
					<h3 id="title"><b>주문 내역</b></h3>
					<hr style="border-width: 3px;border-color: black">
					<div class="w3-round-large w3-theme-l5" style="height: 100px;margin-top: 20px">
						<div class="w3-cell" style="width: 240px;height: 140px;margin: auto">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>전체</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${ordercnt}</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>배송중</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${dlvcnt}</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>구매 확정</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${confirmcnt }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>환불 진행</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<a href="${ctp}/mem/myReturnList"><font size="2px" color="red" ><b>${returncnt}</b></font></a>
							</div>
						</div>
					</div>
					<h5><b>주문 상세 검색</b></h5>
					<hr style="border-width: 2px">
					<div class="w3-container" style="height: 60px;width: 1100px;margin-top: 20px">
						<div class="w3-row">
							<div class="w3-col m5">
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-border w3-round w3-small" style="width: 70px">전체</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=DAY" class="w3-button w3-border w3-round w3-small" style="width: 70px">오늘</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=1" class="w3-button w3-border w3-round w3-small" style="width: 70px">1개월</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=3" class="w3-button w3-border w3-round w3-small" style="width: 70px">3개월</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=6" class="w3-button w3-border w3-round w3-small" style="width: 70px">6개월</a>						
							</div>	
							<div class="w3-col m4">
								<div class="w3-half">
					    		<input type="text" id="datepicker"  class="w3-input w3-border w3-small w3-round-large w3-left" style="width: 130px">
					    	</div>  	
					    	<div class="w3-half">
					    		<input type="text" id="datepicker1"  class="w3-input w3-border w3-small w3-round-large w3-left" style="width: 130px">
					    	</div>   
							</div>
							<div class="w3-col m3">
							<select id="searchVal" style="width: 150px" class="w3-input w3-small w3-border w3-margin-right w3-round-large w3-half ">
								<option disabled="disabled" selected="selected">주문 상태 전체</option>
								<option value="0">주문 대기</option>
								<option value="1">주문 접수</option>
								<option value="2">입금 확인</option>
								<option value="3">출고 완료</option>
								<option value="4">배송중</option>
								<option value="5">배송완료</option>
								<option value="6">구매확정</option>
							</select>
    					<a href="javascript:btDateCheck()" id="searchButton" style="width: 60px" class="w3-button w3-small w3-border w3-half w3-round-large">검색</a>
							</div>
						</div>
					</div>
					<h5><b>주문 상품 정보</b></h5>
					<hr style="border-width: 2px">
					
					<div class="" style="height: 100%">
			    		<table class="w3-table w3-centered w3-round-large">
			    			<tr>
			    				<th class="w3-small" style="width: 15%">주문번호 / 시각</th>
			    				<th class="w3-small" style="width: 25%">상품이름</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">가격</th>
			    				<th class="w3-small" style="width: 10%;text-align: center">주문 상태</th>
			    				<th class="w3-small" style="width: 10%" class="w3-right-align">총 결제 금액</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">기타</th>
			    				<th class="w3-small" style="width: 2%">
			    				<c:if test="${sort == 'desc'}">
				    				<a id="memSort" href="${ctp}/mem/myOrderList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
			    				</c:if>
			    				<c:if test="${sort == 'asc'}">
				    				<a id="memDesc" href="${ctp}/mem/myOrderList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
			    				</c:if>
			    				</th>
			    			</tr>
			    		</table>
			    		<c:if test="${empty vos }">
			    		<div class="w3-container w3-center w3-margin-top">
			    		<h5>구매 내역이 없습니다.</h5>
			    		</div>
			    		</c:if>
			    		<c:if test="${not empty vos}">
			    		<table class="w3-border-top" style="margin-top: 10px;width: 100%">
			    			<c:forEach var="ordvo" items="${vos}" varStatus="st">
			    			<tr class="w3-border" style="height:  150px">
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td class="w3-center w3-border-right w3-border-bottom" rowspan="${ordvo.indexcnt}" style="width: 12%">
			    					<span class="w3-small"><b>${ordvo.pay_marchantId}</b></span><br>
							      <span class="w3-small">${ordvo.pay_orderDate}</span><br><br>
							      <span class="w3-small">주문자 :${ordvo.name}</span>
			    				</td>
			    				</c:if>
			    				<td style="padding-left: 12px;width: 3%" class="w3-border-bottom"><img src="${ctp}/product/${ordvo.prdfName}" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>
			    				<td class="w3-border-bottom w3-border-right" style="width: 20%">
				    				<span class="w3-small"><b>${ordvo.eprdName}</b></span><br>
								    <span class="w3-small">${ordvo.kprdName}</span><br><br>
								    <span class="w3-small">옵션 : <b>${ordvo.order_prdOption }</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
							    <span class="w3-small">수량 : <b>${ordvo.order_prdCount }</b></span>
			    				</td>
			    				<td style="width: 7%" class="w3-center w3-border-bottom w3-border-right">
			    				<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.order_prdPrice * ordvo.order_prdCount }" var="fprdPrice"/>	
			    				<span class="w3-small">${fprdPrice } 원</span><br>
							        <span class="w3-small"><font color="gray">(${ordvo.order_prdPoint} P)</font></span>
			    				</td>
			    				<td style="width:10%" class="w3-center w3-border-bottom w3-border-right">
			    				<c:if test="${ordvo.order_val == 0}">
			    					<span class="w3-small">[주문 확인중]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 1}">
			    					<span class="w3-small">[주문 접수]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 2}">
			    					<span class="w3-small">[입금 확인]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 3}">
			    					<span class="w3-small">[출고 완료]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 4}">
			    					<span class="w3-small">[배송중]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 5}">
			    					<span class="w3-small">[배송 완료]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 6}">
			    					<span class="w3-small">[구매 확정]</span>
			    				</c:if>
			    				</td>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" style="width: 10%" class="w3-center w3-border-bottom w3-border-right">
			    					<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.pay_price}" var="ftotalPrice"/>	
			    					<span class="w3-small"><b>총 결제 금액</b></span><br>
								    <span class="w3-small">${ftotalPrice} 원</span><br><br>
								    <span class="w3-small"><a href="javascript:orderInfor(${ordvo.orderIdx})">[주문 상세 보기]</a></span><br>
			    				</td>
			    				</c:if>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" class="w3-border-bottom w3-center" style="width: 10%">
			    					<c:if test="${empty revos}">
			    						<c:if test="${ordvo.order_val lt 3}">
						    					<div class="tooltip">
						    						<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">주문 취소</font></a>
													  <span class="tooltiptext">상품 출고전<br> 주문을 취소할수 있습니다.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val ge 3 and ordvo.order_val lt 5}">
						    					<div class="tooltip">
				    								<font class="w3-small">[주문 변경 불가]</font>
													  <span class="tooltiptext">상품 출고 이후에는<br>주문을 변경할수 없습니다.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 5}">
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white w3-margin-bottom" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">환불 신청</font></a>
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderConfirm(${ordvo.orderIdx})"><font color="blue">구매 확정</font></a><br>
				    							<font color="gray"><small>자동확정 ${ordvo.strTime }</small></font>
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 6}">
						    					<font color="blue"><small><b>구매확정</b></small></font>
				    						</c:if>		
			    					</c:if>
			    					<c:if test="${not empty revos}">
			    					<c:set var="flag" value="false"/>
			    					<c:forEach var="revo" items="${revos}" varStatus="rest">
			    						<c:if test="${revo.order_Idx == ordvo.orderIdx and revo.return_val == 0}">
			    							<div class="tooltip">
			    								<c:if test="${revo.return_status == '부분취소' }">
			    								[<font color="red">상품 부분 취소</font>]
												  <span class="tooltiptext">상품 취소중 에는<br>주문을 변경할수 없습니다.<br>정상처리후 변경가능합니다</span>
			    								</c:if>
			    								<c:if test="${revo.return_status == '전체취소' }">
			    								[<font color="red">상품 전체 취소</font>]
												  <span class="tooltiptext">상품 취소중 에는<br>주문을 변경할수 없습니다.<br>정상처리후 변경가능합니다</span>
			    								</c:if>
			    								<c:if test="${revo.return_status == '전체환불' }">
			    								[<font color="red">상품 전체 환불</font>]
												  <span class="tooltiptext">상품 환불중 에는<br>구매확정을 할수없습니다.<br>정상처리후 가능합니다</span>
												  </c:if>
			    								<c:if test="${revo.return_status == '부분환불' }">
			    								[<font color="red">상품 부분 환불</font>]
												  <span class="tooltiptext">상품 환불중 에는<br>구매확정을 할수없습니다.<br>정상처리후 가능합니다</span>
												  </c:if>
												</div><br>
				    						<c:set var="flag" value="true"/>
			    						</c:if>
			    						<c:if test="${not flag}">
			    						<c:if test="${rest.last}">
				    						<c:if test="${ordvo.order_val lt 3}">
						    					<div class="tooltip">
						    						<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">주문 취소</font></a>
													  <span class="tooltiptext">상품 출고전<br> 주문을 취소할수 있습니다.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val ge 3 and ordvo.order_val lt 5}">
						    					<div class="tooltip">
				    								<font class="w3-small">[주문 변경 불가]</font>
													  <span class="tooltiptext">상품 출고 이후에는<br>주문을 변경할수 없습니다.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 5}">
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white w3-margin-bottom" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">환불 신청</font></a>
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderConfirm(${ordvo.orderIdx})"><font color="blue">구매 확정</font></a><br>
				    							<font color="gray"><small>자동확정 ${ordvo.strTime }</small></font>
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 6}">
						    					<font color="blue"><small><b>구매확정</b></small></font>
				    						</c:if>														    						
			    						</c:if>
			    						</c:if>
			    					</c:forEach>
			    					</c:if>
			    				</td>
			    				</c:if>
			    			</tr>
			    			<c:set var="idx" value="${ordvo.pay_marchantId}" />
			    			</c:forEach>
			    		</table>
			    		</c:if>
						</div>
						<div class="w3-container w3-center" style="margin-top: 10px">
						<div class="w3-bar text-center">
					  <c:if test="${not empty vos}">
					  <c:if test="${pagevo.pag != 1}">
					  <a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-xlarge">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.pag == 1}">
					  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.curBlock > 1 }">
					  <a href="${ctp}/mem/myOrderList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">&laquo;</a>
					  </c:if>
					  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
						<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
						<c:forEach var="i" begin="${no}" end="${size}">
							<c:choose>
								<c:when test="${i > pagevo.totPage}"></c:when>
								<c:when test="${i == pagevo.pag}">
									<a href="${ctp}/mem/myOrderList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-theme-l4">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="${ctp}/mem/myOrderList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
							<a href="${ctp}/mem/myOrderList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">&raquo;</a>	
						</c:if>
						<c:if test="${pagevo.pag != pagevo.totPage}">
							<a href="${ctp}/mem/myOrderList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-xlarge">&raquo;</a>
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
</div>
<div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;height: 700px">
      <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
      <div class="w3-container w3-padding">
      	<h4><b>주문 상세 조회</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">주문 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">주문번호</th>
							<td id="orderIdx"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문일자</th>
							<td id="orderDate"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문자</th>
							<td id="orderName"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">처리상태</th>
							<td id="orderValue"></td>
						</tr>
					</table>
					<p><b class="w3-large">결제 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">총 주문금액</th>
							<td id="orderTotal"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">사용 포인트</th>
							<td id="orderPoint"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray;font-size: 18px">총 결제금액</th>
							<td id="orderTotalPay" style="font-size: 18px"></td>
						</tr>
					</table>
					<p><b class="w3-large">배송지 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">수령자</th>
							<td id="getName"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">우편번호</th>
							<td id="getPost"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주소</th>
							<td id="getAddress"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">전화번호</th>
							<td id="getTel"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">배송메세지</th>
							<td id="getPostMsg"></td>
						</tr>
					</table>
					<p><b class="w3-large">주문 상품 정보</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable">
					</table>
				</div>
      </div>
    </div>
  </div>
<div id="id02" class="w3-modal">
  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;height: 700px">
    <span onclick="document.getElementById('id02').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
		<form name="cancleMyForm" action="${ctp}/mem/orderCancle" method="post">
      <div class="w3-container w3-padding">
      	<h4><b>환불/취소 요청</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">주문 상품 정보</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable1">
					</table>
					<p><b class="w3-large">주문 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">주문번호</th>
							<td id="orderIdx1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문일자</th>
							<td id="orderDate1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문자</th>
							<td id="orderName1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">처리상태</th>
							<td id="orderValue1"></td>
						</tr>
					</table>
					<p><b class="w3-large">환불 금액 정보</b></p>
					<b><small>※ 소진한 포인트는 소멸됩니다</small></b><br>
					<b><small>※ 부분 환불시 소진포인트를 먼저 소진하여 환불을 진행합니다</small></b>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">사용 포인트</th>
							<td id="orderPoint1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray;font-size: 18px">총 환불금액</th>
							<td id="orderTotalPay1" style="font-size: 18px"></td>
						</tr>
					</table>
					<p><b class="w3-large">환불/취소 사유</b></p>
					<div id="hiddenbox">
					</div>
					<input type="hidden" id="return_status" name="return_status">
					<input type="hidden" id="return_marchantId" name="return_marchantId">
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">환불/취소 사유</th>
							<td>
							<select class="w3-input w3-border" name="return_type" id="return_type">
								<option disabled="disabled" selected="selected" >환불/취소 사유를 선택해주세요</option>
								<option value="단순변심" >단순변심</option>
								<option value="상품정보와 상이" >상품정보와 상이</option>
								<option value="사이즈 선택 실수" >사이즈 선택 실수</option>
								<option value="기타" >기타</option>
							</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea rows="3" cols="85" name="return_content"></textarea>
							</td>
						</tr>
					</table>
					<div class="w3-center w3-margin-top">
						<input type="button" class="w3-button w3-round w3-border" onclick="cancelCheck()" value="취소 요청">
					</div>
				</div>
      </div>
      </form>
    </div>
  </div>
<div id="id03" class="w3-modal">
  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;height: 700px">
    <span onclick="document.getElementById('id03').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
		<form name="confirmMyForm" action="${ctp}/mem/orderConfirm" method="post">
      <div class="w3-container w3-padding">
      	<h4><b>구매 확정</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">주문 상품 정보</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable2">
					</table>
					<p><b class="w3-large">주문 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">주문번호</th>
							<td id="orderIdx2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문일자</th>
							<td id="orderDate2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">주문자</th>
							<td id="orderName2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">처리상태</th>
							<td id="orderValue2"></td>
						</tr>
					</table>
					<div id="hiddenbox2">
					</div>
					<p><b class="w3-large">구매확정 안내</b></p>
					<b><small>※ 구매 확정시 청약철회가 불가합니다.</small></b><br>
					<b><small>※ 부분 확정은 불가능하며 부분 환불 진행후 구매확정이 가능합니다.</small></b><br>
					<b><small>※ 구매 확정시 사용포인트를 지급합니다.</small></b>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">수령 포인트</th>
							<td id="orderPoint2"></td>
						</tr>
					</table>
					<div class="w3-center w3-margin-top">
						<input type="button" class="w3-button w3-round w3-border" onclick="confirmCheck()" value="구매 확정">
					</div>
				</div>
      </div>
      </form>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
