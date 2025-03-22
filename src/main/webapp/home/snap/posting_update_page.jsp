<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/snap/snap_post_write.css">
</head>
<body>

    <div class="posting-form-container">
        <h2 class="posting-title">게시물 수정</h2>

        <form:form modelAttribute="Posting" action="/snap/updatePost.html" method="post" onsubmit="return validateForm()" enctype="multipart/form-data" name="postFrm" id="postingForm" class="posting-form">
              <input type="hidden" name="post_id" value="${Posting.post_id}" />      
            <label for="photo" class="posting-label">사진 첨부</label>
            <input type="file" name="files" id="photo" class="posting-input-file" accept="image/*" multiple/>
            
            <label for="content" class="posting-label">본문 입력</label>
            <form:textarea path="content" id="content" class="posting-textarea" placeholder="내용을 입력하세요..." required="true" value = "${Posting.content }"/>
          
            <label for="item_code"  class="posting-label">상품코드: <button type="button" class="btn btn-primary" onclick="findProduct()">상품 찾기</button></label>
            <form:input path="item_code" id="item_code" value="${Posting.item_code}" class="posting-input" placeholder="관련 상품이 있으면 입력해주세요"/> 
            
            <label class="posting-label">체형 정보</label>
            <form:input path="height" type="number" id="height" class="posting-input" placeholder="키 (cm)" required="true" value = "${Posting.height}"/>
            <form:input path="weight" type="number" id="weight" class="posting-input" placeholder="몸무게 (kg)" required="true"  value = "${Posting.weight}"/>
            
            <label class="posting-label">성별코디</label>
            <div class="posting-radio-group">
                <form:radiobutton path="gender_style" value="male" id="gender_male" label="남성코디"/>
    			<form:radiobutton path="gender_style" value="female" id="gender_female" label="여성코디"/>
    			<form:radiobutton path="gender_style" value="genderless" id="gender_less" label="젠더리스"/>
            </div>
            
            <label class="posting-label">스타일 태그</label>
			<div class="posting-checkbox-group">
			    <label><input type="checkbox" name="styleTags[]" value="casual" class="posting-checkbox" 
			        <c:if test="${fn:contains(style, 'casual')}">checked</c:if>> 캐주얼</label>
			    <label><input type="checkbox" name="styleTags[]" value="minimal" class="posting-checkbox" 
			        <c:if test="${fn:contains(style, 'minimal')}">checked</c:if>> 미니멀</label>
			    <label><input type="checkbox" name="styleTags[]" value="chic" class="posting-checkbox" 
			        <c:if test="${fn:contains(style, 'chic')}">checked</c:if>> 시크</label>
			    <label><input type="checkbox" name="styleTags[]" value="retro" class="posting-checkbox" 
			        <c:if test="${fn:contains(style, 'retro')}">checked</c:if>> 레트로</label>
			    <label><input type="checkbox" name="styleTags[]" value="street" class="posting-checkbox" 
			        <c:if test="${fn:contains(style, 'street')}">checked</c:if>> 스트릿</label>
			</div>
			
			<label class="posting-label">TPO 태그</label>
			<div class="posting-checkbox-group">
			    <label><input type="checkbox" name="tpoTags[]" value="daily" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'daily')}">checked</c:if>> 데일리</label>
			    <label><input type="checkbox" name="tpoTags[]" value="date" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'date')}">checked</c:if>> 데이트</label>
			    <label><input type="checkbox" name="tpoTags[]" value="campus" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'campus')}">checked</c:if>> 캠퍼스</label>
			    <label><input type="checkbox" name="tpoTags[]" value="trip" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'trip')}">checked</c:if>> 여행</label>
			    <label><input type="checkbox" name="tpoTags[]" value="camping" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'camping')}">checked</c:if>> 캠핑</label>
			    <label><input type="checkbox" name="tpoTags[]" value="cafe" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'cafe')}">checked</c:if>> 카페</label>
			    <label><input type="checkbox" name="tpoTags[]" value="beach" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'beach')}">checked</c:if>> 바다</label>
			    <label><input type="checkbox" name="tpoTags[]" value="festival" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'festival')}">checked</c:if>> 페스티벌</label>
			    <label><input type="checkbox" name="tpoTags[]" value="work" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'work')}">checked</c:if>> 출근</label>
			    <label><input type="checkbox" name="tpoTags[]" value="wedding" class="posting-checkbox" 
			        <c:if test="${fn:contains(tpo, 'wedding')}">checked</c:if>> 결혼식</label>
			</div>   
            <button type="submit" class="posting-submit-btn">포스팅 수정</button>
        </form:form>
    </div>
</body>


<script type="text/javascript">

function validateForm() {
    const maleChecked = document.getElementById("gender_male").checked;
    const femaleChecked = document.getElementById("gender_female").checked;
    const genderlessChecked = document.getElementById("gender_less").checked;

    if (!maleChecked && !femaleChecked && !genderlessChecked) {
        alert("성별 스타일을 선택해주세요.");
        return false; // 폼 제출 방지
    }else {
	    return true; // 정상 제출
    }
}

function confirmLogin() {
    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
        // '확인' 클릭 시 로그인 페이지로 이동
        window.location.href = "/login/login.html";
    } else {
    	return false; //아무동작도 안함
    }
}
function findProduct() {
    var url = "/qna/finditem_code.html";
    window.open(url, "_blank", "width=550,height=300");
}
</script>

</html>