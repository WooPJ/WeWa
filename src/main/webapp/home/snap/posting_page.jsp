<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    
		<!-- + 버튼 -->
		<button class="floating_btn">+</button>
	</div>
</div> 

</body>
</html>