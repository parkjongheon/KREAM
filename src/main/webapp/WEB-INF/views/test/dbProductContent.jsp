<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbProductContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	
  	let idxArray = new Array();		/* 배열의 개수 지정없이 동적배열로 잡았다. */
    
    $(function(){
    	$("#selectOption").change(function(){						// <option value="0:기본품목_${productVo.mainPrice}">기본품목</option>
    		let selectOption = $(this).val();							// <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
    		let idx = selectOption.substring(0,selectOption.indexOf(":")); 																	// 현재 옵션의 고유번호(기본품목은 0으로 처리했다)
    		let optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_")); // 옵션명
    		let optionPrice = selectOption.substring(selectOption.indexOf("_")+1); 													// 옵션가격
    		let commaPrice = numberWithCommas(optionPrice);																									// 콤마붙인 가격
    		// 앞에서 하나의 개체를 모두 
    		
    		if($("#layer"+idx).length == 0 && selectOption != "") {
    		  idxArray[idx] = idx;		// 옵션항목의 고유번호에 따른 해당위치의 배열방에 현재상품의 고유번호(idx)를 저장처리하고 있다. 즉, idx가 5번이면 idxArray[5]번방에 5를 기억시키고 있다.
    		  /*
    		    옵션을 추가할때마다 품목(옵션)명(optionName)과 현재가격(statePrice),
    		  */
    		  
	    		let str = '';
	    		str += '<div class="layer row" id="layer'+idx+'"><div class="col">'+optionName+'</div>';
	    		str += '<input type="number" class="text-center numBox" id="numBox'+idx+'" name="optionNum" onchange="numChange('+idx+')" value="1" min="1"/> &nbsp;';
	    		str += '<input type="text" id="imsiPrice'+idx+'" class="price" value="'+commaPrice+'" readonly />';
	    		str += '<input type="hidden" id="price'+idx+'" value="'+optionPrice+'"/> &nbsp;';			/* 변동되는 가격을 재계산하기위해 price+idx 아이디를 사용하고 있다. */
	    		str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove('+idx+')" value="삭제"/>';
	    		str += '<input type="hidden" name="statePrice" id="statePrice'+idx+'" value="'+optionPrice+'"/>';		/* 현재상태에서의 변경된 상품(옵션)의 가격이다. */
	    		str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
	    		str += '<input type="hidden" name="optionName" value="'+optionName+'"/>';
	    		str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
	    		str += '</div>';
	    		$("#product1").append(str);
	    		onTotal();
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  $("div").remove("#layer"+idx);
  	  onTotal();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  let total = 0;
  	  for(let i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0) {
		  	  //alert(idxArray[i]);
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;	/* 재계산된 총금액을 myForm폼의 totalPriceResult아이디(name='totalPrice')에 담아서 값을 넘겨주려고 한다. */
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total);	/* 출력목적으로 만들어 놓은 totalPrice아이디의 text박스에 콤마를 표시하여 보여주고 있다. */
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;	// 수량박스
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);		// 화면에 콤마처리해서 보여주기위해 사용한 가격(보여주기위한 용도로만 사용한다)
    	document.getElementById("price"+idx).value = price;													// price아이디는 개별품목(옵션 등)의 상품가격으로, 수량에따라 변동처리된 상품가격을 hidden으로 담아서 넘기려한다.
    	onTotal();		// 수량이 변동될때마다 다시 총상품금액을 계산시켜주고 있다.
    }
    
    // 장바구니 호출시 수행함수
    function cart() {
    	if(document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		document.myForm.submit();
    	}
    }
    
    // 직접 주문하기
    function order() {
    	let totalPrice = document.getElementById("totalPrice").value;
    	if('${sMid}' == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memLogin";
    	}
    	else if(totalPrice=="" || totalPrice==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		document.getElementById("flag").value = "order";
    		document.myForm.submit();
    	}
    }
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
  <style>
    .layer  {
      border:0px;
      width:100%;
      padding:10px;
      margin-left:1px;
      background-color:#eee;
    }
    .numBox {width:40px}
    .price  {
      width:160px;
      background-color:#eee;
      text-align:right;
      font-size:1.2em;
      border:0px;
      outline: none;
    }
    .totalPrice {
      text-align:right;
      margin-right:10px;
      color:#f63;
      font-size:1.5em;
      font-weight: bold;
      border:0px;
      outline: none;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>

<p><br/></p>
<div class="container">
  <div class="row">
    <div class="col p-3 text-center" style="border:1px solid #ccc">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/dbShop/product/${productVo.FSName}" width="100%"/>
		  </div>
		</div>
		<div class="col p-3 text-right">
		  <!-- 상품 기본정보 -->
		  <div class="text-left"><h3>${productVo.detail}</h4></div>
		  <div>
		    <h3><font color="orange"><fmt:formatNumber value="${productVo.mainPrice}"/>원</font></h3>
		    <h4>${productVo.productName}</h3>
		  </div>
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group">
		    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
		      <select size="1" class="form-control" id="selectOption">
		        <option value="" disabled selected>상품옵션선택</option>
		        <option value="0:기본품목_${productVo.mainPrice}">기본품목</option>
		        <c:forEach var="vo" items="${optionVos}">
		          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
		        </c:forEach>
		      </select>
		    </form>
		  </div>
		  <br/>
		  <div>
			  <form name="myForm" method="post">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
			    <input type="hidden" name="mid" value="${sMid}"/>
			    <input type="hidden" name="productIdx" value="${productVo.idx}"/>
			    <input type="hidden" name="productName" value="${productVo.productName}"/>
			    <input type="hidden" name="mainPrice" value="${productVo.mainPrice}"/>
			    <input type="hidden" name="thumbImg" value="${productVo.FSName}"/>
			    <input type="hidden" name="totalPrice" id="totalPriceResult"/>	<!-- 계산된 총금액(totalPrice)을 넘겨주기위해서사용중. -->
			    <input type="hidden" name="flag" id="flag"/>			<!-- 장바구니담지않고 직접주문시에 flag='order'을 넘겨주기위한 변수 -->
			    <!-- 위쪽에서 메인상품의 기본정보와 아래쪽에서는 선택한 옵션의 정보를 같이 넘겨주려 준비중이다. -->
			    <div id="product1"></div>
			  </form>
		  </div>
		  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
		  <div>
		    <hr/>
		    <div class="text-left"><font size="4" color="black">총상품금액</font></div>
		    <p class="text-right">
		    	<!-- 아래의 id와 class이름인 totalPrice는 출력용으로 보여주기위해서만 사용한것으로 값의 전송시와는 관계가 없다. -->
	        <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly /></b>
		    </p>
		  </div>
		  <br/>
		  <!-- 장바구니보기/주문하기/계속쇼핑하기 처리 -->
		  <div class="text-center">
		    <button class="btn btn-success" onclick="cart()">장바구니담기</button>&nbsp;
		    <button class="btn btn-info" onclick="order()">주문하기</button>&nbsp;
		    <button class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbProductList';">계속쇼핑하기</button>
		    <%-- <button class="btn btn-warning" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보기</button>&nbsp; --%>
		  </div>
		</div>
  </div>
  <br/><br/>
  <!-- 상품 상세설명 보여주기 -->
  <div id="content" class="text-center"><br/>
    ${productVo.content}
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>