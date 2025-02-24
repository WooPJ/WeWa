<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<link rel="stylesheet" type="text/css" href="../css/login.css">
</head>
<body>
	
<div class="wrapper" >
	<div class="wrap">
		<a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a> 
		<div class="login_wrap"> 
			<form:form modelAttribute="loginUser" action="/login/loginDo.html" method="post">
				<div class="id_wrap">
						<div class="id_input_box">
						 <form:input path="id" class="id_input" placeholder="아이디를 입력하세요" />
						 	<div class="error_message">
							    <font color="red"><form:errors path="id" cssClass="error_text"/></font>
							</div>
					</div>
				</div>
				<div class="pw_wrap">
					<div class="pw_input_box">
						 <form:password path="password" class="pw_input" placeholder="비밀번호를 입력하세요" />
						 <div class="error_message">
						    <font color="red"><form:errors path="password" cssClass="error_text"/></font>
						</div>
					</div>
				</div>
				<div class="login_button_wrap">
					<input type="submit" class="login_button" value="로그인">
				</div>
			</form:form>
			   <div class="error_message">
				    <c:if test="${not empty errorMessage}">
				        <span class="error_text"><br/>${errorMessage}</span>
				    </c:if>
				</div>
			
				
				<div class="links_wrapper">
				    <a href="/login/findid.html" class="sub">아이디 찾기</a>
				    <span class="separator">●</span>
				    <a href="/login/findpwd.html" class="sub">비밀번호 찾기</a>
				    <span class="separator">●</span>
				    <a href="/login/selectentry.html" class="sub">회원가입</a>
				</div>
			</div>			
		</div>
	</div>
</body>
</html>
