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
<link rel="stylesheet" type="text/css" href="/css/itemReview.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	<div class="sort-container">
		<label for="sort">정렬:</label> <select id="sort"
			onchange="sortProducts()">
			<option value="default" ${param.sort == 'default' ? 'selected' : ''}>기본</option>
			<option value="starpoint-desc"
				${param.sort == 'starpoint-desc' ? 'selected' : ''}>별점 높은순</option>
			<option value="starpoint-asc"
				${param.sort == 'starpoint-asc' ? 'selected' : ''}>별점 낮은순</option>
			<option value="date-desc"
				${param.sort == 'date-desc' ? 'selected' : ''}>최근 날짜순</option>
			<option value="date-asc"
				${param.sort == 'date-asc' ? 'selected' : ''}>오래된 날짜순</option>
		</select>
	</div>

	<table>
		<thead>
			<tr>
				<th>작성자</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성일</th>
				<th>별점</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="review" items="${reviews}">
				<tr>
					<td>${review.writer}</td>
					<td>${review.title}</td>
					<td>${review.content}</td>
					<td>${review.w_date}</td>
					<td>
						<div class="starpoint_box">
							<div class="starpoint_bg"
								style="width: ${review.item_rate * 20}%"></div>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


	<script type="text/javascript">

function sortProducts() {
    var sortOption = document.getElementById("sort").value;
    var itemCode = "${param.item_code}";  // JSP에서 item_code 값을 받아옴
    window.location.href = "/item/reviewSorted.html?item_code=" + itemCode + "&sort=" + sortOption;
}

// 리뷰 목록 업데이트 함수
function updateReviewTable(reviews) {
    var tableBody = document.querySelector("table tbody");
    tableBody.innerHTML = ""; // 기존 테이블 내용 비우기

    // 새로운 리뷰 데이터를 테이블에 추가
    reviews.forEach(function(review) {
        var row = document.createElement("tr");
        row.innerHTML = `
            <td>${review.writer}</td>
            <td>${review.title}</td>
            <td>${review.content}</td>
            <td>${review.w_date}</td>
            <td>
                <div class="starpoint_box">
                    <div class="starpoint_bg" style="width: ${review.item_rate * 20}%"></div>
                </div>
            </td>
        `;
        tableBody.appendChild(row);
    });
}

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