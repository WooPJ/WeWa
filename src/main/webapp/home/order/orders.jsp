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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/orders.css">

</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>

<div class="container">
	<h2>${sessionScope.loginUser.id}님의주문 목록</h2>
	<table class="order-table">
		<tr>
			<th>이미지</th>
			<th>수량</th>
			<th>색상</th>
			<th>사이즈</th>
			<th>주문일</th>
			<th>주문상태</th>
			<th>주문취소/반품</th>
			<th>리뷰작성</th>
		</tr>
		<c:forEach var="order" items="${orderList}">
			<tr>
				<td>
	                   <c:set var="imageList" value="${fn:split(order.imagename, ',')}" />
	                   <c:set var="lastIndex" value="${fn:length(imageList) - 1}" />
	                   <img src="${imageList[lastIndex]}" class="myItem-image" />
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
				<td>
					<div class="order-status">
						<c:choose>
							<c:when test="${order.order_status == 0}">상품준비중</c:when>
							<c:when test="${order.order_status == 1}">배송 중</c:when>
							<c:when test="${order.order_status == 2}">배송완료</c:when>
							<c:when test="${order.order_status == 3}">반품신청 처리 중</c:when>
							<c:when test="${order.order_status == 4}">반품처리완료</c:when>
							<c:otherwise>알 수 없는 상태</c:otherwise>
						</c:choose>
					</div>
				</td>
				<td>
					<div class="order-cancel">
						<form action="/order/modify.html" method="post"
							onsubmit="return confirmAction(this.BTN.value, ${order.order_status})">
							<input type="hidden" name="orderNo" value="${order.order_no }">
							<input type="submit" name="BTN" value="주문취소"
								onclick="return confirmCancel()">
						</form>
						<br/>
						<form action="/order/returnRequest.html" method="post"
							id="returnForm${order.order_no}">
							<input type="hidden" name="order_no" value="${order.order_no }">
							<input type="submit" name="BTN" value="반품신청"
								id="returnBtn${order.order_no}"
								onclick="return confirmReturn(${order.order_status}, ${order.order_no})">
						</form>
					</div>
				</td>
				<td><c:if test="${order.order_status == 2}">
						<form action="/item/reviewWrite.html" method="get">
							<input type="hidden" name="item_code" value="${order.item_code}">
							<input type="submit" value="리뷰쓰러가기">
						</form>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
function confirmCancel(form) {
    // "정말 주문 취소하시겠습니까?" 메시지 확인
    var confirmCancel = confirm("정말 주문 취소하시겠습니까?");
    if (confirmCancel) {
        // 확인을 누르면 알림 메시지를 띄우고, 폼을 제출함
        alert("주문이 취소되었습니다.");
        return true;  // 폼 제출
    } else {
        // 취소를 누르면 폼 제출을 막음
        return false;
    }
}

function confirmReturn(orderStatus, orderNo) {
    var returnButton = document.getElementById("returnBtn" + orderNo);
    // 각 상태에 따라 처리
    if (orderStatus == 0 || orderStatus == 1) {
        // 배송완료일 때만 반품신청 가능
        alert("배송완료일 때만 반품신청이 가능합니다.");
        returnButton.disabled = true;  // 반품신청 버튼 비활성화
        return false; // form 전송 방지
    } else if (orderStatus == 2) {
        // 배송완료 상태일 때는 반품 신청을 확인
        var confirmReturn = confirm("반품신청을 하시겠습니까?");
        if (!confirmReturn) {
            // 취소를 눌렀을 때 메시지
            alert("반품신청이 취소되었습니다!");
            return false;
        }
        // 확인을 누르면 알림 메시지 후, form 제출 (반품 신청)
        alert("반품신청이 성공적으로 되었습니다!");
        document.getElementById("returnForm" + orderNo).submit();
        return true;
    } else if (orderStatus == 3) {
        // 반품신청 상태일 때는 처리 중
        returnButton.style.display = 'none';  // 버튼 숨김
        return false;
    } else if (orderStatus == 4) {
        // 반품처리완료 상태일 때는 반품 신청 버튼 숨김
        returnButton.style.display = 'none';  // 버튼 숨김
        return false;
    }
    return true; // 기본적으로 form 전송
}

// 특정 버튼 클릭 시 상태 확인
function confirmAction(buttonValue, orderStatus, orderNo) {
    if (buttonValue === "반품신청") {
        // 주문 상태에 따라 처리
        return confirmReturn(orderStatus, orderNo);
    }
    return true;
}
</script>

</body>
</html>
