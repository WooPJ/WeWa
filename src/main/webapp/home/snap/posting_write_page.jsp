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

<body>
    <div class="posting-form-container">
        <h2 class="posting-title">게시물 작성</h2>
        <form:form modelAttribute="Posting" action="/snap/addPostWrite.html" method="post" enctype="multipart/form-data" name="postFrm" id="postingForm" class="posting-form">
            
            <label for="photo" class="posting-label">사진 첨부</label>
            <input type="file" name="files" id="photo" class="posting-input-file" accept="image/*" multiple required/>
            
            <label for="content" class="posting-label">본문 입력</label>
            <form:textarea path="content" id="content" class="posting-textarea" placeholder="내용을 입력하세요..." required="true"/>
            
            <label class="posting-label">체형 정보</label>
            <form:input path="height" type="text" id="height" class="posting-input" placeholder="키 (cm)"/>
            <form:input path="weight" type="text" id="weight" class="posting-input" placeholder="몸무게 (kg)"/>
            
            <label class="posting-label">성별</label>
            <div class="posting-radio-group">
<%--             <form:select path="gender"> --%>
<%--                 <form:option value="male">남성</form:option> --%>
<%--                 <form:option value="female">여성</form:option> --%>
<%--             </form:select> --%>
                <form:radiobutton path="gender" value="male" label="남성"/>
    			<form:radiobutton path="gender" value="female" label="여성"/>
            </div>
            
            <label class="posting-label">스타일 태그</label>
            <div class="posting-checkbox-group">
                <label><input type="checkbox" name="styleTags[]" value="casual" class="posting-checkbox"> 캐주얼</label>
                <label><input type="checkbox" name="styleTags[]" value="minimal" class="posting-checkbox"> 미니멀</label>
                <label><input type="checkbox" name="styleTags[]" value="chic" class="posting-checkbox"> 시크</label>
                <label><input type="checkbox" name="styleTags[]" value="retro" class="posting-checkbox"> 레트로</label>
                <label><input type="checkbox" name="styleTags[]" value="street" class="posting-checkbox"> 스트릿</label>
            </div>
            
            <label class="posting-label">TPO</label>
            <div class="posting-checkbox-group">
                <label><input type="checkbox" name="tpoTags[]" value="daily" class="posting-checkbox"> 데일리</label>
                <label><input type="checkbox" name="tpoTags[]" value="date" class="posting-checkbox"> 데이트</label>
                <label><input type="checkbox" name="tpoTags[]" value="campus" class="posting-checkbox"> 캠퍼스</label>
                <label><input type="checkbox" name="tpoTags[]" value="trip" class="posting-checkbox"> 여행</label>
                <label><input type="checkbox" name="tpoTags[]" value="camping" class="posting-checkbox"> 캠핑</label>
                <label><input type="checkbox" name="tpoTags[]" value="cafe" class="posting-checkbox"> 카페</label>
                <label><input type="checkbox" name="tpoTags[]" value="beach" class="posting-checkbox"> 바다</label>
                <label><input type="checkbox" name="tpoTags[]" value="festival" class="posting-checkbox"> 페스티벌</label>
                <label><input type="checkbox" name="tpoTags[]" value="work" class="posting-checkbox"> 출근</label>
                <label><input type="checkbox" name="tpoTags[]" value="wedding" class="posting-checkbox"> 결혼식</label>
            </div>
            
            <button type="submit" class="posting-submit-btn">포스팅 등록</button>
        </form:form>
    </div>
</body>


<script type="text/javascript">
function confirmLogin() {
    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
        // '확인' 클릭 시 로그인 페이지로 이동
        window.location.href = "/login/login.html";
    } else {
    	return false; //아무동작도 안함
    }
}
</script>
</body>
</html>