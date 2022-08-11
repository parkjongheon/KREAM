<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentOk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script>
	IMP.init('imp63867611');
	
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
	    		alert(msg);
	    }
	})
	</script>
</head>
<body>
<div class="container">
  <h2>결제처리 연습</h2>
  <hr/>
  <p>현재 결제가 진행중입니다.</p>
  <p><i class="fa fa-circle-o-notch fa-spin" style="font-size:24px"></i></p>
  <hr/>
</div>
</body>
</html>