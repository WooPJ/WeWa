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

  	 <%-- 중복 제거된 user_id 목록 생성 --%>
  	 <c:set var="userList" value="" />
  	 <c:forEach var="item" items="${Items}">
  	     <c:if test="${not fn:contains(userList, item.user_id)}">
  	         <c:set var="userList" value="${userList},${item.user_id}" />
  	     </c:if>
  	 </c:forEach>

  	 <%-- userList에서 첫 번째 ',' 제거 후 배열로 변환 --%>
  	 <c:set var="userArray" value="${fn:split(fn:substring(userList, 1, fn:length(userList)), ',')}" />

  	<form id="user-search-form" action="/items/userIdSearch.html" method="get" onsubmit="return updateAction()">
	    <label for="user_id">상호명:</label>
	    <select id="user-select" name="user_id" onchange="this.form.submit()">
	        <option value="all">전체 보기</option>
	        <c:forEach var="user" items="${userArray}">
	            <option value="${user}" <c:if test="${param.user_id eq user}">selected</c:if>>${user}</option>
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
                    <%-- 선택된 user_id와 일치하는 데이터만 출력 --%>
                    <c:if test="${param.user_id eq 'all' or param.user_id eq item.user_id or empty param.user_id}">
                        <tr>
                            <td>${item.item_code}</td>
                            <td>${item.user_id}</td>
                            <td>
                                <c:set var="imageList" value="${fn:split(item.imagename, ',')}" />
                                <c:set var="lastIndex" value="${fn:length(imageList) - 1}" />
                                <img src="${imageList[lastIndex]}" class="myItem-image" />
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
                    </c:if>
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> origin/master
        // 폼 제출 전 action을 동적으로 변경하는 함수
        function updateAction() {
            var select = document.getElementById("user-select");
            if (select.value === "all") {
                // '전체 보기'를 선택한 경우, action을 '/items/itemlist.html'로 변경
                document.getElementById("user-search-form").action = "/items/itemlist.html";
            } else {
                // 다른 값을 선택한 경우 기존 action을 유지
                document.getElementById("user-search-form").action = "/items/userIdSearch.html";
            }
            return true; // 폼 제출을 계속 진행
        }
        
        
<<<<<<< HEAD
>>>>>>> 86530e5 (0305)
=======
>>>>>>> origin/master
    </script>
</body>
</html>
