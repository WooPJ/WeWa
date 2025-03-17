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
<h2 align="center">닉네임 중복 확인</h2>
<form action="../snap/nicknameCheck.html">
닉네임 : <input type="text" name="nickname" value="${NICKNAME}"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'useNo_duplicate' }">
		${NICKNAME}은(는) 사용 중입니다.
	</c:when>
	<c:when test="${DUP == 'useNo_length_null' }">
		닉네임이 빈칸입니다.<br/>
		닉네임은 1자 이상, 20자 이하로 입력하세요.
	</c:when>
	<c:when test="${DUP == 'useNo_length_over' }">
		닉네임 "${NICKNAME}" 의 길이가 부적합 합니다.<br/>
		닉네임은 1자 이상, 20자 이하로 입력하세요.
	</c:when>
	<c:otherwise>
		"${NICKNAME}" 은(는) 사용 가능합니다. <input type="button" value="사용" onclick="nicknameOk('${NICKNAME}')"/>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
function nicknameOk(userNick){
	console.log(userNick.length);
    if (userNick === '') {
        alert("닉네임을 입력하세요.");
        return false;
    } else {
        if (userNick.length < 1 || userNick.length > 20) {
            alert("닉네임은 1자 이상, 20자 이하로 입력하세요.");
        }
    }
	opener.document.postFrm.nickname.value = userNick;
	opener.document.postFrm.nickname.readOnly = true;//편집이 안되게 속성을 readOnly로 바꿈
	opener.document.postFrm.nicknameChecked.value = "yes";//NICKNAME 중복검사용 파라미터(nicknameChecked)에 값을 넣음
	self.close();
}
</script>
</body>
</html>















