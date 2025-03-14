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

<div id="modal" class="modal" data-post-id="">
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
	        <h3>관련 상품</h3>
			<div id="related_products" class="related-products">
			 <!-- 서버에서 가져온 상품들이 여기에 표시될 예정 -->
    		</div>
        </div>
        
		<div class="modal_comment_section">
			<c:choose>
				<c:when test="${loginUser != null }">
		            <input type="text" id="comment_input" placeholder="댓글을 입력하세요...">
		            <button id="comment_button" onclick="submitCheck()">게시</button>
				</c:when>
				<c:otherwise>
		            <input type="text" id="comment_input" placeholder="로그인 후 이용가능합니다..." readonly="readonly">
		            <button id="comment_button" onclick="confirmLogin()">로그인 하러가기</button>
				</c:otherwise>
			</c:choose>
        </div>
		    
		<div id="modal_comment_list" class="modal_comment_list">
			<!-- 서버에서 받아온 댓글데이터를 동적으로 추가 -->
		</div>

    </div><!-- modal_content -->
</div>

<script type="text/javascript">

// 엔터키 처리
const inputEvent = document.getElementById("comment_input");
inputEvent.addEventListener("keyup", e => {
	if(e.key == 'Enter') submitCheck(); 
});

function submitCheck() {
	if(confirm("댓글을 작성하시겠습니까?")) submitComment();
}

function submitComment() {
    const commentContent = document.getElementById("comment_input").value;
    const postId = document.getElementById("modal").getAttribute("data-post-id");/* 게시물 ID를 가져오는 로직 */

    if (!commentContent.trim()) {
        alert("댓글 내용을 입력해주세요.");
        return;
    }

    fetch('/snap/addComment', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            'postId': postId,
            'commentContent': commentContent
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.error) {
            alert(data.error);
        } else {
			alert("댓글 작성을 완료했습니다.");
            document.getElementById("comment_input").value = ''; // 댓글 입력창 초기화
            openPostDetail(postId); // 모달창 다시 열기
        }
    })
    .catch(error => console.error('Error:', error));
}
</script>
</body>
</html>