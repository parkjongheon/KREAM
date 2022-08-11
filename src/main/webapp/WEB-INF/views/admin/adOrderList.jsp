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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<style type="text/css">

		

		.switch {
		  position: relative;
		  display: inline-block;
		  width: 49px;
		  height: 20px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 15px;
		  width: 15px;
		  left: 4px;
		  bottom: 3px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input:checked + .slider {
		  background-color: #87CEFA;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
	</style>
<script type="text/javascript">
	'use strict';
	let param = '${param.btdate}';
	function changeOrderVal(res){
		let idx = res;
		let val = $("#orderVal"+idx).val();
		
		let ans = confirm("상태를 변경하시겠습니까?");
		
		if(ans == true){
			$.ajax({
				type : "post",
				url : "${ctp}/admin/updateOrderVal",
				data : {
					orderIdx : idx,
					val : val
				},
				success : function() {
					location.reload();
				}
			});
		}
	}
	
	function btDateCheck(){
		let start = $("#datepicker").val();
		let end = $("#datepicker1").val();
		let val = $("#searchVal").val();
		let btdate = start+"/"+end;
		if(val == null){
			location.href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate;
		}
		else{
			location.href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate+"&val="+val;
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
    if(param==""){
    	$('#datepicker').datepicker('setDate','${startDate}');
    	$('#datepicker1').datepicker('setDate','today');    	
    }
    else{
    	let data = param.split("/");
    	$('#datepicker').datepicker('setDate',data[0]);
    	$('#datepicker1').datepicker('setDate',data[1]);
    }
  });
	
	function searchOn(){
		let search = $("#searchText").val();
		let part = $("#searchPart").val();
		location.href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&search="+search+"&part="+part;
	}
	
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
					data +='</td>';
				}
				$("#infoTable").html(data);
			}
		});
	}
</script>
</head>
<body class="w3-light-grey">
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div class="w3-card w3-round w3-white" style="width: 99%;height: 100%;margin-top: 0px">
   <div class="w3-container" style="width : 99%;height: 100%">
    <h4><b>주문 상세 검색</b></h4>
    <c:set var="searchflag" value="" />
    <c:if test="${not empty param.search}">
    	<c:set var="searchflag" value="&search=${param.search}" />
    </c:if>
    <div class="w3-row w3-margin-bottom">
			<div class="w3-col m3" style="width: 430px">
				<a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${empty param.date}"> w3-win8-olive</c:if>">전체 보기</a>
	    	<a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=DAY"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='DAY'}"> w3-win8-olive</c:if>">오늘</a>
	    	<a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=1"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='MONTH' and param.orderDate == 1}"> w3-win8-olive</c:if>">1개월</a>
	    	<a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=3"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='MONTH' and param.orderDate == 3}"> w3-win8-olive</c:if>">3개월</a>
	    	<a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=6"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='MONTH' and param.orderDate == 6}"> w3-win8-olive</c:if>">6개월</a>					
			</div>	
			<div class="w3-col m3" style="width: 280px">
				<div class="w3-third">
	    		<input type="text" id="datepicker"  class="w3-input w3-border w3-small w3-round-large w3-right" style="width: 130px">
	    	</div>  	
	    	<div class="w3-third w3-center" style="width: 30px">
	    	<i class="fa fa-arrows-h" aria-hidden="true"></i>
	    	</div>
	    	<div class="w3-third">
	    		<input type="text" id="datepicker1"  class="w3-input w3-border w3-small w3-round-large w3-left" style="width: 130px">
	    	</div>   
			</div>
			<div class="w3-col m2">
			<select id="searchVal" style="width: 150px" class="w3-input w3-left w3-small w3-border w3-margin-right w3-round-large w3-half ">
				<option disabled="disabled" selected="selected">주문 상태 전체</option>
				<option value="0">주문 대기 : 0</option>
				<option value="1">주문 접수 : 1</option>
				<option value="2">입금 확인 : 2</option>
				<option value="3">출고 완료 : 3</option>
				<option value="4">배송중 : 4</option>
				<option value="5">배송 완료 : 5</option>
			</select>
					<a href="javascript:btDateCheck()" id="searchButton" style="width: 60px" class="w3-button w3-small w3-border w3-half w3-round-large w3-win8-olive">검색</a>
			</div>
			<div class="w3-col m3" style="width: 500px">
			<select id="searchPart" style="width: 120px;margin-right: 10px" class="w3-input w3-small w3-border w3-round-large w3-third ">
				
				<option disabled="disabled" <c:if test="${empty param.part}">selected="selected"</c:if>>검색 카테고리</option>
				<option value="o.pay_marchantId" <c:if test="${param.part == 'o.pay_marchantId'}">selected="selected"</c:if>>주문 번호</option>
				<option value="m.name" <c:if test="${param.part == 'm.name'}">selected="selected"</c:if>>주문자</option>
				<option value="p.ebrName" <c:if test="${param.part == 'p.ebrName'}">selected="selected"</c:if>>브랜드(영)</option>
				<option value="p.kprdName" <c:if test="${param.part == 'p.kprdName'}">selected="selected"</c:if>>상품명(한)</option>
				<option value="p.eprdName" <c:if test="${param.part == 'p.eprdName'}">selected="selected"</c:if>>상품명(영)</option>
			</select>
    	<input type="text" id="searchText" style="width: 250px;margin-right: 10px" class="w3-input w3-small w3-border w3-round-large w3-third " value="${param.search}" placeholder="카테고리 선택 후 검색">
    	<a href="javascript:searchOn()" id="searchButton" style="width: 60px" class="w3-button w3-small w3-border w3-third w3-round-large w3-win8-olive">검색</a>
    	</div>
		</div>
   </div>
 	</div>
	 	<div class="w3-row" style="margin-top: 10px">
	 		<div class="w3-col m12">
	 			<div class="w3-card w3-round w3-white" style="width : 99%;max-height: 2000px">
			   <div class="w3-container" style="height: 100%">
			    <h4><b>주문 현황</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 100%">
			    		<table class="w3-table w3-centered w3-win8-steel w3-round-large">
			    			<tr>
			    				<th style="width: 12%">주문번호 / 시각</th>
			    				<th style="width: 21%">상품정보</th>
			    				<th style="width: 10%;text-align: center">옵션 / 수량</th>
			    				<th style="width: 7%;text-align: center">가격</th>
			    				<th style="width: 10%;text-align: center">수령자</th>
			    				<th style="width: 16%">주소지</th>
			    				<th style="width: 10%">주문 상태</th>
			    				<th style="width: 10%" class="w3-right-align">총 결제 금액</th>
			    				<th style="width: 5%">
			    				<c:if test="${sort == 'desc'}">
				    				<a id="memSort" href="${ctp}/admin/adOrderList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
			    				</c:if>
			    				<c:if test="${sort == 'asc'}">
				    				<a id="memDesc" href="${ctp}/admin/adOrderList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
			    				</c:if>
			    				</th>
			    			</tr>
			    		</table>
			    		<c:if test="${empty vos }">
			    		<div class="w3-container w3-center w3-margin-top">
			    		<h4>검색 결과가 없습니다.</h4>
			    		</div>
			    		</c:if>
			    		<c:if test="${not empty vos}">
			    		<table class="" style="width: 100%">
			    			<c:forEach var="ordvo" items="${vos}" varStatus="st">
			    			<tr class="w3-border" style="height:  150px">
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td class="w3-center w3-border-right w3-border-bottom" rowspan="${ordvo.indexcnt}" style="width: 12%">
			    					<span class="w3-small"><b>${ordvo.pay_marchantId}</b></span><br>
							      <span class="w3-small">${ordvo.pay_orderDate}</span><br><br>
							      <span class="w3-small">주문자 :${ordvo.name}</span>
			    				</td>
			    				</c:if>
			    				<td style="padding-left: 12px;width: 6%" class="w3-border-bottom"><img src="${ctp}/product/${ordvo.prdfName}" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>
			    				<td class="w3-border-bottom" style="width: 17%">
				    				<span class="w3-small">${ordvo.eprdName}</span><br>
								    <span class="w3-small">${ordvo.kprdName}</span>
			    				</td>
			    				<td class="w3-border-bottom " style="width: 7%">
			    				<span class="w3-small">옵션 : ${ordvo.order_prdOption }</span><br>
							    <span class="w3-small">수량 : ${ordvo.order_prdCount }</span>
			    				</td>
			    				<td style="width: 7%" class="w3-center w3-border-bottom w3-border-right">
			    				<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.order_prdPrice * ordvo.order_prdCount }" var="fprdPrice"/>	
			    				<span class="w3-small">${fprdPrice } 원</span><br>
							        <span class="w3-small"><font color="gray">(${ordvo.order_prdPoint} P)</font></span>
			    				</td>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" class="w3-center w3-border-bottom w3-border-right" style="width: 10%">
			    				<span class="w3-small"><b>${ordvo.pay_getName}</b></span><br>
								        <span class="w3-small">${ordvo.pay_getTel}</span>
			    				</td>
			    				</c:if>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" style="width: 16%;padding-left: 10px" class="w3-border-bottom w3-border-right">
			    					<span class="w3-small"><b>${ordvo.pay_getPost}</b></span><br>
								    <span class="w3-small">${ordvo.pay_getAddress}</span><br>
								    <span class="w3-small">[${ordvo.pay_getPostMsg}]</span>
			    				</td>
			    				</c:if>
			    				<c:set var="flag" value="false"/>
			    					<c:forEach var="revo" items="${revos}" varStatus="rest">
			    						<c:if test="${revo.resub_subIdx == ordvo.order_subIdx and revo.return_val == 0}">
			    							<td style="width:10%" class="w3-center w3-border-bottom w3-border-right">
						    					<c:if test="${ordvo.order_val != 6 }">
						    					<select class="w3-select w3-border w3-round-large w3-small" disabled="disabled" id="orderVal${ordvo.order_subIdx}" onchange="changeOrderVal(${ordvo.order_subIdx})" style="width: 120px">
											      <c:if test="${ordvo.order_val <= 0 }">
											      <option value="0" <c:if test="${ordvo.order_val == 0 }">selected="selected"</c:if>>주문 대기 : 0</option>
											      </c:if>
											      <c:if test="${ordvo.order_val <= 1 }">
											      <option value="1" <c:if test="${ordvo.order_val == 1 }">selected="selected"</c:if>>주문 접수 : 1</option>
											      </c:if>
											      <c:if test="${ordvo.order_val <= 2 }">
														<option value="2" <c:if test="${ordvo.order_val == 2 }">selected="selected"</c:if>>입금 확인 : 2</option>
											      </c:if>
											      <c:if test="${ordvo.order_val <= 3 }">
														<option value="3" <c:if test="${ordvo.order_val == 3 }">selected="selected"</c:if>>출고 완료 : 3</option>
											      </c:if>
											      <c:if test="${ordvo.order_val <= 4 }">
														<option value="4" <c:if test="${ordvo.order_val == 4 }">selected="selected"</c:if>>배송중 : 4</option>
											      </c:if>
											      <c:if test="${ordvo.order_val <= 5 }">
														<option value="5" <c:if test="${ordvo.order_val == 5 }">selected="selected"</c:if>>배송 완료 : 5</option>
											      </c:if>
											    </select><br><br>
											    <font color="red"><b><small>* 취소요청</small></b></font>
						    					</c:if>
						    					<c:if test="${ordvo.order_val == 6 }">
						    					구매확정
						    					</c:if>
						    				</td>
						    				<c:set var="flag" value="true"/>
				    						</c:if>
					    					<c:if test="${not flag}">
					    						<c:if test="${rest.last}">
					    							<td style="width:10%" class="w3-center w3-border-bottom w3-border-right">
							    					<c:if test="${ordvo.order_val != 6 }">
							    					<select class="w3-select w3-border w3-round-large w3-small" id="orderVal${ordvo.order_subIdx}" onchange="changeOrderVal(${ordvo.order_subIdx})" style="width: 120px">
												      <c:if test="${ordvo.order_val <= 0 }">
												      <option value="0" <c:if test="${ordvo.order_val == 0 }">selected="selected"</c:if>>주문 대기 : 0</option>
												      </c:if>
												      <c:if test="${ordvo.order_val <= 1 }">
												      <option value="1" <c:if test="${ordvo.order_val == 1 }">selected="selected"</c:if>>주문 접수 : 1</option>
												      </c:if>
												      <c:if test="${ordvo.order_val <= 2 }">
															<option value="2" <c:if test="${ordvo.order_val == 2 }">selected="selected"</c:if>>입금 확인 : 2</option>
												      </c:if>
												      <c:if test="${ordvo.order_val <= 3 }">
															<option value="3" <c:if test="${ordvo.order_val == 3 }">selected="selected"</c:if>>출고 완료 : 3</option>
												      </c:if>
												      <c:if test="${ordvo.order_val <= 4 }">
															<option value="4" <c:if test="${ordvo.order_val == 4 }">selected="selected"</c:if>>배송중 : 4</option>
												      </c:if>
												      <c:if test="${ordvo.order_val <= 5 }">
															<option value="5" <c:if test="${ordvo.order_val == 5 }">selected="selected"</c:if>>배송 완료 : 5</option>						      	
												      	<c:if test="${ordvo.order_val == 5 and ordvo.mindate <= 0}">
												      	<option value="6">구매확정 : 6</option>
												      	</c:if>
												      </c:if>
												    </select>
							    					</c:if>
							    					<c:if test="${ordvo.order_val == 5 }">
							    					<c:if test="${ordvo.mindate > 0 }">
								    					<br><font color="red"><small>구매확정까지 ${ordvo.strTime}</small></font>
							    					</c:if>
							    					<c:if test="${ordvo.mindate <= 0 }">
								    					<br><font color="green"><small>*구매확정가능</small></font>
							    					</c:if>
							    					
							    					</c:if>
							    					<c:if test="${ordvo.order_val == 6 }">
							    					<font color="blue"><small>구매확정</small></font>
							    					</c:if>
							    				</td>
					    						</c:if>
					    					</c:if>
			    					</c:forEach>
			    				<c:if test="${idx != ordvo.pay_marchantId}">
			    				<td rowspan="${ordvo.indexcnt}" style="width: 14%" class="w3-center w3-border-bottom">
			    					<fmt:formatNumber type="number" maxFractionDigits="3" value="${ordvo.pay_price}" var="ftotalPrice"/>	
			    					<span class="w3-small"><b>총 결제 금액</b></span><br>
								    <span class="w3-small">${ftotalPrice} 원</span><br><br>
								    <span class="w3-small"><a href="javascript:orderInfor(${ordvo.orderIdx})">[주문 상세 보기]</a></span>
			    				</td>
			    				</c:if>
			    			</tr>
			    			<c:set var="idx" value="${ordvo.pay_marchantId}" />
			    			</c:forEach>
			    		</table>
			    		</c:if>
						</div>
			   </div>
						<div class="w3-container w3-center" style="margin-top: 10px">
							<div class="w3-bar text-center">
						  <c:if test="${not empty vos}">
						  <c:if test="${pagevo.pag != 1}">
						  <a href="${ctp}/admin/adOrderList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.pag == 1}">
						  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.curBlock > 1 }">
						  <a href="${ctp}/admin/adOrderList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">&laquo;</a>
						  </c:if>
						  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
							<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
							<c:forEach var="i" begin="${no}" end="${size}">
								<c:choose>
									<c:when test="${i > pagevo.totPage}"></c:when>
									<c:when test="${i == pagevo.pag}">
										<a href="${ctp}/admin/adOrderList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-theme-l4">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="${ctp}/admin/adOrderList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
								<a href="${ctp}/admin/adOrderList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}" class="w3-button">&raquo;</a>	
							</c:if>
							<c:if test="${pagevo.pag != pagevo.totPage}">
								<a href="${ctp}/admin/adOrderList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&raquo;</a>
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
						<!-- <tr>
							<th style="width: 10%;color:gray;text-align: center">사진</th>
							<th style="width: 50%;color:gray;text-align: center">상품정보</th>
							<th style="width: 10%;color:gray;text-align: center">옵션</th>
							<th style="width: 10%;color:gray;text-align: center">수량</th>
							<th style="width: 10%;color:gray;text-align: center">상태</th>
						</tr> -->
					</table>
				</div>
      </div>
    </div>
  </div>
</body>
</html>