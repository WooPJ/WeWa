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
		<select id="categorySelect" onchange="updateSubcategories()">
		    <option disabled selected>카테고리를 선택하세요</option>
		    <option data-category="top">상의</option>
		    <option data-category="bottom">하의</option>
		    <option data-category="outer">아우터</option>
		    <option data-category="shoes">신발</option>
		</select>
		
		<label for="title">세부 카테고리</label>
		<select id="subcategorySelect" name="subcategory" onchange="setItemId()">
		    <!-- 세부 카테고리는 JavaScript로 동적으로 채워짐 -->
		</select>
		<form:input type="hidden" id="item_id" name="item_id" path="item_id" value=""/>
        <label for="file">이미지 선택:</label>
        <input type="file" name=file accept="image/*"  required />
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
window.onload = function() {
    updateSubcategories(); // 페이지 로드 시 기본적으로 하위 카테고리를 업데이트합니다.
};

function updateSubcategories() {
    var categorySelect = document.getElementById("categorySelect");
    var subcategorySelect = document.getElementById("subcategorySelect");

    // 선택된 카테고리의 data-category 값을 가져옵니다.
    var selectedCategory = categorySelect.options[categorySelect.selectedIndex].getAttribute("data-category");
    console.log("선택된 카테고리:", selectedCategory);
    // 카테고리별 세부 옵션 목록
    var subcategories = {
        "top": [
            { value: 1, text: "니트" },
            { value: 2, text: "맨투맨" },
            { value: 3, text: "후드" },
            { value: 4, text: "셔츠" },
            { value: 5, text: "긴소매" },
            { value: 6, text: "반소매" }
        ],
        "bottom": [
            { value: 11, text: "데님" },
            { value: 12, text: "트레이닝" },
            { value: 13, text: "조거" },
            { value: 14, text: "슬랙스" },
            { value: 15, text: "숏팬츠" }
        ],
        "outer": [
            { value: 21, text: "패딩" },
            { value: 22, text: "후드 집업" },
            { value: 23, text: "카디건" },
            { value: 24, text: "무스탕" },
            { value: 25, text: "코트" },
            { value: 26, text: "트레이닝" }
        ],
        "shoes": [
            { value: 31, text: "스니커즈" },
            { value: 32, text: "부츠" },
            { value: 33, text: "구두" },
            { value: 34, text: "샌들" },
            { value: 35, text: "스포츠" }
        ]
    };
    // 기본 선택지 추가
    var defaultOption = document.createElement("option");
    defaultOption.disabled = true;
    defaultOption.selected = true;
    defaultOption.text = "세부 카테고리를 선택하세요";
    subcategorySelect.appendChild(defaultOption);

    // 새로운 옵션 추가
    if (selectedCategory && subcategories[selectedCategory]) {
        subcategories[selectedCategory].forEach(function(sub) {
            var option = document.createElement("option");
            option.value = sub.value;  // 하위 옵션의 value 설정 (숫자)
            option.text = sub.text;    // 화면에 표시될 텍스트 설정 (한글)
            subcategorySelect.appendChild(option);
        });
    }
}
function setItemId() {
    var subcategorySelect = document.getElementById("subcategorySelect");
    var selectedSubcategory = subcategorySelect.options[subcategorySelect.selectedIndex];
    var itemId = selectedSubcategory ? selectedSubcategory.value : '';  // 선택된 서브 카테고리 값

    // item_id hidden input에 값 설정
    document.getElementById("item_id").value = itemId;
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
