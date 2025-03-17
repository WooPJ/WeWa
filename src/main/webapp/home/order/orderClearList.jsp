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
<link rel="stylesheet" type="text/css" href="/css/orderClearList.css">

</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>

	<div class="container">
		<h2>${sessionScope.loginUser.id }님의상품 주문고객 목록</h2>
		<table class="order-CLear">
			<tr>
				<th>주문고객</th>
				<th>상품코드</th>
				<th>이미지</th>
				<th>수량</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>주문일자</th>
				<th>주문상태/배송상태변경</th>
			</tr>
			<c:forEach var="orderClear" items="${orderClearList}">
				<tr>
					<td>${orderClear.user_id }</td>
					<td>${orderClear.item_code}</td>
					<td>
	                   <c:set var="imageList" value="${fn:split(orderClear.imagename, ',')}" />
	                   <c:set var="lastIndex" value="${fn:length(imageList) - 1}" />
	                   <img src="${imageList[lastIndex]}" class="myItem-image" width="100" height="100"/>
	               </td>
					<td>${orderClear.quantity}</td>
					<td>${orderClear.item_color}</td>
					<td>${orderClear.item_size}</td>
					<td>${orderClear.order_date}</td>
					<td>
						<form action="/order/statusChange.html" method="post">
							<!-- Select 박스에 현재 상태 값을 반영 -->
							<select name="order_status">
								<option value="0"
									${orderClear.order_status == 0 ? 'selected' : ''}>상품준비중</option>
								<option value="1"
									${orderClear.order_status == 1 ? 'selected' : ''}>배송 중</option>
								<option value="2"
									${orderClear.order_status == 2 ? 'selected' : ''}>배송완료</option>
								<option value="3"
									${orderClear.order_status == 3 ? 'selected' : ''}>반품신청</option>
								<option value="4"
									${orderClear.order_status == 4 ? 'selected' : ''}>반품신청
									처리 중</option>
								<option value="5"
									${orderClear.order_status == 5 ? 'selected' : ''}>반품처리완료</option>
							</select>

							<!-- 주문번호를 hidden input으로 전달 -->
							<input type="hidden" name="order_no"
								value="${orderClear.order_no}">

							<!-- 배송상태변경 버튼 -->
							<input type="button" class="status-change-button" value="배송상태변경"
								onclick="confirmStatusChange(this.form)">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<script type="text/javascript">
  // 배송상태 변경 확인 함수
  function confirmStatusChange(form) {
    // confirm 창 띄우기
    var result = confirm("배송상태를 변경하시겠습니까?");
    
    if (result) {
      // 확인을 눌렀을 경우
      alert("배송상태가 변경되었습니다!");
      form.submit();  // 폼을 제출하여 상태를 변경
    } else {
      // 취소를 눌렀을 경우
      alert("배송상태 변경이 취소되었습니다.");
    }
  }
</script>

</body>
</html>

