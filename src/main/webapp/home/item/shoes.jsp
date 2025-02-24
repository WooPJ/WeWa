<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신발 목록</title>
</head>
<body>
<div class="category-container">
    <div class="category-links">
	<a href="/menu/shoes.html">전체</a>
	<a href="/menu/shoescategoryList.html?item_id=31">스니커즈</a>
	<a href="/menu/shoescategoryList.html?item_id=32">부츠</a>
	<a href="/menu/shoescategoryList.html?item_id=33">구두</a>
	<a href="/menu/shoescategoryList.html?item_id=34">샌들</a>
	<a href="/menu/shoescategoryList.html?item_id=35">스포츠</a>
</div>
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
        <div class="image-container">
                <img src="../imgs/item/${item.imagename}" alt="${item.item_title}"/>
                <div class="heart-container">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon"
                         data-item-id="${item.item_code}">
                        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4
                                c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4
                                268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8
                                c0 41.5 17.2 81.2 47.6 109.5z"/>
                    </svg>
                </div>
            </div>    
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