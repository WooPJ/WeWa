<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정</title>
<link rel="stylesheet" type="text/css" href="../css/faqcss.css">
</head>
<body>
    <div class="faq-container">
    <h2>FAQ 수정</h2>
    <!-- Spring form:form 태그 사용 -->
    <form:form action="/faq/update.html" modelAttribute="faq" method="post">
        <form:hidden path="seqno"/>
        <div class="form-group">
            <label for="title">제목</label>
            <form:input path="title" id="title" required="true" />
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <form:textarea path="content" id="content" required="true"></form:textarea>
        </div>

        <button type="submit" class="submit-btn">수정</button>
    </form:form>
    </div>
</body>
</html>
