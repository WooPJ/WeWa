<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <c:if test="${not empty FeedList}">
	        	<jsp:include page="${BOOKMARKLIST}" />
	    	</c:if>
	    	<c:if test="${empty FeedList}">
	    		<script type="text/javascript">
	    			console.log("북마크 비어있음");
	    		</script>
	    		<div class="bookmark_empty">
	    			<h3>북마크 저장함이 비어있습니다! </br>마음에 드는 게시물을 저장해보세요!🤗</h2>
	    		</div>
	    	</c:if>
		</div>
	</c:otherwise>
</c:choose>      
</body>
</html>