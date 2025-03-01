<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>  
<html>
<head>
<meta charset="UTF-8">
<title>상품 리뷰 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/items.css">
<style type="text/css">
.starpoint_box {
  position: relative;
  display: inline-block;
  background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;
  width: 100px; /* 5 * 20px, 별 하나당 20px */
  height: 18px;
}

.starpoint_box .starpoint_bg {
  position: absolute;
  top: 0;
  left: 0;
  height: 18px;
  background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;
  pointer-events: none;
}
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #f4f4f4;
        color: #555;
    }
   .starpoint_wrap {
    display: inline-block;
  }
  .starpoint_box {
    position: relative;
    background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;
    font-size: 0;
  }
  .starpoint_box .starpoint_bg {
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    height: 18px;
    background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;
    pointer-events: none;
  }
  .starpoint_box .label_star {
    display: inline-block;
    width: 20px;
    height: 18px;
    box-sizing: border-box;
  }
  .starpoint_box .star_radio {
    opacity: 0;
    width: 0;
    height: 0;
    position: absolute;
  }
  /* 정수 별점 (1~5) */
  .starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
  .starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg { width: 20%; }
  .starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
  .starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg { width: 40%; }
  .starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
  .starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg { width: 60%; }
  .starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
  .starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg { width: 80%; }
  .starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
  .starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg { width: 100%; }

  .blind {
    position: absolute;
    clip: rect(0 0 0 0);
    margin: -1px;
    width: 1px;
    height: 1px;
    overflow: hidden;
  }   
  .prev, .next {
    cursor: pointer;
    position: absolute;
    top: 45%;
    padding: 16px;
    color: white;
    font-size: 20px; /* 화살표 크기 증가 */
    font-weight: bold;
    background-color: rgba(0, 0, 0, 0.5); /* 배경색을 조금 어두운 색으로 설정 */
    border: none;
    user-select: none;
    transition: 0.3s;
    transform: translateY(-50%);
}


.prev:hover, .next:hover {
    background-color: rgba(0, 0, 0, 0.8);
}

/* 화살표 버튼 위치 */
.prev {
    left: 5px; /* 왼쪽 버튼 */
}

.next {
    right: 5px; /* 오른쪽 버튼 */
}
</style>
</head>
<body>
<br/><br/><br/><br/><br/><br/><br/><br/>	
<h2>리뷰목록</h2>
<!-- 상품 정보 -->
<c:set var="item_code" value="${param.item_code}" />
<c:set var="imageList" value="${fn:split(item.imagename, ',')}" />
   <div class="slideshow-container">
       <c:forEach var="image" items="${imageList}" varStatus="status">
           <div class="mySlides fade" style="display: ${status.index == 0 ? 'block' : 'none'};">
               <img src="${image}" class="myItem-image" width="320" height="350"/>
           </div>
       </c:forEach>

       <!-- 이전 버튼 -->
       <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
       <!-- 다음 버튼 -->
       <a class="next" onclick="plusSlides(1)">&#10095;</a>
   </div>	
<div class="product-name"><h3>${item.item_title}</h3></div>

<table>
    <tr>
        <th>작성자</th>
        <th>제목</th>
        <th>내용</th>
        <th>작성일</th>
        <th>별점</th>
    </tr>
    <c:forEach var="review" items="${reviews}">
        <tr>
            <td>
                <div class="review-writer">${review.writer}</div>
            </td>
            <td>
            	<div class="review-title">${review.title }</div>
            </td>
            <td>
            	<div class="review-content">${review.content }</div>
            </td>
            <td>
            	<div class="review-w_date">${review.w_date }</div>
            </td>
			<td>
				<div class="starpoint_box">
						<!-- 빈 별 배경 (기본) -->
				<div class="starpoint_bg" style="width: ${review.item_rate * 20}%"></div>
				</div>
			</td>
			</tr>
    </c:forEach>
</table>
				
			
<script type="text/javascript">

// 현재 날짜를 hidden input에 설정
function setCurrentDate() {
  const now = new Date();
  const formattedDate = now.toISOString().slice(0, 19).replace('T', ' '); // YYYY-MM-DD HH:MM:SS 형태
  document.getElementById("w_date").value = formattedDate;
}
//이미지 관련 스크립트
var slideIndex = 0;

function plusSlides(n) {
showSlides(slideIndex += n);
}

function showSlides(n) {
var slides = document.getElementsByClassName("mySlides");
if (n >= slides.length) {slideIndex = 0}
if (n < 0) {slideIndex = slides.length - 1}

// 모든 슬라이드를 숨기고, 현재 인덱스의 슬라이드만 보이게 설정
for (var i = 0; i < slides.length; i++) {
   slides[i].style.display = "none"; 
}
slides[slideIndex].style.display = "block";
}

// 첫 번째 슬라이드 자동으로 보여줌
showSlides(slideIndex);
</script>
</body>
</html>