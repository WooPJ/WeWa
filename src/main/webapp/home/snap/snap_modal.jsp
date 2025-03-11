<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스냅피드 모달창</title>
<link rel="stylesheet" type="text/css" href="../css/snap/snap_modal.css">
</head>
<body>

<div id="modal" class="modal">
    <div class="modal_content">
        <span class="close" onclick="closeModal()">&times;</span><!-- 창닫기 -->
    
		<div class="modal_feed">
            <div class="modal_user_info">
                <img id="modal_profile_img" src="/imgs/snap/" class="modal_profile_img">
                <span id="modal_nickname" class="modal_nickname"></span>
            </div>
	    	<div class="modal_img_container">
	    		<div class="slideshow-container">
	            	<img id="modal_img" src="" alt="image">
	            </div>
	        </div>
            <p id="modal_content" class="modal_text">
            	<!-- 서버에서 받아온 피드 내용을 여기에 표시 -->
            </p>
			<div id="modal_tags" class="modal_tags">
	            <!-- 태그가 동적으로 추가될 공간 -->
	        </div>
        </div>
        
		<div class="modal_comment_section">
			<c:choose>
				<c:when test="${loginUser != null }">
		            <input type="text" id="comment_input" placeholder="댓글을 입력하세요..." onclick="checkLogin(event)">
		            <button id="comment_button" onclick="submitComment()">게시</button>
				</c:when>
				<c:otherwise>
		            <input type="text" id="comment_input" placeholder="로그인 후 이용가능합니다..." readonly="readonly">
		            <button id="comment_button" onclick="confirmLogin()">로그인 하러가기</button>
				</c:otherwise>
			</c:choose>
        </div>
		    
		<div class="modal_comment_list">
		<!-- 실제 데이터는 서버에서 받아와 동적으로 추가 -->
		    <div class="modal_comment">
		        <img src="img/user1.jpg" alt="User" class="comment_user_img">
		        <div class="comment_content">
		            <div class="comment_username">username123</div>
		            <div class="comment_text">이 피드 너무 좋아요! 😊aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
		            <div class="comment_time">5분 전</div>
		        </div>
		    </div>
		    <div class="modal_comment">
		        <img src="img/user2.jpg" alt="User" class="comment_user_img">
		        <div class="comment_content">
		            <div class="comment_username">hello_world</div>
		            <div class="comment_text">정말 멋진 사진이네요! 📷</div>
		            <div class="comment_time">10분 전</div>
		        </div>
		    </div>
		</div>

    </div><!-- modal_content -->
</div>


<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
	
// 	function confirmLogin() {
// 	    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
// 	        // '확인' 클릭 시 로그인 페이지로 이동
// 	        window.location.href = "/login/login.html";
// 	    } else {
// 	    	return false; //아무동작도 안함
// 	    }
// 	}
	
	//✅ 모달 열기 함수 => 레거시
// 	window.openModal = function(imageSrc) { // ✅ 전역 함수
// 		let modal = document.getElementById("modal");
// 		console.log(modal);
// 		if(modal) {
// 		    document.getElementById("modal_img").src = imageSrc;
// 		    modal.style.display = "flex";
// 		}
// 		document.body.classList.add("modal-open"); // 배경 스크롤 막기
// 	}
	//✅ 모달 열기
// 	window.openModal = function(postId) {
// 	    $.ajax({
// 	        type: "GET",
// 	        url: "/snap/getPostDetail.html",  // 🔹 매핑 URL
// 	        data: { postId: postId }, // 🔹 전달할 데이터
// 	        success: function(response) {
// 	            $('#modal_img').attr('src', response.imagename); // 이미지 표시
// 	            $('#modal_content').text(response.content);       // 포스팅 내용 표시
// 	            $('#modal_profile_img').attr('src', response.profile.profile_img); // 프로필 이미지 표시
// 	            $('#modal_tags').empty(); // 태그 초기화
	
// 	            // 🔹 스타일 태그 추가
// 	            response.post_style_tags.forEach(tag => {
// 	                $('#modal_tags').append(`<span class="tag">${tag.tag_name}</span>`);
// 	            });
	
// 	            $('#modal').show(); // 모달창 열기
// 	        },
// 	        error: function() {
// 	            alert('게시물 정보를 불러오지 못했습니다.');
// 	        }
// 	    });
// 	}

	
	
	//✅ 모달 닫기 함수
	window.closeModal = function() {
	    document.getElementById("modal").style.display = "none";
	}
    // ✅ 모달 바깥 클릭 시 닫기
    document.getElementById("modal").addEventListener("click", function(event) {
        if (event.target === this) {
            closeModal();
        }
    });
	
});
</script>


</body>
</html>