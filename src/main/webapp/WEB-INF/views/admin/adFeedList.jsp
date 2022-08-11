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
			    <h4><b>FEED 리스트</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 700px">
			    		<table class="w3-table w3-centered w3-theme-l4 w3-round-large">
			    			<tr>
			    				<th style="width: 10%">번호</th>
			    				<th style="width: 20%">작성날짜</th>
			    				<th style="width: 10%">작성자</th>
			    				<th style="width: 30%">내용</th>
			    				<th style="width: 15%">상세보기</th>
			    				<th style="width: 15%">상태</th>
			    			</tr>
			    		</table>
							<ul class="w3-ul w3-round-large w3-margin-top">
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<li class="w3-bar w3-center w3-border-bottom">
									<div class="w3-bar-item" style="width: 10%">
										<span class="w3-center-align">${vo.boIdx}</span>
										<%-- <img class="card-img-top w3-border w3-round-large" src="${ctp}/brand/${brvo.brfName}" alt="Card image" style="width: 50px;height: 50px"> --%>
									</div>
									<div class="w3-bar-item" style="width: 20%">
										<span class="w3-center-align">${vo.bo_date}</span>
									</div>
									<div class="w3-bar-item" style="width: 10%">
										<span class="w3-center-align">${vo.mid}</span>
									</div>
									<div class="w3-bar-item" style="width: 30%">
										<span class="w3-center-align">${vo.bo_content}</span>
									</div> 
									<div class="w3-bar-item" style="width: 15%">
										<span class="w3-center-align">
										<a href="javascript:feed(${vo.boIdx})" class="w3-button w3-border w3-round w3-small">내용보기</a>
										</span>
									</div>
									<div class="w3-bar-item" style="width: 15%">
									<c:if test="${vo.bo_val == 0}">
									<span class="w3-center-align">-</span>
									</c:if>
									<c:if test="${vo.bo_val == 1}">
									<span class="w3-center-align">[블라인드 게시물]</span>
									</c:if>
									<c:if test="${vo.bo_val == 99}">
									<span class="w3-center-align">[삭제된 게시물]</span>
									</c:if>
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
						  <a href="${ctp}/admin/feedList?pag=1&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.pag == 1}">
						  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.curBlock > 1 }">
						  <a href="${ctp}/admin/feedList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}" class="w3-button">&laquo;</a>
						  </c:if>
						  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
							<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
							<c:forEach var="i" begin="${no}" end="${size}">
								<c:choose>
									<c:when test="${i > pagevo.totPage}"></c:when>
									<c:when test="${i == pagevo.pag}">
										<a href="${ctp}/admin/feedList?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button w3-theme-l4">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="${ctp}/admin/feedList?pag=${i}&pageSize=${pagevo.pageSize}" class="w3-button">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
								<a href="${ctp}/admin/feedList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
							</c:if>
							<c:if test="${pagevo.pag != pagevo.totPage}">
								<a href="${ctp}/admin/feedList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}" class="w3-button w3-xlarge">&raquo;</a>
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
function feed(res){
	let boIdx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/admin/getAdUserContent",
		data : {
			boIdx : boIdx
		},
		success : function(vo){
			let imgs = vo.bo_fName.split('/');
			let img = "";
			for(let i = 0; i<imgs.length-1; i++){
				img += '<div>';
				img += '<img class="card-img-top w3-round-large" src="${ctp}/board/'+imgs[i]+'" alt="Card image" style="width: 700px;background-color: #EBF0F5">';
				img += '</div>';
			}
			let con = '';
			if(vo.bo_val == 99){
				con = '<font color="red">[ 삭제된 게시물입니다 ]</font>'
			}
			else if(vo.bo_val == 1){
				con += '<font color="gray">[ 블라인드된 게시물입니다 ]</font><br><br>'
				con += ' <a href="javascript:del('+vo.boIdx+')" class="w3-button w3-round w3-small w3-red">삭제</a>';
			}
			else{
				con += '<a href="javascript:bline('+vo.boIdx+')" class="w3-button w3-round w3-small w3-black"><i class="fa fa-low-vision" aria-hidden="true"></i> 블라인드</a>';
				con += ' <a href="javascript:del('+vo.boIdx+')" class="w3-button w3-round w3-small w3-red">삭제</a>';
			}
				
			$("#control").html(con);
			$("#photo").attr("src", '${ctp}/member/'+vo.photo);
			$("#reCnt").html(vo.reCnt);
			$("#bo_likeCnt").html(vo.bo_likeCnt);
			$("#bo_nickname").html(vo.nickName);
			$("#bo_content").html(vo.bo_content);
			$("#bo_tag").html(vo.bo_tag);
			$(".slider").html(img);
			$('html, body').css({'overflow': 'hidden'});
			$("#id01").css('display','block');
			slick();
		}
	});
}
function bline(res){
	let boIdx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/admin/feedBline",
		data : {
			boIdx : boIdx
		},
		success : function(){
			Swal.fire({
				  position: 'top',
				  icon: 'success',
				  title: '피드 블라인드 처리완료',
				  showConfirmButton: false,
				  timer: 1000
				}).then(function(){
					location.reload();							
				});
		}
	});
}
function del(res){
	let boIdx = res;
	$.ajax({
		type : "post",
		url : "${ctp}/admin/feedDel",
		data : {
			boIdx : boIdx
		},
		success : function(){
			Swal.fire({
				  position: 'top',
				  icon: 'success',
				  title: '피드 삭제 처리완료',
				  showConfirmButton: false,
				  timer: 1000
				}).then(function(){
					location.reload();							
				});
		}
	});
}
function feedClose(){
	$('.slider').slick('unslick');
	$('html, body').css({'overflow': 'auto'});
	$("#id01").css('display','none');
}

</script>
<div id="id01" class="w3-modal" style="padding-top: 50px">
	  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;width:1300px">
	    <span onclick="feedClose()" class="w3-button w3-large w3-display-topright">&times;</span>
			<div class="w3-container">
		    <h4><b>상세 피드</b></h4>
		    <div class="w3-row">
		    	<div class="w3-col m8">
		    		<div class="card" style="width: 700px;margin: auto">
				    <div>
							<div class="slider">					
							</div>	
				    	<div class="card-body w3-left-align">
				      
				      
				      <br>				      
				    </div>
		   		 </div>
		  		</div>
		    	</div>
		    	<div class="w3-col m4">
		    		<div class="w3-container w3-margin-top">
		        	<div class="w3-center" style="width: 200px">
								<img id="photo" class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 0px;margin-right: 7px" src="${ctp}/member/${mvo.photo}">
						   	<span class="w3-left userName" style="font-size: 13px" id="bo_nickname"></span>  	
						  </div><br><br>
						  <p class="card-title"><font color="black" size="3px" id="bo_content"></font></p>
						  <p class="card-text"><font color="blue" size="2px" id="bo_tag"></font>
						  </p><br>
						  <p class="w3-left-align">
			      		<i class="fa fa-heart-o w3-large" aria-hidden="true"></i>
				        <font color="gray" id="bo_likeCnt"></font>
				      	<i class="fa fa-commenting-o w3-large" aria-hidden="true"></i>
				        <font color="gray" id="reCnt"></font>
				      </p>
		        </div>
		        <div class="w3-container" id="control">
		        	
		        </div>
		    	</div>
		    </div>
		    
		   </div>
	  </div>
  </div>
</body>
</html>