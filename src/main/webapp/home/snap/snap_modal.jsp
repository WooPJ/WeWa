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
	        <div class="bookmark-container">
	        	<button class="bookmark-btn" onclick="bookmarkCheck('${loginUser.id}')" title="북마크 저장하기">
	             	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
	             	<path d="M0 48V487.7C0 501.1 10.9 512 24.3 512c5 0 9.9-1.5 14-4.4L192 400 345.7 507.6c4.1 2.9 9 4.4 14 4.4c13.4 0 24.3-10.9 24.3-24.3V48c0-26.5-21.5-48-48-48H48C21.5 0 0 21.5 0 48z"/>
	             	</svg>
	        	</button>
            </div>
            <p id="modal_content" class="modal_text">
            	<!-- 서버에서 받아온 피드 내용을 여기에 표시 -->
            </p>
			<div id="modal_tags" class="modal_tags">
	            <!-- 태그가 동적으로 추가될 공간 -->
	        </div>
	        <h3>관련 상품</h3>
			<div id="related_products" class="related-products">
				
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

async function bookmarkCheck(isLogin) {
	if(!isLogin) { //로그인 안된경우 `null`, `undefined`, `""` 모두 포함
		confirmLogin();
		return; //종료
	}
	
    const postId = document.getElementById('modal').getAttribute('data-post-id');
    const bookmarkBtn = event.currentTarget;
    const isBookmarked = bookmarkBtn.classList.contains('filled');
    const action = isBookmarked ? "remove" : "add";
	
    try {
    	console.log("북마크 클릭한 포스트ID: ", postId);
        const response = await fetch(`/snap/toggleBookmark?postId=\${postId}&userId=${loginUser.id}&action=\${action}`, {
            method: 'POST'
        });

        if (!response.ok) throw new Error('북마크 처리 실패');
        const data = await response.json();

        if (data.status === "added") {
            bookmarkBtn.classList.add('filled');
            console.log("북마크 추가됨");
        } else if (data.status === "removed") {
            bookmarkBtn.classList.remove('filled');
            console.log("북마크 제거됨");
        }

    } catch (error) {
        console.error("북마크 처리 중 오류 발생:", error);
        alert("북마크 처리 중 문제가 발생했습니다.");
    }
	
/*	레거시
	else {
		// 현재 열려있는 모달에서 게시물 ID 가져오기
		const postId = document.getElementById('modal').getAttribute('data-post-id');
	    const bookmarkBtn = event.currentTarget; // 현재 버튼 요소 가져오기
	    bookmarkBtn.classList.toggle('filled'); // filled 클래스 토글
	    
	    // 북마크 상태 확인 => .filled 있으면 true, 없으면 false
	    const isBookmarked = bookmarkBtn.classList.contains('filled');
		
	    if(isBookmarked) {
	      // 북마크 추가 로직
// 	      addBookmark(isLogin);
	      console.log("북마크 추가됨");
	    } else {
	      // 북마크 삭제 로직
// 	      removeBookmark(isLogin);
	      console.log("북마크 제거됨");
	    }
	}*/
	
	
	
}

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