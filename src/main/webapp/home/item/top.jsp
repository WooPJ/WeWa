<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상의 목록</title>
</head>
<body>
<div class="category-container">
	<a href="/menu/top.html">전체</a>
	<a href="/menu/topcategoryList.html?item_id=1">니트</a>
	<a href="/menu/topcategoryList.html?item_id=2">맨투맨</a>
	<a href="/menu/topcategoryList.html?item_id=3">후드</a>
	<a href="/menu/topcategoryList.html?item_id=4">셔츠</a>
	<a href="/menu/topcategoryList.html?item_id=5">긴소매</a>
	<a href="/menu/topcategoryList.html?item_id=6">반소매</a>
</div>
<div class="product-container">
 <c:forEach var="item" items="${Items}">
    <div class="product">
    	<a href="/item/itemDetail.html?item_code=${item.item_code }">
        <img src="${item.imagename} " width="250" height="300"/>
        <div class="product-name">${item.user_id}</div>
        <div class="product-description">${item.item_title}</div>
        <%-- <div class="product-price">${item.price}원</div> --%>
         <div class="product-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/>원</div>
   		 </a>
    </div>
 </c:forEach>
 </div>
</body>
</html>