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
<title>하트찜 목록</title>
<link rel="stylesheet" type="text/css" href="../css/heartList.css">
</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>


<h1 id="title">♥️상품 찜목록♥️</h1>
<c:choose>
	<c:when test="${sessionScope.loginUser == null}">
		<div id="color" class="not_logged">
		    <div class="login_info">
		        <img src="/imgs/icon/heart-in-bubble.png" alt="하트아이콘" class="login_icon">
		        <h2>상품찜하기 기능은 로그인이 필요합니다!</h2>
		        <p>계정을 만들어 다양한 기능을 이용해 보세요!</p>
		        <div class="login_buttons">
		            <a href="/login/login.html" class="login_btn">로그인</a>
		            <a href="/login/selectentry.html" class="signup_btn">회원가입</a>
		        </div>
		    </div>
		</div>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${empty sessionScope.heartList}">
				<div class="heartlist_empty">
					<h2 class="empty_comment">상품 찜목록이 비어있어요</h2>
				</div>
			</c:when>
			<c:otherwise>
			<div class="product-container heart-list-container">
				<c:forEach var="heart" items="${sessionScope.heartList}">
				    <div class="product">
				        <a href="/item/itemDetail.html?item_code=${heart.item_code}">
				            <div class="image-container">
				                <c:if test="${not empty heart.imagename}">
							        <c:set var="images" value="${fn:split(heart.imagename, ',')}" />
							        <img src="${images[0]}" alt="${heart.item_title}" />
							    </c:if>

				                <!-- 찜하트 -->
				                <div class="heart-container">
				                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon"
				                         data-item-code="${heart.item_code}">
				                        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4
				                                c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4
				                                268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8
				                                c0 41.5 17.2 81.2 47.6 109.5z"/>
				                    </svg>
				                </div>
				            </div>    
				            <div class="product-name">${heart.item_title}</div>
				            <div class="product-description">${heart.content}</div>
				            <div class="product-price"><fmt:formatNumber value="${heart.price}" groupingUsed="true"/>원</div>
				        </a>
				    </div>
				</c:forEach>
			</div>
			</c:otherwise>				
		</c:choose>
	</c:otherwise>
</c:choose>

<script type="text/javascript">
const heartIcons = document.querySelectorAll('.heart-icon');
heartIcons.forEach(heart => {
    const itemId = heart.getAttribute("data-item-code");

    heart.addEventListener('click', function (event) {
        event.preventDefault();
        if (${sessionScope.loginUser == null}) {
           redirectToLogin();		               	
        } else {
            this.classList.toggle('filled');
            const isFilled = this.classList.contains('filled');
            const inData = { itemCode: itemId, status: isFilled };
            let param = new URLSearchParams(inData).toString();
            fetch("/heart/toggle.html?" + param); //컨트롤러 매핑
        }
    });
});
</script>
</body>
</html>