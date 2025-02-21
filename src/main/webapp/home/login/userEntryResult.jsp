<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
    setTimeout(function() {
        alert("회원가입이 완료되었습니다!");
        window.location.href = "/login/login.html"; // 페이지 리다이렉트
    }, 100); // 시간 지연 함수
</script>
</body>
</html>