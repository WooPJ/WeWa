<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/snap/snap_content.css">
<style type="text/css">


</style>
</head>
<body>

<!-- 피드게시물----------------------- -->
<div class = "posting_page"> 
	<div class = "posting_line">
         <c:forEach var="feed" items="${FeedList}">
<%--            	<a href="/snap/getPostDetail.html?postId=${feed.post_id}"> --%>
                <div class="posting_box" post-code="${feed.post_id}">
	                <c:set var="images" value="${fn:split(feed.imagename, ',')}" />
	  				<img class="posting_img" src="${images[0]}" alt="${feed.imagename}" />
                </div>
<!--            	</a> -->
         </c:forEach>
                   
        <!-- 게시물작성 버튼 -->            
		<c:choose>
			<c:when test="${loginUser != null }">
				<form action="/snap/addPostWrite.html" method="get">
					<button class="floating_btn">+</button>
				</form>
			</c:when>
			<c:otherwise>
				<button class="floating_btn" onclick="confirmLogin()">+</button>
			</c:otherwise>
		</c:choose>
	</div>
</div> 

<!-- 📌 모달 팝업-->
<jsp:include page="snap_modal.jsp"/>


<script type="text/javascript">

//✅ 모달 닫기 함수
window.closeModal = function() {
    document.getElementById("modal").style.display = "none"; // 모달창 숨김
    document.body.classList.remove("modal-open"); // 배경스크롤 허용
}
//✅ 모달 바깥 클릭 시 닫기
document.getElementById("modal").addEventListener("click", function(event) {
    if (event.target === this) {
        closeModal();
    }
});

//✅ 모달 열기
const postingBoxs = document.querySelectorAll('.posting_box');
postingBoxs.forEach(post => {
	const postCode = post.getAttribute("post-code");
	
	post.addEventListener('click', async function (event) {
		event.preventDefault();

		const inData = { postId : postCode };
		let param = new URLSearchParams(inData).toString();
		console.log("매개변수값확인: "+param)
		
		
		try {
			const response = await fetch("/snap/getPostDetail.html?" + param);
			if (!response.ok) throw new Error('Network response was not ok');

            const data = await response.json();
            
            // JSON 데이터에 에러 메시지가 있는 경우 처리
            if (data.error) {
                alert(data.error);
                return;
            }
            document.getElementById("modal_img").src = data.postInfo.imagename;
//             document.getElementById("modal_img").innerText = data.imagename; 경로값확인
            document.getElementById("modal_content").innerText = data.postInfo.content;
            document.getElementById("modal_profile_img").src = "/imgs/snap/"+ data.postInfo.profile_img;
            document.getElementById("modal_nickname").innerText = data.postInfo.nickname;

            
            const modalTags = document.getElementById("modal_tags");
            modalTags.innerHTML = ""; // 기존 태그 초기화
            //스타일 태그 추가
            data.style_tags.forEach(tag => {
                const tagElement = document.createElement("span");
                tagElement.classList.add("tag", "style-tag"); // 스타일 태그에 고유 클래스 추가
                let tagValue = "";
                switch(tag.style_tag) {
	                case "casual": tagValue = "#캐주얼"; break;
	                case "minimal": tagValue = "#미니멀"; break;
	                case "chic": tagValue = "#시크"; break;
	                case "retro": tagValue = "#레트로"; break;
	                case "street": tagValue = "#스트릿"; break;
                }
                tagElement.textContent = tagValue;
                modalTags.appendChild(tagElement);
            });
         	// TPO 태그 추가
            data.tpo_tags.forEach(tag => {
                const tagElement = document.createElement("span");
                tagElement.classList.add("tag", "tpo-tag"); // TPO 태그에 고유 클래스 추가
                let tagValue = "";
                switch(tag.tpo_tag) {
	                case "daily": tagValue = "#데일리"; break;
	                case "date": tagValue = "#데이트"; break;
	                case "campus": tagValue = "#캠퍼스"; break;
	                case "trip": tagValue = "#여행"; break;
	                case "camping": tagValue = "#캠핑"; break;
	                case "cafe": tagValue = "#카페"; break;
	                case "beach": tagValue = "#바다"; break;
	                case "festival": tagValue = "#페스티벌"; break;
	                case "work": tagValue = "#출근"; break;
	                case "wedding": tagValue = "#결혼식"; break;
                }
                tagElement.textContent = tagValue;
                modalTags.appendChild(tagElement);
            });
         	
         	
         	// 댓글
         	const commentList = document.getElementById("modal_comment_list");
         	commentList.innerHTML = ""; // 기존 태그 초기화
         	
         	data.comments.forEach(comment => { //댓글개수만큼 반복
         		console.log("댓글개수: "+comment.comment_no)
         		  // 1. 댓글 컨테이너 생성
         		  const commentDiv = document.createElement("div");
         		  commentDiv.className = "modal_comment";
         		  
         		  // 2. 프로필 이미지 생성
         		  const userImg = document.createElement("img");
         		  userImg.className = "comment_user_img";
         		  userImg.src = comment.profile_img ? "/imgs/snap/"+ data.postInfo.user_id +"/"+ comment.profile_img : "/imgs/snap/image.png";
         		  userImg.alt = "User";
         		  
         		  // 3. 댓글 내용 컨테이너 생성
         		  const contentDiv = document.createElement("div");
         		  contentDiv.className = "comment_content";
         		  
         		  // 4. 사용자 이름 생성
         		  const usernameDiv = document.createElement("div");
         		  usernameDiv.className = "comment_username";
         		  usernameDiv.textContent = comment.nickname || comment.writer_id;
         		  
         		  // 5. 댓글 텍스트 생성
         		  const textDiv = document.createElement("div");
         		  textDiv.className = "comment_text";
         		  textDiv.textContent = comment.content;
         		  
         		  // 6. 댓글 시간 생성
         		  const timeDiv = document.createElement("div");
         		  timeDiv.className = "comment_time";
         		  timeDiv.textContent = comment.w_date;
         		  
         		  // 7. 요소들을 순서대로 조립
         		  contentDiv.appendChild(usernameDiv);
         		  contentDiv.appendChild(textDiv);
         		  contentDiv.appendChild(timeDiv);
         		  
         		  commentDiv.appendChild(userImg);
         		  commentDiv.appendChild(contentDiv);
         		  
         		  // 8. 최종 댓글을 modal_comments에 추가
         		  commentList.appendChild(commentDiv);
         	});
         	
			
            document.getElementById("modal").style.display = "flex"; // 모달창 표시
            document.body.classList.add("modal-open"); // 배경스크롤 막기
            
		} catch (error) {
            console.error("Error fetching post detail:", error);
            alert("게시물을 불러오지 못했습니다.");
        }
		
	}); //EventListener
}); //forEach

function confirmLogin() {
	event.preventDefault(); // 기본 동작(폼 제출) 방지
    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
        // '확인' 클릭 시 로그인 페이지로 이동
        window.location.href = "/login/login.html";
    } else {
    	return false; //아무동작도 안함
    }
}
</script>
</body>
</html>