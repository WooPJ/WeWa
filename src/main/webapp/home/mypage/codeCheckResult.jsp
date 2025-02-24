<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코드 중복 검사</title>
</head>
<body>
<h2 align="center">코드 중복 확인</h2>
<form action="/items/codecheck.html">
상품 코드 : <input type="text" name="item_code" value="${item_code }"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'NO' }">
		${item_code }는 사용 가능합니다. <input type="button" value="사용" onclick="codeOk('${item_code}')"/>
	</c:when>
	<c:otherwise>
		${item_code }는 사용 중입니다.
		<script type="text/javascript">
			opener.document.itemFrm.item_code.value = "";
		</script>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
function codeOk(item_code){
	opener.document.itemFrm.item_code.value = item_code;
	opener.document.itemFrm.item_code.readOnly = true;
	opener.document.itemFrm.codeChecked.value = "yes";
	
	self.close();
}
</script>
</body>
</html>















