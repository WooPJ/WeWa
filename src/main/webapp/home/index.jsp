<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WearWave</title>
<link rel="stylesheet" type="text/css" href="../css/items.css">
</head>
<body>
<jsp:include page="menu_header.jsp"/>

<table>
<tr>
	<td id="content">
			<c:choose>
				<c:when test="${ BODY != null }">
					<jsp:include page="${ BODY }"/>
				</c:when>
				<c:otherwise>
<jsp:include page="main_slider.jsp"/>	

<c:forEach items="${itemList}" var="item">
    <div class="product">
        <a href="/item/itemDetail.html?item_id=${item.item_code}">
            <div class="image-container">
                <img src="../imgs/item/${item.imagename}" alt="${item.item_title}"/>
                <div class="heart-container">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon"
                         data-item-id="${item.item_code}">
                        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4
                                c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4
                                268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8
                                c0 41.5 17.2 81.2 47.6 109.5z"/>
                    </svg>
                </div>
            </div>    
            <div class="product-name">${item.item_title}</div>
            <div class="product-description">${item.content}</div>
            <div class="product-price">${item.price}원</div>
        </a>
    </div>
</c:forEach>				

<script type="text/javascript">
    function redirectToLogin() {
        alert("로그인 후 찜 기능을 사용할 수 있습니다.");
        window.location.href = "/login/login.html";
    }

    const heartIcons = document.querySelectorAll('.heart-icon');
    heartIcons.forEach(heart => {
        const itemId = heart.getAttribute("data-item-id");

        // 찜한 상품인지 확인
        <c:forEach items="${heartList}" var="heart">
            if ("${heart.item_code}" === itemId) {
                heart.classList.add('filled'); // 하트 채우기
            }
        </c:forEach>

        heart.addEventListener('click', function (event) {
            event.preventDefault();

            if (${sessionScope.loginUser == null}) {
                redirectToLogin();
            } else {
                this.classList.toggle('filled');

                const isFilled = this.classList.contains('filled');
                const inData = { itemId: itemId, status: isFilled };
                let param = new URLSearchParams(inData).toString();
                fetch("/heart/toggle.html?" + param);
            }
        });
    });
</script>


            </c:otherwise>
        </c:choose>
    </td></tr>
</table>
<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome for heart icon -->


</body>
</html>