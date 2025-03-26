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
<link rel="stylesheet" type="text/css" href="../css/snap/snap_edit_profile.css">
</head>
<body>

    <div class="edit-form-container">
        <h2 class="edit-title">프로필 편집</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">
				<script type="text/javascript">
					alert("${error}");
					location.href = "/snap/profileContent.html";
				</script>
            </div>
        </c:if>
        
        <form:form modelAttribute="EditProfile" action="/snap/editProfile.html" method="post" 
        	onsubmit="return frmCheck()" enctype="multipart/form-data" name="postFrm" id="editForm" class="editing-form">
            <input type="hidden" name="nicknameChecked"/>
            
            <label class="edit-label">기존 프로필 사진</label>
            <img alt="profile" src="${empty EditProfile.profile_img ? '/imgs/icon/profile.png' : EditProfile.profile_img}" width="60px">
            
            <label for="photo" class="edit-label">프로필 사진 첨부</label>
	        <input type="file" name="files" id="photo" class="edit-input-file" accept="image/*"/>
            
            <!-- 닉네임입력 & 중복검사 -->
            <label class="edit-label">닉네임 입력</label>
            <div class="input-with-button">
	            <form:input path="nickname" type="text" value="${EditProfile.nickname}" id="nickname" class="edit-input" placeholder="닉네임을 입력하세요..." required="true"/>
	            <input type="button" value="중복 확인" class="check-button" onclick="nicknameCheck()">
            </div>
            
            <label for="intro" class="edit-label">소개말 입력</label>
            <form:textarea path="intro" id="intro" class="edit-textarea" placeholder="소개말 내용을 입력하세요..." onclick="introCheck()"/>
            
            <label class="edit-label">체형 정보</label>
            <form:input path="height" type="number" value="${EditProfile.height}" id="height" class="edit-input" placeholder="키 (cm)"/>
            <form:input path="weight" type="number" value="${EditProfile.weight}" id="weight" class="edit-input" placeholder="몸무게 (kg)"/>
            
            <label class="edit-label">성별</label>
            <div class="edit-radio-group">
                <form:radiobutton path="gender" value="male" id="gender_male" label="남성"/>
    			<form:radiobutton path="gender" value="female" id="gender_female" label="여성"/>
    			<form:radiobutton path="gender" value="private" id="gender_less" label="비공개"/>
            </div>
            
            <button type="submit" class="edit-submit-btn">프로필 등록</button>
        </form:form>
    </div>
</body>

<script type="text/javascript" src="../../js/edit_profile_page_vaildateCheck.js"></script>
</html>