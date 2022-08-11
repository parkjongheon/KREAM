<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentOk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script>
		IMP.init('imp21064327');
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '${payMentVo.name}',
		    amount : ${payMentVo.amount}, //판매 가격
		    buyer_email : '${payMentVo.buyer_email}',
		    buyer_name : '${payMentVo.buyer_name}',
		    buyer_tel : '${payMentVo.buyer_tel}',
		    buyer_addr : '${payMentVo.buyer_addr}',
		    buyer_postcode : '${payMentVo.buyer_postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        paySw = 'ok';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		    if(paySw == 'no') {
			    alert("다시 주문구매창으로 이동합니다.");
		    	location.href='${ctp}/dbShop/dbProductList';
		    }
		    else {
					var temp = "";
					temp += '?name=${payMentVo.name}';
					temp += '&amount=${payMentVo.amount}';
					temp += '&buyer_email=${payMentVo.buyer_email}';
					temp += '&buyer_name=${payMentVo.buyer_name}';
					temp += '&buyer_tel=${payMentVo.buyer_tel}';
					temp += '&buyer_addr=${payMentVo.buyer_addr}';
					temp += '&buyer_postcode=${payMentVo.buyer_postcode}';
					temp += '&imp_uid=' + rsp.imp_uid;
					temp += '&merchant_uid=' + rsp.merchant_uid;
					temp += '&paid_amount=' + rsp.paid_amount;
					temp += '&apply_num=' + rsp.apply_num;
					
					//temp += '&orderIdx=${orderVo.orderIdx}';
					
					location.href='${ctp}/dbShop/paymentResult'+temp;
		    }
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>

<p><br></p>
<div class="container">
  <h2>결제처리 연습</h2>
  <hr/>
  <p>현재 결제가 진행중입니다.</p>
  <p><img src="${ctp}/images/m1.jpg" width="200px"/></p>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>