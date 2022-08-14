<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />

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
    .box-sold {
	position: relative;
}
.img_box_sold > img {
	display: block;
    width: 11em;
    height: 11em;
}
.img_box_sold {
	filter: brightness(50%);
}
.text-sold {
	padding: 10px 20px;
	text-align: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
<script>
'use strict';

$(function(){
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
	})
	let nick = '${sMid}';
	
	function reply(res){
		let idx = res;
		$('html, body').css({'overflow': 'hidden'});
		$('#id01').css({'overflow': 'hidden'});
		$("#id01").css('display','block');
		$("#boRe_boIdx").val(idx);
		$.ajax({
			type : "post",
			url : "${ctp}/board/getReplyList",
			data : {
				boRe_boIdx : idx
			},
			success : function(vos){
				let data = "";
				for(let i = 0; i<vos.length; i++){
					if(vos[i].boRe_index == 0){
						data +='<div class="w3-row" style="width: 100%;height: 50px">';
						data +='<div class="w3-col m1">';
						data +='<a href="${ctp}/board/userFeed?memIdx='+vos[i].idx+'">';
						data +='<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 10px" src="${ctp}/member/'+vos[i].photo+'">';
						data +='</a>';
						data +='</div>';
						data +='<div class="w3-col m2">';
						data +='<a>';
						data +='<span class="w3-left userName " style="font-size: 13px">'+vos[i].nickName+'</span><br>';
						data +='<span class="w3-left" style="font-size: 11px;color: gray">'+vos[i].strBoRe_date+'</span>';
						data +='</a>';
						data +='</div>';
						data +='<div class="w3-col m9">';
						if(vos[i].boRe_val == 99){
							data +='<span class="w3-left" style="font-size: 15px;color:gray">삭제된 댓글입니다.</span><br>';
						}
						else if(vos[i].boRe_forMem == ""){
							data +='<span class="w3-left" style="font-size: 13px">'+vos[i].boRe_coment+'</span><br>';							
						}
						else{
							data +='<span class="w3-left" style="font-size: 13px"><a href="${ctp}/board/userFeed?memIdx='+vos[i].boRe_forMemIdx+'"><font color="blue"><b>@'+vos[i].boRe_forMem+'</b></font></a>&nbsp;'+vos[i].boRe_coment+'</span><br>';
						}
						if(vos[i].boRe_val != 99){
							data +='<span class="w3-left" style="font-size: 11px;color:gray"><a href="javascript:rereply(1,'+vos[i].boRe_boReIdx+','+vos[i].boRe_memIdx+')">답글 쓰기</a>';
							data +='</span>';	
							if(vos[i].mid == nick){
								data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyDelete('+vos[i].boReIdx+')">&nbsp;삭제&nbsp;</a>';
								data +='</span>';	
								data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyUpdate('+vos[i].boReIdx+')">&nbsp;수정&nbsp;</a>';
								data +='</span>';	
							}
						}
						data +='</div>';
						data +='</div>';
					}
					else if(vos[i].boRe_index == 1){
						data +='<div class="w3-row" style="width: 100%;height: 50px">';
						data +='<div class="w3-col m1">';
						data +='&nbsp';
						data +='</div>';
						data +='<div class="w3-col m1">';
						data +='<a href="${ctp}/board/userFeed?memIdx='+vos[i].idx+'">';
						data +='<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 10px" src="${ctp}/member/'+vos[i].photo+'">';
						data +='</a>';
						data +='</div>';
						data +='<div class="w3-col m2">';
						data +='<a>';
						data +='<span class="w3-left userName " style="font-size: 13px">'+vos[i].nickName+'</span><br>';
						data +='<span class="w3-left" style="font-size: 11px;color: gray">'+vos[i].strBoRe_date+'</span>';
						data +='</a>';
						data +='</div>';
						data +='<div class="w3-col m8">';
						if(vos[i].boRe_val == 99){
							data +='<span class="w3-left" style="font-size: 15px;color:gray">삭제된 댓글입니다.</span><br>';
						}
						else if(vos[i].boRe_forMem == ""){
							data +='<span class="w3-left" style="font-size: 13px">'+vos[i].boRe_coment+'</span><br>';							
						}
						else{
							data +='<span class="w3-left" style="font-size: 13px"><a href="${ctp}/board/userFeed?memIdx='+vos[i].boRe_forMemIdx+'"><font color="blue"><b>@'+vos[i].boRe_forMem+'</b></font></a>&nbsp;'+vos[i].boRe_coment+'</span><br>';
						}
						if(vos[i].boRe_val != 99){
							data +='<span class="w3-left" style="font-size: 11px;color:gray"><a href="javascript:rereply(1,'+vos[i].boRe_boReIdx+','+vos[i].boRe_memIdx+')">답글 쓰기</a>';
							data +='</span>';	
							if(vos[i].mid == nick){
								data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyDelete('+vos[i].boReIdx+')">&nbsp;삭제&nbsp;</a>';
								data +='</span>';	
								data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyUpdate('+vos[i].boReIdx+')">&nbsp;수정&nbsp;</a>';
								data +='</span>';	
							}
						}
						data +='</div>';
						data +='</div>';
					}
					else if(vos[i].boRe_index == 2){
						data +='<div class="w3-row" style="width: 100%;height: 50px">';
						data +='<div class="w3-col m1">';
						data +='&nbsp';
						data +='</div>';
						data +='<div class="w3-col m1">';
						data +='&nbsp';
						data +='</div>';
						data +='<div class="w3-col m1">';
						data +='<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 10px" src="${ctp}/member/'+vos[i].photo+'">';
						data +='</div>';
						data +='<div class="w3-col m2">';
						data +='<a>';
						data +='<span class="w3-left userName " style="font-size: 13px">'+vos[i].nickName+'</span><br>';
						data +='<span class="w3-left" style="font-size: 11px;color: gray">'+vos[i].strBoRe_date+'</span>';
						data +='</a>';
						data +='</div>';
						data +='<div class="w3-col m7">';
						data +='<span class="w3-left" style="font-size: 13px"><b>@'+vos[i].boRe_forMem+'</b>&nbsp;'+vos[i].boRe_coment+'</span><br>';
						data +='<span class="w3-left" style="font-size: 11px;color:gray"><a href="javascript:rereply(1,'+vos[i].boRe_boReIdx+','+vos[i].boRe_memIdx+')">답글 쓰기</a></span>';	
						if(vos[i].mid == nick){
							data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyDelete('+vos[i].boReIdx+')">&nbsp;삭제&nbsp;</a>';
							data +='</span>';	
							data +='<span class="w3-right" style="font-size: 11px;color:gray"><a href="javascript:replyUpdate('+vos[i].boReIdx+')">&nbsp;수정&nbsp;</a>';
							data +='</span>';	
						}
						data +='</div>';
						data +='</div>';
					}
					$("#rezone").html(data);
				}
			}
		});
	}
	function InputReply(){
		let boIdx = $("#boRe_boIdx").val();
		let boIndex = $("#boRe_index").val();
		let bocoment = $("#boRe_coment").val();
		let boRe_boReIdx = $("#boRe_boReIdx").val();
		let boRe_forMem = $("#boRe_forMem").val();
		let boRe_forMemIdx = $("#boRe_forMemIdx").val();
		let memIdx = ${param.memIdx};
		let msgurl = '/board/content?boIdx='+boIdx+'&memIdx='+memIdx;
		$.ajax({
			type : "post",
			url : "${ctp}/board/boardReplyInput",
			data : {
				boRe_boIdx : boIdx,
				boRe_index : boIndex,
				boRe_coment : bocoment,
				boRe_boReIdx : boRe_boReIdx,
				boRe_forMem : boRe_forMem,
				boRe_forMemIdx : boRe_forMemIdx,
				msg_url : msgurl,
				memIdx : memIdx
			},
			success : function(){
				
				$("#boRe_index").val(0);
				$("#boRe_boReIdx").val(0);
				$("#boRe_coment").val('');
				$("#retagbox > div").remove();
				reply(boIdx);
			}
		});
	}
	function rereply(index,idx,mem){
		let memIdx = mem;
		$("#boRe_boReIdx").val(idx);
		$("#boRe_index").val(index);
		$("#boRe_forMemIdx").val(memIdx);
		$.ajax({
			type : "post",
			url : "${ctp}/board/getReplyUserInfor",
			data : {
				memIdx : memIdx
			},
			success : function(nick){
				$("#boRe_forMem").val(nick);
				let data = "";
				data +='<div class="w3-col m12 w3-border w3-padding w3-round-large" style="height: 40px;font-size: 13px">';
				data +='<font color="gray">@'+nick+'님에게 답글쓰기</font>';
				data +='<span class="w3-right"><a href="javascript:retagDel()">X</a></span>';
				data +='</div>';
				
				$("#retagbox").html(data);
			}
		});
	}
	function replyDelete(res){
		let boReIdx = res;
		Swal.fire({
			  position: 'top',
			  icon: 'question',
			  title: '댓글을 삭제하시겠습니까?',
			  showConfirmButton: true,
			  showCancelButton: true,
			  cancelButtonText:'취소',
			  confirmButtonText: '삭제'
		}).then((result) => {
		  if(result.isConfirmed){
			  $.ajax({
				  type : "post",
				  url : "${ctp}/board/replyDelete",
				  data : {
					  boReIdx : boReIdx
				  },
				  success : function(){
					  reply(${param.boIdx});
				  }
			  });
		  }						
		});
	}
	function replyUpdate(res){
		let boReIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/board/replyInfo",
			data : {
				boReIdx : boReIdx
			},
			success : function(text){
				let coment = text;
				(async () => {
					const { value: text } = await Swal.fire({
						  input: 'textarea',
						  inputLabel: '댓글 수정',
						  inputPlaceholder: '수정할 내용을 입력해주세요',
						  inputValue: coment,
						  showCancelButton: true,
						  cancelButtonText:'취소',
						  confirmButtonText: '수정',
						  inputValidator: (value) => {
							    if (!value) {
							      return '내용을 입력해주세요'
							    }
							  }
						})
						if (text) {
							let coment = text;
							$.ajax({
								type : "post",
								url : "${ctp}/board/replyUpdate",
								data : {
									boReIdx : boReIdx,
									coment : coment
								},
								success : function(){
									reply(${param.boIdx});
								}
							});
						}
				})()				
			}
		});
	}
	
	function retagDel(){
		$("#retagbox > div").remove();
		$("#boRe_boReIdx").val(0);
		$("#boRe_index").val(0);
		$("#boRe_forMem").val("");
		$("#boRe_forMemIdx").val(0);
	}
	function modalClose(){
		$('html, body').css({'overflow': 'auto'});
		$('#bodycontent').css('max-height','5000px');
		$("#id01").css('display','none');
	}
	function userSearch(){
		$('#id01').css({'overflow': 'hidden'});
		$("#id02").css('display','block');
	}
	function usermodalClose(){
		$('#id01').css({'overflow': 'auto'});
		$("#id02").css('display','none');
	}
	
	$(function(){
		$("#userSearchnick").on('keyup',function(){
			let userSearch = $("#userSearchnick").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/userSearch",
				data : {
					userSearch :userSearch
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
						data +='<a href="javascript:userChoose('+vos[i].idx+')" class="w3-button w3-border w3-round w3-small">선택</a>';
						data +='</div>';
						data +='</li>';
						data +='</ul>';
					}
					$("#userbox").html(data);
				}
			});
		});
	});
	function userChoose(mem){
		let idx = $("#boRe_boReIdx").val();
		let index = $("#boRe_index").val();
		rereply(index,idx,mem);
		$('#id01').css({'overflow': 'auto'});
		$("#id02").css('display','none');
	}
	
	function blikeUp(idx,mem){
		let msg_url = '/board/content?boIdx='+idx+'&memIdx='+mem;
		let msg_memIdx = mem;
		let bl_boardIdx = idx;
		
		let mid = '${sIdx}';
		if(mid == ''){
			Swal.fire({
				  position: 'top',
				  icon: 'warning',
				  title: '로그인후 이용해주세요',
				  showConfirmButton: false,
				  timer: 1000
			}).then(function(){
			location.href = '${ctp}/log/login';							
			});
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardLikeUp",
				data : {
					msg_url : msg_url,
					msg_memIdx : msg_memIdx,
					bl_boardIdx : bl_boardIdx
				},
				success : function(){
					location.reload();
				}
			});			
		}
	}
	function blikeDown(idx){
		let boIdx = idx;
		$.ajax({
			type : "post",
			url : "${ctp}/board/boardLikeDown",
			data : {
				boIdx : boIdx
			},
			success : function(){
				location.reload();
			}
		});
	}
	function follow(res){
		let for_Idx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/mem/setfollow",
			data : {
				for_Idx : for_Idx
			},
			success : function(){
				location.reload();
			}
		});
	}
	function unfollow(res){
		let for_Idx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/mem/setUnfollow",
			data : {
				for_Idx : for_Idx
			},
			success : function(){
				location.reload();
			}
		});
	}
	function boardDelete(res){
		let boIdx = res;
		Swal.fire({
			  position: 'top',
			  icon: 'question',
			  title: '게시물을 삭제하시겠습니까?',
			  showConfirmButton: true,
			  showCancelButton: true,
			  cancelButtonText:'취소',
			  confirmButtonText: '삭제'
		}).then((result) => {
		  if(result.isConfirmed){
			  $.ajax({
				  type : "post",
				  url : "${ctp}/board/boardDelete",
				  data : {
					  boIdx : boIdx
				  },
				  success : function(){
					  location.href="${ctp}/msg/boardDelete";
				  }
			  });
		  }						
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-top w3-white" style="margin-top: 100px;height: 50px">
  <div class="w3-white w3-small w3-center" style="margin-left: 47%">
   <div class="w3-center" style="width: 200px">
   	<a href="${ctp}/board/userFeed?memIdx=${mvo.idx}">
		<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 0px;margin-right: 7px" src="${ctp}/member/${mvo.photo}">
   	<span class="w3-left userName">${mvo.nickName }</span>
   	</a>   	
   </div>
  </div>
</div>

<div class="w3-content" id="bodycontent" style="max-width:2000px;margin-top:200px;height:100%;max-height:5000px;margin-bottom: 100px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1400px;margin: auto;padding-top:10px;padding: auto">
			<div class="w3-animate-opacity w3-center" style="height: 100%;width: 1400px">
				
				<div class="w3-container w3-center" style="width: 1400px;margin-bottom: 50px">
					<div class="card" style="width: 700px;margin: auto">
				    <div>
				    	<ul class="w3-ul" style="height: 65px">
								<li class="w3-bar" style="width: 100%;padding-left: 2px;padding-right: 2px">
								  <img class="w3-circle w3-hide-small w3-left" style="width: 42px;height: 42px;margin-top: 5px" src="${ctp}/member/${bvo.photo}">
									<div class="w3-bar-item w3-left" style="padding-top: 5px;padding-left: 7px;text-align: left">
							    <span><font color="black" size="3px" class="name ">${bvo.nickName }</font></span>
							    <br><span><font color="gray" size="2px" class="name"> ${strtime}</font></span>
							 	 	</div>
							 	 	<c:if test="${not empty sIdx}">
							 	 	<c:if test="${bvo.idx == sIdx}">
							 	 		<div class="w3-bar-item w3-right">
								 	 		<a href="${ctp}/mem/myFeedUpdate?boIdx=${bvo.boIdx}" class="w3-button w3-ripple w3-border w3-border-blue w3-hover-blue w3-round w3-small">수정</a>
								 	 		<a href="javascript:boardDelete(${bvo.boIdx})" class="w3-button w3-ripple w3-border w3-border-red w3-hover-red w3-round w3-small">삭제</a>
								 	 	</div>
							 	 	</c:if>
							 	 	<c:if test="${bvo.idx != sIdx}">
							 	 		<c:if test="${empty fvo}">
								 	 	<div class="w3-bar-item w3-right">
								 	 		<a href="javascript:follow(${bvo.idx})" class="w3-button w3-ripple w3-black w3-hover-black w3-round w3-small">팔로우</a>
								 	 		<a href="javascript:declaration(${bvo.boIdx})" class="w3-button w3-ripple w3-red w3-hover-red w3-round w3-small"><i class="fa fa-bullhorn" aria-hidden="true"></i></a>
								 	 	</div>
							 	 		</c:if>
							 	 		<c:if test="${not empty fvo}">
							 	 		<div class="w3-bar-item w3-right">
								 	 		<a href="javascript:unfollow(${bvo.idx})" class="w3-button w3-ripple w3-light-gray w3-hover-light-gray w3-round w3-small">팔로잉</a>
								 	 		<a href="javascript:declaration(${bvo.boIdx})" class="w3-button w3-ripple w3-red w3-hover-red w3-round w3-small"><i class="fa fa-bullhorn" aria-hidden="true"></i></a>
								 	 	</div>
							 	 		</c:if>
							 	 	</c:if>
							 	 	</c:if>
								</li>
							</ul>
							<c:set var="fNames" value="${fn:split(bvo.bo_fName,'/')}" />	
							<div class="slider">
							<c:if test="${bvo.bo_val == 0}">
							<c:forEach var="i" begin="0" end="${fn:length(fNames)-1}">
			    		<div>
				    		<img class="card-img-top w3-round-large" src="${ctp}/board/${fNames[i]}" alt="Card image" style="width: 700px;background-color: #EBF0F5">
			    		</div>
			    									
							</c:forEach>							
							</c:if>
							<c:if test="${bvo.bo_val == 1}">
	            	<div class="box-sold">
		            	<div class="img_box_sold">
		            		<img class="card-img-top w3-round-large" src="${ctp}/member/blur.png" alt="Card image" style="width: 700px;height:600px;background-color: #EBF0F5">
		            	</div>
		            	<div class="text-sold">
		            		<h4 class="sold_complete" style="color: gray"><i class="fa fa-low-vision" aria-hidden="true"></i><br>관리자에 의해 차단되었습니다.</h4>
		            	</div>
	            	</div>
								</c:if>	
							</div>			    
				    		
				    <div class="card-body w3-left-align">
				      <p class="card-title"><font color="black" size="2px">${bvo.bo_content}</font></p>
				      <c:set var="tags" value="${fn:split(bvo.bo_tag,'#')}"/>
				      <p class="card-text">
				      <c:forEach var="i" begin="0" end="${fn:length(tags)-1}">
				      <a href="${ctp}/board/feedTag?pag=1&pageSize=16&tags=${tags[i]}">
				      <font color="blue" size="2px">
				      #${tags[i]}
				      </font>
				      </a>
				      </c:forEach>
				      <br>				      
							<%-- <font color="gray" size="2px">${bvo.kprdName}</font><br></p> --%>
				    </div>
		   		 </div>
				      <p class="w3-left-align">
				      	<c:if test="${empty blvos }">
					      <a href="javascript:blikeUp(${bvo.boIdx},${bvo.bo_memIdx})">
				      		<i class="fa fa-heart-o w3-large" aria-hidden="true"></i>
				      	</a>
				      </c:if>
				      <c:if test="${not empty blvos }">
				      <c:set var="flag" value="false"/>
				      <c:forEach var="blvo" items="${blvos}" varStatus="stss">
				      <c:if test="${blvo.bl_memIdx == sIdx and blvo.bl_boardIdx == bvo.boIdx}">
				      	<a href="javascript:blikeDown(${bvo.boIdx})">
				      		<i class="fa fa-heart w3-large" style="color:red" aria-hidden="true"></i>
				      	</a>
				        <c:set var="flag" value="true"/>
				      </c:if>
				      <c:if test="${not flag}">
				      <c:if test="${stss.last}">
				      	<a href="javascript:blikeUp(${bvo.boIdx},${bvo.bo_memIdx})">
				      		<i class="fa fa-heart-o w3-large" aria-hidden="true"></i>
				      	</a>
				      </c:if>				      	
				      </c:if>
				      </c:forEach>
				      </c:if>
				      	
				      	
				        <font color="gray">${bvo.bo_likeCnt}</font>
				      	
				      	<i class="fa fa-commenting-o w3-large" aria-hidden="true"></i>
				      	
				        <font color="gray">${bvo.reCnt}</font>
				        <!-- <i class="fa fa-heart" aria-hidden="true"></i> -->
				      </p>
				      <a href="javascript:reply(${bvo.boIdx})"><font color="gray">댓글 보기...</font></a>
				      <c:if test="${bvo.bo_prdIdx !=0}">
				      <p class="w3-left-align"><font color="gray" size="2px">태그 상품</font></p>
				      <div class="card w3-left" id="prdTagItem" style="height: 250px;width: 150px;margin-right: 20px;margin-bottom:10px;cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${bvo.bo_prdIdx}';">
								<img class="card-img-top w3-round-large" src="${ctp}/product/${bvo.prdfName}" alt="Card image" style="width: 150px;height: 150px;background-color: #EBF0F5">
								<div class="card-body w3-left-align">
								<h4 class="card-title"><font color="black" size="2px"><b>${bvo.ebrName}</b></font></h4>
								<p class="card-text" style="padding-top: 0px"><font color="black" size="2px">${bvo.eprdName}</font><br>
								<font color="gray" size="2px">${bvo.kprdName}</font></p>
								</div>
							</div>
				      </c:if>
		  		</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="id01" class="w3-modal" style="z-index: 50">
    <div class="w3-modal-content" style="width: 580px;height:100%;margin-right: 0px">
      <div class="w3-container">
        <span onclick="modalClose()" class="w3-button w3-hover-white w3-display-topleft">&times;</span>
        <h3 style="padding-left: 40px">댓글</h3>
        <div class="w3-container w3-margin-top">
        	<div class="w3-center" style="width: 200px">
				   	<a>
						<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 0px;margin-right: 7px" src="${ctp}/member/${mvo.photo}">
				   	<span class="w3-left userName" style="font-size: 13px">${mvo.nickName }</span>
				   	</a>   	
				  </div><br><br>
				  <p class="card-title"><font color="black" size="2px">${bvo.bo_content}</font></p>
				  <p class="card-text">
				  <c:forEach var="i" begin="0" end="${fn:length(tags)-1}">
				    <a href="${ctp}/board/feedTag?pag=1&pageSize=16&tags=${tags[i]}">
				      <font color="blue" size="2px">
				      #${tags[i]}
				      </font>
				    </a>
				  </c:forEach>
				  </p><br>
        </div>
        <hr>
        <div class="w3-row w3-light-gray" id="retagbox">
        </div>
        <div class="w3-margin-top w3-row">
        <c:if test="${not empty sMid}">
        	<div class="w3-col m1">
					<img class="w3-circle w3-hide-small w3-left" style="width: 30px;height: 30px;margin-top: 5px;margin-right: 7px" src="${ctp}/member/${svo.photo}">  	        	
        	</div>
        	<div class="w3-col m1 w3-margin-right">
        		<a href="javascript:userSearch()" class="w3-button w3-border w3-round-xlarge w3-light-gray">@</a>
        	</div>
        	<div class="w3-col m7">
					<input type="text" id="boRe_coment" class="w3-input w3-hover-white w3-border w3-round-xlarge">
        	</div>
        	<div class="w3-col m2">
					<input type="button" class="w3-button w3-white w3-border w3-round-large w3-margin-left" onclick="InputReply()" value="등록">        	
        	</div>
        </c:if>
        	<c:if test="${empty sMid}">
        		<div class="w3-col m10">
        				<input type="button" class="w3-button w3-border w3-round-xlarge" onclick="location.href='${ctp}/log/login';" value="로그인후 이용해주세요" style="width: 100%">
        		</div>
        		<div class="w3-col m2">
							<input type="button" class="w3-button" disabled="disabled" onclick="InputReply()" value="등록">        	
        		</div>
        	</c:if>
        </div>
        <hr>
        <div id="rezone" class="w3-container w3-margin-top" style="padding: 0px;overflow-y:auto;height: 430px">
        	
        </div>
        <input type="hidden" id="boRe_index" value="0">
        <input type="hidden" id="boRe_boReIdx" value="0">
        <input type="hidden" id="boRe_boIdx" value="">
        <input type="hidden" id="boRe_forMemIdx" value="0">
        <input type="hidden" id="boRe_forMem" value="">
        <input type="hidden" id="nowUrl" value="${requestScope['javax.servlet.forward.request_uri']}">
      </div>
    </div>
  </div>
<div id="id02" class="w3-modal" style="z-index: 60">
    <div class="w3-modal-content" style="width: 580px;height:100%">
      <div class="w3-container">
        <span onclick="usermodalClose()" class="w3-button w3-hover-white w3-display-topright">&times;</span>
        <h3 style="text-align: center">@ 유저 검색</h3>
        <div class="w3-container w3-margin-top w3-center">
        	<div class="w3-row">
        		<div class="w3-col m12">
        			<input type="text" id="userSearchnick" class="w3-input w3-border w3-round-large" placeholder="닉네임,또는 아이디를 입력해주세요">
        		</div>
        	</div>
        </div>
        
				<div id="userbox" class="w3-container w3-margin-top" style="overflow-y:auto;height: 730px">
					
				</div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
  function declaration(res){
	  $('html, body').css({'overflow': 'hidden'});
		$("#id03").css('display','block');
		$("#d_boIdx").val(res);
  }
  function deClose(){
	  $('html, body').css({'overflow': 'auto'});
		$("#id03").css('display','none');
		$('#bodycontent').css('max-height','5000px');
  }
  function decall(){
	  let d_boIdx = $("#d_boIdx").val();
	  let d_status = $("#d_status").val();
	  let d_content = $("#d_content").val();
	  $.ajax({
		  type : "post",
		  url : "${ctp}/board/declaration",
		  data : {
			  d_boIdx : d_boIdx,
			  d_status : d_status,
			  d_content : d_content
		  },
		  success : function(){
			  Swal.fire({
				  position: 'top',
				  icon: 'success',
				  title: '신고를 접수하였습니다.',
				  showConfirmButton: false,
				  timer: 1000
				})
				deClose();
		  }
	  });
  }
  </script>
<div id="id03" class="w3-modal" style="z-index: 60">
    <div class="w3-modal-content" style="width: 580px;height:350px">
      <div class="w3-container">
        <span onclick="deClose()" class="w3-button w3-hover-white w3-display-topright">&times;</span>
        <h3 style="text-align: center">신고</h3>
        <div class="w3-container w3-margin-top w3-center">
        	<div class="w3-row">
        		<div class="w3-col m12">
        		<select class="w3-input" id="d_status">
        			<option value="" disabled="disabled" selected="selected">신고유형을 선택해주세요</option>
        			<option value="부적절한 사진">부적절한 사진</option>
        			<option value="부적절한 내용">부적절한 내용</option>
        			<option value="사진도용">사진도용</option>
        			<option value="기타">기타</option>
        		</select>
        		</div>
        	</div>
        	<input type="hidden" id="d_boIdx">
        	<div class="w3-row">
        		<div class="w3-col m12">
        		<textarea class="w3-input" rows="6" cols="50" placeholder="신고내용을 적어주세요." id="d_content" style="resize: none"></textarea>
        		</div>
        	</div>
        	<div class="w3-center w3-margin-top">
        		<a href="javascript:decall()" class="w3-button w3-red w3-hover-red w3-ripple">신고</a>
        	</div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
