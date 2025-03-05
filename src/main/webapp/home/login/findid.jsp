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
                <!-- 전화번호 입력 -->
                <div class="input_row">
                    <label class="input_label">전화번호</label>
                    <div class="phone_wrap">
                        <select name="phone1" class="input_field">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
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
            <!-- form:form 태그로 변경 -->
            <form:form action="/login/findidbyemail.html" method="post" modelAttribute="user_info">
                <div class="input_box">
                    <label>이름</label>
                    <form:input path="name" class="input_field" placeholder="이름을 입력하세요"/>
                </div>
                <!-- 이메일 입력 -->
                <div class="input_row">
                    <label class="input_label">이메일</label>
                    <div class="email_wrapper">
                        <form:input path="email" class="input_field email_input" placeholder="이메일을 입력하세요" id="emailInput"/> @ 
                        <select name="emailDomain" id="emailDomain" class="input_field email_select" onchange="emailDomainChange()">
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
                        </select>
                    </div>
                    <font color="red"><form:errors path="email"/></font>
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