<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
</head>
<body>
    <div class="mypage-container">
	    <!-- 왼쪽 메뉴 -->
	   	<nav class="menu">
	    <ul>
	        <c:choose>
	            <c:when test="${sessionScope.loginUser == null}">
	                <li><a href="javascript:void(0);" onclick="redirectToLogin('profile')">내 정보</a></li>
	                <li><a href="javascript:void(0);" onclick="redirectToLogin('orders')">주문 내역</a></li>
	                <li><a href="javascript:void(0);" onclick="redirectToLogin('returns')">취소/반품 내역</a></li>
	            </c:when>
	            <c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 1}">
	                <li><a href="/mypage/profile.html" onclick="showContent('profile')">내 정보</a></li>
	                <li><a href="/mypage/orders.html" onclick="showContent('orders')">주문 내역</a></li>
	                <li><a href="/mypage/returns.html" onclick="showContent('returns')">취소/반품 내역</a></li>
	            </c:when>
		        <c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">	
		            <li><a href="/slider/sliderimg.html" onclick="showContent('sliderimage')">슬라이더 이미지 관리</a></li>
		            <li><a href="/items/itemlist.html" onclick="showContent('itemlist')">등록된 상품 관리</a></li>
		            <li><a href="/member/memberlist.html" onclick="showContent('memberlist')">회원 목록</a></li>
		        </c:when>
	
		        <c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 2}">
		            <li><a href="/items/additems.html" onclick="showContent('additems')">상품 등록</a></li>
		            <li><a href="/items/myitemlist.html" onclick="showContent('myItemlist')">등록한 상품 관리</a></li>
		            <li><a href="" onclick="">취소/반품 신청 목록</a></li>
		        </c:when>
		    </c:choose>
	        <li><a href="/mypage/support.html" onclick="showContent('support')">고객센터</a></li>
	        <li><a href="/mypage/product-inquiry.html" onclick="showContent('product-inquiry')">상품 문의 내역</a></li>
	        <li><a href="/mypage/notice.html" class="active-menu" onclick="showContent('notice	')">공지사항</a></li>
	    </ul>
		</nav>
	
	    <!-- 오른쪽 내용 영역 -->
	    <div class="content">
	        <!-- 콘텐츠가 동적으로 로드됩니다 -->
	        <jsp:include page="${CONTENT}" />
	    </div>
    </div>

    <script type="text/javascript">
 // 콘텐츠를 변경하는 함수
    function showContent(contentId) {
        // 모든 메뉴 링크에서 active-menu 클래스 제거
        var menuItems = document.querySelectorAll('nav.menu li a');
        menuItems.forEach(function(item) {
            item.classList.remove('active-menu');
        });

        // 클릭된 메뉴에 active-menu 클래스 추가
        var activeMenu = document.querySelector('a[href="/mypage/' + contentId + '"]');
        activeMenu.classList.add('active-menu');

        // AJAX 방식으로 동적으로 콘텐츠를 업데이트
        fetch("/mypage/" + contentId)
            .then(response => response.text())
            .then(data => {
                document.querySelector('.content').innerHTML = data; // 콘텐츠를 업데이트
            })
            .catch(error => console.error('Error fetching content:', error));
    }

    // 페이지 로드 시 '공지사항' 콘텐츠 활성화
    window.onload = function() {
        showContent('notice');  
    };
    function redirectToLogin(page) {
        alert("로그인 후 마이페이지를 이용할 수 있습니다.");
        window.location.href = "/login/login.html"; // 로그인 페이지로 이동
    }
    </script>
</body>
</html>
