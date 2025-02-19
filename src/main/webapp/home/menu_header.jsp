<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더메뉴</title>
<link rel="stylesheet" type="text/css" href="../css/menu.css">
</head>
<body>
<header>
    <div class="header-container">
      	
        <a href="/home/index.html" class="logo">
            <img alt="로고" src="../imgs/icon/logo.png" width="200" height="50">
        </a>   
        <form action="" method="post" class="search-container">
            <input type="text" name="item" placeholder="검색어를 입력해주세요.">
            <button type="submit" id="search"></button>
        </form>
         <div class="icon-container">
          <a href="/snap/snap.html" class="snap">
	            <img alt="스냅" src="../imgs/icon/snap.png" >
	        </a>  
	         <a href="/mypage/notice.html" class="mypage">
	            <img alt="마이페이지" src="../imgs/icon/mypage.png" >
	        </a>   
	         <a href="/like/likelist.html" class="like">
	            <img alt="찜 목록" src="../imgs/icon/like.png" >
	        </a>   
	         <a href="/cart/cart.html" class="cart">
	            <img alt="장바구니 목록" src="../imgs/icon/cart.png">
	        </a>   
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
              <a class="word" href="">니트</a>
              <a class="word" href="">맨투맨</a>
              <a class="word" href="">후드</a>
              <a class="word" href="">셔츠</a>
              <a class="word" href="">긴소매</a>
              <a class="word" href="">반소매</a>
        </div> 
    </div>
     <div class="menu-item">
        <a class="word">하의</a>
         <div class="submenu">
              <a class="word" href="/menu/bottom.html">전체</a>
              <a class="word" href="">데님</a>
              <a class="word" href="">트레이닝</a>
              <a class="word" href="">조거</a>
              <a class="word" href="">슬랙스</a>
              <a class="word" href="">숏 팬츠</a>
        </div>
    </div>
     <div class="menu-item">
        <a class="word">아우터</a>
        <div class="submenu">
              <a class="word" href="/menu/outer.html">전체</a>
              <a class="word" href="">패딩</a>
              <a class="word" href="">후드 집업</a>
              <a class="word" href="">카디건</a>
              <a class="word" href="">무스탕</a>
              <a class="word" href="">코트</a>
              <a class="word" href="">트레이닝</a>
        </div>
    </div>
     <div class="menu-item">
         <a class="word">신발</a>
        <div class="submenu">
              <a class="word" href="/menu/shoes.html">전체</a>
              <a class="word" href="">스니커즈</a>
              <a class="word" href="">부츠</a>
              <a class="word" href="">구두</a>
              <a class="word" href="">샌들</a>
              <a class="word" href="">스포츠</a>
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
</script>
</body>
</html>









