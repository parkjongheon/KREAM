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
<script type="text/javascript">
	'use strict';
	
	function msg(data){
		let msg = data;
		Swal.fire({
			  position: 'top',
			  icon: 'success',
			  title: msg,
			  showConfirmButton: false,
			  timer: 1000
		}).then(function(){
		location.reload();							
		});
	}

	$(function() {
	    $("#file").on('change', function(){
	    readURL(this);
	    });
	});
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	        $('#brView').attr('src', e.target.result);
	        let filename = $("#file").val().substring(12,$("#file").val().length);
	        $('#brfName').val(filename);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	$(function(){
		$("#brandUpdate").click(function(){
			$("#demo1").html("");
			let kbrName = $("#kbrName").val();
			let ebrName = $("#ebrName").val();
			let file = $("#file").val();
			
			if(kbrName.trim() == ""){
				$("#demo1").html('<font color="red"><b>브랜드이름(한글)을 입력해주세요</b></font>');
			}
			else if(ebrName.trim() == ""){
				$("#demo1").html('<font color="red"><b>브랜드이름(영어)을 입력해주세요</b></font>');
			}
			else{
				let form = $("#brandForm")[0];
				let formData = new FormData(form);
				if(file != null){
					formData.append("brandImage",$("#file")[0].files[0]);					
				}
				$.ajax({
					type : "post",
					url : "${ctp}/admin/adBrandUpdate",
					data : formData,
					contentType : false,
					processData : false,
					success : function(){
						msg('브랜드가 수정되었습니다');
					},
					error : function(){
						alret("전송오류");
					}
				});
			}
		});
	})
	function updateBrand(res){
		let brIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getBrandInfo",
			data : {
				brIdx : brIdx
			},
			success : function(vo){
				$('#brView').attr('src', '${ctp}/brand/'+vo.brfName);
				$("#brfName").val(vo.brfName);
				$("#kbrName").val(vo.kbrName);
				$("#ebrName").val(vo.ebrName);
				$("#brIdx").val(brIdx);
				$("#id01").css('display','block');
			}
		});
	}
	function deleteBrand(res){
		let brIdx = res;
		$.ajax({
			type : "post",
			url : "${ctp}/admin/getBrandPrd",
			data : {
				brIdx : brIdx
			},
			success : function(str){
				if(str == '0'){
					alert("선택한 브랜드로 등록된 상품이있어 지울수없습니다.");
				}
				else{
					$.ajax({
						type : "post",
						url : "${ctp}/admin/deleteBrand",
						data : {
							brIdx : brIdx
						},
						success : function(){
							location.reload();
						}
					});
				}
			}
		});
	}
	
	function categoryUpdate(){
		$("#demo2").html('');	
		let category = $("#category").val();
		let categoryOp = $("#categoryOp").val();
		
		if(categoryOp == null){
			$("#demo2").html('<font color="red"><small><b>수정할 카테고리를 선택하세요</b></small></font>');			
		}
		else if(category == ""){
			$("#demo2").html('<font color="red"><small><b>카테고리를 입력하세요</b></small></font>');						
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/admin/cateUpdate",
				data : {
					idx : categoryOp,
					category : category
				},
				success : function(str){
					if(str == '1'){
						msg('카테고리가 수정되었습니다');								
					}
					else{
						$("#demo2").html('<font color="red"><small><b>카테고리가 중복됩니다.</b></small></font>');
						$("#category").focus();
					}
				}
			});
		}
	}
	
	function subCategoryUpdate(){
		let subCategory = $("#subCategory").val();
		let subCategoryOp = $("#subCategoryOp").val();
		if(subCategoryOp == null){
			$("#demo3").html('<font color="red"><small><b>수정할 서브카테고리를 선택하세요</b></small></font>');	
		}
		else if(subCategory == ""){
			$("#demo3").html('<font color="red"><small><b>서브카테고리를 입력하세요</b></small></font>');	
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/admin/subCateUpdate",
				data : {
					idx : subCategoryOp,
					subcategory : subCategory
				},
				success : function(str){
					if(str == '1'){
						msg('서브 카테고리가 수정되었습니다.');								
					}
					else{
						$("#demo3").html('<font color="red"><small><b>서브카테고리가 중복됩니다.</b></small></font>');
						$("#subCategory").focus();
					}
				}
			});
		}
	}
	
	function categoryDelete(){
		let categoryOp = $("#categoryOp").val();
		if(categoryOp == null){
			$("#demo2").html('<font color="red"><small><b>삭제할 카테고리를 선택하세요</b></small></font>');			
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/admin/cateDelete",
				data : {
					idx : categoryOp
				},
				success : function(res){
					if(res == '1'){
						msg('카테고리가 삭제되었습니다.');								
					}
					else{
						$("#demo2").html('<font color="red"><small><b>카테고리가 등록된 상품이있습니다.</b></small></font>');
					}
				}
			});
		}
	}
	
	function subCategoryDelete(){
		let subCategoryOp = $("#subCategoryOp").val();
		if(subCategoryOp == null){
			$("#demo3").html('<font color="red"><small><b>삭제할 서브카테고리를 선택하세요</b></small></font>');	
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/admin/subCateDelete",
				data : {
					idx : subCategoryOp
				},
				success : function(res){
					if(res == '1'){
						msg('서브 카테고리가 삭제되었습니다.');								
					}
					else{
						$("#demo3").html('<font color="red"><small><b>서브카테고리가 등록된 상품이있습니다.</b></small></font>');
					}
				}
			});
		}
	}
</script>
</head>
<body class="w3-light-grey">
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div class="w3-row">
		<div class="w3-col m7" style="margin-top: 10px;margin-right:10px;">
			<div class="w3-card w3-round w3-white" style="width : 99%;height: 950px">
			   <div class="w3-container" style="height: 850px">
			    <h4><b>브랜드 리스트</b></h4>
					<hr style="border-width: 3px;border-color: black">
			    	<div class="w3-container" style="height: 700px">
			    		<table class="w3-table w3-centered w3-theme-l4 w3-round-large">
			    			<tr>
			    				<th style="width: 20%">사진</th>
			    				<th style="width: 50%">브랜드 명</th>
			    				<th style="width: 30%">기타</th>
			    			</tr>
			    		</table>
							<c:forEach var="brvo" items="${brvos}" varStatus="st">
							<ul class="w3-ul w3-round-large w3-margin-top">
								<li class="w3-bar w3-center w3-border-bottom">
									<div class="w3-bar-item" style="width: 20%;margin-right: 3%">
										<img class="card-img-top w3-border w3-round-large" src="${ctp}/brand/${brvo.brfName}" alt="Card image" style="width: 50px;height: 50px">
									</div>
									<div class="w3-bar-item" style="width: 56%">
										<span class="w3-small w3-left">${brvo.ebrName}</span><br>
										<span class="w3-small w3-left">${brvo.kbrName}</span>
									</div>
									<div class="w3-bar-item" style="width: 20%">
										<a href="javascript:updateBrand(${brvo.brIdx})" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">수정</a>
										<a href="javascript:deleteBrand(${brvo.brIdx})" class="w3-button w3-border w3-round w3-small" style="margin-top: 15px">삭제</a>
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
		<div class="w3-col m2">
				<div class="w3-card w3-round w3-white" style="height: 950px;margin-top: 10px;margin-right:20px;margin-bottom: 20px">
			   <div class="w3-container">
			    <div class="w3-cell">
			    <h4><b>카테고리 수정</b></h4>
					<hr style="border-width: 3px;border-color: black">
						<div class="w3-bar-block" style="height: 50px">
							<select id="categoryOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 20px">
								<option value="" disabled selected="selected">카테고리 선택</option>
								<c:forEach var="cvo" items="${ctvos}">
								<option value="${cvo.idx}">${cvo.category}</option>
								</c:forEach>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<input type="text" id="category" class="w3-input w3-border w3-round" placeholder="카테고리" style="width: 100%;margin: auto;margin-top: 20px">
						</div>
						<div id="demo2"></div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" onclick="categoryUpdate()" class="w3-button w3-border w3-round w3-theme-l4" value="카테고리 수정" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" onclick="categoryDelete()" class="w3-button w3-border w3-round w3-theme-l4" value="카테고리 삭제" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
					</div>
			   </div>
			 	</div>
			</div>
			<div class="w3-col m2">
				<div class="w3-card w3-round w3-white" style="height: 950px;margin-top: 10px;margin-right:20px;margin-bottom: 20px">
			   <div class="w3-container">
			    <div class="w3-cell">
			    <h4><b>SUB 카테고리 수정</b></h4>
					<hr style="border-width: 3px;border-color: black">
						<div class="w3-bar-block" style="height: 50px">
							<select id="subCategoryOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 20px">
								<option value="" disabled selected="selected">서브 카테고리 선택</option>
								<c:forEach var="subvo" items="${subvos}">
									<option value="${subvo.idx}">${subvo.subcategory}</option>
								</c:forEach>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<input type="text" id="subCategory" class="w3-input w3-border w3-round" placeholder="서브 카테고리" style="width: 100%;margin: auto;margin-top: 20px">
						</div>
						<div id="demo3"></div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" onclick="subCategoryUpdate()" class="w3-button w3-border w3-round w3-theme-l4" value="서브 카테고리 수정" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" onclick="subCategoryDelete()" class="w3-button w3-border w3-round w3-theme-l4" value="서브 카테고리 삭제" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
					</div>
			   </div>
			 	</div>
			</div>
		</div>
	</div>
<div id="id01" class="w3-modal">
	  <div class="w3-modal-content w3-card-4" style="overflow-y:scroll;width:400px;height: 700px">
	    <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-large w3-display-topright">&times;</span>
			<div class="w3-container">
		    <h4><b>브랜드 수정</b></h4>
		    <form id="brandForm" name="brandForm" method="post">
		    <div class="w3-cell" >
					<div class="w3-bar-block" style="height: 320px">
						<div class="w3-center" style="height: 300px">
					  	<img src="${ctp}/admin/noImage.jpg" class="w3-border w3-round-large" style="width: 300px;height: 300px;" id="brView" alt="미리보기"/>
						</div>
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="file" class="w3-input w3-border w3-round-large" name="file" id="file" style="width: 70%;margin: auto;margin-top: 10px"/>
						<input type="hidden" id="brfName" name="brfName">
						<input type="hidden" id="brIdx" name="brIdx">
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="text" id="kbrName" name="kbrName" class="w3-input w3-border w3-round" placeholder="브랜드 이름(한글)" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="text" id="ebrName" name="ebrName" class="w3-input w3-border w3-round" placeholder="브랜드 이름(영어)" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
					<div id="demo1" class="w3-center"></div>
					<div class="w3-bar-block w3-center" style="height: 50px">
						<input type="button" id="brandUpdate" class="w3-button w3-border w3-round w3-theme-l4" value="브랜드 수정" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
				</div>
		    </form>
		   </div>
	  </div>
  </div>
</body>
</html>