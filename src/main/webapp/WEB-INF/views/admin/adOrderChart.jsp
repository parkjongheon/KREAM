<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      $(document).ready(function(){
    	  ajaxData();
      });
			function ajaxData(){
				var request = $.ajax({
					type : "post",
					url : "${ctp}/admin/orderChartTotal"
				});
				request.done(function( msg ) {
					 		google.charts.load('current', {'packages':['bar']});
					    google.charts.setOnLoadCallback(drawChart);

					    function drawChart() {
					    	 var data = google.visualization.arrayToDataTable([
					    	        ['올해 매출', '총매출', '원가', '순익'],
					    	        <c:forEach var='ms' items='${list}' varStatus='st'>
					    	        ['${ms.month}', ${ms.totals}, ${ms.rtot}, ${ms.stot}]<c:if test="${not st.last}">,</c:if>
					    	        </c:forEach>
					    	      ]);
					    		 
					      var options = {
					        chart: {
					          title: '상품 판매 현황',
					        }
					      };
					      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
					      
					      var formatter = new google.visualization.NumberFormat({pattern: '###,###'});
					      formatter.format(data,1);
					      formatter.format(data,2);
					      formatter.format(data,3);
					      
					      chart.draw(data, google.charts.Bar.convertOptions(options));
					    }

					
					
				});
			}
     
    </script>
</head>
<body class="w3-light-grey">
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div class="w3-card w3-round w3-white" style="width: 1570px;height: 1000px;margin-top: 10px">
       <div class="w3-container">
        <h4 class="w3-center">총 매출 현황</h4>
        <hr>
        <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
        <table id="example" style="width:100%">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                        <tr>
                            <td></td>
                            <td>게시글입니다.</td>
                            <td>작성자</td>
                            <td></td>
                        </tr>
                </tbody>
            </table>
       </div>
     </div>
</div>
</body>
</html>