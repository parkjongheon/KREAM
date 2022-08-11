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
	function btDateCheck(){
		let start = $("#datepicker").val();
		let end = $("#datepicker1").val();
		let val = $("#searchVal").val();
		let btdate = start+"/"+end;
		if(val == null){
			location.href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate;
		}
		else{
			location.href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&btdate="+btdate+"&val="+val;			
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
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="gray">구매 내역</font></a>
				  <a href="${ctp}/mem/myReturnList" class="w3-bar-item"><font color="black"><b>환불 내역</b></font></a>
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
					<h3 id="title"><b>환불 내역</b></h3>
					<hr style="border-width: 3px;border-color: black">
					<div class="w3-round-large w3-pale-green" style="height: 100px;margin-top: 20px">
						<div class="w3-cell" style="width: 240px;height: 140px;margin: auto">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>전체</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returnAllcnt }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>주문 취소</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returncnt1 }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>환불</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px"><b>${returncnt2 }</b></font>
							</div>
						</div>
						<div class="w3-cell" style="width: 270px;height: 140px">
							<div class="w3-bar-block w3-center" style="margin-top: 20px">
								<font color="gray"><small>완료</small></font>
							</div>
							<div class="w3-bar-block w3-center">
								<font size="2px" color="red"><b>${returnClearcnt }</b></font>
							</div>
						</div>
					</div>
					<h5><b>환불 상세 검색</b></h5>
					<hr style="border-width: 2px">
					<div class="w3-container" style="height: 60px;width: 1100px;margin-top: 20px">
						<div class="w3-row">
							<div class="w3-col m5">
							<a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-border w3-round w3-small" style="width: 70px">전체</a>						
							<a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=DAY" class="w3-button w3-border w3-round w3-small" style="width: 70px">오늘</a>						
							<a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=1" class="w3-button w3-border w3-round w3-small" style="width: 70px">1개월</a>						
							<a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=3" class="w3-button w3-border w3-round w3-small" style="width: 70px">3개월</a>						
							<a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=MONTH&orderDate=6" class="w3-button w3-border w3-round w3-small" style="width: 70px">6개월</a>						
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
								<option value="0">환불/취소 접수 : 0</option>
								<option value="1">환불/취소 완료 : 1</option>
							</select>
    					<a href="javascript:btDateCheck()" id="searchButton" style="width: 60px" class="w3-button w3-small w3-border w3-half w3-round-large">검색</a>
							</div>
						</div>
					</div>
					<h5><b>환불 내역 정보</b></h5>
					<hr style="border-width: 2px">
					
					<div class="" style="height: 100%">
			    		<table class="w3-table w3-centered w3-round-large">
			    			<tr>
			    				<th class="w3-small" style="width: 15%">환불번호 / 시각</th>
			    				<th class="w3-small" style="width: 25%">상품정보</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">가격</th>
			    				<th class="w3-small" style="width: 10%;text-align: center">처리 상태</th>
			    				<th class="w3-small" style="width: 10%" class="w3-right-align">총 환불 금액</th>
			    				<th class="w3-small" style="width: 9%;text-align: center">기타</th>
			    				<th class="w3-small" style="width: 2%">
			    				<c:if test="${sort == 'desc'}">
				    				<a id="memSort" href="${ctp}/mem/myReturnList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
			    				</c:if>
			    				<c:if test="${sort == 'asc'}">
				    				<a id="memDesc" href="${ctp}/mem/myReturnList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
			    				</c:if>
			    				</th>
			    			</tr>
			    		</table>
			    		<c:if test="${empty revos }">
			    		<div class="w3-container w3-center w3-margin-top">
			    		<h5>환불 내역이 없습니다.</h5>
			    		</div>
			    		</c:if>
			    		<c:if test="${not empty revos}">
			    		<table class="w3-border-top" style="margin-top: 10px;width: 100%">
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
			    				<td class="w3-border-bottom w3-border-right" style="width: 20%">
				    				<span class="w3-small"><b>${revo.eprdName}</b></span><br>
								    <span class="w3-small">${revo.kprdName}</span><br><br>
								    <span class="w3-small">옵션 : <b>${revo.resub_option }</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
							    <span class="w3-small">수량 : <b>${revo.resub_count }</b></span>
			    				</td>
			    				<td style="width: 7%" class="w3-center w3-border-bottom w3-border-right">
			    				<fmt:formatNumber type="number" maxFractionDigits="3" value="${revo.resub_price * revo.resub_count }" var="fprdPrice"/>	
			    				<span class="w3-small">${fprdPrice } 원</span><br>
							        <span class="w3-small"><font color="gray">(${revo.resub_delPoint} P)</font></span>
			    				</td>
			    				<td style="width:10%" class="w3-center w3-border-bottom w3-border-right">
			    				<c:if test="${revo.return_val == 0}">
			    					<span class="w3-small">[신청서 검토중]</span>
			    				</c:if>
			    				<c:if test="${revo.return_val == 1}">
			    					<span class="w3-small">[${revo.return_status} 완료]</span>
			    				</c:if>
			    				</td>
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" style="width: 10%" class="w3-center w3-border-bottom w3-border-right">
			    					<fmt:formatNumber type="number" maxFractionDigits="3" value="${revo.return_totalprice}" var="ftotalPrice"/>	
			    					<span class="w3-small"><b>총 환불 금액</b></span><br>
								    <span class="w3-small">${ftotalPrice} 원</span><br><br>
			    				</td>
			    				</c:if>
			    				<c:if test="${idx != revo.return_marchantId}">
			    				<td rowspan="${revo.return_indexcnt}" class="w3-border-bottom w3-center" style="width: 10%">
    								<c:if test="${revo.return_val == 0}">
    								<span class="w3-small"><font color="red">[신청서 검토중]</font></span>
    								</c:if>
    								<c:if test="${revo.return_val == 1}">
    								<span class="w3-small">[${revo.return_status} 완료]</span>
    								</c:if>
			    				</td>
			    				</c:if>
			    			</tr>
			    			<c:set var="idx" value="${revo.return_marchantId}" />
			    			</c:forEach>
			    		</table>
			    		</c:if>
						</div>
						<div class="w3-container w3-center" style="margin-top: 10px">
						<div class="w3-bar text-center">
					  <c:if test="${not empty revos}">
					  <c:if test="${pagevo.pag != 1}">
					  <a href="${ctp}/mem/myReturnList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-xlarge">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.pag == 1}">
					  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.curBlock > 1 }">
					  <a href="${ctp}/mem/myReturnList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">&laquo;</a>
					  </c:if>
					  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
						<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
						<c:forEach var="i" begin="${no}" end="${size}">
							<c:choose>
								<c:when test="${i > pagevo.totPage}"></c:when>
								<c:when test="${i == pagevo.pag}">
									<a href="${ctp}/mem/myReturnList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-theme-l4">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="${ctp}/mem/myReturnList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
							<a href="${ctp}/mem/myReturnList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button">&raquo;</a>	
						</c:if>
						<c:if test="${pagevo.pag != pagevo.totPage}">
							<a href="${ctp}/mem/myReturnList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}&date=${param.date}&orderDate=${param.orderDate}" class="w3-button w3-xlarge">&raquo;</a>
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
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
