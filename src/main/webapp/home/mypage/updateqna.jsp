<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 사항 작성</title>
<link rel="stylesheet" type="text/css" href="../css/faqcss.css">
</head>
<body>
    <div class="faq-container">
        <h2>문의 사항 수정</h2>
        <form:form action="/qna/update.html" modelAttribute="qnabbs" method="post">
        <form:hidden path="seqno" value="${qnabbs.seqno }" />
            <div class="form-group">
                <label for="title">제목:</label>
                <form:input path="title" id="title" required="true"/>
            </div>
            <div class="form-group">
                <label for="title">상품코드: <button type="button" class="btn btn-primary" onclick="findProduct()">상품 찾기</button></label>
               
                <form:input path="item_code" id="item_code"/> 
            </div>
            <div class="form-group">
                <label for="title">이미지:</label>
                 <input type="file" name="file" accept="image/*">
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <form:textarea path="content" id="content" required="true"/>
            </div>
            <button type="submit" class="submit-btn">수정</button>
        </form:form>	
    </div>
    <script>
    function findProduct() {
        const itemCode = document.getElementById("item_code").value;
        var url = "/qna/finditem_code.html"
        window.open(url, "_blank_", "width=450,height=200");
    }
</script>
</body>
</html>
