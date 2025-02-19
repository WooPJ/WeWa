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
    	<a href="">
        <img src="../imgs/item/1.png" width="250" height="300"/>
        <div class="product-name">포멜카멜레</div>
        <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
        <div class="product-price">48,300원</div>
   		 </a>
    </div>
    <div class="product">
    	<a href="">
        <img src="../imgs/item/2.png" width="250" height="300"/>
        <div class="product-name">티뷰</div>
        <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
        <div class="product-price">33,000원</div>
        </a>
    </div>
    <div class="product">
    	<a href="">
        <img src="../imgs/item/3.png" width="250" height="300"/>
        <div class="product-name">티뷰</div>
        <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
        <div class="product-price">19,800원</div>
        </a>
    </div>
     <div class="product">
    	 <a href="">
        <img src="../imgs/item/4.png" width="250" height="300"/>
        <div class="product-name">프리즘웍스</div>
        <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
        <div class="product-price">245,100원</div>
        </a>
    </div>
    <div class="product">
    	<a href="">
        <img src="../imgs/item/1.png" width="250" height="300"/>
        <div class="product-name">포멜카멜레</div>
        <div class="product-description">포멀 에스닉 퍼 울 Brown 5cm</div>
        <div class="product-price">48,300원</div>
   		 </a>
    </div>
    <div class="product">
    	<a href="">
        <img src="../imgs/item/2.png" width="250" height="300"/>
        <div class="product-name">티뷰</div>
        <div class="product-description">레이어드랩셔츠원피스_V54-VOP003</div>
        <div class="product-price">33,000원</div>
        </a>
    </div>
    <div class="product">
    	<a href="">
        <img src="../imgs/item/3.png" width="250" height="300"/>
        <div class="product-name">티뷰</div>
        <div class="product-description">와이드핀턱랩슬랙스_V4A-CPT026</div>
        <div class="product-price">19,800원</div>
        </a>
    </div>
     <div class="product">
    	 <a href="">
        <img src="../imgs/item/4.png" width="250" height="300"/>
        <div class="product-name">프리즘웍스</div>
        <div class="product-description">ALTAVIA DOWN PARKA_BLACK</div>
        <div class="product-price">245,100원</div>
        </a>
    </div>
</c:otherwise></c:choose></td></tr>
</table>


</body>
</html>