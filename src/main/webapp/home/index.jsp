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
                <div class="product-container">
                    <div class="product">
                        <a href="/item/itemDetail.html?item_code=A001">
                            <img src="../imgs/item/A001.png" alt="포멜카멜레"/>
                            <div class="product-name">포멜카멜레</div>
                            <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
                            <div class="product-price">48,300원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_code=A002">
                            <img src="../imgs/item/A002.png" alt="티뷰"/>
                            <div class="product-name">티뷰</div>
                            <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
                            <div class="product-price">33,000원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_code=A003">
                            <img src="../imgs/item/A003.png" alt="티뷰"/>
                            <div class="product-name">티뷰</div>
                            <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
                            <div class="product-price">19,800원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_code=A004">
                            <img src="../imgs/item/A004.png" alt="프리즘웍스"/>
                            <div class="product-name">프리즘웍스</div>
                            <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
                            <div class="product-price">245,100원</div>
                        </a>
                    </div>
                    <!-- 추가 상품 예시 -->
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=5">
                            <img src="../imgs/item/A001.png" alt="포멜카멜레"/>
                            <div class="product-name">포멜카멜레</div>
                            <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
                            <div class="product-price">48,300원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=6">
                            <img src="../imgs/item/A002.png" alt="티뷰"/>
                            <div class="product-name">티뷰</div>
                            <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
                            <div class="product-price">33,000원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=7">
                            <img src="../imgs/item/A003.png" alt="티뷰"/>
                            <div class="product-name">티뷰</div>
                            <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
                            <div class="product-price">19,800원</div>
                        </a>
                    </div>
                    <div class="product">
                        <a href="/item/itemDetail.html?item_id=8">
                            <img src="../imgs/item/A004.png" alt="프리즘웍스"/>
                            <div class="product-name">프리즘웍스</div>
                            <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
                            <div class="product-price">245,100원</div>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </td></tr>
</table>
<!-- <br/><br/><br/>
<footer>
	<h3 align="center">Wearwave. 02-000-0000</h3>
</footer> -->
</body>
</html>