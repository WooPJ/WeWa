<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
>>>>>>> origin/master
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<<<<<<< HEAD
</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>
카트 목록
=======
<link rel="stylesheet" type="text/css" href="../css/cartStyle.css">
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f5f5f5;
    }
    .cart-container {
        width: 50%;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    h2 {
        color: #007bff;
        margin-bottom: 20px;
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
    .cart-button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        width: 45%;
        margin-top: 20px;
    }
    .cart-button:hover {
        background-color: #005aff;
    }
</style>
</head>
<body>
<br/><br/><br/><br/>
<div class="cart-container">
    <h2>${sessionScope.loginUser.id}님의 장바구니 목록</h2>
<table>
    <tr>
        <th>상품명</th>
        <th>상품 코드</th>
        <th>가격</th>
        <th>수량</th>
        <th>색상</th>
        <th>사이즈</th>
        <th>수정/삭제</th>
    </tr>
    <c:forEach var="cart" items="${cartList}">
        <tr>
            <td>${cart.item_title}</td>
            <td>${cart.item_code}</td>
            <td><fmt:formatNumber value="${cart.price}" groupingUsed="true"/>원</td>
            <td>${cart.quantity}</td>
            <td>${cart.item_color}</td>
            <td>${cart.item_size}</td>
            <td>
            	<form action="">
            		<input type="submit" value="수정" name="BTN"/>
            	</form><br/>
            	<form action="">
            		<input type="submit" value="삭제" name="BTN"/>
            	</form>
            </td>
        </tr>
    </c:forEach>
</table>
    <p>총 계 : <fmt:formatNumber value="${totalPrice}" groupingUsed="true"/>원</p>
    <!-- <button type="button" class="cart-button">결제하기</button> -->
    <form action="../item/addcart.html">
    	<input type="submit" class="cart-button" value="결제하기">
    </form>
    <button type="button" class="cart-button" onclick="history.back();">뒤로 가기</button>
</div>
>>>>>>> origin/master
</body>
</html>