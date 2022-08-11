<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<style>
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
  background-color: gray;
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
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript">
	'use strict';
	$(function(){
		$("input[type=password]").on('keyup', function(e){
	        if(e.key==='Enter'||e.keyCode===13){
	        	loginCheck();
	        }
	  });		
	})
	function loginCheck(){
		let mid = $("#mid").val();
		let pwd = $("#pwd").val();
		
		if(mid.trim() == ""){
			$("#demo").html('<p><font color="red"><small><b>아이디를 입력해주세요.</b></small></font></p>');
			$("#mid").focus();
		}
		else if(pwd.trim() == ""){
			$("#demo").html('<p><font color="red"><small><b>비밀번호를 입력해주세요.</b></small></font></p>');
			$("#pwd").focus();
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/log/loginCheck",
				data : {
					mid : mid,
					pwd : pwd
				},
				success : function(res){
					if(res != "1"){
						$("#demo").html('<p><font color="red"><small><b>아이디 또는 비밀번호를 잘못 입력했습니다.<br> 입력하신 내용을 다시 확인해주세요.</b></small></font></p>');
					}
					else{
						myForm.submit();
					}
				},
				error : function(){
					alert("서버오류");
				}
			});
		}
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;margin-top:200px">
	<div class="w3-container" style="height: 800px">
		<div class="w3-container w3-animate-opacity">
			<div class="" style="width: 500px;height: auto;margin: auto">
				<div class="w3-container w3-center" style="width: 400px;height: 20%;margin:auto;margin-bottom: 30px">
					<a href="${ctp}/" class="w3-padding-large"><img alt="" src="${ctp}/logo/logo2.png" style="height: 55px"></a>
				</div>
				<div class="w3-container" style="width: 400px;height: 40%;margin: auto">
				<form name="myForm" method="post">
					<p>
				  <label><small><b>아이디</b></small></label>
				  <input class="w3-input" type="text" id="mid" name="mid" value="${mid}"></p>
				  <p>
				  <label><small><b>비밀번호</b></small></label>
				  <input class="w3-input" type="password" id="pwd" name="pwd"></p>
				  <p>
				  <div style="margin-bottom: 20px">
					  <label class="switch">
						  <input type="checkbox" name="idSave" checked>
						  <span class="slider round"></span>
						</label>
				  	<label><small><b>아이디 저장</b></small></label>
				  </div>
				</form>
				  <div id="demo"></div>
			  	<div style="margin-bottom: 20px">
						<input type="button"  value="로그인" onclick="loginCheck()" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge"/>
			  	</div>
				</div>
				<div class="w3-container w3-center" style="width: 420px;height: 10%;margin: auto">
				<small><b><a href="${ctp}/log/join" class="w3-padding-large">회원 가입</a></b></small> |
				<small><b><a href="${ctp}/log/idSearch" class="w3-padding-large">아이디 찾기</a></b></small> |
				<small><b><a href="${ctp}/log/pwdSearch" class="w3-padding-large">비밀번호 찾기</a></b></small>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>