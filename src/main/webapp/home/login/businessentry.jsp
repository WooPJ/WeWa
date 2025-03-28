<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
        
    <h2>사업자 회원가입</h2>

    <form:form action="/entry/businessprocess.html" method="post" name="frm" modelAttribute="user">
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
            <label class="input_label">상호</label>
            <form:input path="name" class="input_field" placeholder="상호(사업자명)를 입력하세요"/>
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
            <div class="email_wrapper">
                <!-- 이메일 앞부분 -->
                <form:input path="email" class="input_field email_input" placeholder="이메일을 입력하세요" id="emailInput" style="width: 120px; display: inline-block;" /> @

                <!-- 이메일 도메인 선택 -->
                <select name="emailDomain" id="emailDomain" class="input_field email_select" style="width: 150px; display: inline-block;" onchange="emailDomainChange()">
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                    <option value="yahoo.com">yahoo.com</option>
                    <option value="nate.com">nate.com</option>
                    <option value="hotmail.com">hotmail.com</option>
                    <option value="outlook.com">outlook.com</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="icloud.com">icloud.com</option>
                    <option value="mail.com">mail.com</option>
                    <option value="etc">직접입력</option> <!-- '직접입력' 옵션 추가 -->
                </select>

                <!-- '직접입력' 선택 시, 도메인 입력 필드 활성화 -->
<!--                 <input type="text" id="customDomainInput" name="customDomainInput" -->
<!--                 		class="input_field email_input" placeholder="도메인을 입력하세요"  -->
<!--                 		style="width: 150px; display: none;" disabled /> -->
                <form:input path="customEmailDomain"
                 id="customDomainInput" class="input_field email_input" placeholder="도메인을 입력하세요" 
                 style="width: 150px; display: none;" disabled="disabled"/>
            </div>
            <font color="red"><form:errors path="emailDomain"/></font>
        </div>

        <!-- 전화번호 입력 -->
        <div class="input_row">
            <label class="input_label">전화번호</label>
            <select name="phone1" class="input_field">
			    <option value="02">02</option>
			    <option value="031">031</option>
			    <option value="033">033</option>
			    <option value="041">041</option>
			    <option value="042">042</option>
			    <option value="043">043</option>
			    <option value="044">044</option>
			    <option value="051">051</option>
			    <option value="052">052</option>
			    <option value="053">053</option>
			    <option value="054">054</option>
			    <option value="055">055</option>
			    <option value="061">061</option>
			    <option value="062">062</option>
			    <option value="063">063</option>
			    <option value="064">064</option>
            </select> -
            <form:input path="phone2" class="input_field" placeholder="1234" maxlength="4" style="width: 60px; display: inline-block;" />
            <font color="red"><form:errors path="phone2" /></font>
            - 
            <form:input path="phone3" class="input_field" placeholder="5678" maxlength="4" style="width: 60px; display: inline-block;" />
            <font color="red"><form:errors path="phone3" /></font>
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
	//이메일 도메인 선택에 따라 입력 필드 변경 및 숨겨진 필드 설정
	function emailDomainChange() {
	    var emailInput = document.getElementById("emailInput"); // 이메일 앞부분 입력 필드
	    var emailDomain = document.getElementById("emailDomain").value; // 도메인 선택 값
	    var customDomainInput = document.getElementById("customDomainInput"); // '직접입력' 필드
	    var hiddenEmailDomain = document.getElementById("hiddenEmailDomain"); // 숨겨진 필드
	
	    if (emailDomain === "etc") {
	        // '직접입력'이 선택되면 도메인 입력 필드 활성화
	        customDomainInput.disabled = false; // 도메인 입력 필드 활성화
	        customDomainInput.style.display = "inline-block"; // 보여주기
	        customDomainInput.placeholder = "도메인을 입력하세요"; // 플레이스홀더 변경
	        hiddenEmailDomain.value = customDomainInput.value; // 숨겨진 필드에 입력 값 전달
	    } else {
	        // 다른 도메인이 선택되면 '직접입력' 필드 비활성화 및 숨기기
	        customDomainInput.disabled = true;
	        customDomainInput.style.display = "none"; // 숨기기
	        customDomainInput.value = ""; // 값 지우기
	        emailInput.value = ""; // 이메일 앞부분 지우기
	        hiddenEmailDomain.value = emailDomain; // 선택된 도메인을 숨겨진 필드로 전달
	    }
	}
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