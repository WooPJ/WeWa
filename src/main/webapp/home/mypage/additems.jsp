<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 화면</title>
<link rel="stylesheet" type="text/css" href="../css/addItems.css">
</head>
<body>
<div id="upload-container">
    <h3>상품 등록</h3>
    <form:form modelAttribute="Items" action="/items/addItems.html" method="post" enctype="multipart/form-data"  name="itemFrm">
    	<label for="item_code">상품 코드:</label>
        <form:input path="item_code" placeholder="상품 코드를 입력하세요 ex)상호이니셜_001" required="true"/>
        <input type="button" value="중복 검사" onclick="codeCheck()"/>
        <form:input type="hidden" path="codeChecked" id="codeChecked" value="no"/>
        <label for="item_title">상품명:</label>
        <form:input path="item_title" placeholder="상품명을 입력하세요" required="true"/>
		<label for="title">카테고리</label>
        <form:select path="item_id">
        <form:option value="1">상의</form:option>
        <form:option value="2">하의</form:option>
        <form:option value="3">아우터</form:option>
        <form:option value="4">신발</form:option>
		</form:select>
        <label for="file">이미지 선택:</label>
        <input type="file" name="file" accept="image/*"  required />
        <label for="price">가격:</label>
        <form:input path="price" placeholder="가격을 입력하세요" required="true"/>
        <label for="color">색상:</label>
        <div id="color-container">
            <input type="text" name="color[]" placeholder="색상을 입력하세요" required/>
        </div>
        <button type="button" onclick="addField('color')">+ 색상 추가</button>

        <label for="size">사이즈 및 갯수:</label>
        <div id="size-container">
            <div class="size-group">
                <input type="text" name="size[]" placeholder="사이즈를 입력하세요" required/>
                <input type="number" name="quantity[]" placeholder="갯수를 입력하세요" min="1" />
            </div>
        </div>
        <button type="button" onclick="addField('size')">+ 사이즈 추가</button>

        <label for="content">상품설명:</label>
        <form:textarea path="content" placeholder="설명을 입력하세요" required="true"/>

        <button type="submit" onclick="showAler(this.form)">업로드</button>
    </form:form>
</div>

<script type="text/javascript">
function codeCheck(){
	if(document.itemFrm.item_code.value == ''){
		alert("상품코드를 입력하세요."); return;
	}
	var url="/items/codecheck.html?item_code="+document.itemFrm.item_code.value;
	window.open(url, "__blank__","width=450,height=200,top=200,left=300");
}

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
    function showAlert(form) {
        // 수정 완료 메시지
        alert("상품 등록이 완료되었습니다.");
        // 폼 제출
        form.submit();
    }
}
</script>

</body>
</html>
