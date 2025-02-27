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
                    <th>상품코드</th>
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
                    </tr>
                </c:forEach>
            </tbody>
        </table>
<script type="text/javascript">
function idOk(userId){
	opener.document.frm.user_id.value = userId;
	opener.document.frm.user_id.readOnly = true;//편집이 안되게 속성을 readOnly로 바꾼다.
	opener.document.frm.idChecked.value = "yes";//ID중복검사용 파라미터(idChecked)에 값을 넣는다.
	self.close();
}
</script>
</body>
</html>















