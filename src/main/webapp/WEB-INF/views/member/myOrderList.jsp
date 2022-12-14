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
			alert("?????? ?????? ????????? ????????? ??????????????????");
			return;
		}
		else if(retype == null || retype == ""){
			alert("?????? ????????? ??????????????????");
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
					$("#return_status").val('????????????');					
				}
				else{
					$("#return_status").val('????????????');		
				}
			}
			else{
				if(val < 3){
					$("#return_status").val('????????????');					
				}
				else{
					$("#return_status").val('????????????');		
				}
			}
		}
		$("#return_marchantId").val('re#_' + new Date().getTime());
		cancleMyForm.submit();
	}
	// ????????????
	function confirmCheck(){
		confirmMyForm.submit();
	}
	// ?????? ????????????
	function cancelPrdCheck(res){
		//$('input:checkbox[name=cancelTotal]').prop('checked',false); // ?????? ???????????? ???????????? ??????
		let idx = res;
		let size = $('input:checkbox[name=cancelPrd]:checked').length; // for????????? ?????????????????? ?????? ??????????????? ??????
		let cancelPrd = $("#cancelPrd"+idx).is(":checked"); // ??????????????? ??????????????? ??? ???
		let totalCancelPrice = $("#totalCancelPrice").val(); // ??? ?????? ?????? ?????? ??????
		let count = $("#order_prdCount"+idx).val(); // ?????? ?????? ??????
		let price = $("#order_prdPrice"+idx).val(); // ?????? ?????? ??????
		let oriPoint = $("#orisetPoint").val();
		
		//addComma()
		let flag = 0;
		for(let i = 0; i<size; i++){
			if($('input:checkbox[name=cancelPrd]:checked').eq(i).is(":checked") == true){
				flag += 1;
			}
		}
		// ???????????????
		if(cancelPrd == true){
			let prdPrice = Number(price)*Number(count);
			let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
			let salePrdPrice = Number(prdPrice) - oriPoint;
			let salenowTotal = Number(totalCancelPrice) + Number(salePrdPrice);
			if(flag == 1){
				$("#totalCancelPrice").val(salenowTotal);
				$("#orderTotalPay1").html(addComma(salenowTotal.toString()) +" ???");
			}
			else{
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");
			}
		}
		// ?????? ?????? ?????????
		else{
			let prdPrice = Number(price)*Number(count);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
			
			if(flag != 0){
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");
				
			}
			else{
				$("#totalCancelPrice").val(0);
				$("#orderTotalPay1").html("0 ???");
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
					value = "????????????";
				}
				else if(vos[0].order_val == 1){
					value = "????????????";
				}
				else if(vos[0].order_val == 2){
					value = "????????????";
				}
				else if(vos[0].order_val == 3){
					value = "????????????";
				}
				else if(vos[0].order_val == 4){
					value = "?????????";
				}
				else if(vos[0].order_val == 5){
					value = "????????????";
				}
				
				$("#orderValue2").html(value);
				let hiddenbox = "";
				let point = 0;
				
				let data ='<tr>'
					//data += '<th style="width: 10%;color:gray;text-align: center"><input type="checkbox" checked="checked" id="cancelTotal" onclick="totalCheck()" name="cancelTotal"></th>';
					
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 40%;color:gray;text-align: center">????????????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">????????????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					point = point + vos[i].order_prdPoint;
					data += '<tr>';
					data +=	'<td style="width: 10%;text-align: center" class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="????????????"/></td>';
					data += '<td style="width: 40%;text-align: left">'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="width: 15%;text-align: center">'+addComma(vos[i].order_prdPrice.toString())+' ???</td>';
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
					value = "????????????";
				}
				else if(vos[0].order_val == 1){
					value = "????????????";
				}
				else if(vos[0].order_val == 2){
					value = "????????????";
				}
				totalPrice = Number(vos[0].pay_price);
				
				$("#orderValue1").html(value);
				$("#orderTotalPay1").html(addComma(vos[0].pay_price.toString()) +" ???");
				let hiddenbox = "";
				hiddenbox +='<input type="hidden" id="totalCancelPrice" name="return_totalprice" value="'+totalPrice+'">';
				hiddenbox +='<input type="hidden" id="oritotalPrice" name="oritotalPrice" value="'+totalPrice+'" disabled="disabled">';
				hiddenbox +='<input type="hidden" id="orisetPoint" name="return_point" value="'+vos[0].pay_setPoint+'">';
				hiddenbox +='<input type="hidden" id="order_Idx" name="order_Idx" value="'+vos[0].orderIdx+'">';
				hiddenbox +='<input type="hidden" id="order_val" name="order_val" value="'+vos[0].order_val+'">';
				let data ='<tr>'
					//data += '<th style="width: 10%;color:gray;text-align: center"><input type="checkbox" checked="checked" id="cancelTotal" onclick="totalCheck()" name="cancelTotal"></th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 40%;color:gray;text-align: center">????????????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">????????????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					data += '<tr>';
					data += '<td style="width: 5%;text-align: center"><input type="checkbox" id="cancelPrd'+vos[i].order_subIdx+'" name="cancelPrd" value="'+vos[i].order_subIdx+'" checked="checked" onclick="cancelPrdCheck('+vos[i].order_subIdx+')"></td>';
					data +=	'<td style="width: 10%;text-align: center" class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="????????????"/></td>';
					data += '<td style="width: 40%;text-align: left">'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="width: 15%;text-align: center">'+addComma(vos[i].order_prdPrice.toString())+' ???</td>';
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
			$("#orderTotalPay1").html("0 ???");
			$("#totalCancelPrice").val(0);
		}
		else{
			$('input:checkbox[name=cancelPrd]').prop('checked',true);
			$("#orderTotalPay1").html(addComma(oritotalprice.toString()) +" ???");
			$("#totalCancelPrice").val(oritotalprice);
		}
	} */
	
	function keyCheck(idx,cnt){
		let key = $("#cancelCnt"+idx).val();
		let price = $("#order_prdPrice"+idx).val(); // ?????? ?????? ??????
		let count = $("#order_prdCount"+idx).val();
		let oriCount = $("#order_OriprdCount"+idx).val(); // ?????? ????????? ?????? ( ?????? )
		let totalCancelPrice = $("#totalCancelPrice").val();
		
		if(key < 1){
			if(count > key){
				let downcnt = count - 1; // ?????? ??????
				let prdPrice = Number(price)*Number(downcnt);
				let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
				
				$("#cancelCnt"+idx).val(1);
				$("#order_prdCount"+idx).val(1);
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");
			}
	 	}
		else if(key > cnt){
			if(count < key){ // ??????
				let upcnt = cnt - count; // ?????? ??????
				let prdPrice = Number(price)*Number(upcnt);
				let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
				
				$("#cancelCnt"+idx).val(cnt);
				$("#order_prdCount"+idx).val(cnt);
				$("#totalCancelPrice").val(nowTotal);
				$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");
			}
		}
		else if(count > key){ // ??????
			let downcnt = count - key; // ?????? ??????
			let prdPrice = Number(price)*Number(downcnt);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);

	 		$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");
		}
		else if(count < key){ // ??????
			let upcnt = key - count; // ?????? ??????
			let prdPrice = Number(price)*Number(upcnt);
			let nowTotal = Number(totalCancelPrice) + Number(prdPrice);
			
			$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???");

		}

/* 			let prd = Number(oriCount) - Number(key);
			let prdPrice = Number(price)*Number(prd);
			let nowTotal = Number(totalCancelPrice) - Number(prdPrice);
			$("#cancelCnt"+idx).val(key);
			$("#order_prdCount"+idx).val(key);
			$("#totalCancelPrice").val(nowTotal);
			$("#orderTotalPay1").html(addComma(nowTotal.toString()) +" ???"); */
		
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
	    	dateFormat: 'yy-mm-dd' //?????? ?????? ??????
	            ,showOtherMonths: true //??? ????????? ???????????? ???????????? ????????? ??????
	            ,showMonthAfterYear:true // ???- ??? ??????????????? ?????? - ??? ??????
	            ,changeYear: true //option??? ??? ?????? ??????
	            ,changeMonth: true //option???  ??? ?????? ??????                          
	            ,yearSuffix: "???" //????????? ?????? ?????? ??? ?????????
	            ,monthNamesShort: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? ?????????
	            ,monthNames: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? Tooltip
	            ,dayNamesMin: ['???','???','???','???','???','???','???'] //????????? ?????? ?????????
	            ,dayNames: ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'] //????????? ?????? Tooltip
	            ,minDate: "-5Y" //?????? ????????????(-1D:?????????, -1M:?????????, -1Y:?????????)
	            ,maxDate: "+5y" //?????? ????????????(+1D:?????????, -1M:?????????, -1Y:?????????)
	    
	    });
	    let dates = $("#datepicker").val();
	    $('#datepicker1').datepicker({
	    	dateFormat: 'yy-mm-dd' //?????? ?????? ??????
	            ,showOtherMonths: true //??? ????????? ???????????? ???????????? ????????? ??????
	            ,showMonthAfterYear:true // ???- ??? ??????????????? ?????? - ??? ??????
	            ,changeYear: true //option??? ??? ?????? ??????
	            ,changeMonth: true //option???  ??? ?????? ??????                          
	            ,yearSuffix: "???" //????????? ?????? ?????? ??? ?????????
	            ,monthNamesShort: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? ?????????
	            ,monthNames: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? Tooltip
	            ,dayNamesMin: ['???','???','???','???','???','???','???'] //????????? ?????? ?????????
	            ,dayNames: ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'] //????????? ?????? Tooltip
	            ,minDate: new Date(dates) //?????? ????????????(-1D:?????????, -1M:?????????, -1Y:?????????)
	            ,maxDate: "+5y" //?????? ????????????(+1D:?????????, -1M:?????????, -1Y:?????????)
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
					value = "????????????";
				}
				totalPrice = Number(vos[0].pay_price) + Number(vos[0].pay_setPoint);
				
				$("#orderValue").html(value);
				$("#orderTotal").html(addComma(totalPrice.toString())+" ???");
				$("#orderPoint").html(vos[0].pay_setPoint+" P");
				$("#orderTotalPay").html(addComma(vos[0].pay_price.toString()) +" ???");
				$("#getName").html(vos[0].pay_getName);
				$("#getPost").html(vos[0].pay_getPost);
				$("#getAddress").html(vos[0].pay_getAddress);
				$("#getTel").html(vos[0].pay_getTel);
				$("#getPostMsg").html("["+vos[0].pay_getPostMsg+"]");
				let values = "";
				let data ='<tr>'
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 50%;color:gray;text-align: center">????????????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">??????</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					data += '<tr>';
					data +=	'<td class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="????????????"/></td>';
					data += '<td>'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdOption+'</td>';
					data += '<td style="text-align: center">'+vos[i].order_prdCount+'</td>';
					if(vos[i].order_val == 0){
						values = "????????????"
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
				  <h3><a href="${ctp}/mem/myPage" class="w3-bar-item"><b>?????? ?????????</b></a></h3>
				  <h5 class="w3-bar-item"><b>?????? ??????</b></h5>
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="black"><b>?????? ??????</b></font></a>
				  <a href="${ctp}/mem/myReturnList" class="w3-bar-item"><font color="gray">?????? ??????</font></a>
				  <a href="${ctp}/mem/myWishList" class="w3-bar-item"><font color="gray">?????? ??????</font></a>
				</div>
				<div class="w3-bar-block">
				  <h5 class="w3-bar-item"><b>??? ??????</b></h5>
				  <a href="${ctp}/mem/myPage/profile" class="w3-bar-item"><font color="gray">????????? ??????</font></a>
				  <a href="${ctp}/mem/myAddressList" class="w3-bar-item"><font color="gray">?????????</font></a>
				  <a href="${ctp}/mem/myDeclaration" class="w3-bar-item"><font color="gray">?????? ??????</font></a>
				  <a href="${ctp}/mem/myHistory" class="w3-bar-item"><font color="gray">????????????</font></a>
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red">????????????</font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1100px;margin-bottom: 100px">
				<div class="w3-container">
					<h3 id="title"><b>?????? ??????</b></h3>
					<hr style="border-width: 3px;border-color: black">
					<div class="w3-round-large w3-theme-l5" style="height: 100px;margin-top: 20px">
						<div class="w3-cell" style="width: 240px;height: 140px;margin: auto">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>??????</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${ordercnt}</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>?????????</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${dlvcnt}</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>?????? ??????</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${confirmcnt }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 240px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>?????? ??????</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<a href="${ctp}/mem/myReturnList"><font size="2px" color="red" ><b>${returncnt}</b></font></a>
							</div>
						</div>
					</div>
					<h5><b>?????? ?????? ??????</b></h5>
					<hr style="border-width: 2px">
					<div class="w3-container" style="height: 60px;width: 1100px;margin-top: 20px">
						<div class="w3-row">
							<div class="w3-col m5">
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-border w3-round w3-small" style="width: 70px">??????</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=DAY" class="w3-button w3-border w3-round w3-small" style="width: 70px">??????</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=1" class="w3-button w3-border w3-round w3-small" style="width: 70px">1??????</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=3" class="w3-button w3-border w3-round w3-small" style="width: 70px">3??????</a>						
							<a href="${ctp}/mem/myOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=6" class="w3-button w3-border w3-round w3-small" style="width: 70px">6??????</a>						
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
								<option disabled="disabled" selected="selected">?????? ?????? ??????</option>
								<option value="0">?????? ??????</option>
								<option value="1">?????? ??????</option>
								<option value="2">?????? ??????</option>
								<option value="3">?????? ??????</option>
								<option value="4">?????????</option>
								<option value="5">????????????</option>
								<option value="6">????????????</option>
							</select>
    					<a href="javascript:btDateCheck()" id="searchButton" style="width: 60px" class="w3-button w3-small w3-border w3-half w3-round-large">??????</a>
							</div>
						</div>
					</div>
					<h5><b>?????? ?????? ??????</b></h5>
					<hr style="border-width: 2px">
					
					<div class="" style="height: 100%">
			    		<table class="w3-table w3-centered w3-round-large">
			    			<tr>
			    				<th class="w3-small" style="width: 15%">???????????? / ??????</th>
			    				<th class="w3-small" style="width: 25%">????????????</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">??????</th>
			    				<th class="w3-small" style="width: 10%;text-align: center">?????? ??????</th>
			    				<th class="w3-small" style="width: 10%" class="w3-right-align">??? ?????? ??????</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">??????</th>
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
			    		<h5>?????? ????????? ????????????.</h5>
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
							      <span class="w3-small">????????? :${ordvo.name}</span>
			    				</td>
			    				</c:if>
			    				<td style="padding-left: 12px;width: 3%" class="w3-border-bottom"><img src="${ctp}/product/${ordvo.prdfName}" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="????????????"/></td>
			    				<td class="w3-border-bottom w3-border-right" style="width: 20%">
				    				<span class="w3-small"><b>${ordvo.eprdName}</b></span><br>
								    <span class="w3-small">${ordvo.kprdName}</span><br><br>
								    <span class="w3-small">?????? : <b>${ordvo.order_prdOption }</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
							    <span class="w3-small">?????? : <b>${ordvo.order_prdCount }</b></span>
			    				</td>
			    				<td style="width: 7%" class="w3-center w3-border-bottom w3-border-right">
			    				<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.order_prdPrice * ordvo.order_prdCount }" var="fprdPrice"/>	
			    				<span class="w3-small">${fprdPrice } ???</span><br>
							        <span class="w3-small"><font color="gray">(${ordvo.order_prdPoint} P)</font></span>
			    				</td>
			    				<td style="width:10%" class="w3-center w3-border-bottom w3-border-right">
			    				<c:if test="${ordvo.order_val == 0}">
			    					<span class="w3-small">[?????? ?????????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 1}">
			    					<span class="w3-small">[?????? ??????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 2}">
			    					<span class="w3-small">[?????? ??????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 3}">
			    					<span class="w3-small">[?????? ??????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 4}">
			    					<span class="w3-small">[?????????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 5}">
			    					<span class="w3-small">[?????? ??????]</span>
			    				</c:if>
			    				<c:if test="${ordvo.order_val == 6}">
			    					<span class="w3-small">[?????? ??????]</span>
			    				</c:if>
			    				</td>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" style="width: 10%" class="w3-center w3-border-bottom w3-border-right">
			    					<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.pay_price}" var="ftotalPrice"/>	
			    					<span class="w3-small"><b>??? ?????? ??????</b></span><br>
								    <span class="w3-small">${ftotalPrice} ???</span><br><br>
								    <span class="w3-small"><a href="javascript:orderInfor(${ordvo.orderIdx})">[?????? ?????? ??????]</a></span><br>
			    				</td>
			    				</c:if>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" class="w3-border-bottom w3-center" style="width: 10%">
			    					<c:if test="${empty revos}">
			    						<c:if test="${ordvo.order_val lt 3}">
						    					<div class="tooltip">
						    						<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">?????? ??????</font></a>
													  <span class="tooltiptext">?????? ?????????<br> ????????? ???????????? ????????????.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val ge 3 and ordvo.order_val lt 5}">
						    					<div class="tooltip">
				    								<font class="w3-small">[?????? ?????? ??????]</font>
													  <span class="tooltiptext">?????? ?????? ????????????<br>????????? ???????????? ????????????.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 5}">
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white w3-margin-bottom" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">?????? ??????</font></a>
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderConfirm(${ordvo.orderIdx})"><font color="blue">?????? ??????</font></a><br>
				    							<font color="gray"><small>???????????? ${ordvo.strTime }</small></font>
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 6}">
						    					<font color="blue"><small><b>????????????</b></small></font>
				    						</c:if>		
			    					</c:if>
			    					<c:if test="${not empty revos}">
			    					<c:set var="flag" value="false"/>
			    					<c:forEach var="revo" items="${revos}" varStatus="rest">
			    						<c:if test="${revo.order_Idx == ordvo.orderIdx and revo.return_val == 0}">
			    							<div class="tooltip">
			    								<c:if test="${revo.return_status == '????????????' }">
			    								[<font color="red">?????? ?????? ??????</font>]
												  <span class="tooltiptext">?????? ????????? ??????<br>????????? ???????????? ????????????.<br>??????????????? ?????????????????????</span>
			    								</c:if>
			    								<c:if test="${revo.return_status == '????????????' }">
			    								[<font color="red">?????? ?????? ??????</font>]
												  <span class="tooltiptext">?????? ????????? ??????<br>????????? ???????????? ????????????.<br>??????????????? ?????????????????????</span>
			    								</c:if>
			    								<c:if test="${revo.return_status == '????????????' }">
			    								[<font color="red">?????? ?????? ??????</font>]
												  <span class="tooltiptext">?????? ????????? ??????<br>??????????????? ??????????????????.<br>??????????????? ???????????????</span>
												  </c:if>
			    								<c:if test="${revo.return_status == '????????????' }">
			    								[<font color="red">?????? ?????? ??????</font>]
												  <span class="tooltiptext">?????? ????????? ??????<br>??????????????? ??????????????????.<br>??????????????? ???????????????</span>
												  </c:if>
												</div><br>
				    						<c:set var="flag" value="true"/>
			    						</c:if>
			    						<c:if test="${not flag}">
			    						<c:if test="${rest.last}">
				    						<c:if test="${ordvo.order_val lt 3}">
						    					<div class="tooltip">
						    						<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">?????? ??????</font></a>
													  <span class="tooltiptext">?????? ?????????<br> ????????? ???????????? ????????????.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val ge 3 and ordvo.order_val lt 5}">
						    					<div class="tooltip">
				    								<font class="w3-small">[?????? ?????? ??????]</font>
													  <span class="tooltiptext">?????? ?????? ????????????<br>????????? ???????????? ????????????.</span>
													</div>	
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 5}">
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white w3-margin-bottom" href="javascript:orderCancel(${ordvo.orderIdx})"><font color="red">?????? ??????</font></a>
						    					<a class="w3-button w3-border w3-round w3-small w3-hover-white" href="javascript:orderConfirm(${ordvo.orderIdx})"><font color="blue">?????? ??????</font></a><br>
				    							<font color="gray"><small>???????????? ${ordvo.strTime }</small></font>
				    						</c:if>														    						
				    						<c:if test="${ordvo.order_val eq 6}">
						    					<font color="blue"><small><b>????????????</b></small></font>
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
      	<h4><b>?????? ?????? ??????</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderIdx"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderDate"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">?????????</th>
							<td id="orderName"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderValue"></td>
						</tr>
					</table>
					<p><b class="w3-large">?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">??? ????????????</th>
							<td id="orderTotal"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">?????? ?????????</th>
							<td id="orderPoint"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray;font-size: 18px">??? ????????????</th>
							<td id="orderTotalPay" style="font-size: 18px"></td>
						</tr>
					</table>
					<p><b class="w3-large">????????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">?????????</th>
							<td id="getName"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="getPost"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">??????</th>
							<td id="getAddress"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="getTel"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">???????????????</th>
							<td id="getPostMsg"></td>
						</tr>
					</table>
					<p><b class="w3-large">?????? ?????? ??????</b></p>
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
      	<h4><b>??????/?????? ??????</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">?????? ?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable1">
					</table>
					<p><b class="w3-large">?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderIdx1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderDate1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">?????????</th>
							<td id="orderName1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderValue1"></td>
						</tr>
					</table>
					<p><b class="w3-large">?????? ?????? ??????</b></p>
					<b><small>??? ????????? ???????????? ???????????????</small></b><br>
					<b><small>??? ?????? ????????? ?????????????????? ?????? ???????????? ????????? ???????????????</small></b>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">?????? ?????????</th>
							<td id="orderPoint1"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray;font-size: 18px">??? ????????????</th>
							<td id="orderTotalPay1" style="font-size: 18px"></td>
						</tr>
					</table>
					<p><b class="w3-large">??????/?????? ??????</b></p>
					<div id="hiddenbox">
					</div>
					<input type="hidden" id="return_status" name="return_status">
					<input type="hidden" id="return_marchantId" name="return_marchantId">
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">??????/?????? ??????</th>
							<td>
							<select class="w3-input w3-border" name="return_type" id="return_type">
								<option disabled="disabled" selected="selected" >??????/?????? ????????? ??????????????????</option>
								<option value="????????????" >????????????</option>
								<option value="??????????????? ??????" >??????????????? ??????</option>
								<option value="????????? ?????? ??????" >????????? ?????? ??????</option>
								<option value="??????" >??????</option>
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
						<input type="button" class="w3-button w3-round w3-border" onclick="cancelCheck()" value="?????? ??????">
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
      	<h4><b>?????? ??????</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">?????? ?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable2">
					</table>
					<p><b class="w3-large">?????? ??????</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderIdx2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderDate2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">?????????</th>
							<td id="orderName2"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">????????????</th>
							<td id="orderValue2"></td>
						</tr>
					</table>
					<div id="hiddenbox2">
					</div>
					<p><b class="w3-large">???????????? ??????</b></p>
					<b><small>??? ?????? ????????? ??????????????? ???????????????.</small></b><br>
					<b><small>??? ?????? ????????? ??????????????? ?????? ?????? ????????? ??????????????? ???????????????.</small></b><br>
					<b><small>??? ?????? ????????? ?????????????????? ???????????????.</small></b>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">?????? ?????????</th>
							<td id="orderPoint2"></td>
						</tr>
					</table>
					<div class="w3-center w3-margin-top">
						<input type="button" class="w3-button w3-round w3-border" onclick="confirmCheck()" value="?????? ??????">
					</div>
				</div>
      </div>
      </form>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
