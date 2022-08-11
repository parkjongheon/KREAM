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
	})
	function emailCheck(){
		let email1 = $("#email1").val();
		let email2 = $("#email2").val();
		let email = email1 + email2;
		$("#demo").html('');
		
		if(email1.trim()==""){
			$("#demo").html('<p><b><font color="red">이메일을 입력해주세요</font></b></p>');
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/log/emailCheck",
				data : {
					email : email
				},
				success : function(res){
					if(res == '1'){
						$("#demo").html('<p><b><font color="red">아이디를 찾을수없습니다. 이메일을 다시 입력해주세요</font></b></p>');
					}
					else{
						let fixlen = res.length;
	    			let pre = res.substring(0,3);
	    			let fix = res.substring(6,fixlen);
	    			let userId = pre + "***" + fix;
						$("#demo").html('');
						$("#title").html('<b>아이디 찾기에 성공하였습니다.</b>');
						$("#body1").hide();
						$("#body2").show();
						$("#id").html('<b>'+userId+'</b>');
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
					<h3 id="title"><b>아이디 찾기</b></h3>
				</div>
				<div class="w3-container" style="height: 30px">
					<hr style="border-width: 2px;border-color: black">
				</div>
				<div id="body1" class="w3-container" style="width: 500px;height: 70%;margin: auto">
					<div style="height: 70px">
						<p>가입 시 등록한 이메일을 입력하면<br>
							 아이디의 일부를 알려드립니다.</p>
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
					<div class="w3-container w3-margin-bottom">
					 	<input type="button" onclick="emailCheck()" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="아이디 찾기">
					</div>
				</div>
				<div id="body2" class="w3-container" style="width: 500px;height: 70%;margin: auto">
					<div class="w3-center" style="height: 100px">
						<p><small>아이디</small></p>
						<p id="id"></p>
					</div>
					<div class="w3-container w3-margin-bottom">
					<div class="w3-half">
					 	<input type="button" onclick="location.href='${ctp}/log/pwdSearch';" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="비밀번호 찾기">
					</div>
					<div class="w3-half">
					 	<input type="button" onclick="location.href='${ctp}/log/login';" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="로그인">
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