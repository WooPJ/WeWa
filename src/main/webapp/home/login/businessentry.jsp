<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 회원가입</title>
<link rel="stylesheet" type="text/css" href="../css/signup.css">
</head>
<body>
<div class="wrapper">
    <div class="wrap">
        <a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a> 
        
        <h2>회원가입</h2>

        <form action="/signup/process.html" method="post">
            <!-- 아이디 입력 & 중복 검사 -->
            <div class="input_row">
                <label class="input_label">아이디</label>
                <input type="text" name="USER_ID" class="input_field" placeholder="아이디를 입력하세요">
                <button type="button" class="check_button" onclick="checkDuplicateId()">중복 확인</button>
            </div>

            <!-- 비밀번호 입력 -->
            <div class="input_row">
                <label class="input_label">비밀번호</label>
                <input type="password" name="PASSWORD" class="input_field" placeholder="비밀번호를 입력하세요">
            </div>

            <!-- 비밀번호 확인 -->
            <div class="input_row">
                <label class="input_label">비밀번호 확인</label>
                <input type="password" name="PASSWORD_CONFIRM" class="input_field" placeholder="비밀번호를 다시 입력하세요">
            </div>

            <!-- 상호 입력 -->
            <div class="input_row">
                <label class="input_label">상호</label>
                <input type="text" name="NAME" class="input_field" placeholder="상호를 입력하세요">
            </div>

            <!-- 주소 입력 -->
            <div class="input_row">
                <label class="input_label">주소</label>
                <input type="text" name="ADDRESS" class="input_field" placeholder="주소를 입력하세요">
            </div>

            <!-- 이메일 입력 -->
            <div class="input_row">
                <label class="input_label">이메일</label>
                <input type="email" name="EMAIL" class="input_field" placeholder="이메일을 입력하세요">
            </div>

            <!-- 전화번호 입력 -->
            <div class="input_row">
                <label class="input_label">전화번호</label>
                <input type="text" name="PHONE" class="input_field" placeholder="전화번호를 입력하세요">
            </div>

            <!-- 가입하기 버튼 -->
            <div class="submit_wrap">
                <input type="submit" value="회원가입" class="submit_button">
            </div>
        </form>
    </div>
</div>

<script>
    function checkDuplicateId() {
        let userId = document.getElementsByName("USER_ID")[0].value;
        if (userId.trim() === "") {
            alert("아이디를 입력하세요.");
            return;
        }
        alert("중복 검사 기능을 구현해야 합니다."); // 실제 구현 필요
    }
</script>

</body>
</html>
