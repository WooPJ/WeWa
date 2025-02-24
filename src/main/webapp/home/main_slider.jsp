<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>슬라이드</title>
    <link rel="stylesheet" type="text/css" href="../css/slider.css">
</head>
<body>

<div class="slideshow-container">

  <div class="mySlides fade">
    <div class="numbertext">1 / 3</div>
    <a href=""><img src="../imgs/slider/image1.jpg" style="width:100%"></a>
  </div>

  <div class="mySlides fade">
    <div class="numbertext">2 / 3</div>
    <a href=""> <img src="../imgs/slider/image2.jpg" style="width:100%"></a>
  </div>

  <div class="mySlides fade">
    <div class="numbertext">3 / 3</div>
    <a href=""> <img src="../imgs/slider/image3.jpg" style="width:100%"></a>

  </div>

  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<br>

<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span> 
</div> 

<script>
var slideIndex = 1;
showSlides(slideIndex);

// 자동 슬라이드 변경 (5초 간격)
setInterval(function() {
  plusSlides(1); // 1번 슬라이드로 이동
}, 5000); // 5000ms = 5초

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
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
