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
.stored_page{
    display: flex;
    width: 935px;
    flex-direction: column;
}
</style>
</head>
<body>

<!-- 저장된게시물----------------------- -->
<c:choose>
	<c:when test="${loginUser == null }">
		<div class="profile_not_logged" id="color_stored">
		    <div class="login_info">
		        <img id="stored_icon" src="/imgs/icon/love-heart-bubble.png" alt="로그인 아이콘" class="login_icon">
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
		<div class = "stored_page">
	      <div id="store_top">
	          <span>저장한 내용은 회원님만 볼 수 있습니다.</span>
	          <div class="new_store">+새 컬렉션</div>
	      </div>
	      <div id = "store_main">
	          <div id="store_main_box">
	              <div id = "store_img_box">
	                  <svg class="store_img" aria-label="" fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><polygon fill="none" points="20 21 12 13.44 4 21 4 3 20 3 20 21" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polygon></svg>
	              </div>
	              <span>저장</span>
	              <span>다시보고 싶은 사진과 동영상을 저장하세요. 콘텐츠를<br> 저장해도 다른 사람에게 알림이 전송되지 않으며, 저장된<br>콘텐츠는 회원님만 볼 수 있습니다.</span>
	          </div>
	      </div>
		</div>
	</c:otherwise>
</c:choose>      
</body>
</html>