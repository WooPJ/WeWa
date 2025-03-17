<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 align="center">상품 검색</h2>
<form action="/qna/finditem_codeResult.html">
상품명 : <input type="text" name="NAME" value="${NAME }"/>
	<input type="submit" value="검색"/>
</form>
  <table id="myItem-table" class="table">
            <thead>
                <tr>
                    <th>코드</th>
                    <th>상호명</th>
                    <th>상품명</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${Items}">
                    <tr>
                        <td>${item.item_code}</td>
                        <td>${item.user_id}</td>
                        <td>${item.item_title}</td>  
                        <td>
                       		<button type="button" onclick="selectItemCode('${item.item_code}')">사용</button>
                    	</td>                 
                    </tr>
                </c:forEach>
            </tbody>
        </table>
<script>
    function selectItemCode(itemCode) {
        if (window.opener) {
            window.opener.document.getElementById("item_code").value = itemCode;
            window.close(); // 창 닫기
        }
    }
</script>
</body>
</html>















