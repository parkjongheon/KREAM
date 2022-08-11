<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
'use strict';
	
	$(function(){
		$("#body2").hide();
		$("#spinner").hide();
	})
	function emailCheck(){
		let mid = $("#mid").val();
		let email1 = $("#email1").val();
		let email2 = $("#email2").val();
		let email = email1 + email2;
		$("#demo").html('');
		
		if(email1.trim()==""){
			$("#demo").html('<p><b><font color="red">이메일을 입력해주세요</font></b></p>');
		}
		else if(mid.trim()==""){
			$("#demo").html('<p><b><font color="red">아이디를 입력해주세요</font></b></p>');
		}
		else{
			$("#spinner").show();
			$.ajax({
				type : "post",
				url : "${ctp}/log/pwdCheck",
				data : {
					email : email,
					mid : mid
				},
				success : function(res){
					if(res == '1'){
						$("#demo").html('<p><b><font color="red">회원님의 정보를 찾을수없습니다. 다시입력해주세요</font></b></p>');
						$("#spinner").hide();
					}
					else{
						$("#demo").html('');
						$("#title").html('<b>이메일 전송이 성공하였습니다.</b>');
						$("#body1").hide();
						$("#body2").show();
						let fixlen = res.length;
    				let pre = res.substring(0,3);
    				let fix = res.substring(6,fixlen);
    				let userEmail = pre + "***" + fix;
						$("#id").html('<b>'+userEmail+'</b>');
					}
				},
				error : function(){
					
				}
			});
		}
	}




</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;margin-top:200px;margin-bottom: 100px">
	<div class="w3-container" style="height: auto">
		<div class="w3-container w3-animate-opacity">
			<div class="" style="width: 500px;height: auto;margin: auto">
				<div class="w3-container w3-center" style="width: 400px;height: 10%;margin: auto;margin-bottom: 10px">
					<h3 id="title"><b>비밀번호 찾기</b></h3>
				</div>
				<div class="w3-container" style="height: 30px">
					<hr style="border-width: 2px;border-color: black">
				</div>
				<div id="body1" class="w3-container" style="width: 500px;height: 70%;margin: auto">
					<div style="height: 70px">
						<p>가입 시 등록하신 아이디와 이메일을 입력하시면<br>
							 이메일로 임시 비밀번호를 전송해 드립니다.</p>
					</div>
					<div class="w3-margin-bottom">
						  <label><small><b>아이디</b></small></label>
						  <input class="w3-input" type="text" name="mid" id="mid" placeholder="가입하신 아이디">
						  <p id="lmid"></p>
						</div>
					<label><small><b>이메일</b></small></label>
					<div class="w3-margin-bottom">
					  <div class="w3-half w3-margin-bottom" style="width: 60%;margin-right: 5%">
					  	<input class="w3-input" type="text" id="email1" placeholder="이메일 아이디"/>
					  </div>
					  <div class="w3-half w3-margin-bottom" style="width: 30%;margin-right: 5%">
					  	<select class="w3-input" id="email2">
					  		<option value="@naver.com" selected="selected">@naver.com</option>
					  		<option value="@daum.net">@daum.net</option>
					  		<option value="@google.com">@google.com</option>
					  	</select>
					  </div>
					</div>
					<div class="w3-container w3-center" id="demo">
					</div>
					<div id="spinner" class="w3-center">
						<p><i class="fa fa-circle-o-notch fa-spin" style="font-size:24px"></i> 정보 확인중</p>
					</div>
					<div class="w3-container w3-margin-bottom">
					 	<input type="button" onclick="emailCheck()" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="이메일 전송하기">
					</div>
				</div>
				<div id="body2" class="w3-container" style="width: 500px;height: 70%;margin: auto">
					<div class="w3-center" style="height: 120px">
						<p><small>고객님의 이메일로 임시비밀번호를 전송하였습니다.</small></p>
						<p id="id"></p>
						<p><small>이메일을 확인해주세요.</small></p>
					</div>
					<div class="w3-container w3-margin-bottom">
					 	<input type="button" onclick="location.href='${ctp}/log/login';" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="로그인으로 돌아가기">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>