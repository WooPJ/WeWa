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
<h2 align="center">계정 중복 확인</h2>
<form action="../entry/idcheck.html">
계 정 : <input type="text" name="user_id" value="${ID }"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'NO' }">
		${ID }는 사용 가능합니다. <input type="button" value="사용" onclick="idOk('${ID}')"/>
	</c:when>
	<c:otherwise>
		${ID }는 사용 중입니다.
		<script type="text/javascript">
			opener.document.frm.ID.value = "";
		</script>
	</c:otherwise>
</c:choose>
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















