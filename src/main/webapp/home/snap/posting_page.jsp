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
<link rel="stylesheet" type="text/css" href="../css/snap/snap_content.css">

</head>
<body>

<!-- 피드게시물----------------------- -->
<div class = "posting_page"> 
	<div class = "posting_line">
         <c:forEach var="feed" items="${sessionScope.FeedList}">
           	<a>
                <div class="posting_box" onclick="openModal('/imgs/item/${feed.imagename}')">
                <c:set var="images" value="${fn:split(feed.imagename, ',')}" />
  				<img class="posting_img" src="/imgs/item/${images[0]}" alt="${feed.imagename}" />
                </div>
           	</a>
         </c:forEach>
                    
			<c:choose>
				<c:when test="${loginUser != null }">
					<form action="/snap/addPostWrite.html" method="get">
						<button class="floating_btn">+</button>
					</form>
				</c:when>
				<c:otherwise>
					<button class="floating_btn" onclick="confirmLogin()">+</button>
				</c:otherwise>
			</c:choose>
	</div>
</div> 

<script type="text/javascript">
function confirmLogin() {
	event.preventDefault(); // 기본 동작(폼 제출) 방지
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