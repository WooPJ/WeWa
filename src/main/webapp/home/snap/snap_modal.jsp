<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
        <span class="close" onclick="closeModal()">&times;</span>
		<div class="modal_feed">
            <div class="modal_user_info">
                <img src="img/profile_img2.jpg" class="modal_profile_img">
                <span class="modal_username">jeonga.cho</span>
            </div>
	    	<div class="modal_img_container">
	            <img id="modal_img" src="" alt="image">
	        </div>
            <p class="modal_text">
            	이곳에 피드 내용을 표시합니다.
            	Lorem ipsum dolor sit amet consectetur adipisicing elit. Laboriosam, ut facere id ullam ea adipisci et ipsam est quidem commodi ducimus nostrum cum optio non dolor! Quam ipsum nam rem!
            </p>
        </div>
		<div class="modal_comment_section">
            <input type="text" id="comment_input" placeholder="댓글을 입력하세요...">
            <button id="comment_button" onclick="submitComment()">게시</button>
        </div>
		    
		<div class="modal_comment_list">
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
	//✅ 모달 열기 함수
	window.openModal = function(imageSrc) { // ✅ 전역 함수
		let modal = document.getElementById("modal");
		console.log(modal);
		if(modal) {
		    document.getElementById("modal_img").src = imageSrc;
		    modal.style.display = "flex";
		}
		document.body.classList.add("modal-open"); // 배경 스크롤 막기
	}
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