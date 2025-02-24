<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>슬라이드</title>
    <link rel="stylesheet" type="text/css" href="../css/slider.css">
</head>
<body>

<div class="slideshow-container">
  <c:forEach var="slide" items="${sliderList}">
    <div class="mySlides fade">
      <a href=""><img src="${slide.image_url}" style="width:100%"></a>
    </div>
  </c:forEach>

  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<br>

<div style="text-align:center">
  <c:forEach var="slide" items="${sliderList}" varStatus="status">
    <span class="dot" onclick="currentSlide(${status.index + 1})"></span>
  </c:forEach>
</div> 

<script>
var slideIndex = 1;
showSlides(slideIndex);

setInterval(function() { // 자동 슬라이드 변경 (5초 간격)
  plusSlides(1); // 1번 슬라이드로 이동
}, 5000);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1} 
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none"; 
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block"; 
  dots[slideIndex-1].className += " active";
} 
</script>

</body>
</html> 
