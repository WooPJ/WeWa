<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더메뉴</title>
<link rel="stylesheet" type="text/css" href="/css/menu.css">
</head>
<body>
<header>
    <div class="header-container">
    
        <a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a>   
        <form action="/home/search.html" method="post" class="search-container">
            <input type="text" name="NAME" placeholder="검색어를 입력해주세요.">
            <button type="submit" id="search"></button>
        </form>
         <div class="icon-container">
          <a href="/snap/snap.html" class="snap">
	            <img alt="스냅" src="../imgs/icon/snap.png" >
	        </a>  
	         <a href="/mypage/notice.html" class="mypage">
	            <img alt="마이페이지" src="../imgs/icon/mypage.png" >
	        </a>   
	         <a href="/heart/heartlist.html" class=heart>
	            <img alt="찜 목록" src="../imgs/icon/like.png" >
	        </a>
				<c:choose>
					<c:when test="${sessionScope.loginUser == null}">
						<a href="javascript:void(0);" class="cart"
							onclick="confirmLogin()"> <img alt="장바구니 목록"
							src="../imgs/icon/cart.png">
						</a>
					</c:when>
					<c:otherwise>
						<a href="/cart/cart.html" class="cart"> <img alt="장바구니 목록"
							src="../imgs/icon/cart.png">
						</a>
					</c:otherwise>
				</c:choose>
			</div>
    </div>
	<div class="sub-header">
	<button class="top-bar-button" onclick="toggleSidebar()">☰</button>
		<c:choose>
			<c:when test="${sessionScope.loginUser == null }">
				<a href="/login/login.html" class="login">로그인</a> 
				<a href="/login/selectentry.html" class="sign up">회원가입</a> 
			</c:when>
			<c:otherwise>

				<font color="#FF1493" style="bold"><b>${ sessionScope.loginUser.id }고객님</b></font>
				<a href="/login/logout.html" class="logout">로그아웃</a> 
			</c:otherwise>
		</c:choose> 
	</div>
<div class="sidebar">
    <div class="menu-item">
        <a href="/home/index.html">홈</a>
    </div>
   <div class="menu-item">
        <a class="word">상의</a>
        <div class="submenu">
              <a class="word" href="/menu/top.html">전체</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=1">니트</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=2">맨투맨</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=3">후드</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=4">셔츠</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=5">긴소매</a>
              <a class="word" href="/menu/topcategoryList.html?item_id=6">반소매</a>
        </div> 
    </div>
     <div class="menu-item">
        <a class="word">하의</a>
         <div class="submenu">
              <a class="word" href="/menu/bottom.html">전체</a>
              <a class="word" href="/menu/bottomcategoryList.html?item_id=11">데님</a>
              <a class="word" href="/menu/bottomcategoryList.html?item_id=12">트레이닝</a>
              <a class="word" href="/menu/bottomcategoryList.html?item_id=13">조거</a>
              <a class="word" href="/menu/bottomcategoryList.html?item_id=14">슬랙스</a>
              <a class="word" href="/menu/bottomcategoryList.html?item_id=15">숏 팬츠</a>
        </div>
    </div>
     <div class="menu-item">
        <a class="word">아우터</a>
        <div class="submenu">
              <a class="word" href="/menu/outer.html">전체</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=21">패딩</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=22">후드 집업</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=23">카디건</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=24">무스탕</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=25">코트</a>
              <a class="word" href="/menu/outercategoryList.html?item_id=26">트레이닝</a>
        </div>
    </div>
     <div class="menu-item">
         <a class="word">신발</a>
        <div class="submenu">
              <a class="word" href="/menu/shoes.html">전체</a>
              <a class="word" href="/menu/shoescategoryList.html?item_id=31">스니커즈</a>
              <a class="word" href="/menu/shoescategoryList.html?item_id=32">부츠</a>
              <a class="word" href="/menu/shoescategoryList.html?item_id=33">구두</a>
              <a class="word" href="/menu/shoescategoryList.html?item_id=34">샌들</a>
              <a class="word" href="/menu/shoescategoryList.html?item_id=35">스포츠</a>
        </div>
    </div>
</div>

</header>

<script type="text/javascript">
		let isSidebarOpen = false;
		let isTopBarOpen = false;
		
		function toggleSidebar() {
		    const sidebar = document.querySelector(".sidebar");
		    const topBarButton = document.querySelector(".top-bar-button");
		
		    if (isSidebarOpen) {
		        sidebar.classList.remove("open");
		        topBarButton.classList.remove("open");
		        isSidebarOpen = false;
		        isTopBarOpen = false;
		    } else {
		        sidebar.classList.add("open");
		        topBarButton.classList.add("open");
		        isSidebarOpen = true;
		        isTopBarOpen = true;
		    }
		}
		
		document.querySelectorAll(".menu-item").forEach(menuItem => {
		    const submenu = menuItem.querySelector(".submenu");
		
		    if (submenu) {
		        menuItem.addEventListener("mouseenter", () => {
		            submenu.style.display = "block";
		        });
		
		        menuItem.addEventListener("mouseleave", () => {
		            setTimeout(() => {
		                submenu.style.display = "none";
		            }, 300); // 0.3초 후 사라지게 설정
		        });
		
		        submenu.addEventListener("mouseenter", () => {
		            submenu.style.display = "block"; // 서브메뉴에 마우스를 올려도 유지됨
		        });
		
		        submenu.addEventListener("mouseleave", () => {
		            submenu.style.display = "none"; // 서브메뉴에서 벗어나면 닫힘
		        });
		    }
		});
		function confirmLogin() {
		    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
		        // '확인' 클릭 시 로그인 페이지로 이동
		        window.location.href = "/login/login.html";
		    } else {
		        // '취소' 클릭 시 홈으로 이동
		        window.location.href = "/home/index.html";
		    }
		}
</script>
</body>
</html>









