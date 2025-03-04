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
<link rel="stylesheet" type="text/css" href="/css/itemReviewAndWrite.css">
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
        <th>삭제</th>
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
			<td>
				<!-- 조건: 현재 로그인한 사용자와 리뷰 작성자가 같을 때만 수정/삭제 버튼 표시 -->
				<c:if test="${sessionScope.loginUser.id == review.writer}">
					<!-- 삭제 버튼 -->
					<form action="/review/delete.html" method="post">
						<input type="hidden" name="seqno" value="${review.seqno }">
						<input type="hidden" name="item_code" value="${item.item_code }">
						<input type="submit" value="삭제">
					</form>
				</c:if>
			</td>
			</tr>
    </c:forEach>
</table>
<div class="write-review">
    <h3>상품 리뷰 작성</h3>

    <c:choose>
        <c:when test="${sessionScope.loginUser == null}">
            <a href="/login/login.html">리뷰작성은 로그인 후 가능합니다.(로그인하러 가기)</a>
        </c:when>
        <c:otherwise>
            <!-- 리뷰 작성 폼 -->
            <div class="review">
                <form action="/review/submit" method="post" onsubmit="return confirmReview()">
                    <!-- 작성자는 로그인된 사용자 정보에서 가져오기 -->
                    <input type="hidden" name="writer" value="${sessionScope.loginUser.id}">
                    <!-- 상품 코드 (숨김 처리) -->
                    <input type="hidden" name="item_code" value="${item.item_code}" />
                    
                    <table>
                        <tr>
                            <td><label for="review_title">제목:</label></td>
                            <td><input type="text" name="review_title" id="review_title" required></td>
                        </tr>
                        <tr>
                            <td><label for="content">내용:</label></td>
                            <td><textarea name="content" id="content" rows="8" cols="50" required></textarea></td>
                        </tr>
                        <tr>
                            <td><label for="item_rate">별점:</label></td>
                            <td>
                                <div class="starpoint_wrap">
                                    <div class="starpoint_box">
                                        <label for="starpoint_1" class="label_star" title="1"><span class="blind">1점</span></label> 
                                        <label for="starpoint_2" class="label_star" title="2"><span class="blind">2점</span></label>
                                        <label for="starpoint_3" class="label_star" title="3"><span class="blind">3점</span></label> 
                                        <label for="starpoint_4" class="label_star" title="4"><span class="blind">4점</span></label>
                                        <label for="starpoint_5" class="label_star" title="5"><span class="blind">5점</span></label> 
                                        <input type="radio" name="item_rate" id="starpoint_1" class="star_radio" value="1" required>
                                        <input type="radio" name="item_rate" id="starpoint_2" class="star_radio" value="2">
                                        <input type="radio" name="item_rate" id="starpoint_3" class="star_radio" value="3">
                                        <input type="radio" name="item_rate" id="starpoint_4" class="star_radio" value="4">
                                        <input type="radio" name="item_rate" id="starpoint_5" class="star_radio" value="5">
                                        <span class="starpoint_bg"></span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
<!--                             <td><label for="w_date">작성일:</label></td>
                            <td><input type="text" name="w_date" id="w_date" readonly></td> -->
                        </tr>
                    </table>
                    
                    <br/>
                    <input type="submit" value="리뷰 등록">
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script type="text/javascript">
// 리뷰 제출 전에 확인 메시지를 띄우는 함수
function confirmReview() {
    var confirmation = confirm("리뷰를 등록하시겠습니까?");
    if (confirmation) {
        alert("리뷰가 성공적으로 작성되었습니다.");
        return true;  // 폼 제출
    } else {
        return false;  // 폼 제출 취소
    }
}
// 별점 선택 시 hidden input에 저장
document.querySelectorAll('.star_radio').forEach((radio) => {
  radio.addEventListener('change', function () {
    console.log("선택된 별점:", this.value);
  });
});

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