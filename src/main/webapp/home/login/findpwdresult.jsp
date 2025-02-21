<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
<link rel="stylesheet" type="text/css" href="../css/result.css">
</head>	
<body>
<div class="wrapper">
    <div class="result_container">
        <h3>비밀번호 변경</h3>

        <!-- 메시지가 있을 경우 출력 -->
        <c:if test="${not empty message}">
            <p class="result_message">${message}</p>
        </c:if>

        <!-- 아이디가 있을 경우 비밀번호 변경 폼 표시 -->
        <c:if test="${not empty ID}">
  

            <form action="/login/updatepwd.html" method="post" onsubmit="return checkPasswords()">
                <input type="hidden" name="user_id" value="${ID}"/>

                <div class="input_box">
                    <label>새 비밀번호</label>
                    <input type="password" name="new_pwd" class="input_field" placeholder="새 비밀번호 입력" required="true"/>
                </div>

                <div class="input_box">
                    <label>비밀번호 확인</label>
                    <input type="password" name="confirm_pwd" class="input_field" placeholder="비밀번호 확인" required="true"/>
                </div>

                <input type="submit" value="비밀번호 변경" class="result_button"/><br/><br/>
            </form>
        </c:if>

        <div class="button_wrap">
            <a href="/login/login.html" class="result_button">로그인</a>
            <a href="/home/index.html" class="result_button">홈으로</a>
        </div>
    </div>
</div>
<script type="text/javascript">
    // 비밀번호 일치 여부 체크 함수
    function checkPasswords() {
        var newPwd = document.getElementsByName("new_pwd")[0].value;
        var confirmPwd = document.getElementsByName("confirm_pwd")[0].value;

        // 비밀번호가 일치하지 않으면 경고 메시지 출력
        if (newPwd !== confirmPwd) {
            alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
            return false;  // 폼 제출을 막음
        }
        return true;  // 폼을 제출하도록 허용
    }
</script>
</body>
</html>
