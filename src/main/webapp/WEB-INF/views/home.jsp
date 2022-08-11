<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
.tag{
    padding: 8px 10px;
    border: 1px solid #ebebeb;
    border-radius: 12px;
    font-size: 15px;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    font-family: -apple-system,BlinkMacSystemFont,Roboto,AppleSDGothicNeo-Regular,NanumBarunGothic,NanumGothic,나눔고딕,Segoe UI,Helveica,Arial,Malgun Gothic,Dotum,sans-serif;
}
.img_tag{
		position: absolute;
    background-color: white;
    border-radius: 70%;
    font-size: 15px;
    margin-left: 10px;
    margin-top: 10px;
    padding-bottom: 2px;
    padding-top: 2px;
    padding-left: 2px;
    padding-right: 2px;
		/* position: absolute;
    top: 8px;
    right: 8px;
    background-color: rgba(34,34,34,.5);
    border-radius: 30px; */
}
.img_Cnt{
    padding: 0px 0px;
    font-size: 12px;
    letter-spacing: -.33px;
    color: #fff;
}
* {box-sizing: border-box}
.mySlides {display: none}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  max-width: 2000px;
  position: relative;
  margin: auto;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  animation-name: fade;
  animation-duration: 1.5s;
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .prev, .next,.text {font-size: 11px}
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide.jsp" />

<div class="w3-content" style="max-width:2000px;max-height:8000px;margin-top:50px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1580px;margin: auto;padding-top:10px;padding-left: 180px;padding-right: 180px">
			<div class="w3-container">
				<h4><b>인기 상품</b></h4>
				<div class="w3-row">
					<c:forEach var="vo" items="${vos}">
					<div class="card w3-col m3" style="height: 520px;width: 275px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${vo.prdIdx}';">
				    <c:choose>
				    	<c:when test="${vo.ebrName == 'Nike'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #EBF0F5">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Jordan'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F6EEED">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Adidas'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F1F1EA">
				    	</c:when>
				    	<c:otherwise>
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F5F5F5">
				    	</c:otherwise>
				    </c:choose>
				    <div class="card-body text-center">
				      <h4 class="card-title"><font color="black" size="2px"><b>${vo.ebrName}</b></font></h4>
				      <p class="card-text"><font color="black" size="2px">${vo.eprdName}</font><br>
							<font color="gray" size="2px">${vo.kprdName}</font><br></p>
							<c:if test="${vo.prdSale == 0}">
					      <font color="black" size="2px"><b>${vo.formatPrice}원</b></font><br><font color="gray" size="2px">판매 가격</font>
							</c:if>
							<c:if test="${vo.prdSale != 0}">
								<c:set var="prdSalePrice" value="${vo.SPrice - (vo.SPrice * (vo.prdSale / 100))}"/>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdSalePrice}" var="commaPrice"/>
					      <font color="black" size="2px"><b style="text-decoration: line-through;text-decoration-color:red;">${vo.formatPrice}원</b></font><br>
					      <font color="black" size="2px"><b>${commaPrice}원</b></font><br>
					      <font color="gray" size="2px">판매 가격</font>
					      <span class="w3-right">${vo.prdSale}%</span>
							</c:if>
				    </div>
		   		 </div>
		  		</div>
					</c:forEach>
				</div>
				<h4><b>최신 상품</b></h4>
				<div class="w3-row">
					<c:forEach var="vo" items="${nvos}">
					<div class="card w3-col m3" style="height: 520px;width: 275px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${vo.prdIdx}';">
				    <c:choose>
				    	<c:when test="${vo.ebrName == 'Nike'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #EBF0F5">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Jordan'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F6EEED">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Adidas'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F1F1EA">
				    	</c:when>
				    	<c:otherwise>
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 259px;height: 259px;background-color: #F5F5F5">
				    	</c:otherwise>
				    </c:choose>
				    <div class="card-body text-center">
				      <h4 class="card-title"><font color="black" size="2px"><b>${vo.ebrName}</b></font></h4>
				      <p class="card-text"><font color="black" size="2px">${vo.eprdName}</font><br>
							<font color="gray" size="2px">${vo.kprdName}</font><br></p>
							<c:if test="${vo.prdSale == 0}">
					      <font color="black" size="2px"><b>${vo.formatPrice}원</b></font><br><font color="gray" size="2px">판매 가격</font>
							</c:if>
							<c:if test="${vo.prdSale != 0}">
								<c:set var="prdSalePrice" value="${vo.SPrice - (vo.SPrice * (vo.prdSale / 100))}"/>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${prdSalePrice}" var="commaPrice"/>
					      <font color="black" size="2px"><b style="text-decoration: line-through;text-decoration-color:red;">${vo.formatPrice}원</b></font><br>
					      <font color="black" size="2px"><b>${commaPrice}원</b></font><br>
					      <font color="gray" size="2px">판매 가격</font>
					      <span class="w3-right">${vo.prdSale}%</span>
							</c:if>
				    </div>
		   		 </div>
		  		</div>
					</c:forEach>
				</div>
				<h4><b>인기 FEED</b></h4>
				<c:if test="${not empty bvos}">
					<c:forEach var="bvo" items="${bvos}">
					<div class="card w3-col m2" style="width: 185px;height:246px;margin-right: 10px;margin-bottom:200px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/board/content?boIdx=${bvo.boIdx}&memIdx=${bvo.bo_memIdx}';">
								<c:set var="fNames" value="${fn:split(bvo.bo_fName,'/')}" />							
								<div class="img_tag" style="">
									<span class="img_Cnt"><img class="w3-circle w3-hide-small w3-left" style="width: 35px;height: 35px" src="${ctp}/member/${bvo.photo}"></span>	
								</div>
				    		<img class="card-img-top w3-round-large" src="${ctp}/board/${fNames[0]}" alt="Card image" style="width: 184px;height:246px;background-color: #EBF0F5">
				    		<ul class="w3-ul" style="height: 31px">
									<li class="w3-bar" style="width: 100%;padding-left: 2px">
									  <img class="w3-circle w3-hide-small w3-left" style="width: 25px;height: 25px;margin-top: 5px" src="${ctp}/member/${bvo.photo}">
										<div class="w3-bar-item w3-left" style="padding-top: 5px;padding-left: 7px">
								    <span><font color="gray" size="2px">${bvo.nickName }</font></span>
								 	 	</div>
									</li>
								</ul>
		   		 		</div>
		  			</div>
					</c:forEach>
					</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
