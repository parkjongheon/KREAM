<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		let cateCnt = 0;
		let subCnt = 0;
		let brandCnt = 0;
		
		function wishUp(res){
			let mid = '${sIdx}';
			let prdIdx = res;
			if(mid == ''){
				Swal.fire({
					  position: 'top',
					  icon: 'warning',
					  title: '로그인후 이용해주세요',
					  showConfirmButton: false,
					  timer: 1000
				}).then(function(){
				location.href = '${ctp}/log/login?url=productMain';							
				});
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/product/wishUp",
					data : {
						memIdx : mid,
						prdIdx : prdIdx
					},
					success : function(){
						location.reload();
					}
				});
			}
			
		}
		
		function wishDown(res){
			let mid = '${sIdx}';
			let prdIdx = res;
			$.ajax({
				type : "post",
				url : "${ctp}/product/wishDown",
				data : {
					memIdx : mid,
					prdIdx : prdIdx
				},
				success : function(){
					location.reload();
				}
			});
		}
		
		function deleteTag(name){
			$("#"+name+"Filter").hide();
			$("#"+name+"Value").val("1");
			if(name == 'brand'){
				brandCnt = 0;
			}
			else if(name == 'subcate'){
				subCnt = 0;				
			}
			else if(name == 'cate'){
				cateCnt =0;
			}
			
			/* if(cateCnt == 0 && subCnt == 0 && brandCnt == 0){
				$("#tagzone").hide();
			} */
		}
		
		function goSearch(){
			let brand = $("#brandValue").val();
			let part = $("#cateValue").val();
			let subpart = $("#subcateValue").val();
			let sort = '${param.sort}';
			let pag = '${param.pag}';
			let pageSize = '${param.pageSize}';
			if(part != "1"){
				part = "part="+part+"&";
			}
			else{
				part = "";
			}
			if(brand != "1"){
				brand = "brand="+brand+"&";
			}
			else{
				brand = "";
			}
			if(subpart != "1"){
				subpart = "subpart="+subpart+"&";
			}
			else{
				subpart = "";
			}
			location.href='${ctp}/product/productMain?pag=1&pageSize=16&'+brand+part+subpart+"sort="+sort;
		}
		
		
		function show(no){
			$("#box"+no).hide();
			$("#subbox"+no).show();
		}
		
		function hide(no){
			$("#box"+no).show();
			$("#subbox"+no).hide();
		}
		function brandshow(no,name){
			let idx = no;
			let bcount = $("#bcount").val();
			for(let i = 0; i<bcount; i++){
				if(i == idx){
					$("#brandboxitems"+i).show();					
					$("#brandboxitem"+i).hide();
				}
				else{
					$("#brandboxitems"+i).hide();
					$("#brandboxitem"+i).show();
				}
			}
			$("#tagzone").show();
			$("#brandFilter").show();
			$("#brandTag").html(name+"&nbsp;X");
			$("#brandValue").val(name);
			brandCnt = 1;
		}
		function brandhide(no){
			let idx = no;
			$("#brandboxitem"+idx).show();
			$("#brandboxitems"+idx).hide();
			$("#brandFilter").hide();
			$("#brandTag").html('');
			$("#brandValue").val('1');
			brandCnt = 0;
			/* if(cateCnt == 0 && subCnt == 0 && brandCnt == 0){
				$("#tagzone").hide();
			} */
			
		}
		function subshow(count,no,name){
			let idx = Number(no);
			let num =  Number(count);
			let ccount = $("#ccount").val();
			for(let i = 0; i<ccount; i++){
				if(i == num){
					$("#subboxitem"+i).hide();
					$("#subboxitems"+i).show();					
				}
				else{
					$("#subboxitems"+i).hide();
					$("#subboxitems"+i+"> a").remove();
					$("#subboxitem"+i).show();
				}
			}
			$("#tagzone").show();
			$("#cateFilter").show();
			$("#cateTag").html(name+"&nbsp;X");
			$("#cateValue").val(name);
			cateCnt = 1;
			
			$.ajax({
				type : "post",
				url : "${ctp}/product/getSubCategory",
				data : {
					idx : idx
				},
				success : function(vos){
					let data = '<a href="javascript:subhide('+num+')" class="w3-bar-item"><i class="fa fa-check-square" aria-hidden="true"></i> '+vos[0].category+'</a>';
					for(let i = 0; i<vos.length; i++){
						let sub = "'"+vos[i].subcategory+"'";
						data += '<a id="subshow'+i+'" href="javascript:subitemhide('+i+','+sub+')" class="w3-bar-item" style="margin-left: 15px"><i class="fa fa-square-o" aria-hidden="true"></i> '+vos[i].subcategory+'</a>';
						data += '<a id="subhide'+i+'" href="javascript:subitemshow('+i+')" class="w3-bar-item" style="margin-left: 15px;display:none"><i class="fa fa-check-square" aria-hidden="true"></i> '+vos[i].subcategory+'</a>';
					}
					$("#sccount").val(vos.length);
					$("#subboxitems"+num).append(data);
				}
			});
		}
		function subitemhide(num,subpart){
			let idx = num;
			let name = subpart;
			let sccount = $("#sccount").val();
			for(let i = 0; i<sccount; i++){
				if(i == idx){
					$("#subhide"+i).show();
					$("#subshow"+i).hide();					
				}
				else{
					$("#subshow"+i).show();					
					$("#subhide"+i).hide();					
				}
			}
			
			
			$("#tagzone").show();
			$("#subcateFilter").show();
			$("#subcateTag").html(name+"&nbsp;X");
			$("#subcateValue").val(name);
			subCnt = 1;
		}
		function subitemshow(no){
			let idx = no;
			$("#subshow"+idx).show();
			$("#subhide"+idx).hide();
			$("#subcateFilter").hide();
			$("#subcateTag").html('');
			$("#subcateValue").val('1');
			/* subCnt = 0;
			if(cateCnt == 0 && subCnt == 0 && brandCnt == 0){
				$("#tagzone").hide();
			} */
			
		}
		function subhide(no){
			$("#subboxitems"+no+"> a").remove();
			$("#subboxitems"+no).hide();
			$("#subboxitem"+no).show();
			$("#cateFilter").hide();
			$("#cateTag").html('');
			$("#cateValue").val('1');
			cateCnt = 0;
			/* if(cateCnt == 0 && subCnt == 0 && brandCnt == 0){
				$("#tagzone").hide();
			} */
		}
	</script>
	
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="w3-content" style="max-width:2000px;max-height:3000px;margin-top:160px">
	<div class="w3-container" style="width:100%;height: 100%">
		<div class="w3-container" style="width:1480px;margin: auto;padding-top:10px;padding: auto">
		<div class="w3-center" style="padding-top: 50px;height: 150px">
			<c:if test="${empty param.brand || param.brand == ''}">
		    <h2><b>SHOP</b></h2>
			</c:if>
			<c:if test="${not empty param.brand}">
		    <h2><b>${param.brand}</b></h2>
			</c:if>  	

  	</div>
			<div class="w3-margin-bottom w3-center" style="width:90%;height: 120px;margin-left: 40px">
				<%-- <c:forEach var="brvo" items="${brvos}">
				<div class="w3-cell" style="width: 100px;margin-right: 2px">
					<img class="card-img-top w3-round-large" src="${ctp}/brand/${brvo.brfName}" alt="Card image" style="width: 60px;height: 60px">
					<div class="w3-bar-block">
						<font color="black" size="2px">${brvo.kbrName}</font>
					</div>
				</div>
				</c:forEach> --%>
				
			</div>
			<div class="w3-half w3-cell" style="height: 700px;width: 220px;margin-left: 40px">
				<div class="w3-bar-block w3-margin-bottom">
				  <a href="${ctp}/product/productMain?pag=1&pageSize=16&sort=desc" class="w3-bar-item"><b>필터</b>
				  <span class="w3-right"><font color="gray">초기화</font> <i class="fa fa-retweet" aria-hidden="true"></i></span></a>
				</div>
				<div id="box1" class="w3-bar-block w3-border-bottom">
				  <a href="javascript:show(1)" class="w3-bar-item">
					  <b>카테고리</b><span class="w3-right"><i class="fa fa-plus" aria-hidden="true"></i></span>
					  <br><font color="gray">모든 카테고리</font>
				  </a>
				</div>
				<div id="subbox1" class="w3-bar-block w3-border-bottom" style="display: none">
				  <a href="javascript:hide(1)" class="w3-bar-item">
					  <b>카테고리</b><span class="w3-right"><i class="fa fa-minus" aria-hidden="true"></i></span>
				  </a>
				  <c:forEach var="catvo" items="${catvos}" varStatus="sts">
				  <div id="subboxitem${sts.index}">
						<a href="javascript:subshow('${sts.index}','${catvo.idx}','${catvo.category}')" class="w3-bar-item"><i class="fa fa-square-o" aria-hidden="true"></i> ${catvo.category}</a>
				  </div>			  
				  <div id="subboxitems${sts.index}" style="display: none">
				  </div>
				  <c:set var="ccount" value="${sts.index + 1}"/>
				  </c:forEach>
				  <input type="hidden" id="ccount" value="${ccount}">
				  <input type="hidden" id="sccount" value="">
				</div>
				<div id="box2" class="w3-bar-block w3-border-bottom">
				  <a href="javascript:show(2)" class="w3-bar-item">
					  <b>브랜드</b><span class="w3-right"><i class="fa fa-plus" aria-hidden="true"></i></span>
					  <br><font color="gray">모든 브랜드</font>
				  </a>
				</div>
				<div id="subbox2" class="w3-bar-block w3-border-bottom" style="display: none">
				  <a href="javascript:hide(2)" class="w3-bar-item">
					  <b>카테고리</b><span class="w3-right"><i class="fa fa-minus" aria-hidden="true"></i></span>
				  </a>
				  <c:forEach var="brvo" items="${brvos}" varStatus="st">
				  <div id="brandboxitem${st.index}">
						<a href="javascript:brandshow('${st.index}','${brvo.ebrName}')" class="w3-bar-item"><i class="fa fa-square-o" aria-hidden="true"></i> ${brvo.ebrName}</a>
				  </div>			  
				  <div id="brandboxitems${st.index}" style="display: none">
				  	<a href="javascript:brandhide('${st.index}')" class="w3-bar-item"><i class="fa fa-check-square" aria-hidden="true"></i> ${brvo.ebrName}</a>
				  </div>
				  <c:set var="bcount" value="${st.index + 1}"/>
				  </c:forEach>
				  <input type="hidden" id="bcount" value="${bcount}">
				</div>
				<div id="box3" class="w3-bar-block w3-border-bottom">
				  <a href="#" class="w3-bar-item">
					  <b>신발 사이즈</b><span class="w3-right"><i class="fa fa-plus" aria-hidden="true"></i></span>
					  <br><font color="gray">모든 사이즈</font>
				  </a>
				</div>
				<div class="w3-bar-block w3-border-bottom">
				  <a id="box4" href="#" class="w3-bar-item">
					  <b>의류 사이즈</b><span class="w3-right"><i class="fa fa-plus" aria-hidden="true"></i></span>
					  <br><font color="gray">모든 사이즈</font>
				  </a>
				</div>
			</div>
			<div class="w3-half w3-animate-opacity" style="height: 100%;width: 1180px">
				<div class="w3-container">
					<div style="height: 50px;width: 92%">
						<c:if test="${empty param.brand && empty param.part && empty param.subpart}">
						<div id="tagzone" class="w3-left" style="display: none">
							<div id="brandFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('brand')" id="brandTag" class="w3-button w3-round-large w3-small" style="background-color: #EBF0F5"></a>
								<input type="hidden" id="brandValue" value="1">
							</div>
							<div id="cateFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('cate')" id="cateTag" class="w3-button w3-round-large w3-small" style="background-color: #F1F1EA"></a>
								<input type="hidden" id="cateValue" value="1">
							</div>
							<div id="subcateFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('subcate')" id="subcateTag" class="w3-button w3-round-large w3-small" style="background-color: #F5F5F5"></a>
								<input type="hidden" id="subcateValue" value="1">
							</div>
						<input type="button" onclick="goSearch()" class="w3-button w3-small w3-round-large w3-khaki" value="검색">
						</div>
						</c:if>
						<c:if test="${not empty param.brand ||not empty param.part ||not empty param.subpart}">
						<div id="tagzone" class="w3-left">
							<c:if test="${not empty param.brand}">
							<div id="brandFilter" class="w3-left w3-margin-right">
								<a href="javascript:deleteTag('brand')" id="brandTag" class="w3-button w3-round-large w3-small" style="background-color: #EBF0F5">${param.brand} X</a>
							</div>
							</c:if>
							<c:if test="${empty param.brand}">
							<div id="brandFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('brand')" id="brandTag" class="w3-button w3-round-large w3-small" style="background-color: #EBF0F5">${param.brand} X</a>
							</div>
							</c:if>
							<c:if test="${not empty param.part}">
							<div id="cateFilter" class="w3-left w3-margin-right">
								<a href="javascript:deleteTag('cate')" id="cateTag" class="w3-button w3-round-large w3-small" style="background-color: #F1F1EA">${param.part} X</a>
							</div>
							</c:if>
							<c:if test="${empty param.part}">
							<div id="cateFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('cate')" id="cateTag" class="w3-button w3-round-large w3-small" style="background-color: #F1F1EA">${param.part} X</a>
							</div>
							</c:if>
							<c:if test="${not empty param.subpart}">
							<div id="subcateFilter" class="w3-left w3-margin-right">
								<a href="javascript:deleteTag('subcate')" id="subcateTag" class="w3-button w3-round-large w3-small" style="background-color: #F5F5F5">${param.subpart} X</a>
							</div>
							</c:if>
							<c:if test="${empty param.subpart}">
							<div id="subcateFilter" class="w3-left w3-margin-right" style="display: none">
								<a href="javascript:deleteTag('subcate')" id="subcateTag" class="w3-button w3-round-large w3-small" style="background-color: #F5F5F5">${param.subpart} X</a>
							</div>
							</c:if>
								<c:if test="${empty param.brand}">
									<input type="hidden" id="brandValue" value="1">
								</c:if>
								<c:if test="${not empty param.brand}">
									<input type="hidden" id="brandValue" value="${param.brand}">
								</c:if>							
								<c:if test="${empty param.part}">
									<input type="hidden" id="cateValue" value="1">
								</c:if>
								<c:if test="${not empty param.part}">
									<input type="hidden" id="cateValue" value="${param.part}">
								</c:if>
								<c:if test="${empty param.subpart}">
								 <input type="hidden" id="subcateValue" value="1">
								</c:if>
								<c:if test="${not empty param.subpart}">
								 <input type="hidden" id="subcateValue" value="${param.subpart}">
								</c:if>
						<input type="button" onclick="goSearch()" class="w3-button w3-small w3-round-large w3-khaki" value="검색">
						</div>
						</c:if>
					<c:if test="${param.sort == 'desc' || empty param.sort}">
						<a href="${ctp}/product/productMain?brand=${param.brand}&part=${param.part}&subpart=${param.subpart}&sort=asc" class="w3-bar-item">
					  	<span class="w3-right">오름차순</span>
							<img alt="" src="${ctp}/logo/sort.svg" class="w3-right" style="width: 25px;height:25px">
					  </a>
					  <input type="hidden" id="sort" value="desc">
					</c:if>
					<c:if test="${param.sort == 'asc'}">
				  <a href="${ctp}/product/productMain?brand=${param.brand}&part=${param.part}&subpart=${param.subpart}&sort=desc" class="w3-bar-item">
				  	<span class="w3-right">내림차순</span>
						<img alt="" src="${ctp}/logo/sort.svg" class="w3-right" style="width: 25px;height:25px">
				  </a>
				  <input type="hidden" id="sort" value="asc">
				  </c:if>
					</div>
					<c:if test="${empty vos}">
					<div class="w3-center"><b>검색 결과가 없습니다.</b></div>
					</c:if>
					<c:if test="${not empty vos}">
					<c:forEach var="vo" items="${vos}">
					<div class="card w3-quarter" style="height: 520px;width: 250px;margin-right: 20px;margin-bottom:10px">
				    <div style="cursor:pointer" onclick="location.href='${ctp}/product/productInfo?prdIdx=${vo.prdIdx}';">
				    <c:choose>
				    	<c:when test="${vo.ebrName == 'Nike'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 250px;height: 250px;background-color: #EBF0F5">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Jordan'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 250px;height: 250px;background-color: #F6EEED">
				    	</c:when>
				    	<c:when test="${vo.ebrName == 'Adidas'}">
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 250px;height: 250px;background-color: #F1F1EA">
				    	</c:when>
				    	<c:otherwise>
				    		<img class="card-img-top w3-round-large" src="${ctp}/product/${vo.prdfName}" alt="Card image" style="width: 250px;height: 250px;background-color: #F5F5F5">
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
				      <p>
				      <c:if test="${empty wvos }">
				      <a href="javascript:wishUp(${vo.prdIdx})"><i class="fa fa-bookmark-o" aria-hidden="true"></i></a> 
				      	<font color="gray">${vo.wishCount}</font> 
				      </c:if>
				      <c:if test="${not empty wvos }">
				      <c:set var="flag" value="false"/>
				      <c:forEach var="wvo" items="${wvos}" varStatus="stss">
				      <c:if test="${wvo.memIdx == sIdx and wvo.prdIdx == vo.prdIdx}">
				      	<a href="javascript:wishDown(${vo.prdIdx})"><i class="fa fa-bookmark" aria-hidden="true"></i></a>
				        <font color="gray">${vo.wishCount}</font>
				        <c:set var="flag" value="true"/>
				      </c:if>
				      <c:if test="${not flag}">
				      <c:if test="${stss.last}">
				      	<a href="javascript:wishUp(${vo.prdIdx})"><i class="fa fa-bookmark-o" aria-hidden="true"></i></a> 
				      	<font color="gray">${vo.wishCount}</font> 
				      </c:if>				      	
				      </c:if>
				      </c:forEach>
				      </c:if>
				      </p>
		  		</div>
					</c:forEach>
					<div class="w3-container w3-center">
						<div class="w3-bar text-center">
					  <c:if test="${not empty vos}">
					  <c:if test="${pagevo.pag != 1}">
					  <a href="${ctp}/product/productMain?pag=1&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button w3-xlarge">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.pag == 1}">
					  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
					  </c:if>
					  <c:if test="${pagevo.curBlock > 1 }">
					  <a href="${ctp}/product/productMain?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button">&laquo;</a>
					  </c:if>
					  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
						<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
						<c:forEach var="i" begin="${no}" end="${size}">
							<c:choose>
								<c:when test="${i > pagevo.totPage}"></c:when>
								<c:when test="${i == pagevo.pag}">
									<a href="${ctp}/product/productMain?pag=${i}&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button w3-theme-l4">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="${ctp}/product/productMain?pag=${i}&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
							<a href="${ctp}/product/productMain?pag=${(curBlock+1)*blockSize+1}&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button">&raquo;</a>	
						</c:if>
						<c:if test="${pagevo.pag != pagevo.totPage}">
							<a href="${ctp}/product/productMain?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${param.sort}&brand=${param.brand}&part=${param.part}&subpart=${param.subpart}" class="w3-button w3-xlarge">&raquo;</a>
						</c:if>
						<c:if test="${pagevo.pag == pagevo.totPage}">
							<a class="w3-button w3-xlarge w3-disabled">&raquo;</a>
						</c:if>
					  </c:if>		
						</div>
					</div>	
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>