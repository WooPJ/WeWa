<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<link rel="stylesheet" type="text/css" href="../css/profile.css">
</head>
<body>
<div align="center">
<h2>내 정보</h2>
<form:form action="/mypage/modify.html" method="post" modelAttribute="user_info">
<table>
	<tr><th>계 정</th><td><form:input path="user_id" readonly="true"/></td></tr>
	<tr><th>암 호</th><td><form:password path="user_pwd" value="${user_info.user_pwd }"/>
		<font color="red"><form:errors path="user_pwd"/></font></td></tr>
	<tr><th>이 름</th><td><form:input path="name" readonly="true"/></td></tr>
	<tr><th>주 소</th><td><form:input path="addr"/>
		<font color="red"><form:errors path="addr"/></font></td></tr>
	<tr><th>전화번호</th><td><form:input path="phone"/>
		<font color="red"><form:errors path="phone"/></font></td></tr>
	<tr><th>등 급</th>
    <td>
        <c:choose>
            <c:when test="${user_info.grade == 0}">어드민</c:when>
            <c:when test="${user_info.grade == 1}">손님</c:when>
            <c:when test="${user_info.grade == 2}">사업자</c:when>
        </c:choose>
        </td></tr>
	<tr><th>이메일</th><td><form:input path="email"/>
		<font color="red"><form:errors path="email"/></font></td></tr>
	<tr><td align="center" colspan="2"><input type="submit" value="개인정보 수정" onclick="showAlertAndSubmit(this.form)"/>
			<input type="reset" value="취 소"/></td></tr>
</table>
</form:form><br/><br/>
</div>
<script>
        function showAlertAndSubmit(form) {
            // 수정 완료 메시지
            alert("개인정보 수정이 완료되었습니다.");
            // 폼 제출
            form.submit();
        }
    </script>
</body>
</html>
