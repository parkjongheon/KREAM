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
			  title: msg+'(이)가 등록되었습니다',
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
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
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
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	$(function(){
		$("#brandInput").click(function(){
			$("#demo1").html("");
			let file = $("#file").val();
			let kbrName = $("#kbrName").val();
			let ebrName = $("#ebrName").val();
			
			if(file == ""){
				$("#demo1").html('<font color="red"><b>사진을 등록해주세요</b></font>');
			}
			else if(kbrName.trim() == ""){
				$("#demo1").html('<font color="red"><b>브랜드이름(한글)을 입력해주세요</b></font>');
			}
			else if(ebrName.trim() == ""){
				$("#demo1").html('<font color="red"><b>브랜드이름(영어)을 입력해주세요</b></font>');
			}
			else{
				let form = $("#brandForm")[0];
				let formData = new FormData(form);
				formData.append("brandImage",$("#file")[0].files[0]);
				$.ajax({
					type : "post",
					url : "${ctp}/admin/brandInput",
					data : formData,
					contentType : false,
					processData : false,
					success : function(res){
						if(res == 1){
							msg('브랜드');						
						}
						else{
							alert("에러");
						}
					},
					error : function(){
						alret("전송오류");
					}
				});
			}
		});
	})
	$(function(){
		$("#categoryInput").click(function(){
			$("#demo2").html("");
			let category = $("#category").val();
			if(category.trim() == ""){
				$("#demo2").html('<font color="red"><small><b>카테고리를 입력해주세요</b></small></font>');
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/admin/categoryInput",
					data : {
						category : category
					},
					success : function(res){
						if(res == '1'){
							msg('카테고리');								
						}
						else{
							$("#demo2").html('<font color="red"><small><b>카테고리가 중복됩니다.</b></small></font>');
							$("#category").focus();
						}
					},
					error : function(){
						alert("전송오류");
					}
				});
			}
		});
	})
	$(function(){
		$("#subCategoryInput").click(function(){
			$("#demo3").html("");
			let categoryOp = $("#categoryOp").val();
			let subCategory = $("#subCategory").val();
			
			if(categoryOp == null){
				$("#demo3").html('<font color="red"><small><b>카테고리를 선택해주세요</b></small></font>');
			}
			else if(subCategory.trim() == ""){
				$("#demo3").html('<font color="red"><small><b>서브카테고리를 입력해주세요</b></small></font>');
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/admin/subCategoryInput",
					data : {
						subCategory : subCategory,
						category : categoryOp
					},
					success : function(res){
						if(res == '1'){
							msg('서브 카테고리');								
						}
						else{
							$("#demo3").html('<font color="red"><small><b>서브카테고리가 중복됩니다.</b></small></font>');
							$("#subCategory").focus();
						}
					},
					error : function(){
						alert("전송오류");
					}
				});
			}
		});
	})
	$(function(){
		$("#prdCategoryOp").on("change",function(){
			let prdCategoryOp = $("#prdCategoryOp").val();
			$("#prdSubCategoryOp > option").remove();
			
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getSubCategory",
				data : {
					category : prdCategoryOp
				},
				success : function(vos){
					let data = '<option value="" disabled="disabled" selected="selected">서브 카테고리 선택</option>';
					if(vos != null){
						for(let i = 0; i<vos.length; i++){
							data += '<option value='+vos[i].subcategory+'>'+vos[i].subcategory+'</option>';
						}
					}
					
					$("#prdSubCategoryOp").append(data);
				},
				error : function(){
					
				}
			});
		});
	})
	
	// (옵션등록) 브랜드 선택시 유효 카테고리
	$(function(){
		$("#opBrandOp").on("change",function(){
			
			$("#opCategoryOp > option").remove();
			$("#opSubCategoryOp > option").remove();
			$("#opSubCategoryOp").append('<option value="" disabled="disabled" selected="selected">서브 카테고리 선택</option>');
			$("#opSizeOp > option").remove();
			$("#opSizeOp").append('<option value="" disabled="disabled" selected="selected">사이즈 선택</option>');
			$("#opProductOp > option").remove();
			$("#opProductOp").append('<option value="" disabled="disabled" selected="selected">상품 선택</option>');
			
			let brand = $("#opBrandOp").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getBrandCategory",
				data : {
					brand : brand
				},
				success : function(vos){
					let data = '<option value="" disabled="disabled" selected="selected">카테고리 선택</option>';
					if(vos != null){
						for(let i = 0; i<vos.length; i++){
							data += '<option value='+vos[i].prdCategory+'>'+vos[i].prdCategory+'</option>';
						}
					}
					$("#opCategoryOp").append(data);
				},
				error : function(){
					alert("전송오류");
				}
			});
		});
	})
	// (옵션등록) 카테고리 선택시 유효 서브 카테고리
	$(function(){
		$("#opCategoryOp").on("change",function(){
			$("#opProductOp > option").remove();
			$("#opProductOp").append('<option value="" disabled="disabled" selected="selected">상품 선택</option>');
			let brand = $("#opBrandOp").val();
			let category = $("#opCategoryOp").val();
			$("#opSubCategoryOp > option").remove();
			$("#opSizeOp > option").remove();
			
			let size = '<option value="" disabled="disabled" selected="selected">사이즈 선택</option>';
			
			if(category == "신발"){
				for(let i = 230; i<=285; i=i+5){
					size += '<option value='+i+'>'+i+'</option>';					
				}
			}
			else{
				size += '<option value="XL">XL</option>';
				size += '<option value="L">L</option>';
				size += '<option value="M">M</option>';
				size += '<option value="S">S</option>';
			}
			$("#opSizeOp").append(size);
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getBCSubCategory",
				data : {
					brand : brand,
					category : category
				},
				success : function(vos){
					let data = '<option value="" disabled="disabled" selected="selected">서브 카테고리 선택</option>';
					if(vos != null){
						for(let i = 0; i<vos.length; i++){
							data += '<option value='+vos[i].prdSubCategory+'>'+vos[i].prdSubCategory+'</option>';
						}
					}
					$("#opSubCategoryOp").append(data);
				},
				error : function(){
					alert("전송오류");
				}
			});
		});
	})
	// (옵션등록) 서브카테고리 선택시 유효 상품가져오기
	$(function(){
		$("#opSubCategoryOp").on("change",function(){
			let brand = $("#opBrandOp").val();
			let category = $("#opCategoryOp").val();
			let subCategory = $("#opSubCategoryOp").val();
			$("#opProductOp > option").remove();
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/getBCSProduct",
				data : {
					brand : brand,
					category : category,
					subCategory :subCategory
				},
				success : function(vos){
					let data = '<option value="" disabled="disabled" selected="selected">상품 선택</option>';
					if(vos != null){
						for(let i = 0; i<vos.length; i++){
							data += '<option value='+vos[i].prdIdx+'>'+vos[i].kprdName+'</option>';
						}
					}
					$("#opProductOp").append(data);
					
					
				},
				error : function(){
					alert("전송오류");
				}
			});
		});
	})
	// 옵션 등록
	$(function(){
		$("#optionInput").click(function(){
			$("#demo5").html('');
			
			let brand = $("#opBrandOp").val();
			let category = $("#opCategoryOp").val();
			let subCategory = $("#opSubCategoryOp").val();
			let prdIdx = $("#opProductOp").val();
			let size = $("#opSizeOp").val();
			let count = $("#opPrdCountOp").val();
			
			if(brand == null){
				$("#demo5").html('<font color="red"><small><b>브랜드를 선택해주세요</b></small></font>');
				$("#opBrandOp").focus();
			}
			else if(category == null){
				$("#demo5").html('<font color="red"><small><b>카테고리를 선택해주세요</b></small></font>');
				$("#opCategoryOp").focus();
			}
			else if(subCategory == null){
				$("#demo5").html('<font color="red"><small><b>서브 카테고리를 선택해주세요</b></small></font>');
				$("#opSubCategoryOp").focus();
			}
			else if(prdIdx == null){
				$("#demo5").html('<font color="red"><small><b>상품을 선택해주세요</b></small></font>');
				$("#opProductOp").focus();
			}
			else if(size == null){
				$("#demo5").html('<font color="red"><small><b>사이즈를 선택해주세요</b></small></font>');
				$("#opSizeOp").focus();
			}
			else if(count == null){
				$("#demo5").html('<font color="red"><small><b>수량을 입력해주세요</b></small></font>');
				$("#opPrdCountOp").focus();
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/admin/optionInput",
					data : {
						prdIdx : prdIdx,
						size : size,
						count : count
					},
					success : function(res){
						if(res == 1){
							Swal.fire({
								  position: 'top',
								  icon: 'success',
								  title: '옵션이 등록되었습니다',
								  showConfirmButton: false,
								  timer: 1000
							})							
						}
						else{
							$("#demo5").html('<font color="red"><small><b>사이즈가 중복됩니다.</b></small></font>');
							$("#opSizeOp").focus();
						}
					},
					error : function(){
						alert("전송오류");
					}
				});
			}
		});
	})
	// 상품 등록 
	$(function(){
		$("#productInput").click(function(){
			$("#demo4").html("");
			
			let text = CKEDITOR.instances['CKEDITOR'].getData();
			
			$("textarea#CKEDITOR").val(text);
			
			let file1 = $("#file1").val();
			let prdBrandOp = $("#prdBrandOp").val();
			let prdCategoryOp = $("#prdCategoryOp").val();
			let prdSubCategoryOp = $("#prdSubCategoryOp").val();
			let kprdName = $("#kprdName").val();
			let eprdName = $("#eprdName").val();
			let prdColor = $("#prdColor").val();
			let rPrcie = $("#rPrcie").val();
			let sPrcie = $("#sPrcie").val();
			
			if(file1 == ""){
				$("#demo4").html('<font color="red"><small><b>상품 사진을 등록해주세요</b></small></font>');
			}
			else if(prdBrandOp == null){
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
				formData.append("productImage",$("#file1")[0].files[0]);
				$.ajax({
					type : "post",
					url : "${ctp}/admin/setProductInput",
					data : formData,
					contentType : false,
					processData : false,
					success : function(res){
						if(res == 1){
							msg('상품');						
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
	<div class="w3-row">
		<div class="w3-col m4">
			<div class="w3-card w3-round w3-white" style="height: 650px;margin-top: 10px;margin-right:20px">
		   <div class="w3-container">
		    <h4><b>브랜드 등록</b></h4>
		    <form id="brandForm" name="brandForm" method="post">
		    <div class="w3-cell" >
					<div class="w3-bar-block" style="height: 320px">
						<div class="w3-center" style="height: 300px">
					  	<img src="${ctp}/admin/noImage.jpg" class="w3-border w3-round-large" style="width: 300px;height: 300px;" id="brView" alt="미리보기"/>
						</div>
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="file" class="w3-input w3-border w3-round-large" name="file" id="file" style="width: 70%;margin: auto;margin-top: 10px"/>
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="text" id="kbrName" name="kbrName" class="w3-input w3-border w3-round" placeholder="브랜드 이름(한글)" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
					<div class="w3-bar-block" style="height: 50px">
						<input type="text" id="ebrName" name="ebrName" class="w3-input w3-border w3-round" placeholder="브랜드 이름(영어)" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
					<div id="demo1" class="w3-center"></div>
					<div class="w3-bar-block w3-center" style="height: 50px">
						<input type="button" id="brandInput" class="w3-button w3-border w3-round w3-theme-l4" value="브랜드 등록" style="width: 70%;margin: auto;margin-top: 10px">
					</div>
				</div>
		    </form>
		   </div>
		 	</div>
		 	<div class="w3-col m6">
				<div class="w3-card w3-round w3-white" style="height: 500px;margin-top: 10px;margin-right:20px;margin-bottom: 20px">
			   <div class="w3-container ">
			    <h5><b>카테고리등록</b></h5>
			    <div class="w3-cell">
						<div class="w3-bar-block" style="height: 50px">
							<input type="text" id="category" class="w3-input w3-border w3-round" placeholder="카테고리" style="width: 100%;margin: auto;margin-top: 20px">
						</div>
						<div id="demo2"></div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" id="categoryInput" class="w3-button w3-border w3-round w3-theme-l4" value="카테고리 등록" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
						<br><br><br>
					<h5><b>SUB 카테고리등록</b></h5>
						<div class="w3-bar-block" style="height: 50px">
							<select id="categoryOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 20px">
								<option value="" disabled selected="selected">카테고리 선택</option>
								<c:forEach var="cvo" items="${ctvos}">
									<option value="${cvo.category}">${cvo.category}</option>
								</c:forEach>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<input type="text" id="subCategory" class="w3-input w3-border w3-round" placeholder="서브 카테고리" style="width: 100%;margin: auto;margin-top: 5px">
						</div>
						<div id="demo3"></div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" id="subCategoryInput" class="w3-button w3-border w3-round w3-theme-l4" value="서브 카테고리 등록" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
					</div>
			   </div>
			 	</div>
			</div>
			<div class="w3-col m6">
				<div class="w3-card w3-round w3-white" style="height: 500px;margin-top: 10px;margin-right:20px;margin-bottom: 20px">
			   <div class="w3-container ">
			    <h5><b>옵션 등록</b></h5>
			    <div class="w3-cell">
						<div class="w3-bar-block " style="height: 50px">
							<select id="opBrandOp" class="w3-input w3-border w3-round " style="width: 100%;margin: auto;margin-top: 20px">
								<option value="no" disabled="disabled" selected="selected">브랜드 선택</option>
								<c:forEach var="brvo" items="${brvos}">
									<option value="${brvo.ebrName}">${brvo.ebrName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">	
						<select id="opCategoryOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 10px">
							<option value="" disabled selected="selected">카테고리 선택</option>
						</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<select id="opSubCategoryOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 10px">
								<option value="" disabled="disabled" selected="selected">서브카테고리 선택</option>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<select id="opProductOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 10px">
								<option value="" disabled="disabled" selected="selected">상품 선택</option>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<select id="opSizeOp" class="w3-input w3-border w3-round" style="width: 100%;margin: auto;margin-top: 10px">
								<option value="" disabled="disabled" selected="selected">사이즈 선택</option>
							</select>
						</div>
						<div class="w3-bar-block" style="height: 50px">
							<input type="number" id="opPrdCountOp" class="w3-input w3-border w3-round" placeholder="상품 수량" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
						<div id="demo5" class="w3-center"></div>
						<div class="w3-bar-block w3-center" style="height: 50px">
							<input type="button" id="optionInput" class="w3-button w3-border w3-round w3-theme-l4" value="옵션 등록" style="width: 100%;margin: auto;margin-top: 10px">
						</div>
					</div>
			   </div>
			 	</div>
			</div>
		</div>
		<div class="w3-col m8">
			<div class="w3-card w3-round w3-white" style="height: 1160px;margin-top: 10px;margin-right:20px;margin-bottom: 20px">
		   <div class="w3-container">
		    <h4><b>상품 등록</b></h4>
		    <form id="productForm" name="productForm" method="post">
    			<div class="w3-row">
    				<div class="w3-col m4">
    					<div class="w3-bar-block" style="height: 320px">
								<div class="w3-center" style="height: 300px">
							  	<img src="${ctp}/admin/noImage.jpg" class="w3-border w3-round-large" style="width: 90%;height: 300px;" id="productView" name="brandView"  alt="미리보기"/>
								</div>
							</div>
							<div class="w3-bar-block" style="height: 70px">
								<input type="file" class="w3-input w3-border w3-round-large" name="file1" id="file1" style="width: 90%;margin-bottom: 10px;margin-left: 5%"/>
							</div>
    				</div>
    				<div class="w3-col m4">
    					<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<select id="prdBrandOp" name="ebrName" class="w3-input w3-border w3-round" style="width: 90%;margin: auto">
									<option value="" disabled="disabled" selected="selected">브랜드 선택</option>
									<c:forEach var="brvo" items="${brvos}">
									<option value="${brvo.ebrName}">${brvo.ebrName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
							<select id="prdCategoryOp" name="prdCategory" class="w3-input w3-border w3-round" style="width: 90%;margin: auto;margin-top: 5px">
								<option value="" disabled selected="selected">카테고리 선택</option>
								<c:forEach var="cvo" items="${ctvos}">
									<option value="${cvo.category}">${cvo.category}</option>
								</c:forEach>
							</select>
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<select id="prdSubCategoryOp" name="prdSubCategory" class="w3-input w3-border w3-round" style="width: 90%;margin: auto;margin-top: 5px">
									<option value="" disabled="disabled" selected="selected">서브 카테고리 선택</option>
								</select>
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="text" id="kprdName" name="kprdName" class="w3-input w3-border w3-round" placeholder="상품이름(한글)" style="width: 90%;margin: auto;margin-top: 5px">
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="text" id="eprdName" name="eprdName" class="w3-input w3-border w3-round" placeholder="상품이름(영어)" style="width: 90%;margin: auto;margin-top: 5px">
							</div>
    				</div>
    				<div class="w3-col m4">
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="text" id="prdNum" name="prdNum" class="w3-input w3-border w3-round" placeholder="모델번호" style="width: 90%;margin: auto">
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="text" id="prdColor" name="color" class="w3-input w3-border w3-round" placeholder="색상" style="width: 90%;margin: auto;margin-top: 5px">
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="number" id="rPrice" name="rPrice" class="w3-input w3-border w3-round" placeholder="원가" style="width: 90%;margin: auto;margin-top: 5px">
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px">
								<input type="number" id="sPrice" name="sPrice" class="w3-input w3-border w3-round" placeholder="판매가" style="width: 90%;margin: auto;margin-top: 5px">
							</div>
							<div class="w3-bar-block" style="height: 70px;margin-right:10px;padding-left: 15px">
									<label> <font color="gray">%</font></label>
									<input type="number" id="prdSale" name="prdSale" min="0" max="100" maxlength="3" name="sPrice" class="w3-input w3-border w3-round w3-left" placeholder="할인 적용 %" style="width: 120px;margin: auto;margin-top: 5px" value="0">									
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
</body>
</html>