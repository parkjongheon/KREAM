<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<meta charset="UTF-8">
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
	<title>message</title>
	<script>
		'use strict';
		let msg = '${msg}';
		let url = '${ctp}/${url}';
		let flag = '${flag}';
		//alert(msg);
		$().ready(function () {
			Swal.fire({
				  position: 'top',
				  icon: flag,
				  title: '${msg}',
				  showConfirmButton: false,
				  timer: 1000
			}).then(function(){
			location.href = url;							
			});
		});
		
	</script>
</head>
<body>

</body>
</html>