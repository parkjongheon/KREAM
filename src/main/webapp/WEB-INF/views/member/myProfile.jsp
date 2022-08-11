<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript">
	'use strict';
	
	var timer = null;
	var isRunning = false;
	let pwd1Check = 0;
	let pwd2Check = 0;
	let nickCheck = 0;
	
	$(function(){
		$("#imgProfile").on("change",function(){
			let formData = new FormData();
			formData.append("imgProfile",$("#imgProfile")[0].files[0]);
			
			$.ajax({
				type : "post",
				enctype: 'multipart/form-data',
				url : "${ctp}/mem/imgProfile",
				processData : false,
				contentType : false,
				data : formData,
				success : function(){
					location.reload();
				},
				error : function(){
					alert("전송 오류");
				}
			});
		});
		$("#imgProfileDelete").click(function(){
			$.ajax({
				type : "post",
				url : "${ctp}/mem/imgProfileDelete",
				success : function(){
					location.reload();
				},
				error : function(){
					alert("전송 오류");
				}
			});
		});
	})
	
	$(function(){
		$("#emaillChangeView").hide();
		$("#pwdChangeView").hide();
		$("#nickNameChangeView").hide();
		$("#nameChangeView").hide();
		$("#telChangeView").hide();
		$("#spinner").hide();
		$("#demo").hide();
	})
	
	$(function(){
	    $("#emailForm1").click(function(){
	    	$("#emaillChangeView").show();
				$("#emailView").hide();
	    });
	    $("#emailForm2").click(function(){
	    	$("#emaillChangeView").hide();
				$("#emailView").show();
	    });
	    $("#pwdForm1").click(function(){
	    	$("#pwdChangeView").show();
				$("#pwdView").hide();
	    });
	    $("#pwdForm2").click(function(){
	    	$("#pwdChangeView").hide();
				$("#pwdView").show();
	    });
	    $("#nickNameForm1").click(function(){
	    	$("#nickNameChangeView").show();
				$("#nickNameView").hide();
	    });
	    $("#nickNameForm2").click(function(){
	    	$("#nickNameChangeView").hide();
				$("#nickNameView").show();
	    });
	    $("#nameForm1").click(function(){
	    	$("#nameChangeView").show();
				$("#nameView").hide();
	    });
	    $("#nameForm2").click(function(){
	    	$("#nameChangeView").hide();
				$("#nameView").show();
	    });
	    $("#telForm1").click(function(){
	    	$("#telChangeView").show();
				$("#telView").hide();
	    });
	    $("#telForm2").click(function(){
	    	$("#telChangeView").hide();
				$("#telView").show();
	    });
	})
	// 이메일 인증
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
			$.ajax({
				type : "post",
				url : "${ctp}/mem/emailChange",
				data : {
					email : email
				},
				success : function(){
					location.reload();
				},
				error : function(){
					alert("서버오류");
				}
			});
		}
		else{
			$("#demo1").append('<p><font color="red">인증실패</font>코드를 다시입력해주세요</p>');		
		}
	}
	$(function(){
	    $("#check").click(function(e){
	    
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
	    				$("#spinner").hide();
	    				$("#demo1").html('<p><font color="red"><small><b>중복된 이메일입니다</b></small></font></p>');
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
	
	$(function(){
		$("#userPwd").keyup(function(){
			let pwd = $("#userPwd").val();
			if(pwd.trim() == ""){
				$("#userPwdCheck").html("");	
				pwd1Check = 0;
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/mem/pwdCheck",
					data : {
						pwd : pwd
					},
					success : function(res){
						if(res == '0'){
							$("#userPwdCheck").html('<font color="red"><small><b>비밀번호가 일치하지 않습니다</b></small></font>');
							pwd1Check = 0;
						}
						else{
							$("#userPwdCheck").html('<font color="green"><small><b>✔ 비밀번호 일치</b></small></font>');
							
							pwd1Check = 1;
						}
					}
				});
			}
		});
		$("#newPwd").keyup(function(){
			let pwd = $("#newPwd").val();
			let regPwd = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;		
			if(pwd.trim() == ""){
				$("#newPwdCheck").html("");	
				pwd2Check = 0;
			}
			else if(!regPwd.test(pwd)){
				$("#newPwdCheck").html('<font color="red"><small><b>영문,숫자,특수문자 조합 8-18자리</b></small></font>');
				pwd2Check = 0;
			}
			else{
				$("#newPwdCheck").html('<font color="green"><small><b>✔ 사용가능</b></small></font>');
				pwd2Check = 1;
			}
		});
		$("#pwdCheck").click(function(){
			let pwd = $("#newPwd").val();
			
			if(pwd1Check != 1){
				$("#demo2").html('<font color="red"><small><b>기존비밀번호 인증을 완료해주세요</b></small></font>');
				$("#userPwd").focus();
			}
			else if(pwd2Check != 1){
				$("#demo2").html('<font color="red"><small><b>새 비밀번호를 정확히 입력해주세요</b></small></font>');
				$("#newPwd").focus();
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/mem/pwdChange",
					data : {
						pwd : pwd
					},
					success : function(res){
						location.href="${ctp}/msg/pwdChangeOk";
					},
					error : function(){
						
					}
				});
			}
		});
	})
	$(function(){
		$("#nickName").keyup(function(){
			let regNick = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{6,20}$/;
			let nickName = $("#nickName").val();
			if(nickName.trim() == ""){
				$("#nickNameCheck").html("");	
				nickCheck = 0;
			}
			else if(!regNick.test(nickName)){
				$("#nickNameCheck").html('<font color="red"><small><b>한글,영문,숫자 6-20자</b></small></font>');	
				nickCheck = 0;
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/mem/nickNameCheck",
					data : {
						nickName : nickName
					},
					success : function(res){
						if(res == '0'){
							$("#nickNameCheck").html('<font color="red"><small><b>닉네임이 중복됩니다</b></small></font>');
							nickCheck = 0;
						}
						else{
							$("#nickNameCheck").html('<font color="green"><small><b>✔ 사용 가능</b></small></font>');
							
							nickCheck = 1;
						}
					},
					error : function(){
						
					}
				});
			}
		});
		$("#nickNamecheck").click(function(){
			let nickName = $("#nickName").val();
			if(nickCheck != 1){
				$("#nickNameCheck").html('<font color="red"><small><b>닉네임 인증을 완료해주세요</b></small></font>');
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/mem/nickNameChange",
					data : {
						nickName : nickName
					},
					success : function(res){
						location.reload();
					},
					error : function(){
						
					}
				});
			}
		});
		$("#namecheck").click(function(){
			let name = $("#name").val();
			if(name.trim() == ""){
				$("#demo4").html('<font color="red"><small><b>변경할 이름을 입력해주세요</b></small></font>');
				$("#name").focus();
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/mem/nameChange",
					data : {
						name : name
					},
					success : function(res){
						location.reload();
					},
					error : function(){
						
					}
				});
			}
		});
		$("#telcheck").click(function(){
			let tel1 = $("#tel1").val();
			let tel2 = $("#tel2").val();
			let tel3 = $("#tel3").val();
			let tel = tel1 + "-" + tel2 + "-" + tel3;
			$.ajax({
				type : "post",
				url : "${ctp}/mem/telChange",
				data : {
					tel : tel
				},
				success : function(res){
					location.reload();
				},
				error : function(){
					
				}
			});
		});
	})
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;max-height:2000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-half w3-cell" style="height: 700px;width: 220px;margin-left: 40px">
				<div class="w3-bar-block">
				  <h3><a href="${ctp}/mem/myPage" class="w3-bar-item"><b>마이 페이지</b></a></h3>
				  <h5 class="w3-bar-item"><b>쇼핑 정보</b></h5>
				  <a href="${ctp}/mem/myOrderList" class="w3-bar-item"><font color="gray">주문 내역</font></a>
				  <a href="${ctp}/mem/myReturnList" class="w3-bar-item"><font color="gray">환불 내역</font></a>
				  <a href="${ctp}/mem/myWishList" class="w3-bar-item"><font color="gray">관심 상품</font></a>
				</div>
				<div class="w3-bar-block">
				  <h5 class="w3-bar-item"><b>내 정보</b></h5>
				  <a href="${ctp}/mem/myPage/profile" class="w3-bar-item"><font color="black"><b>프로필 정보</b></font></a>
				  <a href="${ctp}/mem/myAddressList" class="w3-bar-item"><font color="gray">주소록</font></a>
				  <a href="${ctp}/mem/myDeclaration" class="w3-bar-item"><font color="gray">신고 내역</font></a>
				  <a href="${ctp}/mem/myHistory" class="w3-bar-item"><font color="gray">히스토리</font></a>
				  <a href="${ctp}/mem/userDel" class="w3-bar-item"><font color="red">회원탈퇴</font></a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 1500px;width: 1000px">
				<div class="w3-container">
					<div class="" style="width: 100%;height: 10%;margin: auto;margin-bottom: 10px">
						<h3 id="title"><b>프로필 정보</b></h3>
						<hr style="border-width: 3px;border-color: black">
					</div>
					<div class="w3-round-large" style="height: 150px;width: 965px;margin-top: 20px;margin-bottom: 20px">
						<div class="w3-cell w3-left" style="width: 150px;height: 140px">
							<div class="box" style="margin: auto;margin-top: 20px">
							    <img class="profile" src="${ctp}/member/${vo.photo}">
							</div>
						</div>
						<div class="w3-cell w3-left" style="width: 230px;height: 140px">
							<div class="w3-bar-block" style="margin-top: 30px">
								<font size="4px"><b>${vo.mid}</b></font><br>
								<font size="1px" color="gray"><b>[자기소개는 내피드에서 변경할수있습니다]</b></font>
							</div>
							<div class="w3-bar-block">
								<div class="w3-cell">
								<label for="imgProfile" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" style="margin-top: 10px;margin-right: 5px"> 이미지 변경</label>
								<input type="file" id="imgProfile" style="display: none">
									<!-- <a href="#" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" style="margin-top: 10px;margin-right: 5px">이미지 변경</a> -->
								</div>
								<div class="w3-cell">
									<input type="button" value="삭제" id="imgProfileDelete" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" style="margin-top: 10px">
								</div>
							</div>
						</div>
					</div>
					<hr style="border-width: 2px">
					<div class="w3-round-large" style="height: 100px;width: 965px;margin-top: 0px">
						<h4><b>로그인정보</b></h4>
						<div id="emailView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 20px">
									<font color="gray"><small>이메일 주소</small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<font size="2px"><b>${vo.email}</b></font>
									</div>
									<div class="w3-cell">
										<input type="button" id="emailForm1" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="변경">
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<c:set var="emails" value="${fn:split(vo.email,'@')}"/>
						<div id="emaillChangeView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 20px">
									<font color="black"><small><b>이메일 주소 변경</b></small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<div class="w3-third w3-margin-bottom" style="width: 40%;margin-right: 5%">
									  	<input class="w3-input" type="text" id="email1" placeholder="${emails[0]}"/>
									  </div>
									  <div class="w3-third w3-margin-bottom" style="width: 35%;margin-right: 6%">
									  	<select class="w3-input" id="email2">
									  		<option value="@naver.com" selected="selected">@naver.com</option>
									  		<option value="@daum.net">@daum.net</option>
									  		<option value="@google.com">@google.com</option>
									  	</select>
									  </div>
									  <div class="w3-third w3-margin-bottom" style="width: 14%">
									  	<input type="button" id="emailForm2" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="취소">
									  </div>
									</div>
									<div class="w3-block w3-center">
									  	<input type="button" value="인증" id="check" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>									
									</div>
									<div id="codeView" style="margin-top: 30px">
										<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
											<div class="w3-bar-block">
												<div class="w3-cell" style="width: 400px">
													<div id="spinner" class="w3-center">
														<p><i class="fa fa-circle-o-notch fa-spin" style="font-size:24px"></i> 정보 확인중</p>
													</div>
													<div id="demo" class="w3-container w3-margin-bottom">
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
													<div id="demo1" class="w3-center"></div>
													<hr style="border-width: 1px;border-color: gary">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="pwdView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="gray"><small>비밀번호</small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<font size="2px"><b>●●●●●●●●●</b></font>
									</div>
									<div class="w3-cell">
										<input type="button" id="pwdForm1" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="변경">
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						
						<div id="pwdChangeView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="black"><small><b>비밀번호 변경</b></small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<div class="" style="width: 300px;margin-bottom: 20px">
											<label><small><b>이전 비밀번호</b></small></label>&nbsp;&nbsp;&nbsp;<span id="userPwdCheck"></span>
									  	<input class="w3-input" type="password" id="userPwd" placeholder="기존 비밀번호 입력"/>
									  </div>
										<div class="" style="width: 300px">
											<label><small><b>새로운 비밀번호</b></small></label>&nbsp;&nbsp;&nbsp;<span id="newPwdCheck"></span>
									  	<input class="w3-input" type="password" id="newPwd" placeholder="영문,숫자,특수문자 조합 8-16자"/>
									  </div>
									</div>
									<div class="w3-cell ">
										<input type="button" id="pwdForm2" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="취소">
									</div>
									<div id="demo2" class="w3-center" style="padding-top: 10px"></div>
									<div class="w3-block w3-center w3-margin-top">
									  	<input type="button" value="비밀번호 변경" id="pwdCheck" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>									
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						
						
						<h4><b>개인 정보</b></h4>
						<div id="nickNameView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="gray"><small>닉네임</small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<font size="2px"><b>@ ${vo.nickName}</b></font>
									</div>
									<div class="w3-cell">
										<input type="button" id="nickNameForm1" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="변경">
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<div id="nickNameChangeView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="black"><small><b>닉네임 변경</b></small></font>&nbsp;&nbsp;&nbsp;<span id="nickNameCheck"></span>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<input class="w3-input" type="text" id="nickName" placeholder="${vo.nickName}" style="width: 300px"/>
									</div>
									<div class="w3-cell">
										<input type="button" id="nickNameForm2" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="취소">
									</div>
									<div id="demo3" class="w3-center" style="padding-top: 10px"></div>
									<div class="w3-block w3-center w3-margin-top">
									  	<input type="button" value="닉네임 변경" id="nickNamecheck" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>									
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<div id="nameView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="gray"><small>이름</small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<font size="2px"><b>${vo.name}</b></font>
									</div>
									<div class="w3-cell">
										<input type="button" id="nameForm1" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="변경">
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<div id="nameChangeView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="black"><small><b>이름 변경</b></small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<input class="w3-input" type="text" id="name" placeholder="${vo.name}" style="width: 300px"/>
									</div>
									<div class="w3-cell">
										<input type="button" id="nameForm2" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="취소">
									</div>
									<div id="demo4" class="w3-center" style="padding-top: 10px"></div>
									<div class="w3-block w3-center w3-margin-top">
									  	<input type="button" value="이름 변경" id="namecheck" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>									
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<div id="telView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="gray"><small>전화번호</small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
										<font size="2px"><b>${vo.tel}</b></font>
									</div>
									<div class="w3-cell">
										<input type="button" id="telForm1" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="변경">
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
						</div>
						<div id="telChangeView">
							<div class="w3-cell" style="width: 400px;height: 120px;margin: auto">
								<div class="w3-bar-block" style="margin-top: 0px">
									<font color="black"><small><b>전화번호 변경</b></small></font>
								</div>
								<div class="w3-bar-block">
									<div class="w3-cell" style="width: 400px">
									  <div class="w3-third w3-margin-bottom" style="width: 20%;margin-right: 5%">
									  	<select class="w3-input" name="tel1" id="tel1">
									  		<option value="010" selected="selected">010</option>
									  	</select>
									  </div>
										<div class="w3-third w3-margin-bottom" style="width: 25%;margin-right: 5%">
									  	<input class="w3-input" type="text" name="tel2" id="tel2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
									  </div>
										<div class="w3-third w3-margin-bottom" style="width: 25%;margin-right: 5%">
									  	<input class="w3-input" type="text" name="tel3" id="tel3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
									  </div>
									  <div class="w3-third w3-margin-bottom" style="width: 14%">
									  	<input type="button" id="telForm2" class="w3-button w3-ripple w3-small w3-hover-white w3-round-large w3-border" value="취소">
									  </div>
									</div>
									<div id="demo4" class="w3-center" style="padding-top: 10px"></div>
									<div class="w3-block w3-center w3-margin-top">
									  	<input type="button" value="전화번호 변경" id="telcheck" class="w3-button w3-small w3-block w3-border w3-blue-grey w3-hover-light-grey w3-round-large"/>									
									</div>
									<hr style="border-width: 1px;border-color: gary">
								</div>
							</div>
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
