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
        <h2>문의 사항 작성</h2>
        <form:form modelAttribute="qnabbs" action="/qna/write.html" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">제목:</label>
                <form:input path="title" id="title" required="true" placeholder="제목을 입력하세요"/>
            </div>
            <div class="form-group">
                <label for="title">상품코드: <button type="button" class="btn btn-primary" onclick="findProduct()">상품 찾기</button></label>
               
                <form:input path="item_code" id="item_code" placeholder="관련 상품이 있으면 입력해주세요"/> 
            </div>
             <div class="form-group">
                <label for="file">이미지:</label>
                <form:input type="file" path="image" id="image" accept="image/*"/>
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <form:textarea path="content" id="content" required="true" placeholder="내용을 입력하세요"/>
            </div>
            <button type="submit" class="submit-btn">등록</button>
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
