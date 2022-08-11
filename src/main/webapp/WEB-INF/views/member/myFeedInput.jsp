<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style type="text/css">
.notification {
 /*  padding: 15px 26px; */
  position: relative;
  display: inline-block;
  margin-right: 15px;
}
.notification .badge {
	height : 30px;
	width : 30px;
  position: absolute;
  top: -15px;
  right: -15px;
  padding: 2px 5px;
  border-radius: 50%;
  background-color: gray;
  color: white;
}
.tag {
  padding: 4px 15px 4px 20px;
  position: relative;
  display: inline-block;
  margin-right: 15px;
}
.card{
	position: relative;
  display: inline-block;
  margin-right: 15px;
}
.card .badges {
  height : 30px;
	width : 30px;
  position: absolute;
  top: -15px;
  right: -15px;
  padding: 2px 5px;
  border-radius: 50%;
  background-color: gray;
  color: white;
}
/* .tag .tagbadge {
	height : 30px;
	width : 30px;
  position: absolute;
  top: -15px;
  right: -15px;
  padding: 2px 5px;
  border-radius: 50%;
  background-color: gray;
  color: white;
} */
</style>
<script type="text/javascript">
	'use strict';
	

	let cnt = 1;
	function hiddenFile(no){
	  let file = '';
	  file += '<input type="file" name="file" id="fName'+no+'"/>';
	  return file;	
	}
	
	function addFile(no){
		 $('#imgHidden').append(hiddenFile(no));
		 $('#fName' + no).click();
		 $('#fName' + no).on('change', function(){
			 readURL(this);
			 function readURL(input) {
				   if (input.files && input.files[0]) {
				       var reader = new FileReader();
				       reader.onload = function (e) {
				    	  $("#imgBox").append('<div class="notification" id="notifi'+no+'"><img class="w3-border w3-round-large" src="" style="width:100px;height: 100px" id="view'+no+'" alt="미리보기"/><a href="javascript:delImage('+no+')"><span class="badge">x</span></a></div>');
				       	$("#view"+no).attr('src', e.target.result);			
				       }
				       reader.readAsDataURL(input.files[0]);
				       cnt = cnt + 1;
					    }
					}
		 });
	}
	$(function() {
		$("#addfile").on('click',function(){
			/* for(let i =0; i < $('input[name="file"]').length; i++){
				
			} */
			//let files = $('input[name="file"]')[0].files.length;
			let imgcnt = $('input[name="file"]').length - 1;
			
			if(imgcnt > 4){
				alert("추가 이미지는 최대 5개까지 가능합니다");
				return;
			}
			else{
			addFile(cnt);				
			}
		});
	});
	function delImage(res){
		$("#fName"+res).remove();
		$("#notifi"+res).remove();

	}
	$(function() {
	    $("#contentImg").on('change', function(){
	    readURL(this);
	    });
	});
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	        $('#noimage').hide();
	        $('#view').css('display', 'block');
	        $('#view').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	let tagCnt = 1;
	$(function(){
		$("#tagInput").on('click', function(){
			$("#demo").html('');
			let key = $("#tagName").val();
			let tagCheck = 0;
			for(let i =0; i < $('input[name="tagH"]').length+1; i++){
				let tagH = $('input[name="tagH"]').eq(i).val();
				if(tagH == key){
					tagCheck = 1;
				}
			}
			if(tagCheck == 1){
				$("#demo").html('<font color="red">태그가 중복됩니다.</font>');
				$("#tagName").val("");
			}
			else if(key == ""){
				$("#demo").html('<font color="red">태그를 입력해주세요</font>');
				$("#tagName").val("");
			}
			else{
				inputTag();	
			}
		});
		$("#tagName").on('keyup',function(key){
			if(key.keyCode == 13){
				let keys = $("#tagName").val();
				let tagCheck = 0;
				for(let i =0; i < $('input[name="tagH"]').length+1; i++){
					let tagH = $('input[name="tagH"]').eq(i).val();
					if(tagH == keys){
						tagCheck = 1;
					}
				}
				if(tagCheck == 1){
					$("#demo").html('<font color="red">태그가 중복됩니다.</font>');
					$("#tagName").val("");
				}
				else if(keys == ""){
					$("#demo").html('<font color="red">태그를 입력해주세요.</font>');
					$("#tagName").val("");
				}
				else{
					inputTag();	
				}
			}
		});
	})
	function inputTag(){
		let tagName = $("#tagName").val();
		let tagHidden = $("#hiddenTag").val();
		let hidden = tagHidden + '#'+tagName;
		let data = "<div class='tag w3-light-gray w3-round-large' id='tagItem"+tagCnt+"' style='margin-bottom : 5px'><span><b><font color='gray'>#"+tagName+"</font></b></span><a style='margin-left : 10px' href='javascript:deltag("+tagCnt+")'><i class='fa fa-times' aria-hidden='true'></i></a>";
				data += '<input type="hidden" name="tagH" id="tagH'+tagCnt+'" value="'+tagName+'"></div>';
		$("#tagBox").append(data);
		$("#hiddenTag").val(hidden);
		$("#tagName").val("");
		tagCnt = tagCnt + 1;
	}
	function deltag(no){
		let tagH = $("#tagH"+no).val();
		let hidden = '#'+tagH;
		let tagHidden = $("#hiddenTag").val();
		let intag = tagHidden.replace(hidden,"");
		
		$("#hiddenTag").val(intag);
		$("#tagItem"+no).remove();
	}
	$(function (){
		$("#searchItem").on('keyup',function(){
			let key = $("#searchItem").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/mem/searchProduct",
				data : {
					key : key
				},
				success : function(vos){
					let data = '<ul class="w3-ul w3-round-large w3-margin-top">';
					for(let i = 0; i<vos.length; i++){
						data +='<li class="w3-bar w3-center">';
						data +='<div class="w3-bar-item" style="width: 10%;margin-right: 3%">';
						data +='<img class="card-img-top w3-round-large" src="${ctp}/product/'+vos[i].prdfName+'" alt="Card image" style="width: 50px;height: 50px;background-color: #EBF0F5">';
						data +='</div>';
						data +='<div class="w3-bar-item" style="width: 66%">';
						data +='<span class="w3-small w3-left">'+vos[i].eprdName+'</span><br>';
						data +='<span class="w3-small w3-left">'+vos[i].kprdName+'</span>';
						data +='</div>';
						data +='<div class="w3-bar-item" style="width: 20%">';
						data +='<a href="javascript:chooseItem('+vos[i].prdIdx+')" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">선택</a>';
						data +='</div>';
						data +='</li>';
					}
					data += '</ul>';
					$("#searchItemTag").html(data);
				}
			});
		});
	})
	function chooseItem(res){
		let prdIdx = res;
		$('#id01').css('display','none');
		//document.getElementById('id01').style.display='none';
		$.ajax({
			type : "post",
			url : "${ctp}/mem/chooseItem",
			data : {
				prdIdx : prdIdx
			},
			success : function(vo){
				let data = '<div class="card w3-left" id="prdTagItem" style="height: 250px;width: 150px;margin-right: 20px;margin-bottom:10px">';
						data +='<a href="javascript:delPrdTage()"><span class="badges">x</span></a>';
						data +='<img class="card-img-top w3-round-large" src="${ctp}/product/'+vo.prdfName+'" alt="Card image" style="width: 150px;height: 150px;background-color: #EBF0F5">';
						data +='<div class="card-body w3-left-align">';
						data +='<h4 class="card-title"><font color="black" size="2px"><b>'+vo.ebrName+'</b></font></h4>';
						data +='<p class="card-text" style="padding-top: 0px"><font color="black" size="2px">'+vo.eprdName+'</font><br>';
						data +='<font color="gray" size="2px">'+vo.kprdName+'</font></p>';
						data +='<input type="hidden" id="prdTag" name="bo_prdIdx" value="'+vo.prdIdx+'">';
						data +='</div>';
						data +='</div>';
				$("#prdTagbox").html(data);
			}
		});
	}
	function delPrdTage(){
		$("#prdTagItem").remove();
	}
	function inputCheck(){
		let fName = $('#contentImg').val();
		let bo_content = $('#bo_content').val();
		if(fName == ""){
			alert("사진을 등록해주세요.");
		}
		else if(bo_content == ""){
			alert('내용을 작성해주세요.');
		}
		else{
		myForm.submit();			
		}
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;margin-top:100px">
	<div class="w3-container" style="width:100%;height: 100%;margin-bottom: 50px">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-animate-opacity w3-center" style="height: 100%;width: 1400px">
				<hr>
				<form name="myForm" method="post" action="${ctp}/mem/myFeedInput" onsubmit="return false" enctype="multipart/form-data">
				<div class="w3-container" style="width: 1400px">
					<div class="w3-row" >
						<div class="w3-col m6">
							<div class="w3-row w3-right w3-margin-bottom" style="width:640px">
								<div class="w3-col m10 w3-left-align">
								<h5><b>대표사진을 등록해주세요</b></h5>
								</div>
								<div class="w3-col m2">
								<label for="contentImg" class="w3-button w3-ripple w3-hover-white "><i class="fa fa-plus" aria-hidden="true"></i></label>
								<input type="file" name="file" id="contentImg" style="display: none">
								</div>
							</div>
							<div class="w3-right" style="width: 600px;height: 700px;margin-right: 40px;padding: 0px">
								<div id="noimage" class="w3-border w3-round-large" style="width: 600px;height: 700px;padding-top: 300px">
									<div class="w3-center">
									<i class="fa fa-camera" aria-hidden="true"></i><br>
									<h5>사진을 등록해주세요</h5>
									</div>
								</div>
					  		<img class="w3-border w3-round-large" src="${ctp}/member/noimage1.jpg" style="width: 600px;height: 700px;display: none"  id="view" alt="미리보기"/>
							</div>
							<div class="w3-row w3-margin-top w3-right" style="width:640px">
								<div class="w3-col m10 w3-left-align">
								<h5><b>추가 이미지를 등록해보세요</b><small>(최대 5개)</small></h5>
								</div>
								<div class="w3-col m2">
								<a id="addfile" class="w3-button w3-ripple w3-hover-white"><i class="fa fa-plus" aria-hidden="true"></i></a>
								</div>
							</div>
							<div id="imgBox" class="w3-margin-top w3-right" style="width:600px;height: 100px;margin-right: 40px;border-color: gray">
					  		
							</div>

							<div id="imgHidden" style="display: none">
							
							</div>
						</div>
						<div class="w3-col m6">
							<ul class="w3-ul">
								<li class="w3-bar" style="width: 100%">
							    <img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px" src="${ctp}/member/${vo.photo}">
								<div class="w3-bar-item w3-left">
						    <span class="w3-large"><B>${vo.nickName }</B></span>
						 	 	</div>
								</li>
							</ul>
							<textarea class="w3-border w3-padding w3-round-large" rows="8" cols="70" style="resize: none" id="bo_content" name="bo_content" placeholder="회원님의 사진을 표현해 보세요"></textarea>
							<div class="w3-row">
								<div class="w3-col m6">
									<p class="w3-left-align"><b># 태그</b></p>
									<div>
										<input type="text" class="w3-input w3-border w3-round-large" id="tagName" style="width: 250px;display: inline-block;">
										<input type="button" class="w3-button w3-border w3-round-large" id="tagInput" value="등록">
									</div>
									<div id="demo" style="height: 30px"></div>
								</div>
								<div class="w3-col m6">
									
								</div>
							</div>
							<div class="w3-row" style="height: 100px">
								<div class="w3-col">
									<div class="w3-left" id="tagBox">
									</div>
									<input type="hidden" class="w3-input" id="hiddenTag" name="bo_tag">
								</div>
							</div>
							<div class="w3-row">
								<div class="w3-col">
								<p class="w3-left-align"><b># 상품태그</b></p>
								<input type="button" onclick="document.getElementById('id01').style.display='block'" class="w3-button w3-border w3-round w3-left" value="상품 검색하기">
								</div>
							</div>
							<div class="w3-row w3-margin-top">
								<div class="w3-col" id="prdTagbox">
									
								</div>
								
							</div>
						</div>
					</div>
				</div>
				</form>
				<hr>
				<div class="w3-center">
					<a href="javascript:inputCheck()" class="w3-button w3-border">등록하기</a>
				</div>
			</div>
		</div>
	</div>
	<div id="id01" class="w3-modal">
	  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;width:600px;height: 700px">
	    <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
			<div class="w3-row" style="margin-top: 100px;height: 50px">
				<div class="w3-col">
					<input type="text" id="searchItem" class="w3-input w3-center w3-border w3-round-large" style="width: 300px;margin: auto" placeholder="상품을 검색해주세요">				
				</div>
			</div>
			<div class="w3-row" style="margin-top: 20px">
				<div class="w3-col" id="searchItemTag">
				</div>
			</div>
	  </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
