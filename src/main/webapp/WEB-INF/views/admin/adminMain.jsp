<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	  bar();
	  tab();
	  pie();
});
function bar(){
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
	
}
function tab(){
	google.charts.load('current', {'packages':['table']});
	google.charts.setOnLoadCallback(drawTable);
	
	
	function drawTable() {
		var data = new google.visualization.DataTable();
        data.addColumn('string', '월');
        data.addColumn('number', '총매출');
        data.addColumn('number', '원가');
        data.addColumn('number', '순이익');
        data.addRows([
        	<c:forEach var='ms' items='${list}' varStatus='st'>
	        ['${ms.month}', ${ms.totals}, ${ms.rtot}, ${ms.stot}]<c:if test="${not st.last}">,</c:if>
	        </c:forEach>
        ]);
		
			 
	  
	  var table = new google.visualization.Table(document.getElementById('table_div'));

	  var formatter = new google.visualization.NumberFormat({pattern: '###,###'});
	  formatter.format(data,1);
	  formatter.format(data,2);
	  formatter.format(data,3);
	  
    table.draw(data, {showRowNumber: true, width: '100%', height: '100%'});
	}
	
}
function pie(){
	google.charts.load('current', {'packages':['corechart']}); 
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string','브랜드');
        data.addColumn('number','판매량');

        data.addRows([ 
            <c:forEach var='p' items='${pie}' varStatus='sts'>
	        ['${p.kprdName}', ${p.cnt}]<c:if test="${not sts.last}">,</c:if>
	        </c:forEach>
        ]);
        var opt = {
                'title':'top5 상품 (pie)',
                'width':500,
                'height':500,
                pieSliceText:'label',
                legend:'none' 
        };
        var chart = new google.visualization.PieChart(document.getElementById('myChart'));
        chart.draw(data,opt);
        
        var bar_options = {'title':'top5 상품 (bar)',
                'width':600,
                'height':480};

			 var bar_chart = new google.visualization.BarChart(document.getElementById('barchart_div'));
			 bar_chart.draw(data, bar_options);
    }
	
}
</script>
</head>
<body class="w3-light-grey">
<%-- <jsp:include page="/WEB-INF/views/include/adNav.jsp" /> --%>
<jsp:include page="/WEB-INF/views/include/adSide.jsp" />
<div class="w3-content" style="max-width:2000px;margin-left:320px;">
	<div class="w3-card w3-round w3-white" style="width: 1570px;height: 1000px;margin-top: 10px">
       <div class="w3-container">
        <h4 class="w3-center">관리자 페이지</h4>
        <hr>
        <div class="w3-row">
        	<div class="w3-col m8">
		        <div id="columnchart_material" style="width: 800px; height: 400px;"></div>
        	</div>
        	<div class="w3-col m4">
		        <div id="table_div" style="width: 500px; height: 400px;"></div>
        	</div>
        </div>
        <div class="w3-row">
        	<div class="w3-col m6">
		        <div id="myChart" style="width: 800px; height: 400px;"></div>
        	</div>
        	<div class="w3-col m6">
		        <div id="barchart_div" style="width: 800px; height: 400px;"></div>
        	</div>
        </div>
       </div>
     </div>
</div>
</body>
</html>