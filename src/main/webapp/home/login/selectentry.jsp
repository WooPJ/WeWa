<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 선택</title>
<link rel="stylesheet" href="../css/selectentry.css">
</head>
<body>
<a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="300" height="75">
        </a> 
<div class="selectentry-btn">
    <button type="button" class="user" onclick="location.href='/login/userentry.html'">손님 회원가입</button>
    <button type="button" class="business" onclick="location.href='/login/businessentry.html'">사업자 회원가입</button>
</div>
</body>
</html>