<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

h2 {
	color: #007bff;
	margin-bottom: 20px;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}
/* 테이블 헤더와 데이터 셀 스타일 */
.order-table th, .order-table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    text-align: center;
}

th {
	background-color: #f4f4f4;
	color: #555;
}

</style>
</head>
<body>
<br/><br/><br/><br/><br/>
<h2>${sessionScope.loginUser.id}님의 주문 목록</h2>
<table class="order-table">
			<tr>
				<th>상품 코드</th>
				<th>수량</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>주문일</th>
			</tr>	
			<c:forEach var="order" items="${orderList }">
				<tr>
					<td>
						<div class="order-itemcode">${order.item_code }</div>
					</td>
					<td>
						<div class="order-quantity">${order.quantity }</div>
					</td>
					<td>	
						<div class="order-itemcolor">${order.item_color }</div>
					</td>
					<td>
						<div class="order-itemsize">${order.item_size }</div>
					</td>
					<td>
						<div class="order-itemorderdate">${order.order_date }</div>
					</td>
				</tr>
			
			</c:forEach>			
</table>
</body>
</html>