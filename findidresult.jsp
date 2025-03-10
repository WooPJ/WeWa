<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<link rel="stylesheet" type="text/css" href="../css/result.css">
</head>
<body>
<div class="wrapper">
    <div class="result_container">
        <h3>아이디 찾기 결과</h3>

        <!-- 메시지가 있을 경우 출력 -->
        <c:if test="${not empty message}">
            <p class="result_message">${message}</p>
        </c:if>

        <!-- 아이디가 있을 경우 출력 -->
        <c:if test="${not empty ID}">
            <p class="result_id">아이디: ${ID}</p>
        </c:if>

        <div class="button_wrap">
            <a href="/login/login.html" class="result_button">로그인</a>
            <a href="/home/index.html" class="result_button">홈으로</a>
        </div>
    </div>
</div>
</body>
</html>
