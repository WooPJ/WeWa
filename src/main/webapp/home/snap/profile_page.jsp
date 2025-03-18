<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/snap/snap_content.css">
<style type="text/css">
.profile_page{
    display: flex;
    width: 935px;
    flex-direction: column;
}
.snap_content{
	margin-top: 100px;
}

</style>
</head>
<body>

<!-- 프로필 및 작성게시글----------------------- -->  				                
<c:choose>
	<c:when test="${loginUser == null }">
		<div class="profile_not_logged" id="color_profile">
		    <div class="login_info">
		        <img src="/imgs/icon/login_icon.png" alt="로그인 아이콘" class="login_icon">
		        <h2>해당 기능은 로그인이 필요합니다!</h2>
		        <p>계정을 만들어 다양한 기능을 이용해 보세요!</p>
		        <div class="login_buttons">
		            <a href="/login/login.html" class="login_btn">로그인</a>
		            <a href="/login/selectentry.html" class="signup_btn">회원가입</a>
		        </div>
		    </div>
		</div>
	</c:when>
	<c:otherwise>
		<div class = "profile_page">
			<div class="profile">
				<div class = "user_top">
					<img class = "user_img" src="${empty EditProfile.profile_img ? '/imgs/icon/profile.png' : EditProfile.profile_img}" width="100" height="100">
				</div>
		
				<section class="user_section">
					<div class=user_info_box>
		                <div class="user_name"><h2>${EditProfile.nickname}</h2></div>
		                <a class="profile_modify" href="/snap/editProfile.html">프로필 편집</a>
					</div>
		            <ul class="user_follow">
		               <li><a href="/snap/mysnap.html">작성한 게시물 <span>${EditProfile.countPostNum}개</span></a></li>
<!-- 		               <li>팔로워 <span>123</span></li> -->
<!-- 		               <li>팔로우 <span>456</span></li> -->
		            </ul>
		            <div class="user_detail">
		               <span>${EditProfile.intro}</span>
		               <c:choose>
							<c:when test="${empty EditProfile.intro}">
							</c:when>
							<c:otherwise>
							
							</c:otherwise>
		               </c:choose>
		               <div class="gender_cm_kg">
     						${empty EditProfile.gender ? "성별 미입력" : EditProfile.gender} /  
     						${empty EditProfile.height ? "미입력" : EditProfile.height}cm /
     						${empty EditProfile.weight ? "미입력" : EditProfile.weight}kg
     					</div>
		            </div>
				</section>
			</div>
			<div class="snap_content">
            <c:if test="${not empty CONTENT2}">
	        	<jsp:include page="${CONTENT2}" />
	    	</c:if>	
	    </div>
		</div>
			
	</c:otherwise>
</c:choose>
</body>

</html>