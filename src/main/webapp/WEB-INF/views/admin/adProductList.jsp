<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<style type="text/css">

		th{
		color: gray;
		}

		.switch {
		  position: relative;
		  display: inline-block;
		  width: 49px;
		  height: 20px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 15px;
		  width: 15px;
		  left: 4px;
		  bottom: 3px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input:checked + .slider {
		  background-color: #87CEFA;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
	</style>
	<script type="text/javascript">
		'use strict';
		
		function msg(data,flag){
			Swal.fire({
				  position: 'top',
				  icon: flag,
				  title: data,
				  showConfirmButton: false,
				  timer: 1000
			}).then(function(){
			location.reload();							
			});
		}
		
		function prdSell(prdIdx){
			$.ajax({
				type : "post",
				url : "${ctp}/admin/prdSell",
				data : {
					prdIdx : prdIdx,
					flag : "prdSell"
				},
				success : function(res){
					if(res == 0){
						let data = "옵션을등록해야 판매가 가능합니다.";
						let flag = "error";
						msg(data,flag);
						/* alert("옵션을등록해야 판매가 가능합니다.");
						$("#prdSellStop"+prdIdx).prop('checked', false); */
					}
					else {
						location.reload();
					}
				}
			});
		}
		function prdSellStop(prdIdx){
			$.ajax({
				type : "post",
				url : "${ctp}/admin/prdSell",
				data : {
					prdIdx : prdIdx,
					flag : "prdSellStop"
				},
				success : function(res){
					location.reload();
				}
			});
		}
		
		function productInfor(res){
			let prdIdx = res;
			document.getElementById('id01').style.display='block'
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getPrdInfor",
				data : {
					prdIdx : prdIdx
				},
				success : function(vos){
					let data = '<tr>';
							data += '<th style="width: 30%;text-align: center">사이즈</th>';
							data += '<th style="width: 70%;text-align: center">수량</th>';
							data += '</tr>';
					
					$("#kprdName").html("<b>"+vos[0].kprdName+"</b>");
					$("#eprdName").html("<b>"+vos[0].eprdName+"</b>");
					$("#prdfName").attr("src", "${ctp}/product/"+vos[0].prdfName);
					$("#prdIdx").html("<b>"+vos[0].prdIdx+"</b>");
					$("#ebrName").html("<b>"+vos[0].ebrName+"</b>");
					$("#prdCategory").html("<b>"+vos[0].prdCategory+"</b>");
					$("#prdSubCategory").html("<b>"+vos[0].prdSubCategory+"</b>");
					$("#prdNum").html("<b>"+vos[0].prdNum+"</b>");
					$("#prdColor").html("<b>"+vos[0].color+"</b>");
					$("#prdrPrice").html("<b>"+vos[0].rprice+"</b>");
					$("#prdsPrice").html("<b>"+vos[0].sprice+"</b>");
					$("#content").html(vos[0].prdContent);
					if(vos[1] != null){
						for(let i = 0; i < vos.length; i++){
							data += '<tr>';
							data += '<td style="width: 30%;text-align: center">'+vos[i].size+'</td>';
							data += '<td style="width: 70%;text-align: center"><input type="number" id="op'+vos[i].opIdx+'" value="'+vos[i].count+'" style="width:100px"><a class="w3-button w3-tiny w3-ripple w3-border w3-round" href="javascript:optionchange('+vos[i].opIdx+')">수정</a></td>';
							data += '</tr>';
						}
					}
					else{
						data += '<tr>';
						data += '<td colspan="2" style="text-align: center">등록된 옵션이 없습니다.</td>';
						data += '</tr>';
					}
					$("#prdOptions").html(data);
				}
			});
		}
		function optionchange(res){
			let opIdx = res;
			let count = $("#op"+res).val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/product/optionChange",
				data : {
					opIdx : opIdx,
					count : count
				},
				success : function(){
					alert("변경성공");
				}
			});
		}
		$(function() {
		    $("#file1").on('change', function(){
		    readURL1(this);
		    });
		});
		function readURL1(input) {
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		        $('#productView').attr('src', e.target.result);
		        let filename = $("#file1").val().substring(12,$("#file1").val().length);
		        $('#prdfName1').val(filename);
		        }
		        reader.readAsDataURL(input.files[0]);
		    }
		}
		$(function(){
			$("#productInput").click(function(){
				$("#demo4").html("");
				
				let text = CKEDITOR.instances['CKEDITOR'].getData();
				
				$("textarea#CKEDITOR").val(text);
				
				let file1 = $("#file1").val();
				let prdBrandOp = $("#prdBrandOp").val();
				let prdCategoryOp = $("#prdCategoryOp").val();
				let prdSubCategoryOp = $("#prdSubCategoryOp").val();
				let kprdName = $("#kprdName1").val();
				let eprdName = $("#eprdName1").val();
				let prdColor = $("#prdColor1").val();
				let rPrcie = $("#rPrcie1").val();
				let sPrcie = $("#sPrcie1").val();
				let prdSale = $("#prdSale1").val();
				
				if(prdBrandOp == null){
					$("#demo4").html('<font color="red"><small><b>브랜드를 선택해주세요</b></small></font>');
					$("#prdBrandOp").focus();
				}
				else if(prdCategoryOp == null){
					$("#demo4").html('<font color="red"><small><b>카테고리를 선택해주세요</b></small></font>');
					$("#prdCategoryOp").focus();
				}
				else if(prdSubCategoryOp == null){
					$("#demo4").html('<font color="red"><small><b>서브 카테고리를 선택해주세요</b></small></font>');
					$("#prdSubCategoryOp").focus();
				}
				else if(kprdName.trim() == ""){
					$("#demo4").html('<font color="red"><small><b>상품 이름(한글) 을 입력해주세요</b></small></font>');
					$("#kprdName").focus();
				}
				else if(eprdName.trim() == ""){
					$("#demo4").html('<font color="red"><small><b>상품 이름(영어) 을 입력해주세요</b></small></font>');
					$("#eprdName").focus();
				}
				else if(prdColor.trim() == ""){
					$("#demo4").html('<font color="red"><small><b>상품 색상 을 입력해주세요</b></small></font>');
					$("#prdColor").focus();
				}
				else{
					let form = $("#productForm")[0];
					let formData = new FormData(form);
					if(file1 != null){
						formData.append("productImage",$("#file1")[0].files[0]);					
					}
					$.ajax({
						type : "post",
						url : "${ctp}/admin/setProductUpdate",
						data : formData,
						contentType : false,
						processData : false,
						success : function(res){
							if(res == 1){
								let data = "상품을 수정하였습니다";
								let flag = "success";
								msg(data,flag);
							}
							else{
								alert("에러");
							}
						},
						error : function(){
							alert("전송오류");
						}
					});
				}
			});
		})
	</script>
</head>
<body class="w3-light-grey">
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">

	 	<div class="w3-row" style="margin-top: 10px">
	 		<div id="prdInfor" class="w3-col m4" style="display: none">
	 			<div class="w3-card w3-round w3-white" style="width : 98%;height: 700px">
			   <div class="w3-container">
			    <h4><b>상품 정보</b></h4>
			    <span class="w3-bar-item w3-white w3-xlarge w3-right">
						<a href="javascript:InforHide()"><span class="w3-right w3-white"><i class="fa fa-times" aria-hidden="true"></i></span></a>
					</span>
			   </div>
			 	</div>
	 		</div>
	 		<div id="prdList" class="w3-col m12">
	 			<div class="w3-card w3-round w3-white" style="width : 99%;height: 950px">
			   <div class="w3-container" style="height: 850px">
			    <h4><b>상품 리스트</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 700px">
			    		<table class="w3-table w3-centered w3-theme-l4 w3-round-large">
			    			<tr>
			    				<th style="width: 5%">사진</th>
			    				<th style="width: 10%">브랜드</th>
			    				<th style="width: 17%">상품이름</th>
			    				<th style="width: 10%">상품코드</th>
			    				<th style="width: 7%">분류1</th>
			    				<th style="width: 7%">분류2</th>
			    				<th style="width: 10%">색상</th>
			    				<th style="width: 8%">원가</th>
			    				<th style="width: 8%">판매가</th>
			    				<th style="width: 10%">
			    				<c:if test="${sort == 'desc'}">
				    				<a id="memSort" href="${ctp}/admin/adProductList?sort=asc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a>
			    				</c:if>
			    				<c:if test="${sort == 'asc'}">
				    				<a id="memDesc" href="${ctp}/admin/adProductList?sort=desc&pag=${pagevo.pag}&pageSize=${pagevo.pageSize}"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></a>
			    				</c:if>
			    				</th>
			    			</tr>
			    		</table>
							  	<c:forEach var="prdvo" items="${prdvos}" varStatus="st">
							  <ul class="w3-ul w3-card w3-round-large w3-margin-top">
							    <li class="w3-bar w3-center" >
							      <div class="w3-bar-item" style="width: 4%;margin-right: 1%">
							        <%-- <span class="w3-small">${prdvo.prdIdx}</span><br> --%>
							        <c:choose>
								    	<c:when test="${pvo.ebrName == 'Nike'}">
								    		<img class="w3-round-large" src="${ctp}/product/${prdvo.prdfName}" alt="Card image" style="width: 50px;height: 50px;background-color: #EBF0F5">
								    	</c:when>
								    	<c:when test="${pvo.ebrName == 'Jordan'}">
								    		<img class="w3-round-large" src="${ctp}/product/${prdvo.prdfName}" alt="Card image" style="width: 50px;height: 50px;background-color: #F6EEED">
								    	</c:when>
								    	<c:when test="${pvo.ebrName == 'Adidas'}">
								    		<img class="w3-round-large" src="${ctp}/product/${prdvo.prdfName}" alt="Card image" style="width: 50px;height: 50px;background-color: #F1F1EA">
								    	</c:when>
								    	<c:otherwise>
								    		<img class="w3-round-large" src="${ctp}/product/${prdvo.prdfName}" alt="Card image" style="width: 50px;height: 50px;background-color: #F5F5F5">
								    	</c:otherwise>
								    </c:choose>
							      </div>
							      <div class="w3-bar-item" style="width: 10%;margin-right: 1%">
							        <span class="w3-small">${prdvo.ebrName}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 18%;margin-right: 1%">
							        <span class="w3-small">${prdvo.eprdName}</span><br>
							        <span class="w3-small">${prdvo.kprdName}</span>
							      </div>
							      <div class="w3-bar-item" style="width: 10%;margin-right: 1%">
							        <span class="w3-small">${prdvo.prdNum}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 7%;margin-right: 1%">
							        <span class="w3-small">${prdvo.prdCategory}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 7%;margin-right: 1%">
							        <span class="w3-small">${prdvo.prdSubCategory}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 9%;margin-right: 2%">
							        <span class="w3-small">${prdvo.color}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 7%;margin-right: 2%">
							        <span class="w3-small">${prdvo.RPrice}</span><br>
							      </div>
							      <div class="w3-bar-item" style="width: 7%;margin-right: 1%">
							        <span class="w3-small">${prdvo.SPrice}</span><br>
							        <c:if test="${prdvo.prdSale != 0}">
							        <span class="w3-small"><font color="red">할인율 ${prdvo.prdSale}%</font></span>
							        </c:if>
							      </div>
							      <div class="w3-bar-item" style="width: 7%">
							      	<c:if test="${prdvo.sellStop == 0}">
							        <span class="w3-small">판매중지</span><br>
							        <span class="w3-small">
							        	<label class="switch">
												  <input type="checkbox" id ="prdSellStop${prdvo.prdIdx}" onclick="prdSell('${prdvo.prdIdx}')">
												  <span class="slider round"></span>
												</label>
											</span><br>
							      	</c:if>
							      	<c:if test="${prdvo.sellStop == 1}">
							        <span class="w3-small">판매중</span><br>
							        <span class="w3-small">
							        	<label class="switch">
												  <input type="checkbox" id ="prdSell" onclick="prdSellStop('${prdvo.prdIdx}')"  checked >
												  <span class="slider round"></span>
												</label>
											</span><br>
							      	</c:if>
							      </div>
							      <div class="w3-bar-item" style="width: 3%">
							      	<div class="w3-dropdown-click w3-hover-white">
										    <span class="w3-large">
													<a href="javascript:myFunction('${st.index}')">
														<i class="fa fa-cog" aria-hidden="true"></i>
													</a>
												</span>
										    <div id="Demo${st.index}" class="w3-dropdown-content w3-bar-block w3-border">
										      <a onclick="productInfor('${prdvo.prdIdx}')" class="w3-bar-item w3-button">상세정보</a>
										      <a onclick="productUpdatePage('${prdvo.prdIdx}')" class="w3-bar-item w3-button">상품수정</a>
										    </div>
										  </div>
							      </div>
							    </li>
							  </ul>
							</c:forEach>	    
						</div>
			   </div>
						<div class="w3-container w3-center" style="margin-top: 10px">
							<div class="w3-bar text-center">
						  <c:if test="${not empty prdvos}">
						  <c:if test="${pagevo.pag != 1}">
						  <a href="${ctp}/admin/adProductList?pag=1&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.pag == 1}">
						  <a class="w3-button w3-xlarge w3-disabled">&laquo;</a>
						  </c:if>
						  <c:if test="${pagevo.curBlock > 1 }">
						  <a href="${ctp}/admin/adProductList?pag=${(pagevo.curBlock-1)*pagevo.blockSize+1}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">&laquo;</a>
						  </c:if>
						  <c:set var="no" value="${(pagevo.curBlock*pagevo.blockSize)+1}"/>
							<c:set var="size" value="${(pagevo.curBlock*pagevo.blockSize)+pagevo.blockSize}"/>
							<c:forEach var="i" begin="${no}" end="${size}">
								<c:choose>
									<c:when test="${i > pagevo.totPage}"></c:when>
									<c:when test="${i == pagevo.pag}">
										<a href="${ctp}/admin/adProductList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-theme-l4">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="${ctp}/admin/adProductList?pag=${i}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						  <c:if test="${pagevo.curBlock < pagevo.lastBlock}">
								<a href="${ctp}/admin/adProductList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&sort=${sort}" class="w3-button">&raquo;</a>	
							</c:if>
							<c:if test="${pagevo.pag != pagevo.totPage}">
								<a href="${ctp}/admin/adProductList?pag=${pagevo.totPage}&pageSize=${pagevo.pageSize}&sort=${sort}" class="w3-button w3-xlarge">&raquo;</a>
							</c:if>
							<c:if test="${pagevo.pag == pagevo.totPage}">
								<a class="w3-button w3-xlarge w3-disabled">&raquo;</a>
							</c:if>
						  </c:if>		
							</div>
						</div>
			 </div>
	 		</div>
	 		<div id="prdUpdate" class="w3-col m12" style="display: none">
	 			<div class="w3-card w3-round w3-white" style="width : 99%;height: 1200px">
			   <div class="w3-container">
			    <h4><b>상품 수정</b></h4>
					<hr style="border-width: 3px;border-color: black">
					<a href="javascript:productListPage()">◀ 돌아가기</a>
			    	<div class="w3-container" style="height: 700px">
			    		<form id="productForm" name="productForm" method="post">
			    			<div class="w3-row">
			    				<div class="w3-col m4">
			    					<div class="w3-bar-block" style="height: 320px">
											<div class="w3-center" style="width:400px;height: 300px">
										  	<img src="${ctp}/admin/noImage.jpg" class="w3-border w3-round-large" style="width: 90%;height: 300px;" id="productView" name="brandView"  alt="미리보기"/>
											</div>
										</div>
										<div class="w3-bar-block" style="width:400px;height: 70px">
											<input type="file" class="w3-input w3-border w3-round-large" name="file1" id="file1" style="width: 90%;margin-bottom: 10px;margin-left: 5%"/>
											<input type="hidden" name="prdIdx" id="prdIdx1" value="">
											<input type="hidden" name="prdfName" id="prdfName1" value="">
										</div>
			    				</div>
			    				<div class="w3-col m4">
			    					<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<select id="prdBrandOp" name="ebrName" class="w3-input w3-border w3-round" style="width: 90%;margin: auto">
												<c:forEach var="brvo" items="${brvos}">
												<option id="${brvo.ebrName}" value="${brvo.ebrName}">${brvo.ebrName}</option>
												</c:forEach>
											</select>
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
										<select id="prdCategoryOp" name="prdCategory" class="w3-input w3-border w3-round" style="width: 90%;margin: auto;margin-top: 5px">
											<c:forEach var="cvo" items="${ctvos}">
												<option id="${cvo.category}" value="${cvo.category}">${cvo.category}</option>
											</c:forEach>
										</select>
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<select id="prdSubCategoryOp" name="prdSubCategory" class="w3-input w3-border w3-round" style="width: 90%;margin: auto;margin-top: 5px">	
											</select>
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="text" id="kprdName1" name="kprdName" class="w3-input w3-border w3-round" placeholder="상품이름(한글)" style="width: 90%;margin: auto;margin-top: 5px">
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="text" id="eprdName1" name="eprdName" class="w3-input w3-border w3-round" placeholder="상품이름(영어)" style="width: 90%;margin: auto;margin-top: 5px">
										</div>
			    				</div>
			    				<div class="w3-col m4">
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="text" id="prdNum1" name="prdNum" class="w3-input w3-border w3-round" placeholder="모델번호" style="width: 90%;margin: auto">
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="text" id="prdColor1" name="color" class="w3-input w3-border w3-round" placeholder="색상" style="width: 90%;margin: auto;margin-top: 5px">
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="number" id="rPrice1" name="rPrice" class="w3-input w3-border w3-round" placeholder="원가" style="width: 90%;margin: auto;margin-top: 5px">
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px">
											<input type="number" id="sPrice1" name="sPrice" class="w3-input w3-border w3-round" placeholder="판매가" style="width: 90%;margin: auto;margin-top: 5px">
										</div>
										<div class="w3-bar-block" style="height: 70px;margin-right:10px;padding-left: 25px">
										<label> <font color="gray">할인율 %</font></label>
										<input type="number" id="prdSale1" name="prdSale" min="0" max="100" maxlength="3" name="sPrice" class="w3-input w3-border w3-round w3-left" placeholder="할인 적용 %" style="width: 100px;margin: auto;margin-top: 5px">
									
										</div>
										<div id="demo4" class="w3-center"></div>
			    				</div>
			    			</div>
			    			<div class="row">
			    				<div class="w3-col m12">
			    					<textarea rows="4" name="prdContent" id="CKEDITOR" class="form-control" required></textarea>
										<script>
							      	CKEDITOR.replace("prdContent",{
							      		height:500,
							      		filebrowserUploadUrl:"${ctp}/imageUpload",
							      		uploadUrl : "${ctp}/imageUpload"
							      	});
							      </script>
							      <div class="w3-bar-block w3-center">
											<input type="button" id="productInput" class="w3-button w3-border w3-round w3-theme-l4" value="상품 등록" style="width: 300px;margin: auto;margin-top: 10px">
										</div>
			    				</div>
			    			</div>
			    			</form>
						</div>
			   </div>
			 </div>
	 		</div>
	 	</div>
	 </div>
	 <div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-animate-opacity w3-card-4">
      <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
      <div class="w3-container w3-padding">
      	<h4><b>상품 정보</b></h4>
				<hr style="border-width: 3px;border-color: black">
				<div class="w3-container">
					<div class="w3-row">
						<div class="w3-col m5">
							<div class="w3-container w3-center">
				        <div style="width:300px;height: 300px">
									<img src="${ctp}/admin/noImage.jpg" class="w3-border w3-round-large" style="width: 300px;height: 300px;" id="prdfName" alt="미리보기"/>
								</div>
								<div class="w3-bar-item w3-margin-top w3-margin-bottom">
									<span class="w3-medium" id="eprdName"></span><br>
									<span class="w3-medium" id="kprdName"></span><br>
								</div>
							</div>
						</div>
						<div class="w3-col m7 w3-border w3-padding w3-round-large">
						<table class="w3-table" style="width: 100%">
							<tr>
								<th style="width: 20%">상품번호</th>
								<td id="prdIdx" style="width: 30%"></td>
								<th style="width: 15%">브랜드</th>
								<td id="ebrName" style="width: 35%"></td>
							</tr>
							<tr>
								<th>분류1</th>
								<td id="prdCategory"></td>
								<th>분류2</th>
								<td id="prdSubCategory"></td>
							</tr>
							<tr>
								<th>상품코드</th>
								<td id="prdNum"></td>
								<th>색상</th>
								<td id="prdColor"></td>
							</tr>
							<tr>
								<th>원가</th>
								<td id="prdrPrice"></td>
								<th>판매가</th>
								<td id="prdsPrice"></td>
							</tr>
						</table>
						</div>
						<div class="w3-col m7 w3-border w3-padding w3-round-large w3-margin-top">
							<table class="w3-table" id="prdOptions">
								
							</table>
						</div>
					</div>
				</div>
      </div>
    </div>
  </div>
	 <script>
	 function productUpdatePage(idx){
		 $("#prdList").hide();
	   $("#prdUpdate").fadeIn();
	   
	   let prdIdx = idx;
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getPrdInfor",
			data : {
				prdIdx : prdIdx
			},
			success : function(vos){
				$("#productView").attr("src", "${ctp}/product/"+vos[0].prdfName);
				$("#"+vos[0].ebrName).attr("selected", true);
				$("#"+vos[0].prdCategory).attr("selected", true);
				$("#kprdName1").val(vos[0].kprdName);
				$("#eprdName1").val(vos[0].eprdName);
				$("#prdIdx1").val(vos[0].prdIdx);
				$("#prdNum1").val(vos[0].prdNum);
				$("#prdColor1").val(vos[0].color);
				$("#rPrice1").val(vos[0].rprice);
				$("#sPrice1").val(vos[0].sprice);
				$("#prdfName1").val(vos[0].prdfName);
				$("#prdSale1").val(vos[0].prdSale);
				CKEDITOR.instances.CKEDITOR.setData(vos[0].prdContent);
				
				let prdCategoryOp = vos[0].prdCategory;
				let prdSubCategory = vos[0].prdSubCategory;
				
				$.ajax({
					type : "post",
					url : "${ctp}/admin/getSubCategory",
					data : {
						category : prdCategoryOp
					},
					success : function(voss){
						let data = '';
						if(vos != null){
							for(let i = 0; i<voss.length; i++){
								if(prdSubCategory == voss[i].subcategory){
									data += '<option value='+voss[i].subcategory+' selected="selected">'+voss[i].subcategory+'</option>';									
								}
								else{
									data += '<option value='+voss[i].subcategory+'>'+voss[i].subcategory+'</option>';									
								}
							}
						}
						$("#prdSubCategoryOp").append(data);
					},
					error : function(){
						
					}
				});
			}
		});
	 }
	 function productListPage(){
		 $("#prdList").fadeIn();
		 $("#prdUpdate").hide();
	 }
function myFunction(idx) {
  var x = document.getElementById("Demo"+idx);
  
  if (x.className.indexOf("w3-show") == -1) {
	  for(let i =0; i<6; i++){
		  if(idx == i){
    		x.className += " w3-show";
		  }
		  else{
		  	document.getElementById("Demo"+i).className = x.className.replace(" w3-show", "");			  
		  }
	  }
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>