<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
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
    
</style>
</head>
<body>
<br/><br/><br/><br/><br/><br/><br/><br/>	
<h2>리뷰목록</h2>
<!-- 상품 정보 -->
<c:set var="item_code" value="${param.item_code}" />
<img class="product-image" src="${item.imagename}" width="400" height="450" />
<div class="product-name"><h3>${item.item_title}</h3></div>

<table>
    <tr>
        <th>리뷰번호</th>
        <th>작성자</th>
        <th>제목</th>
        <th>내용</th>
        <th>작성일</th>
        <th>별점</th>
    </tr>
    <c:forEach var="review" items="${reviews}">
        <tr>
            <td>
                <div class="review-seqno">${review.seqno}</div>
            </td>
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
				
<div class="write-review">
    <h3>상품 리뷰 작성</h3>

<%-- <!-- 상품 정보 -->
<c:set var="item_code" value="${param.item_code}" />
<img class="product-image" src="${item.imagename}" width="400" height="450" />
<div class="product-name">${item.item_title}</div> --%>


<c:choose>
	<c:when test="${sessionScope.loginUser == null}">
	
	<a href="/login/login.html">리뷰작성은 로그인 후 가능합니다.(로그인하러 가기)</a>
	</c:when>
	<c:otherwise>
			<!-- 리뷰 작성 폼 -->
			<div class="review">
				<form action="/review/submit" method="post"
					onsubmit="setCurrentDate()">
					<!-- 작성자는 로그인된 사용자 정보에서 가져오기 -->
					<input type="hidden" name="writer"
						value="${sessionScope.loginUser.id}">
					<!-- 상품 코드 (숨김 처리) -->
					<input type="hidden" name="item_code" value="${item.item_code}" />
					<!-- 제목 입력 -->
					<label for="review_title">제목:</label> <input type="text"
						name="review_title" id="review_title" required><br />
					<!-- 내용 입력 -->
					<label for="content">내용:</label>
					<textarea name="content" id="content" rows="8" cols="50" required></textarea>
					<br />
					<!-- 별점 선택 -->
					<label for="ITEM_RATE">별점:</label>
					<div class="starpoint_wrap">
						<div class="starpoint_box">
							<label for="starpoint_1" class="label_star" title="1"><span
								class="blind">1점</span></label> <label for="starpoint_2"
								class="label_star" title="2"><span class="blind">2점</span></label>
							<label for="starpoint_3" class="label_star" title="3"><span
								class="blind">3점</span></label> <label for="starpoint_4"
								class="label_star" title="4"><span class="blind">4점</span></label>
							<label for="starpoint_5" class="label_star" title="5"><span
								class="blind">5점</span></label> <input type="radio" name="item_rate"
								id="starpoint_1" class="star_radio" value="1" required>
							<input type="radio" name="item_rate" id="starpoint_2"
								class="star_radio" value="2"> <input type="radio"
								name="item_rate" id="starpoint_3" class="star_radio" value="3">
							<input type="radio" name="item_rate" id="starpoint_4"
								class="star_radio" value="4"> <input type="radio"
								name="item_rate" id="starpoint_5" class="star_radio" value="5">
							<span class="starpoint_bg"></span>
						</div>
					</div>
					<input type="hidden" name="star_radio" id="star_radio">
					<!-- 작성일 (자동 설정) -->
					<input type="hidden" name="w_date" id="w_date">
					<!-- 리뷰 제출 버튼 -->
					<input type="submit" value="리뷰 등록">
				</form>
			</div>
		</c:otherwise>
</c:choose>
</div>				
<script type="text/javascript">
//리뷰 작성 및 보러가는 버튼 기능 함수
/* function goWriteReview() {
    window.location.href = `/item/review/write`;
} */
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
</script>
</body>
</html>
