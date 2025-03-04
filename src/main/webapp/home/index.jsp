<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WearWave</title>
<link rel="stylesheet" type="text/css" href="/css/items.css">
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
				 <c:forEach var="item" items="${itemList}">
				    <div class="product">
				        <a href="/item/itemDetail.html?item_code=${item.item_code}">
				            <div class="image-container">
				                 <c:if test="${not empty item.imagename}">
							        <c:set var="images" value="${fn:split(item.imagename, ',')}" />
							        <img src="${images[0]}" alt="${item.item_title}" />
							    </c:if>
				                <div class="heart-container">
				                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="-50 0 580 512" class="heart-icon"
				                         data-item-code="${item.item_code}">
				                        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4
				                                c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4
				                                268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8
				                                c0 41.5 17.2 81.2 47.6 109.5z"/>
				                    </svg>
				                </div>
				            </div>    
				            <div class="product-name">${item.item_title}</div>
				            <div class="product-description">${item.content}</div>
				            <div class="product-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/>원</div>
				        </a>
				    </div>
				</c:forEach>
				</div>			
				<script type="text/javascript">
				 let pageNo = ${currentPage} + 1; // EL을 사용하여 JSP 변수를 JavaScript로 전달
				    let loading = false; // 로딩 중인지 확인
				    
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
				       console.log("Requested page number: ", pageno);
				       const url = "/home/index.html?pageno=" + pageno;

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
            </c:otherwise>
        </c:choose>
    </td></tr>
</table>
<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome for heart icon -->

<script type="text/javascript">
    function redirectToLogin() {
    	//if(confirm("로그인 후 찜 기능을 사용할 수 있습니다. \n로그인 하시겠습니까?")) {
    	if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")){
	        window.location.href = "/login/login.html";
    	}
    }

	document.addEventListener("DOMContentLoaded", function () {	
	    
	    const heartIcons = document.querySelectorAll('.heart-icon');
	    heartIcons.forEach(heart => {
	        const itemId = heart.getAttribute("data-item-code");
	
	        // 찜한 상품인지 확인
	        <c:forEach items="${sessionScope.heartList}" var="heart">
	            if ("${heart.item_code}" == itemId) {
	                heart.classList.add('filled'); // 하트 채우기
	            }
	        </c:forEach>
	
		    if (document.querySelector('#item-detail-container')) {
		        console.log("🚀 현재 페이지는 itemDetail.jsp입니다. index.jsp의 heartIcon 스크립트 실행 안함");
		        return; // 실행 중단
		    } else { //itemDetail.jsp가 아니면
		    	
		        heart.addEventListener('click', function (event) {
		            event.preventDefault();
		            if (${sessionScope.loginUser == null}) {
		               redirectToLogin();		               	
		            } else {
		                this.classList.toggle('filled');
		                const isFilled = this.classList.contains('filled');
		                const inData = { itemCode: itemId, status: isFilled };
		                let param = new URLSearchParams(inData).toString();
		                fetch("/heart/toggle.html?" + param); //컨트롤러 매핑
		            }
		        });
		    }
	    });
	});

    // 뒤로가기 클릭시 새로고침(하트표시 반영)
    window.onpageshow = function(event){   // onpageshow는 page 호출되면 캐시든 아니든 무조건 호출됨
        if (event.persisted || (window.performance && window.performance.navigation.type == 2)){
            // 사파리 or 안드로이드에서 뒤로가기로 넘어온 경우 캐시를 이용해 화면을 보여주는데, 이때 사파리의 경우 event.persisted 가 ture임 
            // 그외 브라우저(크롬 등)에서는 || 뒤에 있는 조건으로 뒤로가기 체크가 가능함
            window.location.reload(); 
        }
    };
    
   
</script>
</body>
</html>
