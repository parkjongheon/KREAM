<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css">
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css">

<style type="text/css">
.slick-arrow {
        z-index: 10;
        width: 50px;
        height: 50px;
        background: rgba($bk, 0.2);
        border-radius: 50%;
        transition: background 0.5s;
        &:hover {
            background: rgba($pt, 0.9);

            &::before {
                color: rgba($bk, 0.5);
            }
        }
        &::before {
            font-family: 'Line Awesome Free';
            font-weight: 900;
            font-size: 49px;
            transition: all 0.5s;
        }
    }
    
    .slick-prev {
        left: 10px;
				    padding-bottom: 2px;
        &::before {
            content: "\f137";
        }
    }

    .slick-next {
        right: 10px;

        &::before {
            content: "\f138";
        }
    }
    .userName{
    	font-size: 18px;
    	letter-spacing: -.27px;
    	font-weight: 600;
    	font-family: -apple-system,BlinkMacSystemFont,Roboto,AppleSDGothicNeo-Regular,NanumBarunGothic,NanumGothic,나눔고딕,Segoe UI,Helveica,Arial,Malgun Gothic,Dotum,sans-serif;
    }
</style>
<script type="text/javascript">
function slick(){
	$('.slider').slick({
			slide: 'div',
		  dots: true, //페이지 네비게이션
		  arrows:true, // next, prev 이동 버튼
		  autoplay: false, // 자동 넘김 여부
		  infinite: false, //반복설정
		  speed: 300, //슬라이드 속도
		  autoplaySpeed : 10000,   // 자동 넘김시 슬라이드 시간
		  pauseOnHover : true,// 마우스 hover시 슬라이드 멈춤
		  vertical : false,  // 세로 방향 슬라이드 옵션
		  prevArrow : "<button type='button' class='slick-prev'>Previous</button>",        
		  nextArrow : "<button type='button' class='slick-next'>Next</button>", //화살표 커스텀
		  slidesToShow: 1, //보여질 슬라이드 수
		  slidesToScroll: 1 //넘겨질 슬라이드 수
		  
		});	
}

</script>
</head>
<body class="w3-light-grey">
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div class="w3-row">
		<div class="w3-col m12" style="margin-top: 10px;margin-right:10px;">
			<div class="w3-card w3-round w3-white" style="width : 99%;height: 950px">
			   <div class="w3-container" style="height: 850px">
			    <h4><b>신고내역 리스트</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 700px">
			    		<table class="w3-table w3-centered w3-theme-l4 w3-round-large">
			    			<tr>
			    				<th style="width: 10%">신고번호</th>
			    				<th style="width: 20%">신고날짜</th>
			    				<th style="width: 10%">신고자</th>
			    				<th style="width: 10%">신고유형</th>
			    				<th style="width: 30%">내용</th>
			    				<th style="width: 10%">답변여부</th>
			    				<th style="width: 10%">기타</th>
			    			</tr>
			    		</table>
							<ul class="w3-ul w3-round-large w3-margin-top">
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<li class="w3-bar w3-center w3-border-bottom">
									<div class="w3-bar-item" style="width: 10%">
										<span class="w3-center-align">${vo.d_Idx}</span>
										<%-- <img class="card-img-top w3-border w3-round-large" src="${ctp}/brand/${brvo.brfName}" alt="Card image" style="width: 50px;height: 50px"> --%>
									</div>
									<div class="w3-bar-item" style="width: 20%">
										<span class="w3-center-align">${vo.d_decDate}</span>
									</div>
									<div class="w3-bar-item" style="width: 10%">
										<span class="w3-center-align">${vo.mid}</span>
									</div>
									<div class="w3-bar-item" style="width: 10%">
										<span class="w3-center-align">[${vo.d_status}]</span>
									</div> 
									<div class="w3-bar-item" style="width: 30%">
										<span class="w3-center-align">${vo.d_content}</span>
									</div>
									<div class="w3-bar-item" style="width: 10%">
										<c:if test="${empty vo.d_coment}">
										<span class="w3-center-align">❌</span>
										</c:if>
										<c:if test="${not empty vo.d_coment}">
										<span class="w3-center-align">✔</span>
										</c:if>
									</div>
									<div class="w3-bar-item" style="width: 10%">
										<a href="javascript:dec(${vo.d_Idx})" class="w3-button w3-border w3-round w3-small">내용보기</a>
									</div>
								</li>
							</c:forEach>	    
							</ul> 	
						</div>
			   </div>
						<div class="w3-container w3-center" style="margin-top: 10px">
							<div class="w3-bar text-center">
						  <c:if test="${not empty vos}">
						  <c:if test="${pagevo.pag != 1}">
						  <a href="${ctp}/admin/decList?pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.pag == 1}">
						  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.curBlock > 1 }">
						  <a href="${ctp}/admin/decList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
						  </c:if>
						  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
							<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
							<c:forEach var="i" begin="${no}" end="${size}">
								<c:choose>
									<c:when test="${i > pagevo.totPage}"></c:when>
									<c:when test="${i == pagevo.pag}">
										<a href="${ctp}/admin/decList?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-theme-l4">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="${ctp}/admin/decList?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
								<a href="${ctp}/admin/decList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
							</c:if>
							<c:if test="${pagevo.pag != pagevo.totPage}">
								<a href="${ctp}/admin/decList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
							</c:if>
							<c:if test="${pagevo.pag == pagevo.totPage}">
								<a class="w3-button w3-xlarge w3-disabled">&raquo;</a>
							</c:if>
						  </c:if>		
							</div>
						</div>
			 </div>
		</div>
	</div>
</div>
<script type="text/javascript">
function dec(res){
	let d_Idx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/admin/getDeclContent",
		data : {
			d_Idx : d_Idx
		},
		success : function(vo){
			let imgs = vo.bo_fName.split('/');
			let img = "";
			for(let i = 0; i<imgs.length-1; i++){
				img += '<div>';
				img += '<img class="card-img-top w3-round-large" src="${ctp}/board/'+imgs[i]+'" alt="Card image" style="width: 300px;background-color: #EBF0F5">';
				img += '</div>';
			}
			if(vo.d_coment == null){
				$("#demono").show();
			}
			else{
				$("#demotitle").html(vo.d_coment);
				$("#demook").show();
			}
			$("#d_Idx").val(d_Idx);
			$("#boidx").html("<b>게시판 번호</b> : "+vo.boIdx)
			$("#bocontent").html(vo.bo_content);
			$("#d_Idx").html(vo.d_Idx);
			$("#d_memIdx").html(vo.mid);
			$("#d_status").html(vo.d_status);
			$("#d_content").html(vo.d_content);
			$(".slider").html(img);
			$("#id01").css('display','block');
			slick();
		}
	});
}
function decClose(){
	$('.slider').slick('unslick');
	$("#d_Idx").val("");
	$("#id01").css('display','none');
}
function decOk(){
	let d_Idx = $("#d_Idx").val();
	let d_coment = $("#d_coment").val();
	
	$.ajax({
		type : "post",
		url : "${ctp}/admin/decOk",
		data : {
			d_Idx : d_Idx,
			d_coment : d_coment
		},
		success : function(){
			Swal.fire({
				  position: 'top',
				  icon: 'success',
				  title: '답변 작성 완료.',
				  showConfirmButton: false,
				  timer: 1000
				}).then(function(){
					location.reload();							
				});
		}
	});
}
</script>
<div id="id01" class="w3-modal">
	  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;width:1000px">
	    <span onclick="decClose()" class="w3-button w3-large w3-display-topright">&times;</span>
			<div class="w3-container">
		    <h4><b>신고 내역</b></h4>
		    <div class="w3-row w3-margin-bottom">
		    	<div class="w3-col m5 w3-border w3-round" style="padding-left: 45px;padding-top: 20px">
			    	<div class="slider" style="width: 300px">
			    					
						</div>
						<div class="w3-center" style="width: 300px">
						
						<p id="boidx"></p>
						<p><b>글내용 : </b></p>
						<p id="bocontent"></p>	
						</div>		    	
		    	</div>
		    	<div class="w3-col m7">
			    	<div class="w3-container">
			    		<table class="w3-table w3-centered w3-border w3-bordered">
			    			<tr>
			    				<th class="w3-light-gray" style="width: 50%">신고번호</th>
			    				<td style="width: 50%" id="d_Idx"></td>
			    			</tr>
			    			<tr>
			    				<th class="w3-light-gray">신고자 아이디</th>
			    				<td id="d_memIdx"></td>
			    			</tr>
			    			<tr>
			    				<th class="w3-light-gray">신고종류</th>
			    				<td id="d_status"></td>
			    			</tr>
			    			<tr>
			    				<th class="w3-light-gray" colspan="2">신고내용</th>
			    			</tr>
			    			<tr>
			    				<td colspan="2" id="d_content"></td>
			    			</tr>
			    		</table>
			    	</div>
			    	<div id="demook" class="w3-container" style="display: none">
			    		<table class="w3-table w3-centered w3-border w3-bordered">
			    			<tr>
			    				<th class="w3-light-gray">답변내용</th>
			    			</tr>
			    			<tr>
			    				<td id="demotitle"></td>
			    			</tr>
			    		</table>
			    	</div>
			    	<div id="demono" style="display: none">
			    		<div class="w3-container w3-margin-top">
			    			<textarea class="w3-input w3-border w3-round" id="d_coment" rows="6" cols="30" style="resize: none" placeholder="신고자에게 답변해주세요"></textarea>
			    		</div>
			    		<div class="w3-container w3-margin-top w3-center">
			    			<input type="hidden" id="d_Idx">
			    			<a class="w3-button w3-black w3-round" href="javascript:decOk()">신고 접수</a>
			    		</div>
			    	</div>
		    	</div>
		    </div>
		   </div>
	  </div>
  </div>
</body>
</html>