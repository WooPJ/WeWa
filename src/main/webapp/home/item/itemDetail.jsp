<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 정보</title>
    <style>
        body {
            display: flex;
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            height: 100vh; /* 화면 높이 전체 사용 */
            margin: 0; /* 기본 여백 제거 */
        }
        .product-details {
            text-align: center; /* 텍스트 중앙 정렬 */
        }
    </style>
</head>
<body>
    <div class="product-details">
        <h1>상품 상세 정보</h1>

        <c:set var="item_id" value="${param.item_id}" />
        
        <img src="../imgs/item/${item_id}.png" width="250" height="300" alt="${productName}"/>
        <div class="product-name">${productName}</div>
        <div class="product-description">${productDescription}</div>
        <div class="product-price">${productPrice}</div>
    </div>
</body>
</html>