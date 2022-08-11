<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
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
</style>
<script>
'use strict';
$(function(){
	$('.slider').slick({
			slide: 'div',
		  dots: true, //페이지 네비게이션
		  arrows:true, // next, prev 이동 버튼
		  autoplay: true, // 자동 넘김 여부
		  infinite: true, //반복설정
		  speed: 400, //슬라이드 속도
		  autoplaySpeed : 3000,   // 자동 넘김시 슬라이드 시간
		  pauseOnHover : false,// 마우스 hover시 슬라이드 멈춤
		  vertical : false,  // 세로 방향 슬라이드 옵션
		  prevArrow : "<button type='button' class='slick-prev'>Previous</button>",        
		  nextArrow : "<button type='button' class='slick-next'>Next</button>", //화살표 커스텀
		  slidesToShow: 1, //보여질 슬라이드 수
		  slidesToScroll: 1 //넘겨질 슬라이드 수
		  
		});
	})
</script>
<div class="slider" style="margin-top: 100px">

	<div>
  <img src="${ctp}/logo/q1.PNG" style="width:100%;height: 100%">
	</div>


	<div>
  <img src="${ctp}/logo/q2.PNG" style="width:100%;height: 100%">
	</div>

	<div>
  <img src="${ctp}/logo/q3.PNG" style="width:100%;height: 100%">
	</div>
	<div>
  <img src="${ctp}/logo/q4.PNG" style="width:100%;height: 100%">
  </div>	
</div>
<br>
