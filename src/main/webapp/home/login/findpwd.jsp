<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
            <form:form action="/login/findpwdbyphone.html" method="post" modelAttribute="user_info">
                <div class="input_box">
                    <label>아이디</label>
                    <form:input path="user_id" class="input_field" placeholder="아이디를 입력하세요"/>
                </div>
                <div class="input_box">
                    <label>이름</label>
                    <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
                </div>
                <div class="input_row">
                    <label class="input_label">전화번호</label>
                    <div class="phone_wrap">
                        <select name="phone1" class="input_field">
                        	<option value="010">---고객---</option>
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
                            <option value="010">---사업자---</option>
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
                        <form:input path="phone2" class="input_field" placeholder="1234" maxlength="4" />
                        <font color="red"><form:errors path="phone2" /></font> - 
                        <form:input path="phone3" class="input_field" placeholder="5678" maxlength="4" />
                        <font color="red"><form:errors path="phone3" /></font>
                    </div>
                </div>
                <div class="button_wrap">
                    <input type="submit" value="조회" class="submit_button"/>
                </div>
            </form:form>
        </div>

        <!-- 이메일로 찾기 -->
        <div class="find_wrap">
            <h3>등록된 이메일로 찾기</h3>
            <form:form action="/login/findpwdbyemail.html" method="post" modelAttribute="user_info">
                <div class="input_box">
                    <label>아이디</label>
                    <form:input path="user_id" class="input_field" placeholder="아이디를 입력하세요"/>
                </div>
                <div class="input_box">
                    <label>이름</label>
                    <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
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

                <form:input path="customEmailDomain"
                 id="customDomainInput" class="input_field email_input" placeholder="도메인을 입력하세요" 
                 style="width: 150px; display: none;" disabled="disabled"/>
            </div>
            <font color="red"><form:errors path="emailDomain"/></font>
        </div>
                <div class="button_wrap">
                    <input type="submit" value="조회" class="submit_button"/>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script type="text/javascript">
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
</script>
</body>
</html>
