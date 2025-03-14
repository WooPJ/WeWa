<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슬라이더 이미지 추가</title>
<link rel="stylesheet" type="text/css" href="../css/uploadslideimg.css">
</head>
<body>
<div id="upload-container">
    <h3>슬라이더 이미지 추가</h3>

    <form:form modelAttribute="sliderImg" action="/slider/uploadImage.html" method="post" enctype="multipart/form-data">
        <label for="title">이미지 제목</label>
        <form:input path="title" placeholder="제목을 입력하세요" required="true"/>
        <label for="item_code">상품코드: <button type="button" class="btn btn-primary" onclick="findProduct()">상품 찾기</button></label>
        <form:input path="item_code" id="item_code"  placeholder="관련 상품을 입력해주세요"  required="true"/> 
        <label for="file">이미지 선택</label>
        <input type="file" name="file" accept="image/*"  required />

        <button type="submit" onclick="showAlert(this.form)">업로드</button>
    </form:form>
</div>
<script type="text/javascript">
function showAlert(form) {
    // 수정 완료 메시지
    alert("이미지 등록이 완료되었습니다.");
    // 폼 제출
    form.submit();
}
function findProduct() {
    const itemCode = document.getElementById("item_code").value;
    var url = "/qna/finditem_code.html"
    window.open(url, "_blank_", "width=450,height=200");
}
</script>
</body>
</html>