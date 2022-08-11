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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/resources/js/woo.js"></script>
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
<script type="text/javascript">
function address(flag,res,atr){
	$("#atr").val(atr);
	$("#flag").val(flag);
	$("#idx").val(res);	
	if(atr == 'update'){
		$.ajax({
			type : "post",
			url : "${ctp}/mem/getUserAddress",
			data : {
				flag : flag,
				idx : res
			},
			success : function(vo){
				if(flag == 'main'){
					$("#name").val(vo.name);
					let tel = vo.tel.split("-");
					$("#tel2").val(tel[1]);
					$("#tel3").val(tel[2]);
					$("#sample6_postcode").val(vo.post);
					let address = vo.address.split("/");
					$("#sample6_address").val(address[0]);
					$("#sample6_detailAddress").val(address[1]);
					$("#sample6_extraAddress").val(address[2]);
				}
				else{
					$("#name").val(vo.adr_name);
					let tel = vo.adr_tel.split("-");
					$("#tel2").val(tel[1]);
					$("#tel3").val(tel[2]);
					$("#sample6_postcode").val(vo.adr_post);
					let address = vo.adr_address.split("/");
					$("#sample6_address").val(address[0]);
					$("#sample6_detailAddress").val(address[1]);
					$("#sample6_extraAddress").val(address[2]);
				}	
				$("#demoTitle").html('주소지 변경');
				$("#btn").html('<a href="javascript:addCheck()" class="w3-button w3-light-gray w3-border w3-black w3-hover-light-gray w3-round-large">수정 하기</a>');
				$("#addresszone").css('display','block');
			}
		});
	}
	else{
		$("#demoTitle").html('새 주소 추가');
		$("#btn").html('<a href="javascript:addCheck()" class="w3-button w3-light-gray w3-border w3-black w3-hover-light-gray w3-round-large">추가 하기</a>');
		$("#addresszone").css('display','block');
	}
}
function addressClose(){
	$("#atr").val("");
	$("#flag").val("");
	$("#idx").val("");	
	$("#name").val("");
	$("#tel2").val("");
	$("#tel3").val("");
	$("#sample6_postcode").val("");
	$("#sample6_address").val("");
	$("#sample6_detailAddress").val("");
	$("#sample6_extraAddress").val("");
	$("#addresszone").css('display','none');
	
}
function addCheck(){
	$("#lname").html("");
	$("#ltel").html("");
	$("#laddress").html("");
	
	let flag = $("#flag").val();
	let atr = $("#atr").val();
	let idx = $("#idx").val();
	
	let name = $("#name").val();
	let tel1 = $("#tel1").val();
	let tel2 = $("#tel2").val();
	let tel3 = $("#tel3").val();
	let tel = tel1+"-"+tel2+"-"+tel3;
	let email = $("#email").val();
	let post = $("#sample6_postcode").val();
	let address = $("#sample6_address").val();
	let detailAddress = $("#sample6_detailAddress").val();
	let extraAddress = $("#sample6_extraAddress").val();
	
	
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	
	if(name.trim() == ""){
		$("#lname").html('<font color="red"><small><b>이름을 정확히 입력해주세요</b></small></font>');
		$("#name").focus();
	}
	else if(!regPhone.test(tel)){
		$("#ltel").html('<font color="red"><small><b>전화번호를 정확히 입력해주세요</b></small></font>');
	}
	else if(post.trim() == "" || address.trim() == ""){
		$("#laddress").html('<p><font color="red"><small><b>주소찾기를 이용해 주소를 등록해주세요</b></small></font></p>');
	}
	else{
		let addressTot = address+"/"+detailAddress+"/"+extraAddress;
		if(atr == 'input'){
			$.ajax({
				type : "post",
				url : "${ctp}/mem/addressInput",
				data : {
					adr_name : name,
					adr_tel : tel,
					adr_post : post,
					adr_address : addressTot
				},
				success : function(){
					location.reload();
				}
			});
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/mem/addressUpdate",
				data : {
					adr_name : name,
					adr_tel : tel,
					adr_post : post,
					adr_address : addressTot,
					flag : flag,
					idx : idx
				},
				success : function(){
					location.reload();
				}
			});
		}
	}
}
function adrChange(res){
	let adr_Idx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/mem/addressChange",
		data : {
			adr_Idx : adr_Idx
		},
		success : function(){
			location.reload();
		}
	});
}
function addressDelete(res){
	let adr_Idx = res;
	Swal.fire({
		  position: 'top',
		  icon: 'question',
		  title: '주소지를 삭제하시겠습니까?',
		  showConfirmButton: true,
		  showCancelButton: true,
		  cancelButtonText:'취소',
		  confirmButtonText: '삭제'
	}).then((result) => {
	  if(result.isConfirmed){
		  $.ajax({
			  type : "post",
			  url : "${ctp}/mem/addressDelete",
			  data : {
				  adr_Idx : adr_Idx
			  },
			  success : function(){
				  location.reload();
			  }
		  });
	  }						
	});
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:5000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;height:800px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-cell" style="height: 100%;width: 220px;margin-left: 40px">
				<div class="w3-bar-block">
				  <h3><a href="${ctp}/mem/myPage" class="w3-bar-item"><b>마이 페이지</b></a></h3>
				  <h5 class="w3-bar-item"><b>쇼핑 정보</b></h5>
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="gray">구매 내역</font></a>
				  <a href="${ctp}/mem/myReturnList" class="w3-bar-item"><font color="gray">환불 내역</font></a>
				  <a href="${ctp}/mem/myWishList" class="w3-bar-item"><font color="gray">관심 상품</font></a>
				</div>
				<div class="w3-bar-block">
				  <h5 class="w3-bar-item"><b>내 정보</b></h5>
				  <a href="${ctp}/mem/myPage/profile" class="w3-bar-item"><font color="gray">프로필 정보</font></a>
				  <a href="${ctp}/mem/myAddressList" class="w3-bar-item"><font color="black"><b>주소록</b></font></a>
				  <a href="${ctp}/mem/myDeclaration" class="w3-bar-item"><font color="gray">신고 내역</font></a>
				  <a href="${ctp}/mem/myHistory" class="w3-bar-item"><font color="gray">히스토리</font></a>
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red">회원탈퇴</font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1100px;margin-bottom: 100px">
				<div class="w3-container">
				<div class="w3-row">
					<div class="w3-col m10 w3-left-align">
						<h3 id="title"><b>주소록</b></h3>
					</div>
					<div class="w3-col m2" style="margin-top: 15px">
					<a href="javascript:address('1',1,'input')" class="w3-button w3-ripple w3-hover-white w3-right"><i class="fa fa-plus" aria-hidden="true"></i></a>
					</div>
				</div>
					<hr style="border-width: 3px;border-color: black">
					<ul class="w3-ul w3-round-large">
						<li class="w3-bar w3-center">
						<div class="w3-bar-item" style="width: 79%">
						<span class="w3-small w3-left w3-light-gray" style="width: 80px">기본배송지</span><br>
						<span class="w3-small w3-left"><b>${vo.name}</b></span><br>
						<span class="w3-small w3-left">${vo.tel}</span><br>
						<c:set var="add" value="${fn:split(vo.address,'/')}"/>
						<span class="w3-small w3-left">(${vo.post}) ${add[0]} ${add[1]} ${add[2]}</span>
						</div>
						<div class="w3-bar-item" style="width: 20%">
						<a href="javascript:address('main',${vo.idx},'update')" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">수정</a>
						</div>
						</li>
					</ul>
					<hr style="border-width: 1px;border-color: gray">
					<c:if test="${not empty adrvos}">
					<ul class="w3-ul w3-round-large">
						<c:forEach var="adrvo" items="${adrvos}">
						<li class="w3-bar w3-center">
						<div class="w3-bar-item" style="width: 69%">
						<span class="w3-small w3-left"><b>${adrvo.adr_name}</b></span><br>
						<span class="w3-small w3-left">${adrvo.adr_tel}</span><br>
						<c:set var="adr" value="${fn:split(adrvo.adr_address,'/')}"/>
						<span class="w3-small w3-left">(${adrvo.adr_post}) ${adr[0]} ${adr[1]} ${adr[2]}</span>
						</div>
						<div class="w3-bar-item" style="width: 30%">
						<a href="javascript:adrChange(${adrvo.adr_Idx})" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">기본주소로 변경</a>
						<a href="javascript:address('sub',${adrvo.adr_Idx},'update')" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">수정</a>
						<a href="javascript:addressDelete(${adrvo.adr_Idx})" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">삭제</a>
						</div>
						</li>
						</c:forEach>
					</ul>
					</c:if>
				</div>
				<%-- <div class="w3-container w3-center">
					<div class="w3-bar text-center">
				  <c:if test="${not empty vos}">
				  <c:if test="${pagevo.pag != 1}">
				  <a href="${ctp}/mem/myWishList?pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
				  </c:if>
				  <c:if test="${pagevo.pag == 1}">
				  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
				  </c:if>
				  <c:if test="${pagevo.curBlock > 1 }">
				  <a href="${ctp}/board/feedAll?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
				  </c:if>
				  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
					<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
					<c:forEach var="i" begin="${no}" end="${size}">
						<c:choose>
							<c:when test="${i > pagevo.totPage}"></c:when>
							<c:when test="${i == pagevo.pag}">
								<a href="${ctp}/board/feedAll?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-light-gray">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="${ctp}/board/feedAll?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
						<a href="${ctp}/board/feedAll?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
					</c:if>
					<c:if test="${pagevo.pag != pagevo.totPage}">
						<a href="${ctp}/board/feedAll?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
					</c:if>
					<c:if test="${pagevo.pag == pagevo.totPage}">
						<a class="w3-button w3-xlarge w3-disabled">&raquo;</a>
					</c:if>
				  </c:if>		
					</div>
				</div> --%>
			</div>
		</div>
	</div>
</div>
<!-- <div id="addressUpdate" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 500px;height:550px">
      <div class="w3-container">
        <span onclick="updateClose()" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h4 id="msgTitle" style="text-align: center"><b>주소록 수정</b></h4>        
				<div id="addressbox" class="w3-margin-top" style="padding: 0px;height: 380px">
					<div class="w3-container w3-margin-bottom">
						  <label><small><b>이름<font color="red">*</font></b></small></label>
						  <input class="w3-input" type="text" name="name" id="name">
						  <p id="lname"></p>
						</div>
						<div class="w3-container">
							<label><small><b>전화번호<font color="red">*</font></b></small></label>
							<div class="w3-margin-bottom">
							  <div class="w3-third w3-margin-bottom" style="width: 30%;margin-right: 5%;margin-top: 2px">
							  	<select class="w3-input" name="tel1" id="tel1">
							  		<option value="010" selected="selected">010</option>
							  	</select>
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 30%;margin-right: 5%">
							  	<input class="w3-input" type="text" name="tel2" id="tel2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 30%">
							  	<input class="w3-input" type="text" name="tel3" id="tel3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							  </div>
							  <p id="ltel"></p>
							</div>
						</div>
						<div class="w3-container w3-margin-bottom">
						<label><small><b>주소<font color="red">*</font></b></small></label>
							<div style="margin-bottom: 20px">
								<input type="text" name="post" id="sample6_postcode" class="w3-input w3-half" placeholder="우편번호" style="width: 60%;margin-right: 5%"/>
								<input type="button" id="searchAddress" onclick="sample6_execDaumPostcode()"class="w3-button w3-half w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large" value="주소 찾기" style="width: 30%">
							</div>
							<div>
								<input type="text" name="roadAddress" id="sample6_address" class="w3-input" placeholder="주소" style="width: 95%">
							</div>
							<div>
								<input type="text" name="detailAddress" id="sample6_detailAddress" class="w3-input w3-half" placeholder="상세주소" style="width: 45%;margin-right: 5%">
								<input type="text" name="extraAddress" id="sample6_extraAddress" class="w3-input w3-half" placeholder="참고항목" style="width: 45%">
							</div>
							<p id="laddress"></p>
				    </div>
				    <input type="hidden" id="flag">
				    <input type="hidden" id="idx">
					</div>
					<div class="w3-center" style="margin-top: 50px">
					<a href="javascript:updateCheck()" class="w3-button w3-light-gray w3-border w3-black w3-hover-light-gray w3-round-large">수정하기</a>
					</div>
      </div>
    </div>
  </div> -->
<div id="addresszone" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content w3-round-large" style="width: 500px;height:550px">
      <div class="w3-container">
        <span onclick="addressClose()" class="w3-button w3-round-large w3-hover-white w3-display-topright">&times;</span>
        <h4 id="msgTitle" style="text-align: center"><b id="demoTitle">새 주소 추가</b></h4>        
				<div id="addressbox" class="w3-margin-top" style="padding: 0px;height: 380px">
					<div class="w3-container w3-margin-bottom">
						  <label><small><b>이름<font color="red">*</font></b></small></label>
						  <input class="w3-input" type="text" name="name" id="name">
						  <p id="lname"></p>
						</div>
						<div class="w3-container">
							<label><small><b>전화번호<font color="red">*</font></b></small></label>
							<div class="w3-margin-bottom">
							  <div class="w3-third w3-margin-bottom" style="width: 30%;margin-right: 5%;margin-top: 2px">
							  	<select class="w3-input" name="tel1" id="tel1">
							  		<option value="010" selected="selected">010</option>
							  	</select>
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 30%;margin-right: 5%">
							  	<input class="w3-input" type="text" name="tel2" id="tel2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 30%">
							  	<input class="w3-input" type="text" name="tel3" id="tel3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							  </div>
							  <p id="ltel"></p>
							</div>
						</div>
						<div class="w3-container w3-margin-bottom">
						<label><small><b>주소<font color="red">*</font></b></small></label>
							<div style="margin-bottom: 20px">
								<input type="text" name="post" id="sample6_postcode" class="w3-input w3-half" placeholder="우편번호" style="width: 60%;margin-right: 5%"/>
								<input type="button" id="searchAddress" onclick="sample6_execDaumPostcode()"class="w3-button w3-half w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large" value="주소 찾기" style="width: 30%">
							</div>
							<div>
								<input type="text" name="roadAddress" id="sample6_address" class="w3-input" placeholder="주소" style="width: 95%">
							</div>
							<div>
								<input type="text" name="detailAddress" id="sample6_detailAddress" class="w3-input w3-half" placeholder="상세주소" style="width: 45%;margin-right: 5%">
								<input type="text" name="extraAddress" id="sample6_extraAddress" class="w3-input w3-half" placeholder="참고항목" style="width: 45%">
							</div>
							<p id="laddress"></p>
				    </div>
				    <input type="hidden" id="atr">
				    <input type="hidden" id="flag">
				    <input type="hidden" id="idx">
					</div>
					<div class="w3-center" id="btn" style="margin-top: 50px">
					</div>
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
