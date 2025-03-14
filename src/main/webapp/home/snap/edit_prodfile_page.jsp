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
    <div class="edit-form-container">
        <h2 class="edit-title">프로필 편집</h2>
        <form:form modelAttribute="EditProfile" action="/snap/editProfile.html" method="post" onsubmit="return validateForm()" enctype="multipart/form-data" name="postFrm" id="postingForm" class="posting-form">
            
            <label for="photo" class="posting-label">사진 첨부</label>
            <input type="file" name="files" id="photo" class="posting-input-file" accept="image/*" required/>
            
            <label for="content" class="posting-label">본문 입력</label>
            <form:textarea path="content" id="content" class="posting-textarea" placeholder="내용을 입력하세요..." required="true"/>
            
            <label class="edit-label">체형 정보</label>
            <form:input path="height" type="number" id="height" class="posting-input" placeholder="키 (cm)" required="true"/>
            <form:input path="weight" type="number" id="weight" class="posting-input" placeholder="몸무게 (kg)" required="true"/>
            
            <label class="edit-label">성별</label>
            <div class="posting-radio-group">
<%--             <form:select path="gender"> --%>
<%--                 <form:option value="male">남성</form:option> --%>
<%--                 <form:option value="female">여성</form:option> --%>
<%--             </form:select> --%>
                <form:radiobutton path="gender" value="male" label="남성"/>
    			<form:radiobutton path="gender" value="female" label="여성"/>
            </div>
            
            <button type="submit" class="posting-submit-btn">포스팅 등록</button>
        </form:form>
    </div>
</body>


<script type="text/javascript">
function validateForm() {
    const maleChecked = document.getElementById("gender_male").checked;
    const femaleChecked = document.getElementById("gender_female").checked;

    if (!maleChecked && !femaleChecked) {
        alert("성별을 선택해주세요.");
        return false; // 폼 제출 방지
    }else {
	    return true; // 정상 제출
    }
}
</script>
</body>
</html>