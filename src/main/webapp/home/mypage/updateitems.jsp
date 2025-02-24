<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 화면</title>
<link rel="stylesheet" type="text/css" href="../css/addItems.css">
</head>
<body>
<div id="upload-container">
    <h3>상품 수정</h3>
    <form:form modelAttribute="items" action="/items/updateItemDo.html" method="post" enctype="multipart/form-data" name="itemFrm">
 
        <label for="item_code">상품 코드:</label>
        <form:input path="item_code" readonly="true" required="true"/>
        
        <label for="item_title">상품명:</label>
        <form:input path="item_title" value="${Items.item_title}" placeholder="상품명을 입력하세요" required="true"/>
      
        <label for="file">이미지 선택:</label>
        <input type="file" name="file" accept="image/*" />

        <label for="price">가격:</label>
        <form:input path="price" value="${Items.price}" placeholder="가격을 입력하세요" required="true"/>
        
        <label for="color">색상:</label>
        <div id="color-container">
            <c:forEach var="color" items="${color}">
                <input type="text" name="color[]" value="${color.item_color}" placeholder="색상을 입력하세요" required/>
            </c:forEach>
        </div>
        <button type="button" onclick="addField('color')">+ 색상 추가</button>

        <label for="size">사이즈 및 갯수:</label>
        <div id="size-container">
            <c:forEach var="size" items="${size}">
                <div class="size-group">
                    <input type="text" name="size[]" value="${size.item_size}" placeholder="사이즈를 입력하세요" required/>
                    <input type="number" name="quantity[]" value="${size.quantity}" placeholder="갯수를 입력하세요" min="1" />
                </div>
            </c:forEach>
        </div>
        <button type="button" onclick="addField('size')">+ 사이즈 추가</button>

        <label for="content">상품설명:</label>
        <form:textarea path="content" value="${Items.content}" placeholder="설명을 입력하세요" required="true"/>

        <button type="submit" onclick="showAlert(this.form)">수정 완료</button>
    </form:form>
</div>

<script type="text/javascript">
function addField(fieldName) {
    var container = document.getElementById(fieldName + '-container');
    
    if (fieldName === 'size') {
        // Create new size and quantity input fields
        var sizeGroup = document.createElement('div');
        sizeGroup.classList.add('size-group');
        
        var sizeInput = document.createElement('input');
        sizeInput.type = 'text';
        sizeInput.name = 'size[]';  // 배열 형태로 보내기 위해 [] 추가
        sizeInput.placeholder = '사이즈를 입력하세요';
        
        var quantityInput = document.createElement('input');
        quantityInput.type = 'number';
        quantityInput.name = 'quantity[]';  // 배열 형태로 보내기 위해 [] 추가
        quantityInput.placeholder = '갯수를 입력하세요';
        quantityInput.min = 1;
        
        sizeGroup.appendChild(sizeInput);
        sizeGroup.appendChild(quantityInput);
        
        container.appendChild(sizeGroup);
    } else {
        var inputField = document.createElement('input');
        inputField.type = 'text';
        inputField.name = fieldName + '[]';  // 배열 형태로 보내기 위해 [] 추가
        inputField.placeholder = '색상을 입력하세요';

        container.appendChild(inputField);
    }
}

function showAlert(form) {
    // 수정 완료 메시지
    alert("상품 수정이 완료되었습니다.");
    // 폼 제출
    form.submit();
}
</script>

</body>
</html>
