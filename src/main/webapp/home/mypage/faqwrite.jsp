<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글쓰기</title>
<link rel="stylesheet" type="text/css" href="../css/faqcss.css">
</head>
<body>
    <div class="faq-container">
        <h2>FAQ 글쓰기</h2>
        <form:form modelAttribute="faq" action="/faq/input.html" method="post">
            <div class="form-group">
                <label for="title">질문:</label>
                <form:input path="title" id="title" required="true" placeholder="질문을 입력하세요"/>
            </div>
            <div class="form-group">
                <label for="content">답변:</label>
                <form:textarea path="content" id="content" required="true" placeholder="답변을 입력하세요"/>
            </div>
            <button type="submit" class="submit-btn">등록</button>
        </form:form>
    </div>
</body>
</html>
