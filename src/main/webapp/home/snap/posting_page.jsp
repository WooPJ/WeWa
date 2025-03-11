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
            document.getElementById("modal_img").src = data.imagename;
            document.getElementById("modal_content").innerText = data.content;
            document.getElementById("modal_profile_img").src = "/imgs/snap/" +data.profile.profile_img;
            document.getElementById("modal_nickname").innerText = data.profile.nickname;

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

            document.getElementById("modal").style.display = "flex";
            
		} catch (error) {
            console.error("Error fetching post detail:", error);
            alert("게시물을 불러오지 못했습니다.");
        }
		
/*		fetch("/snap/getPostDetail.html?" + param)
		    .then(response => {
		        if (!response.ok) {
		            throw new Error('Network response was not ok');
		        }
		        return response.json(); // JSON 형식으로 변환
		    })		
		    .then(data => {
		        document.getElementById("modal_img").src = data.imagename;
		        document.getElementById("modal_content").innerText = data.content;
		        document.getElementById("modal_profile_img").src = data.profile.profile_img;
		
		        const modalTags = document.getElementById("modal_tags");
		        modalTags.innerHTML = ""; // 태그 초기화
		        data.post_style_tags.forEach(tag => {
		            const tagElement = document.createElement("span");
		            tagElement.classList.add("tag");
		            tagElement.textContent = tag.tag_name;
		            modalTags.appendChild(tagElement);
		        });
		
		        document.getElementById("modal").style.display = "flex";
		    })
		
	        .catch(error => {
	            console.error("Error fetching post detail:", error);
	            alert("게시물을 불러오지 못했습니다.");
	        }); //컨트롤러 매핑 
*/

	        
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