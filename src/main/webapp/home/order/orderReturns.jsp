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
<link rel="stylesheet" type="text/css" href="/css/orderReturns.css">


</head>
<body>
<br/><br/><br/><br/><br/>
	<div class="container">
		<h2>${sessionScope.loginUser.id}님의반품신청 목록</h2>
		<table class="return-table">
			<tr>
				<th>상품 코드</th>
				<th>수량</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>주문일</th>
				<th>반품상태</th>
				<th>리뷰 작성</th>
			</tr>
			<c:forEach var="returns" items="${returnList}">
				<tr>
					<td>
						<div class="return-itemcode">${returns.item_code }</div>
					</td>
					<td>
						<div class="return-quantity">${returns.quantity }</div>
					</td>
					<td>
						<div class="return-itemcolor">${returns.item_color }</div>
					</td>
					<td>
						<div class="return-itemsize">${returns.item_size }</div>
					</td>
					<td>
						<div class="return-itemorderdate">${returns.order_date }</div>
					</td>
					<td>
						<div class="return-status">
							<c:choose>
								<c:when test="${returns.order_status == 0}">상품준비중</c:when>
								<c:when test="${returns.order_status == 1}">배송 중</c:when>
								<c:when test="${returns.order_status == 2}">배송완료</c:when>
								<c:when test="${returns.order_status == 3}">반품신청 처리 중</c:when>
								<c:when test="${returns.order_status == 4}">반품처리완료</c:when>
								<c:otherwise>알 수 없는 상태</c:otherwise>
							</c:choose>
						</div>
					</td>
					<td>
						<form action="/item/reviewWrite.html" method="get">
							<input type="hidden" name="item_code"
								value="${returns.item_code}"> <input type="submit"
								value="리뷰쓰러가기">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</body>
</html>