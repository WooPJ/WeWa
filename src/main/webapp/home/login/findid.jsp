<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="../css/findidpwd.css">
</head>
<body>
<div class="wrapper">
    <div class="wrap">
        <a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a> 
        
        <!-- 전화번호로 찾기 -->
        <div class="find_wrap">
            <h3>등록된 전화번호로 찾기</h3>
            <!-- form:form 태그로 변경 -->
            <form:form action="/login/findidbyphone.html" method="post" modelAttribute="user_info">
                <div class="input_box">
                    <label>이름</label>
                    <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
                </div>
                <div class="input_box">
                    <label>전화번호</label>
                    <form:input path="phone" class="input_field" placeholder="전화번호를 입력하세요 ex)010-0000-0000"/>
                </div>
                <div class="button_wrap">
                    <input type="submit" value="조회" class="submit_button"/>
                </div>
            </form:form>
        </div>

        <!-- 이메일로 찾기 -->
        <div class="find_wrap">
            <h3>등록된 이메일로 찾기</h3>
            <!-- form:form 태그로 변경 -->
            <form:form action="/login/findidbyemail.html" method="post" modelAttribute="user_info">
                <div class="input_box">
                    <label>이름</label>
                    <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
                </div>
                <div class="input_box">
                    <label>이메일</label>
                    <form:input path="email" class="input_field" placeholder="이메일을 입력하세요"/>
                </div>
                <div class="button_wrap">
                    <input type="submit" value="조회" class="submit_button"/>
                </div>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
