<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WearWave</title>
<link rel="stylesheet" type="text/css" href="../css/items.css">
</head>
<body>
<jsp:include page="menu_header.jsp"/>

<table>
<tr>
	<td id="content">
			<c:choose>
				<c:when test="${ BODY != null }">
					<jsp:include page="${ BODY }"/>
				</c:when>
				<c:otherwise>
<jsp:include page="main_slider.jsp"/>				
<div class="product-container">
 <c:forEach var="item" items="${Items}">
    <div class="product">
    	<a href="">
        <img src="${item.imagename} " width="250" height="300"/>
        <div class="product-name">${item.user_id}</div>
        <div class="product-description">${item.item_title}</div>
        <div class="product-price">${item.price}원</div>
   		 </a>
    </div>
 </c:forEach>
 </div>
</c:otherwise></c:choose></td></tr>
</table>


</body>
</html>