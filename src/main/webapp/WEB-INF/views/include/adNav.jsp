<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- Navbar -->
<div class="w3-top" style="z-index:1">
  <div class="w3-bar w3-card w3-white w3-large">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
  	<div class="w3-bar-item w3-padding-large w3-left">
  		<img alt="" src="${ctp}/logo/logo1.png" >
  	</div>
    <a href="${ctp}/" class="w3-padding-large w3-hide-small w3-right" style="margin-top: 5px"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;나가기</a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<!-- <div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
</div>
<script>
// Automatic Slideshow - change image every 4 seconds
var myIndex = 0;


// Used to toggle the menu on small screens when clicking on the menu button
function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script> -->