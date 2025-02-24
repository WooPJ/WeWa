<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 회원가입</title>
<link rel="stylesheet" type="text/css" href="../css/signup.css">
</head>
<body>
<div class="wrapper">
    <div class="wrap">
        <a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a> 
        
    <h2>회원가입</h2>

    <form:form action="/signup/customerprocess.html" method="post" name="frm" modelAttribute="user">
        <form:hidden path="idChecked"/>

        <!-- 아이디 입력 & 중복 검사 -->
        <div class="input_row">
            <label class="input_label">아이디</label>
            <form:input path="user_id" class="input_field" name="user_id" placeholder="아이디를 입력하세요"/>
            <font color="red" size="2"><form:errors path="idChecked"/></font>
            <!-- <button type="button" class="check_button" onclick="idCheck()">중복 확인</button> -->
            <input type="button" value="중복 확인" class="check_button" onclick="idCheck()">
        </div>

        <!-- 비밀번호 입력 -->
        <div class="input_row">
            <label class="input_label">비밀번호</label>
            <form:password path="user_pwd" class="input_field" placeholder="비밀번호를 입력하세요"/>
            <font color="red"><form:errors path="user_pwd"/></font>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="input_row">
            <label class="input_label">비밀번호 확인</label>
            <form:password path="user_pwd_confirm" class="input_field" placeholder="비밀번호를 다시 입력하세요"/>
        </div>

        <!-- 이름(상호) 입력 -->
        <div class="input_row">
            <label class="input_label">이름</label>
            <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
            <font color="red"><form:errors path="name"/></font>
        </div>

        <!-- 주소 입력 -->
        <div class="input_row">
            <label class="input_label">주소</label>
            <form:input path="addr" class="input_field" placeholder="주소를 입력하세요"/>
            <font color="red"><form:errors path="addr"/></font>
        </div>

        <!-- 이메일 입력 -->
        <div class="input_row">
            <label class="input_label">이메일</label>
            <form:input path="email" class="input_field" placeholder="이메일을 입력하세요"/>
            <font color="red"><form:errors path="email"/></font>
        </div>

        <!-- 전화번호 입력 -->
        <div class="input_row">
            <label class="input_label">전화번호</label>
            <form:input path="phone" class="input_field" placeholder="전화번호를 입력하세요"/>
            <font color="red"><form:errors path="phone"/></font>
        </div>

        <!-- 가입하기 버튼 -->
        <div class="submit_wrap">
            <input type="submit" value="회원가입" class="submit_button">
        </div>
    </form:form>
</div>
    </div>
</div>

<script>
    function idCheck() {
        let userIdField = document.getElementsByName("user_id")[0]; // user_id 필드 가져오기
        if (userIdField.value.trim() === '') {
            alert("아이디를 입력하세요.");
            userIdField.focus();
            return false;
        } else {
            if (userIdField.value.length < 5 || userIdField.value.length > 15) {
                alert("계정은 6자 이상, 15자 이하로 입력하세요.");
                userIdField.focus();
                return false;
            }
        }
        var url = "/entry/idcheck.html?user_id=" + userIdField.value;
        window.open(url, "_blank_", "width=450,height=200");
    }
</script>

</body>
</html>