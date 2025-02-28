<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록된 상품 관리</title>
<link rel="stylesheet" type="text/css" href="../css/myItemList.css">
</head>
<body>
 	<div id="header-container">
  	 <h3>등록된 상품 관리</h3>
  	 <form id="user-search-form" action="/items/userIdSearch.html">
    <label for="user_id">상호명:</label>
    <select id="user-select" name="user_id">
        <c:forEach var="item" items="${Items}">
            <option value="${item.user_id}">${item.user_id}</option>
        </c:forEach>
    </select>
    <input class="btn-search" type="submit" value="조회"/>
</form>
	</div>
	<div>
        <table id="myItem-table" class="table">
            <thead>
                <tr>
                    <th>상품코드</th>
                    <th>상호명</th>
                    <th>이미지</th>
                    <th>상품명</th>
                    <th>등록일</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${Items}">
                    <tr>
                        <td>${item.item_code}</td>
                        <td>${item.user_id}</td>
                        <td>
						    <c:set var="imageList" value="${fn:split(item.imagename, ',')}" />
						    <img src="${imageList[0]}" class="myItem-image" />
						</td>
                        <td>${item.item_title}</td>
                        <td>${item.reg_date}</td>
                        <td>
                            <form action="/items/updateItem.html" method="post" class="update-form">
							    <input type="hidden" name="item_code" value="${item.item_code}" />
							    <input type="submit" class="update-btn" value="수정"/>
							</form>
                        </td>
                        <td>
                            <form action="/items/deleteItem.html" method="post" class="delete-form" onsubmit="return deleteimage(this)">
							    <input type="hidden" name="item_code" value="${item.item_code}" />
							     <input type="hidden" name="num" value="${item.num}" />
							    <input type="submit" class="delete-btn" value="삭제"/>
							</form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        // 삭제 확인 함수
        function deleteimage(form) {
            if (confirm("정말 삭제하시겠습니까?")) {
                alert("삭제가 완료되었습니다");
                form.submit();  // 폼 제출
            }
            return false;  // 기본 폼 제출 방지
        }
    </script>
</body>
</html>
