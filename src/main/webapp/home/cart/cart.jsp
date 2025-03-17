<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
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
	width: 70%;
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
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<div class="cart-container">
		<h2>${sessionScope.loginUser.id}님의장바구니 목록</h2>
		<table>
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>상품 코드</th>
				<th>가격</th>
				<th>수량</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>총액</th>
				<th>장바구니 삭제</th>
			</tr>
			<c:set var="counter" value="1" />
			<!-- 번호 카운터 초기화 -->
			<c:set var="totalAmount" value="0" />
			<!-- 총액 초기화 -->
			<c:forEach var="cart" items="${cartList}">
				<c:set var="rowTotal" value="${cart.price * cart.quantity}" />
				<!-- 각 행의 총액 계산 -->
				<c:set var="totalAmount" value="${totalAmount + rowTotal}" />
				<!-- 전체 총액 누적 -->
				<tr>
					<td>${counter}</td>
					<!-- 카운터 값 출력 -->
					<td>${cart.item_title}</td>
					<td>${cart.item_code}</td>
					<td><fmt:formatNumber value="${cart.price}"
							groupingUsed="true" />원</td>
					<td>${cart.quantity}</td>
					<td>${cart.item_color}</td>
					<td>${cart.item_size}</td>
					<td><fmt:formatNumber value="${rowTotal}" groupingUsed="true" />원</td>
					<!-- 행별 총액 표시 -->
					<td>
						<form action="/cart/modify.html" method="post"
							onsubmit="return confirmDelete(this);">
							<input type="hidden" name="item_code" value="${cart.item_code}">
							<input type="hidden" name="item_color" value="${cart.item_color}" />
							<input type="hidden" name="item_size" value="${cart.item_size}" />
							<input type="hidden" name="BTN" value="삭제">
							<input type="submit" value="삭제" />
						</form>
					</td>
				</tr>
				<c:set var="counter" value="${counter + 1}" />
				<!-- 카운터 증가 -->
			</c:forEach>
		</table>
		<span style="font-weight: bold; color: red;">
			<p>
				총 액 :
				<fmt:formatNumber value="${totalAmount}" groupingUsed="true" />
				원
			</p> <!-- 최종 총액 표시 -->
		</span>

		<!-- <button type="button" class="cart-button">결제하기</button> -->
		<form action="/order/order.html" method="post">
			<c:forEach var="cart" items="${cartList}">
				<input type="hidden" name="order_user_id"
					value="${sessionScope.loginUser.id}">
				<input type="hidden" name="order_item_code"
					value="${cart.item_code}">
				<input type="hidden" name="order_item_color"
					value="${cart.item_color}">
				<input type="hidden" name="order_item_size"
					value="${cart.item_size}">
				<input type="hidden" name="order_quantity" value="${cart.quantity}">
			</c:forEach>
			<input type="submit" class="cart-button" value="주문하기">
		</form>
		<button type="button" class="cart-button" onclick="gohome()">상품
			보러 가기</button>
	</div>
	<script type="text/javascript">
		function gohome() {
	    window.location.href = "/home/index.html"; // 페이지 이동
	}
	    // 삭제 버튼 클릭 시 확인 창을 띄우는 함수
	    function confirmDelete(form) {
	        if (confirm("정말 삭제하시겠습니까?")) {
	            form.submit(); // 확인을 누르면 폼을 제출
	        } else {
	            return false; // 취소를 누르면 아무것도 하지 않음
	        }
	    }
	</script>
</body>
</html>