<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
		    var y = $(event.relatedTarget).text();  // previous tab
		  });
		});
  
	  // 결재하기
    function order() {
		  var paymentCard = document.getElementById("paymentCard").value;
    	var payMethodCard = document.getElementById("payMethodCard").value;
		  var paymentBank = document.getElementById("paymentBank").value;
    	var payMethodBank = document.getElementById("payMethodBank").value;
    	if(paymentCard == "" && paymentBank == "") {
    		alert("결제방식과 결제번호를 입력하세요.");
    		return false;
    	}
    	if(paymentCard != "" && payMethodCard == "") {
    		alert("카드번호를 입력하세요.");
    		document.getElementById("payMethodCard").focus();
    		return false;
    	}
    	else if(paymentBank != "" && payMethodBank == "") {
    		alert("입금자명을 입력하세요.");
    		return false;
    	}
    	var ans = confirm("결재하시겠습니까?");
    	if(ans) {
    		if(paymentCard != "" && payMethodCard != "") {
    			document.getElementById("payment").value = "C"+paymentCard;
    			document.getElementById("payMethod").value = payMethodCard;
    		}
    		else {
    			document.getElementById("payment").value = "B"+paymentBank;
    			document.getElementById("payMethod").value = payMethodBank;
    		}
	    	myForm.action = "${ctp}/dbShop/payment";
	    	myForm.submit();
    	}
    }
  </script>
  <style>
    td, th {padding: 5px}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>

<p><br/></p>
<div class="container">
	<h2 class="text-center">주문 / 결제</h2>
	<br/>
	<table class="table-bordered text-center" style="margin:auto; width:90%">
	  <tr class="table-dark text-dark">
	    <th colspan="2">상 품</th>
	    <th>총상품금액</th>
	  </tr>
	    
	  <!-- 주문서 목록출력 -->
	  <c:set var="orderTotalPrice" value="0"/>
	  <c:forEach var="vo" items="${sOrderVos}">  <!-- 세션에 담아놓은 sOrderVos의 품목내역들을 화면에 각각 보여주는 작업처리 -->
	    <tr align="center">
	      <td><img src="${ctp}/dbShop/product/${vo.thumbImg}" width="150px"/></td>
	      <td align="left">
	        <p><br/>주문번호 : ${vo.orderIdx}</p>
	        <p class="text-center"><br/>
	          모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/>
	          &nbsp; <b><fmt:formatNumber value="${vo.mainPrice}"/>원</b>
	        </p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 옵션 내역 : 총 ${fn:length(optionNames)}개<br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp;ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach> 
	        </p>
	      </td>
	      <td>
	        <b>총 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b><br/><br/>
	      </td>
	    </tr>
		  <%-- <input type="hidden" name="cartIdx" value="${idx}"/> --%>  <!-- 장바구니고유번호를 비롯한 주문된 상품의 정보들은 세션에 담겨있기에 굳이 따로 넘길필요없다. 즉 따로이 입력된 배송지 정보들만 넘긴다. -->
	    <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
	  </c:forEach>
	</table>
	<table style="margin:auto; width:90%"><tr><td>
  <div style="padding:8px; background-color:#eee;text-align:center;">
    총 주문(결재) 금액 : 상품가격(<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>) +
                    배송비(<fmt:formatNumber value="${sOrderVos[0].baesong}" pattern='#,###원'/>) =
                    총 <font size="4" color="orange"><b><fmt:formatNumber value="${orderTotalPrice + sOrderVos[0].baesong}" pattern='#,###'/></b></font>원
  </div>
  </td></tr></table>
	<p><br/></p>
	<form name="myForm" method="post">
	  <table class="table table-bordered text-center">
	    <tr>
	      <th colspan="2">
	        <h3>배송지 정보 / 결재수단</h3>
	      </th>
	    </tr>
	    <tr>
			  <th width="40%">구매자이름</th>
			  <td><input type="text" name="buyer_name" value="${memberVo.name}" readonly class="form-control"/></td>
			</tr>
	    <tr>
			  <th>구매자메일주소(결제결과받는곳)</th>
			  <td><input type="text" name="buyer_email" value="${memberVo.email}" class="form-control"/></td>
			</tr>
	    <tr>
			  <th>구매자전화번호</th>
			  <td><input type="text" name="buyer_tel" value="${memberVo.tel}" class="form-control"/></td>
			</tr>
	    <tr>
			  <th>구매자주소</th>
			  <c:set var="addr" value="${fn:split(memberVo.address,'/')}"/>
			  <td class="text-left">
			    <input type="text" name="buyer_postcode" value="${addr[0]}"/><br/>
			    <input type="text" name="buyer_addr" value="${addr[1]} ${addr[2]} ${addr[3]}" class="form-control"/>
			  </td>
			</tr>
	    <tr>
			  <th>배송시요청사항</th>
			  <td><input type="text" name="message" class="form-control" placeholder="배송시요청사항을 기록하세요"/></td>
			</tr>
	    <tr>
			  <th>처리될 총 결제금액</th>
			  <%-- <td><input type="text" name="amount" value="${orderTotalPrice}" class="form-control" autofocus /></td> --%>
			  <td><input type="text" name="amount" value="10" class="form-control" autofocus readonly /></td>
			</tr>
		</table>
		<hr/>
		
	  <!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결재</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결재</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <h3>카드결재</h3>
	      <p>
	        <select name="paymentCard" id="paymentCard">
	          <option value="">카드선택</option>
	          <option value="국민">국민</option>
	          <option value="현대">현대</option>
	          <option value="신한">신한</option>
	          <option value="농협">농협</option>
	          <option value="BC">BC</option>
	          <option value="롯데">롯데</option>
	          <option value="삼성">삼성</option>
	          <option value="LG">LG</option>
	        </select>
	      </p>
				<p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard"/></p>
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <h3>은행결재</h3>
	      <p>
	        <select name="paymentBank" id="paymentBank">
	          <option value="">은행선택</option>
	          <option value="국민">국민(111-111-111)</option>
	          <option value="신한">신한(222-222-222)</option>
	          <option value="우리">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank"/></p>
	    </div>
	    <div id="telCheck" class="container tab-pane fade"><br>
	      <h3>전화상담</h3>
	      <p>콜센터(☎) : 02-1234-1234</p>
	    </div>
	  </div>
		<hr/>
		<div align="center">
		  <button type="button" class="btn btn-primary" onClick="order()">결제하기</button> &nbsp;
			<button type="button" class="btn btn-info" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보기</button> &nbsp;
		  <button type="button" class="btn btn-success" onClick="location.href='${ctp}/dbShop/dbShopList';">계속 쇼핑하기</button>
		  <%-- <a href="${ctp}/dbShop/dbShopList" class="btn btn-secondary">계속쇼핑하기</a> --%>
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
    <%-- <input type="hidden" name="oIdx" value="${oIdx}"/> --%>  						<!-- 주문테이블 고유번호 -->
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>  							<!-- 주문번호 -->
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>	<!-- 최종 구매(결제)금액 -->
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>			<!-- 결재종류 : 카드/계좌이체 등. -->
	  <input type="hidden" name="payMethod" id="payMethod"/>	<!-- 결재방법중에서 카드번호/계좌번호 등. -->
	  
	  <input type="hidden" name="name" value="${memberVo.name}"/>	<!-- 결재창으로 넘겨줄 모델명 -->
	  <%-- <input type="hidden" name="amount" value="${orderTotalPrice}"/> --%>	<!-- 결재창으로 넘겨줄 결제금액 -->
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>