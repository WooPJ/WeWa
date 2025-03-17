<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아우터 목록</title>
</head>
<body>
<div class="category-container">
    <div class="category-links">
	<a href="/menu/outer.html">전체</a>
	<a href="/menu/outercategoryList.html?item_id=21">패딩</a>
	<a href="/menu/outercategoryList.html?item_id=22">후드 집업</a>
	<a href="/menu/outercategoryList.html?item_id=23">카디건</a>
	<a href="/menu/outercategoryList.html?item_id=24">무스탕</a>
	<a href="/menu/outercategoryList.html?item_id=25">코트</a>
	<a href="/menu/outercategoryList.html?item_id=26">트레이닝</a>
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
                 <c:if test="${not empty item.imagename}">
			        <c:set var="images" value="${fn:split(item.imagename, ',')}" />
			        <img src="${images[0]}" alt="${item.item_title}" />
			    </c:if>
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
        <div class="product-name">${item.name}</div>
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

let pageNo = ${currentPage} + 1; // EL을 사용하여 JSP 변수를 JavaScript로 전달
let loading = false; // 로딩 중인지 확인
let categoryId = ${item_id}

console.log("Initial page number: ", pageNo);

// 무한 스크롤 구현
window.addEventListener("scroll", function() {
const scrollPosition = window.innerHeight + window.scrollY;
const triggerPoint = document.body.offsetHeight - 300; // 끝에서 300px 전에 실행

if (scrollPosition >= triggerPoint && !loading) {
    loading = true;
    
    loadItems(pageNo); // 서버에서 새로운 아이템을 불러오기
}
});

function loadItems(pageno) {
	let url;
    if (categoryId) {
        // 카테고리가 있을 경우
        url = "/menu/outercategoryList.html?item_id=" + categoryId + "&pageno=" + (pageno+1);
    } else {
        // 카테고리가 없으면 기본 리스트를 요청
        url = "/menu/outer.html?pageno=" + pageno;
    }
    console.log("Requested URL: ", url);
   fetch(url)
       .then(response => response.text())
       .then(html => {
           const container = document.querySelector(".product-container");
           const newContent = document.createElement('div');
           newContent.innerHTML = html.trim();

           // 새로운 데이터가 있는지 확인
           const newItems = newContent.querySelector(".product-container")?.innerHTML.trim();
           if (!newItems) {
               console.log("더 이상 불러올 데이터가 없습니다.");
               hasMoreData = false; // 데이터 없으면 로딩 중지
               return;
           }

           container.innerHTML += newItems; // 기존 컨텐츠에 새로운 아이템 추가
           pageNo++; // 데이터가 있을 때만 증가
           loading = false; // 로딩 상태 해제
       })
       .catch(error => {
           console.error("아이템 로딩 실패", error);
           loading = false;
       });
}

</script>
</body>
</html>