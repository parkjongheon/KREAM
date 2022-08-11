<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/resources/js/woo.js"></script>
<script>

var timer = null;
var isRunning = false;
let idCheck = 0;
let pwd1Check = 0;
let pwd2Check = 0;
let emailCheck= 0;

$(function(){
	$("#tooInfor").hide();
	$("#tooInforClose").hide();
	$("#demo2").hide();
	$("#spinner").hide();
})
function tooInforOpen(){
	$("#tooInfor").show();
	$("#tooInforClose").show();
	$("#tooInforOpen").hide();
}
function tooInforClose(){
	$("#tooInfor").hide();
	$("#tooInforClose").hide();
	$("#tooInforOpen").show();
}


// 전화번호 체크
$(function(){
	$("#tel2").keypress(function(){
		let regTel = /\d{4}/;
		let tel2 = $("#tel2").val();
		if(regTel.test(tel2)){
			$("#tel3").focus();
		}
	});
	$("#tel3").keypress(function(){
		let regTel = /\d{4}/;
		let tel3 = $("#tel3").val();
		if(regTel.test(tel3)){
			$("#email1").focus();
		}
	});
})
// 비밀번호 유효성 확인
$(function(){
	$("#pwd1").keyup(function(){
		
		let pwd1 = $("#pwd1").val();
		let regPwd = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;		
		if(pwd1.trim() == ""){
			$("#lpwd1").html("");	
			pwd1Check = 0;
		}
		else if(!regPwd.test(pwd1)){
			$("#lpwd1").html('<font color="red"><small><b>영문,숫자,특수문자 조합 8-18자리</b></small></font>');
			pwd1Check = 0;
		}
		else{
			$("#lpwd1").html('<font color="green"><small><b>✔ 사용가능</b></small></font>');
			pwd1Check = 1;
		}
	});
	$("#pwd2").keyup(function(){
		let pwd1 = $("#pwd1").val();
		let pwd2 = $("#pwd2").val();
		if(pwd2.trim() == ""){
			$("#lpwd2").html("");	
		}
		else if(pwd1 != pwd2){
			$("#lpwd2").html('<font color="red"><small><b>비밀번호가 일치하지 않습니다.</b></small></font>');
			pwdCheck = 0;
		}
		else if(pwd1Check == 0){
			$("#lpwd2").html('<font color="red"><small><b>비밀번호 형식이 옳바르지 않습니다.</b></small></font>');
			pwd2Check = 0;
		}
		else{
			$("#lpwd2").html('<font color="green"><small><b>✔ 비밀번호 일치</b></small></font>');
			$("#pwd").val(pwd2);
			pwd2Check = 1;
		}
	});
})
// 아이디 중복
$(function(){
	$("#mid").keyup(function(){
		let mid = $("#mid").val();
		let regMid = /^[a-z0-9_]{6,20}$/;
		if(mid.trim() == ""){
			$("#lmid").html("");			
		}
		else if(!regMid.test(mid)){
			$("#lmid").html('<font color="red"><small><b>영문 소문자와 숫자,언더바(_)6~20자리</b></small></font>');						
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/log/idCheck",
				data : {
					mid : mid
				},
				success : function(res){
					if(res == '1'){
						$("#lmid").html('<font color="green"><small><b>✔ 사용가능한 아이디입니다</b></small></font>');	
						$("#nickName").val(mid);
						idCheck = 1;
					}
					else{
						$("#lmid").html('<font color="red"><small><b>아이디가 중복됩니다. 다시입력해주세요</b></small></font>');
						idCheck = 0;
					}
				},
				error : function(){
					alert("전송오류");
				}
			});
		}
	});
})


$(function(){
	    $("#codeCheck").click(function(){
	    	$("#demo1 > p").remove();
	    	codeCheck();
	    });
})
function codeCheck(){
	let hiddenCode = $("#hiddenCode").val();
	let code = $("#code").val();
	let email1 = $("#email1").val();
	let email2 = $("#email2").val();
	let email = email1 + email2;
	
	if(hiddenCode == code){
		clearInterval(timer);
		isRunning = false;
		$('#time').html("<h5><small>인증완료</small></h5>");
		$('#codeCheck').attr("disabled",true);
	  $('#code').attr("disabled",true);
		$("#demo1").append('<p><font color="green">인증완료</font></p>');
		$("#email").val(email);
		emailCheck = 1;
	}
	else{
		$("#demo1").append('<p><font color="red">인증실패</font>코드를 다시입력해주세요</p>');		
	}
}
$(function(){
	    $("#check").click(function(e){
	    emailCheck = 0;
	    
    	var display = $('#time');
    	var leftSec = 180;
    	// 남은 시간
    	// 이미 타이머가 작동중이면 중지
    	
    	let email1 = $("#email1").val();
    	let email2 = $("#email2").val();
    	let email = email1 + email2;
    	
    	$('#code').val("");
      $('#codeCheck').attr("disabled",false);
	    $('#code').attr("disabled",false);
	    $('#demo2').hide();
	    
    	if(email1 == ""){
    		$("#demo1 > p").remove();
    		$("#demo1").append('<p><font color="red"><small><b>이메일을 입력해주세요</b></small></font></p>');
    	}
    	else{
    		$("#spinner").show();
    		$("#demo1 > p").remove();
	    	$.ajax({
	    		type : "post",
	    		url : "${ctp}/log/codeCheck",
	    		data : {
	    			toMail : email
	    		},
	    		success : function(res){
	    			if(res[0] == "1"){
	    				if (isRunning){
    		    		clearInterval(timer);
    		    		display.html("");
    		    		startTimer(leftSec, display);
    		    	}
	    				else{
    		    		startTimer(leftSec, display);
    		    	}
	    				$("#hiddenCode").val(res[1]);
	    			}
	    			else{
	    				let fixlen = res[1].length;
	    				let pre = res[1].substring(0,3);
	    				let fix = res[1].substring(6,fixlen);
	    				let userId = pre + "***" + fix;
	    				
	    				$("#spinner").hide();
	    				$("#demo2").show();
	    				$("#demo2l").html("이미 <b>"+userId+"</b> 아이디로 가입되어있습니다.");
	    			}
	    		},
	    		error : function(){
	    			alert("서버오류");
	    		}
	    	});
	    	
    	}    	
    });
    	
})

    
function startTimer(count, display) {
					
    		var minutes, seconds;
            timer = setInterval(function () {
            minutes = parseInt(count / 60, 10);
            seconds = parseInt(count % 60, 10);
     
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
     				
            display.html("<h5>"+minutes + ":" + seconds+"</h5>");
            $("#spinner").hide();
            $("#demo").show();
            // 타이머 끝
            if (--count < 0) {
    	     clearInterval(timer);
    	     display.html("<h5><small>시간초과</small></h5>");
    	     $('#codeCheck').attr("disabled",true);
    	     $('#code').attr("disabled",true);
    	     $("#demo1").append('<p><font color="red"><small><b>인증받기 버튼을 다시 눌러주세요</b></small></font></p>');
    	     isRunning = false;
            }
        }, 1000);
             isRunning = true;
}
function joinCheck(){
	$("#lname").html("");
	$("#ltel").html("");
	$("#laddress").html("");
	
	let mid = $("#mid").val();
	let pwd = $("#pwd").val();
	let pwd1 = $("#pwd1").val();
	let pwd2 = $("#pwd2").val();
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
	let gender = $("input[name=gender]:checked").val();
	
	
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	if(idCheck != 1){
		$("#lmid").html('<font color="red"><small><b>아이디를 정확히 입력해주세요</b></small></font>');
		$("#mid").focus();
	}
	else if(pwd1.trim() == ""){
		$("#lpwd1").html('<font color="red"><small><b>비밀번호를 입력해주세요</b></small></font>');
		$("#pwd1").focus();
	}
	else if(pwd1Check != 1){
		$("#lpwd1").html('<font color="red"><small><b>비밀번호를 정확히 입력해주세요</b></small></font>');
		$("#pwd1").focus();
	}
	else if(pwd2.trim() == ""){
		$("#lpwd2").html('<font color="red"><small><b>비밀번호를 다시 입력해주세요</b></small></font>');
		$("#pwd2").focus();
	}
	else if(pwd2Check != 1){
		$("#lpwd2").html('<font color="red"><small><b>비밀번호를 정확히 입력해주세요</b></small></font>');
		$("#pwd2").focus();
	}
	else if(name.trim() == ""){
		$("#lname").html('<font color="red"><small><b>이름을 정확히 입력해주세요</b></small></font>');
		$("#name").focus();
	}
	else if(!regPhone.test(tel)){
		$("#ltel").html('<font color="red"><small><b>전화번호를 정확히 입력해주세요</b></small></font>');
	}
	else if(emailCheck != 1){
		$("#demo1").append('<p><font color="red"><small><b>이메일 인증을 해주세요</b></small></font></p>');
		$("#email").focus();
	}
	else if(post.trim() == "" || address.trim() == ""){
		$("#laddress").html('<p><font color="red"><small><b>주소찾기를 이용해 주소를 등록해주세요</b></small></font></p>');
	}
	else{
		let addressTot = address+"/"+detailAddress+"/"+extraAddress;
		$("#tel").val(tel);
		$("#address").val(addressTot);
		myForm.submit();
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
				<div class="w3-container w3-center" style="width: 400px;height: 10%;margin: auto">
					<h2>회원 가입</h2>
				</div>
				<form name="myForm" method="post">
					<div class="w3-container" style="width: 500px;height: 70%;margin: auto">
						<div class="w3-container w3-margin-bottom">
						  <label><small><b>아이디<font color="red">*</font></b></small></label>
						  <input class="w3-input" type="text" name="mid" id="mid">
						  <p id="lmid"></p>
						</div>
						<div class="w3-container w3-margin-bottom">
						  <label ><small><b>비밀번호<font color="red">*</font></b></small></label>
						  <input class="w3-input" type="password" name="pwd1" id="pwd1" placeholder="영문,숫자,특수문자 조합 8-16자" style="margin-bottom: 15px">
						  <p id="lpwd1"></p>
						  <input class="w3-input" type="password" name="pwd2" id="pwd2" placeholder="비밀번호 재입력">
						  <p id="lpwd2"></p>
						  
						</div>
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
						<div class="w3-container">
							<label><small><b>이메일<font color="red">*</font></b></small></label>
							<div class="w3-margin-bottom">
							  <div class="w3-third w3-margin-bottom" style="width: 40%;margin-right: 5%">
							  	<input class="w3-input" type="text" id="email1"/>
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 30%;margin-right: 5%">
							  	<select class="w3-input" id="email2">
							  		<option value="@naver.com" selected="selected">@naver.com</option>
							  		<option value="@daum.net">@daum.net</option>
							  		<option value="@google.com">@google.com</option>
							  	</select>
							  </div>
							  <div class="w3-third w3-margin-bottom" style="width: 20%">
							  	<input type="button" value="인증받기" id="check" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>
							  </div>
							</div>
						</div>
						<div id="spinner" class="w3-center">
							<p><i class="fa fa-circle-o-notch fa-spin" style="font-size:24px"></i> 정보 확인중</p>
						</div>
						<div id="demo" class="w3-container w3-margin-bottom" style="display: none">
							<div class="w3-third" style="width: 40%;margin-right: 5%">
								<input type="text" id="code" class="w3-input" placeholder="인증번호6자리"/>
								<input type="hidden" id="hiddenCode" value=""/>
							</div>
							<div class="w3-third w3-center" id="time" style="width: 20%;margin-right: 5%">
							</div>
							<div class="w3-third" style="width: 30%">
								<input type="button" value="확인" id="codeCheck" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>
							</div>
						</div>
						<div id="demo2" class="w3-center w3-container" style="margin-bottom: 50px">
							<p id="demo2l"></p>
							<div class="w3-half" style="width: 40%;margin-right: 5%;margin-left: 5%">
								<input type="button" value="로그인하기" onclick="location.href='${ctp}/log/login';" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>
							</div>
							<div class="w3-half" style="width: 40%">
								<input type="button" value="비밀번호찾기" onclick="location.href='${ctp}/log/pwdSearch';" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>
							</div>
						</div>
						<div id="demo1" class="w3-center">
						</div>
						<div class="w3-container w3-margin-bottom">
						<label><small><b>주소<font color="red">*</font></b></small></label>
							<div style="margin-bottom: 20px">
								<input type="text" name="post" id="sample6_postcode" class="w3-input w3-half" placeholder="우편번호" style="width: 60%;margin-right: 5%">
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
				    <div class="w3-container w3-margin-bottom">
				    	<label><small><a href="javascript:tooInforOpen()" id="tooInforOpen"><b><추가 정보>&nbsp;</b><font color="gray">닉네임,성별</font> ▼</a></small></label>
				    	<label><small><a href="javascript:tooInforClose()" id="tooInforClose"><b><추가 정보>&nbsp;</b><font color="gray">닉네임,성별</font> ▲</a></small></label>
				    	<div id="tooInfor" class="w3-margin-bottom">
				    		<label><small><b>닉네임</b></small></label>
				    		<input type="text" name="nickName" id="nickName" class="w3-input">
				    		<label><small><b>성별</b></small></label>
				    		<div>
					    		<input type="radio" name="gender" id="genderNo" class="w3-small" checked="checked" value="선택안함"/>
				    			<label for="genderNo">선택 안함</label>
					    		<input type="radio" name="gender" id="genderMan" class="w3-small" value="남자"/>
				    			<label for="genderMan">남자</label>
					    		<input type="radio" name="gender" id="genderGirl" class="w3-small" value="여자"/>
				    			<label for="genderGirl">여자</label>
				    		</div>
				    	</div>
				    </div>
						<div class="w3-container w3-margin-bottom">
						 	<input type="button" onclick="joinCheck()" class="w3-button w3-xlarge w3-block w3-border w3-black w3-hover-light-grey w3-round-xlarge" value="가입하기">
						</div>
						<div class="w3-container w3-center" style="width: 420px;height: 10%;margin: auto">
						<small><b><a href="${ctp}/log/login" class="w3-padding-large">돌아가기</a></b></small> 
						<small><b><a href="${ctp}/log/idSearch" class="w3-padding-large">아이디 찾기</a></b></small> 
						<small><b><a href="${ctp}/log/pwdSearch" class="w3-padding-large">비밀번호 찾기</a></b></small>
						</div>
					</div>
					<input type="hidden" name="tel" id="tel" value=""/>
					<input type="hidden" name="pwd" id="pwd" value=""/>
					<input type="hidden" name="email" id="email" value=""/>
					<input type="hidden" name="address" id="address" value="">
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>