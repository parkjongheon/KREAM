<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- Navbar -->
<style>
.badge {
	font-family: Arial, Helvetica, sans-serif;
  background-color: gray;
  color: white;
  padding: 4px 8px;
  text-align: center;
  border-radius: 45px;
}
.tag{
    padding: 8px 10px;
    border: 1px solid #ebebeb;
    border-radius: 12px;
    font-size: 15px;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    font-family: -apple-system,BlinkMacSystemFont,Roboto,AppleSDGothicNeo-Regular,NanumBarunGothic,NanumGothic,나눔고딕,Segoe UI,Helveica,Arial,Malgun Gothic,Dotum,sans-serif;
}
input::placeholder {color:gray;font-size: 15px}
</style>
<script>
	$(document).ready(function(){
		$.ajax({
			type : "post",
			url : "${ctp}/msgBoxCnt",
			success : function(res){
				if(res == 0){
					$("#msgcnt").css('display','none');
				}
				else{
					$("#msgcnt").html(res);
					
				}
			}
		});
	});
	function msgOpen(){
		$('html, body').css({'overflow': 'hidden'});
		$('#id01').css({'overflow': 'hidden'});
		$.ajax({
			type : "post",
			url : "${ctp}/msg/getUserMsgList",
			success : function(vos){
				let data = "";
				for(let i =0; i<vos.length; i++){
					data +='<ul class="w3-ul w3-border w3-round-large w3-margin-top">';
					data +='<li class="w3-bar w3-center" style="padding:3px 0px">';
					data +='<div class="w3-bar-item" style="width: 100%;padding-left:10px">';
					data +='<span class="w3-left userName" style="font-size: 13px">'+vos[i].msg_content+'</span><br>';
					data +='<span class="w3-left userName w3-tiny" style="width:50px;font-size: 13px;color:gray">';
					data +='<a href="javascript:msgRead('+vos[i].msgIdx+')">읽음</a>';
					data +='</span>';
					data +='<span class="w3-left userName w3-tiny" style="font-size: 13px;color:gray">';
					data +='<a href="javascript:msgGoUrl('+vos[i].msgIdx+')">보기</a>';
					data +='</span>';
					data +='</div>';
					data +='</li>';
					data +='</ul>';
				}
				$("#msgTitle").html("새로운 알림 "+vos.length+"개");
				$("#msgbox").html(data);
			}
		});
		$("#msgModal").css('display','block');
	}
	function msgRead(res){
		let msgIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/msg/msgRead",
			data : {
				msgIdx : msgIdx
			},
			success : function(){
				msgOpen();
			}
		});
	}
	function msgGoUrl(res){
		let msgIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/msg/msgGoUrl",
			data : {
				msgIdx : msgIdx
			},
			success : function(url){
				location.href="${ctp}"+url;
			}
		});
	}
	function msgModalClose(){
		$.ajax({
			type : "post",
			url : "${ctp}/msgBoxCnt",
			success : function(res){
				if(res == 0){
					$("#msgcnt").css('display','none');
				}
				else{
					$("#msgcnt").html(res);
				}
				$('html, body').css({'overflow': 'auto'});
				$('.w3-content').css('max-height','5000px');
				$("#msgModal").css('display','none');
			}
		});
	}
	function search(){
		$('html, body').css({'overflow': 'hidden'});
		$("#searchModal").css('display','block');
	}
	function searchModalClose(){
		$('html, body').css({'overflow': 'auto'});
		$("#searchModal").css('display','none');
	}
	$(function(){
		$("#searchbar").on('keyup',function(){
			let search = $("#searchbar").val();
			if(search.charAt(0)=='#'){
				tag(search.substring(1));
			}
			else if(search.charAt(0)=='@'){
				mem(search.substring(1));
			}
			else if(search.trim() == ""){
				$("#searchbox").html("");
			}
			else{
				prd(search);
			}
		});
	})
	function tag(str){
		$.ajax({
			type : "post",
			url : "${ctp}/board/tagSearch",
			data : {
				tags :str
			},
			success : function(vos){
				let data = '';
				for(let i = 0; i<vos.length; i++){
					data +='<ul class="w3-ul w3-round-large w3-margin-top">';
					data +='<li class="w3-bar w3-center">';
					data +='<div class="w3-bar-item" style="width: 50%;margin-right: 3%">';
					data +='<span class="w3-left userName" style="font-size: 13px">#'+vos[i].tagName+'</span><br>';
					data +='</div>';
					data +='<div class="w3-bar-item" style="width: 26%">';
					let bcnt = vos[i].tagCnt + 1;
					data +='<span class="w3-left userName" style="font-size: 13px;color:gray"> 게시물수 '+bcnt+'</span>';
					data +='</div>';
					data +='<div class="w3-bar-item" style="width: 20%">';
					data +='<a href="${ctp}/board/feedTag?pag=1&pageSize=16&tags='+vos[i].tagName+'" class="w3-button w3-border w3-round w3-small">선택</a>';
					data +='</div>';
					data +='</li>';
					data +='</ul>';
				}
				$("#searchbox").html(data);
			}
		});
	}
	function mem(str){
		$.ajax({
			type : "post",
			url : "${ctp}/board/userSearch",
			data : {
				userSearch :str
			},
			success : function(vos){
				let data = '';
				for(let i = 0; i<vos.length; i++){
					data +='<ul class="w3-ul w3-round-large w3-margin-top">';
					data +='<li class="w3-bar w3-center">';
					data +='<div class="w3-bar-item" style="width: 10%;margin-right: 3%">';
					data +='<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 0px;margin-right: 7px" src="${ctp}/member/'+vos[i].photo+'">';
					data +='</div>';
					data +='<div class="w3-bar-item" style="width: 66%">';
					data +='<span class="w3-left userName" style="font-size: 13px">'+vos[i].nickName+'</span><br>';
					data +='<span class="w3-left userName" style="font-size: 13px;color:gray">'+vos[i].mid+'</span>';
					data +='</div>';
					data +='<div class="w3-bar-item" style="width: 20%">';
					data +='<a href="${ctp}/board/userFeed?memIdx='+vos[i].idx+'" class="w3-button w3-border w3-round w3-small">선택</a>';
					data +='</div>';
					data +='</li>';
					data +='</ul>';
				}
				$("#searchbox").html(data);
			}
		});
	}
	function prd(str){
		$.ajax({
			type : "post",
			url : "${ctp}/mem/searchProduct",
			data : {
				key : str
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
					data +='<a href="${ctp}/product/productInfo?prdIdx='+vos[i].prdIdx+'" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">선택</a>';
					data +='</div>';
					data +='</li>';
				}
				data += '</ul>';
				$("#searchbox").html(data);
			}
		});
	}
</script>
<div class="w3-top" style="">
  <div class="w3-bar w3-white w3-small">
  	<c:if test="${empty sMid}">
	    <a href="${ctp}/log/login" class="w3-bar-item w3-padding-large w3-right">로그인</a>
  	</c:if>
  	<c:if test="${not empty sMid}">
	    <a href="${ctp}/log/logout" class="w3-bar-item w3-padding-large w3-right">로그아웃</a>
	    <c:if test="${sGrade == 0}">
	  		<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-padding-large w3-right">관리자페이지</a>
	    </c:if>
  	</c:if>
  	<a href="${ctp}/mem/myPage" class="w3-bar-item w3-padding-large w3-right">마이페이지</a>
  	<c:if test="${not empty sMid}">
  	<a href="${ctp}/board/userFeed?memIdx=${sIdx}" class="w3-bar-item w3-padding-large w3-right">내 피드</a>
  	</c:if>
  	<a href="${ctp}/product/productCartPage" class="w3-bar-item w3-padding-large w3-right">장바구니</a>
  	<a href="#" class="w3-bar-item w3-padding-large w3-right">고객센터</a>
  </div>
  <div class="w3-bar w3-white w3-border-top w3-large">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
  	
  	<a href="${ctp}/" class="w3-bar-item w3-padding-large w3-left"><img alt="" src="${ctp}/logo/logo1.png" ></a>
    <c:if test="${not empty sMid}">
    <a href="javascript:msgOpen()" class="w3-padding-large w3-hide-small w3-right"><i class="fa fa-bell"></i><span id="msgcnt" class="badge w3-tiny"></span></a>
  	 </c:if>
    <a href="javascript:search()" class="w3-padding-large w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  	<a href="${ctp}/board/feedAll" class="w3-bar-item w3-padding-large w3-right">FEED</a>
  	<a href="${ctp}/product/productMain?pag=1&pageSize=16&sort=desc" class="w3-bar-item w3-padding-large w3-right">SHOP</a>
  </div>
</div>
<div id="msgModal" class="w3-modal" style="z-index: 40">
    <div class="w3-modal-content" style="width: 400px;height:500px;margin-right: 0px">
      <div class="w3-container">
        <span onclick="msgModalClose()" class="w3-button w3-hover-white w3-display-topright">&times;</span>
        <h3 id="msgTitle" style="text-align: center">알림</h3>        
				<hr>
				<div id="msgbox" class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 390px">
					
				</div>
      </div>
    </div>
  </div>
<div id="searchModal" class="w3-modal" style="z-index: 200;padding-top: 0px">
    <div class="w3-modal-content" style="width: 1400px;height:950px;margin-top: 0px">
        <span onclick="searchModalClose()" class="w3-button w3-hover-white w3-display-topright">&times;</span>
      <div class="w3-container" style="width: 700px;margin-left: 25%;padding-top: 50px">
      	<div class="w3-center">
      	<c:forEach var="tvo" items="${tvos}">
					<a href="${ctp}/board/feedTag?pag=1&pageSize=16&tags=${tvo.tagName}" class="w3-button w3-white w3-hover-white w3-round-large tag w3-margin-left w3-margin-bottom">#${tvo.tagName }</a>
				</c:forEach>
      	</div>
        <input type="text" class="w3-input w3-xlarge" id="searchbar" placeholder="# : 태그검색 , @ : 사람검색 , 기본 : 상품검색">
				<div id="searchbox" class="w3-margin-top" style="padding: 0px;overflow-y:auto;height: 600px">
					
				</div>
      </div>
    </div>
  </div>
<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
</div>
<script>
// Automatic Slideshow - change image every 4 seconds
var myIndex = 0;


// Used to toggle the menu on small screens when clicking on the menu button
function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>