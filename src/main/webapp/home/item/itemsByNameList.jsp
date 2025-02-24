<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>상의 목록</title>
</head>
<body>
<div class="category-container">
    <div class="sort-container">
        <label for="sort">정렬:</label>
        <select id="sort" onchange="sortProducts()">
            <option value="default">기본순</option>
            <option value="price-asc">가격 낮은 순</option>
            <option value="price-desc">가격 높은 순</option>
            <option value="name-asc">이름 오름차순</option>
            <option value="name-desc">이름 내림차순</option>
        </select>
    </div>
</div>
<div class="product-container">
 <c:forEach var="item" items="${Items}">
    <div class="product">
    	<a href="/item/itemDetail.html?item_code=${item.item_code }">
        <img src="${item.imagename} " width="250" height="300"/>
        <div class="product-name">${item.user_id}</div>
        <div class="product-description">${item.item_title}</div>
        <%-- <div class="product-price">${item.price}원</div> --%>
         <div class="product-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/>원</div>
   		 </a>
    </div>
 </c:forEach>
 </div>
 <script>
function sortProducts() {
    let sortType = document.getElementById("sort").value;
    let productsContainer = document.querySelector(".product-container");
    let products = Array.from(productsContainer.getElementsByClassName("product"));

    products.sort((a, b) => {
        let priceA = parseInt(a.querySelector(".product-price").textContent.replace(/[^0-9]/g, ""));
        let priceB = parseInt(b.querySelector(".product-price").textContent.replace(/[^0-9]/g, ""));
        let nameA = a.querySelector(".product-name").textContent.trim();
        let nameB = b.querySelector(".product-name").textContent.trim();

        if (sortType === "price-asc") return priceA - priceB;
        if (sortType === "price-desc") return priceB - priceA;
        if (sortType === "name-asc") return nameA.localeCompare(nameB, "ko");
        if (sortType === "name-desc") return nameB.localeCompare(nameA, "ko");
        return 0;
    });

    productsContainer.innerHTML = "";
    products.forEach(product => productsContainer.appendChild(product));
}
</script>
</body>
</html>