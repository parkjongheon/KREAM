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
	
	function returnOk(){
		let reIdx = $("#resub_reIdx").val();
		$.ajax({
			type : "post",
			url : "${ctp}/admin/returnOk",
			data : {
				reIdx : reIdx
			},
			success : function(){
				alert("환불처리가 완료되었습니다.");
				location.reload();
			}
		});
	}
	
	function btDateCheck(){
		let start = $("#datepicker").val();
		let end = $("#datepicker1").val();
		let val = $("#searchVal").val();
		let btdate = start+"/"+end;
		if(val == null){
			location.href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate;
		}
		else{
			location.href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate+"&val="+val;
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
		location.href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&search="+search+"&part="+part;
	}
	
	function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
  }
	
	function returnCheck(res){
		let reIdx = res;
		document.getElementById('id01').style.display='block'
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getReturnInfo",
			data : {
				reIdx : reIdx
			},
			success : function(vos){
				let value= "";
				let totalPrice = 0;
				$("#resub_reIdx").val(vos[0].resub_reIdx);
				$("#return_marchantId").html(vos[0].return_marchantId);
				$("#return_date").html(vos[0].return_date);
				$("#return_mid").html(vos[0].name);
				if(vos[0].return_val == 0){
					value = "취소신청대기중";
				}
				totalPrice = Number(vos[0].return_totalprice);
				
				$("#return_val").html(value);
				$("#return_totalprice").html(addComma(totalPrice.toString())+" 원");
				$("#return_point").html(vos[0].return_point+" P");
				$("#return_status").html(vos[0].return_status);
				$("#return_type").html(vos[0].return_type);
				$("#return_content").html(vos[0].return_content);
				let values = "";
				let data ='<tr>'
					data += '<th style="width: 10%;color:gray;text-align: center">사진</th>';
					data += '<th style="width: 50%;color:gray;text-align: center">상품정보</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">옵션</th>';
					data += '<th style="width: 10%;color:gray;text-align: center">수량</th>';
					data += '</tr>';
				for(let i = 0; i < vos.length; i++){
					data += '<tr>';
					data +=	'<td class="w3-border-bottom"><img src="${ctp}/product/'+vos[i].prdfName+'" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>';
					data += '<td>'+vos[i].eprdName+'<br>'+vos[i].kprdName+'</td>';
					data += '<td style="text-align: center">'+vos[i].resub_option+'</td>';
					data += '<td style="text-align: center">'+vos[i].resub_count+'</td>';
					data +='</td>';
				}
				let rebtn = '<input type="hidden" id="resub_reIdx" value="'+vos[0].resub_reIdx+'">';
				if(vos[0].return_val == 0){
						rebtn +='<input type="button" onclick="returnOk()" class="w3-button w3-round w3-white w3-border w3-border-red w3-hover-white" value="신청승인">';					
				}
				$("#rebtn").html(rebtn);
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
    <h4><b>환불 상세 검색</b></h4>
    <%-- <c:set var="searchflag" value="" />
    <c:if test="${not empty param.search}">
    	<c:set var="searchflag" value="&search=${param.search}" />
    </c:if>
    <div class="w3-row w3-margin-bottom">
			<div class="w3-col m3" style="width: 430px">
				<a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${empty param.date}"> w3-win8-olive</c:if>">전체 보기</a>
	    	<a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=DAY"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='DAY'}"> w3-win8-olive</c:if>">오늘</a>
	    	<a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=1"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='MONTH' and param.orderDate == 1}"> w3-win8-olive</c:if>">1개월</a>
	    	<a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=3"
	    	 class="w3-button w3-small w3-border w3-round<c:if test="${param.date =='MONTH' and param.orderDate == 3}"> w3-win8-olive</c:if>">3개월</a>
	    	<a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=6"
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
		</div> --%>
   </div>
 	</div>
	 	<div class="w3-row" style="margin-top: 10px">
	 		<div class="w3-col m12">
	 			<div class="w3-card w3-round w3-white" style="width : 99%;height: 1150px">
			   <div class="w3-container" style="height: 1050px">
			    <h4><b>취소 / 환불 신청 내역</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 700px">
			    		<table class="w3-table w3-centered w3-win8-steel w3-round-large">
			    			<tr>
			    				<th style="width: 12%">환불번호 / 시각</th>
			    				<th style="width: 35%">상품정보</th>
			    				<th style="width: 10%">소멸 포인트</th>
			    				<th style="width: 14%;text-align: center">환불 처리</th>
			    				<th style="width: 10%">환불 유형</th>
			    				<th style="width: 10%" class="w3-right-align">총 환불 금액</th>
			    				<th style="width: 5%">
			    				<c:if test="${sort == 'desc'}">
				    				<a id="memSort" href="${ctp}/admin/adReturnList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
			    				</c:if>
			    				<c:if test="${sort == 'asc'}">
				    				<a id="memDesc" href="${ctp}/admin/adReturnList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
			    				</c:if>
			    				</th>
			    			</tr>
			    		</table>
			    		<c:if test="${empty revos }">
			    		<div class="w3-container w3-center w3-margin-top">
			    		<h4>환불 내역이 없습니다.</h4>
			    		</div>
			    		</c:if>
			    		<c:if test="${not empty revos}">
			    		<table class="" style="width: 100%">
			    			<c:forEach var="revo" items="${revos}" varStatus="st">
			    			<tr class="w3-border" style="height:  150px">
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td class="w3-center w3-border-right w3-border-bottom" rowspan="${revo.return_indexcnt}" style="width: 12%">
			    					<span class="w3-small"><b>${revo.return_marchantId}</b></span><br>
							      <span class="w3-small">${revo.return_date}</span><br><br>
							      <span class="w3-small">신청인 :${revo.name}</span>
			    				</td>
			    				</c:if>
			    				<td style="padding-left: 12px;width: 3%" class="w3-border-bottom"><img src="${ctp}/product/${revo.prdfName}" class="w3-border w3-round-large " style="width: 50px;height: 50px;" id="productView" name="brandView"  alt="미리보기"/></td>
			    				<td class="w3-border-bottom" style="width: 17%">
				    				<span class="w3-small">${revo.eprdName}</span><br>
								    <span class="w3-small">${revo.kprdName}</span>
			    				</td>
			    				<td class="w3-border-bottom " style="width: 7%">
			    				<span class="w3-small">옵션 : ${revo.resub_option }</span><br>
							    <span class="w3-small">수량 : ${revo.resub_count }</span>
			    				</td>
			    				<td style="width: 7%" class="w3-center w3-border-bottom w3-border-right">
			    				<fmt:formatNumber type="number" maxFractionDigits="3" value="${revo.resub_price * revo.resub_count }" var="fprdPrice"/>	
			    				<span class="w3-small">${fprdPrice } 원</span><br>
							        <span class="w3-small"><font color="gray">(${revo.resub_delPoint} P)</font></span>
			    				</td>
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" class="w3-center w3-border-bottom w3-border-right" style="width: 10%">
			    				<span class="w3-small"><b>- ${revo.return_point}P</b></span><br>
			    				</td>
			    				</c:if>
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" style="width: 14%;padding-left: 1px" class="w3-center w3-border-bottom w3-border-right">
			    					<c:if test="${revo.return_val == 0}">
			    					<span class="w3-small"><a href="javascript:returnCheck(${revo.reIdx})" class="w3-button w3-round w3-small w3-border">신청서 보기</a></span>
			    					</c:if>
			    					<c:if test="${revo.return_val == 1}">
			    					<span class="w3-small"><font color="blue">처리 완료</font></span><br><br>	
			    					<span class="w3-small"><a href="javascript:returnCheck(${revo.reIdx})">[환불 정보 보기]</a></span>	
			    					</c:if>
			    				</td>
			    				</c:if>
			    				<c:if  test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" style="width:11%" class="w3-center w3-border-bottom w3-border-right">
						    		<span class="w3-small"><b>[${revo.return_status }]</b></span>		
						    	</td>
						    	</c:if>
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" style="width: 15%" class="w3-center w3-border-bottom">
			    					<fmt:formatNumber type="number" maxFractionDigits="3" value="${revo.return_totalprice}" var="ftotalPrice"/>	
			    					<span class="w3-small"><b>총 환불 금액</b></span><br>
								    <span class="w3-small">${ftotalPrice} 원</span><br><br>
								    <c:if test="${revo.return_val == 0}">
								    <span class="w3-small">[<font color="red">주문 취소 대기중</font>]</span>
								    </c:if>
								    <c:if test="${revo.return_val == 1}">
								    <span class="w3-small">[<font color="blue">주문 취소 완료</font>]</span>
								    </c:if>
			    				</td>
			    				</c:if>
			    			</tr>
			    			<c:set var="idx" value="${revo.return_marchantId}" />
			    			</c:forEach>
			    		</table>
			    		</c:if>
						</div>
			   </div>
					<div class="w3-container w3-center" style="margin-top: 10px">
						<div class="w3-bar text-center">
					  <c:if test="${not empty revos}">
					  <c:if test="${pagevo.pag != 1}">
					  <a href="${ctp}/admin/adReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.pag == 1}">
					  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.curBlock > 1 }">
					  <a href="${ctp}/admin/adReturnList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">&laquo;</a>
					  </c:if>
					  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
						<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
						<c:forEach var="i" begin="${no}" end="${size}">
							<c:choose>
								<c:when test="${i > pagevo.totPage}"></c:when>
								<c:when test="${i == pagevo.pag}">
									<a href="${ctp}/admin/adReturnList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-theme-l4">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="${ctp}/admin/adReturnList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
							<a href="${ctp}/admin/adReturnList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}" class="w3-button">&raquo;</a>	
						</c:if>
						<c:if test="${pagevo.pag != pagevo.totPage}">
							<a href="${ctp}/admin/adReturnList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&raquo;</a>
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
      	<h4><b>환불 신청서</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<p><b class="w3-large">환불 정보</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">환불번호</th>
							<td id="return_marchantId"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">환불 신청 일자</th>
							<td id="return_date"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">신청자</th>
							<td id="return_mid"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">처리상태</th>
							<td id="return_val"></td>
						</tr>
					</table>
					<p><b class="w3-large">환불 상품 정보</b></p>
					<table class="w3-table w3-border w3-bordered" id="infoTable">
						<!-- <tr>
							<th style="width: 10%;color:gray;text-align: center">사진</th>
							<th style="width: 50%;color:gray;text-align: center">상품정보</th>
							<th style="width: 10%;color:gray;text-align: center">옵션</th>
							<th style="width: 10%;color:gray;text-align: center">수량</th>
							<th style="width: 10%;color:gray;text-align: center">상태</th>
						</tr> -->
					</table>
					<p><b class="w3-large">환불 내역</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">소멸 포인트</th>
							<td id="return_point"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray;font-size: 18px">총 환불금액</th>
							<td id="return_totalprice" style="font-size: 18px"></td>
						</tr>
					</table>
					<p><b class="w3-large">환불 내용</b></p>
					<table class="w3-table w3-border w3-bordered">
						<tr>
							<th style="width: 20%;color:gray">환불 유형</th>
							<td id="return_status"></td>
						</tr>
						<tr>
							<th style="width: 20%;color:gray">환불 제목</th>
							<td id="return_type"></td>
						</tr>
						<tr>
							<th colspan="2" style="width: 20%;color:gray">작성 내용</th>
						</tr>
						<tr>
							<td style="height: 100px" colspan="2" id="return_content"></td>
						</tr>
					</table>
					<div class="w3-center" id="rebtn" style="margin-top: 30px;margin-bottom: 30px">
						<input type="hidden" id="resub_reIdx" value="">
						<input type="button" onclick="returnOk()" class="w3-button w3-round w3-white w3-border w3-border-red w3-hover-white" value="신청승인">
					</div>
				</div>
      </div>
    </div>
  </div>
</body>
</html>