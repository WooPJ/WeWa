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
             <div class="posting_box" onclick="openPostDetail('${feed.post_id}'); return false;" post-code="${feed.post_id}">
             <c:set var="images" value="${fn:split(feed.imagename, ',')}" />
				<img class="posting_img" src="${images[0]}" alt="${feed.imagename}" />
             </div>
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

<script type="text/javascript" src="../../js/posting_page_modal.js"></script>
<script type="text/javascript">
//✅ 게시물 상세 정보를 불러오는 함수
async function openPostDetail(postId) {
    const inData = { postId: postId };
    let param = new URLSearchParams(inData).toString();
    
    try {
    	//AJAX 비동기 요청
        const response = await fetch("/snap/getPostDetail.html?" + param); 
        if (!response.ok) throw new Error('Network response was not ok');
        const DATA = await response.json(); // 서버응답을 JSON으로 변환
        
        // JSON 데이터에 에러 메시지가 있는 경우 처리
        if (DATA.error) { alert(DATA.error); return; }
        const POST = DATA.postInfo;
        
        sessionStorage.setItem("postWriter", POST.user_id);	
        // 프로필이미지 없으면 기본이미지 할당
        document.getElementById("modal_profile_img").src = 
            POST.profile_img ? POST.profile_img : "/imgs/snap/image.png";
        document.getElementById("modal_img").src = POST.imagename;
        document.getElementById("modal_content").innerText = POST.content;
        document.getElementById("modal_nickname").innerText = POST.nickname ? POST.nickname : "(알수없음)";
        document.getElementById("modal_date").innerText = POST.reg_date;
        document.getElementById("modal_userId").value = POST.user_id;
        
        let gender = POST.gender_style;
        if(gender == "male") gender = "남성코디";
        else if(gender == "female") gender = "여성코디";
        else if(gender == "genderless") gender = "젠더리스";
        document.getElementById("modal_genderStyle").innerText = gender;
        	
        let cmkg = POST.height + "cm / ";	cmkg += POST.weight + "kg";
        document.getElementById("modal_cmkg").innerText = cmkg;
        
        //북마크
        const bookmarkStatusRes = await fetch(`/snap/getBookmarkStatus?postId=\${postId}&userId=${loginUser.id}`);
        const bookmarkData = await bookmarkStatusRes.json();
        const bookmarkBtn = document.querySelector('.bookmark-btn');
        
        if (bookmarkData.isBookmarked) bookmarkBtn.classList.add('filled');
        else bookmarkBtn.classList.remove('filled');
        
        
        // 태그
        const modalTags = document.getElementById("modal_tags");
        modalTags.innerHTML = ""; // 기존 태그 초기화
        
        DATA.style_tags.forEach(tag => { //스타일 태그 추가
            const tagElement = document.createElement("a");
            const tagData = tag.style_tag;
        	let tagViewValue = "";
            switch(tagData) {
                case "casual": tagViewValue = "#캐주얼"; break;
                case "minimal": tagViewValue = "#미니멀"; break;
                case "chic": tagViewValue = "#시크"; break;
                case "retro": tagViewValue = "#레트로"; break;
                case "street": tagViewValue = "#스트릿"; break;
            }
            tagElement.classList.add("tag", "style-tag"); // 스타일 태그에 고유 클래스 추가
            tagElement.href = `/snap/postListByStyleTag.html?tagValue=\${tagData}`;
            tagElement.textContent = tagViewValue;
            modalTags.appendChild(tagElement);
        });
        DATA.tpo_tags.forEach(tag => { // TPO 태그 추가
            const tagElement = document.createElement("a");
        	const tagData = tag.tpo_tag;
            let tagViewValue = "";
            switch(tag.tpo_tag) {
                case "daily": tagViewValue = "#데일리"; break;
                case "date": tagViewValue = "#데이트"; break;
                case "campus": tagViewValue = "#캠퍼스"; break;
                case "trip": tagViewValue = "#여행"; break;
                case "camping": tagViewValue = "#캠핑"; break;
                case "cafe": tagViewValue = "#카페"; break;
                case "beach": tagViewValue = "#바다"; break;
                case "festival": tagViewValue = "#페스티벌"; break;
                case "work": tagViewValue = "#출근"; break;
                case "wedding": tagViewValue = "#결혼식"; break;
            }
            tagElement.classList.add("tag", "tpo-tag"); // TPO 태그에 고유 클래스 추가
            tagElement.href = `/snap/postListByTpoTag.html?tagValue=\${tagData}`;
            tagElement.textContent = tagViewValue;
            modalTags.appendChild(tagElement);
        });
        
        
     	//관련 상품 정보 추가
        const productContainer = document.getElementById("related_products");
		productContainer.innerHTML = ""; // 기존 상품 정보 초기화
		
		if (DATA.related_products) {  
		    const product = DATA.related_products; // 상품 객체
		
		    const productDiv = document.createElement("div");
		    productDiv.className = "modal_product_item";
		
		    // 상품 이미지
		   const productImg = document.createElement("img");
			productImg.className = "product_img";
			
			// product.imagename이 있으면 ','로 구분하여 첫 번째 이미지를, 없으면 기본 이미지로 설정
			const imageUrl = product.imagename ? product.imagename.split(",")[0] : "/imgs/no_image.png";
			
			productImg.src = imageUrl;	
			
		    const productName = document.createElement("div");
		    productName.className = "product_name";
		    productName.textContent = product.item_title || "상품명 없음";
		    console.log(product.title); 
		    // 상품 가격
		    const productPrice = document.createElement("div");
			productPrice.className = "product_price";
			
			// 가격이 존재하면 천 단위 구분자를 추가하고, 없으면 "가격 정보 없음" 표시
			if (product.price) {
			    const formattedPrice = product.price.toLocaleString(); // 천 단위 구분자 추가
			    console.log(formattedPrice);
			    productPrice.textContent = formattedPrice + "원";
			} else {
			    productPrice.textContent = "가격 정보 없음";
			}
		    // 상품 상세 페이지 링크
		    const productLink = document.createElement("a");
		    productLink.href = `/item/itemDetail.html?item_code=` + product.item_code; // 상품 상세 페이지 링크

		    console.log(productLink.href);
		    productLink.target = "_blank"; // 새 창에서 열기
		    productLink.appendChild(productImg);
		    productLink.appendChild(productName);
		    productLink.appendChild(productPrice);
		
		    productDiv.appendChild(productLink);
		    productContainer.appendChild(productDiv);
		} else {
		    productContainer.innerText = "관련 상품 정보 없음"; // 상품이 없을 경우 메시지 출력
		}
        
        // 댓글
        let isWriter = false;
        const loginUser = "${loginUser.id}";
        const commentList = document.getElementById("modal_comment_list");
        commentList.innerHTML = ""; // 기존 태그 초기화
        
        
        if(DATA.comments.length == 0) { //댓글이 없는경우
            commentList.innerHTML = ""; // 기존 태그 초기화
            const noCommentDiv = document.createElement("div");
            noCommentDiv.className = "no_comment_notice";
            noCommentDiv.textContent = "아직 댓글이 없습니다. 첫 댓글을 달아보세요!";
            commentList.appendChild(noCommentDiv); // 안내 메시지 추가
            
        } else {
	        DATA.comments.forEach(comment => { // 댓글개수만큼 반복
	            console.log("댓글번호: " + comment.comment_no);
	            // 1. 댓글 컨테이너 생성
	            const commentDiv = document.createElement("div");
	            commentDiv.className = "modal_comment";
	            
	            // 2. 프로필 이미지 생성
	            const userImg = document.createElement("img");
	            userImg.className = "comment_user_img";
	            // 프로필이미지 없으면 기본이미지 할당
	            userImg.src = comment.profile_img ? comment.profile_img : "/imgs/snap/image.png";
	            userImg.alt = "User";
	            
	            // 3. 댓글 내용 컨테이너 생성
	            const contentDiv = document.createElement("div");
	            contentDiv.className = "comment_content";
	            
	            // 4. 닉네임 생성
	            const usernameDiv = document.createElement("div");
	            usernameDiv.className = "comment_username";
	            usernameDiv.textContent = comment.nickname || comment.writer_id;
	            
	            // 5. 댓글 텍스트 생성
	            const textDiv = document.createElement("div");
	            textDiv.className = "comment_text";
	            textDiv.textContent = comment.content;
	            
	            // 6. 시간표시 | 삭제버튼 컨테이너
	            const actionDiv = document.createElement("div");
	            actionDiv.className = "comment_actions";
	            
	            // 7. 댓글 시간 생성
	            const timeDiv = document.createElement("div");
	            timeDiv.className = "comment_time";
	            timeDiv.textContent = comment.w_date;
	
	            // 8. 삭제 버튼 생성
	            console.log("로그인계정: "+loginUser);
	            console.log("댓글작성자: "+comment.writer_id);
	            
	            const deleteButton = document.createElement("button");
	            if(loginUser == comment.writer_id) { //로그인계정이 댓글작성자과 같은경우만 삭제버튼 보여주기
		            deleteButton.className = "comment_delete";
		            deleteButton.textContent = "삭제";
		            deleteButton.onclick = () => deleteCheck(comment.comment_no, comment.content);
		            actionDiv.appendChild(deleteButton); 
		            isWriter = true;
	            } else 
	            	deleteButton.style.display = "none"; //아니면 버튼태그 숨김
	            
	            // 9. 요소들을 순서대로 조립
	            actionDiv.appendChild(timeDiv);
	            if(isWriter && deleteButton) actionDiv.appendChild(deleteButton);            
	            
	            contentDiv.appendChild(usernameDiv);
	            contentDiv.appendChild(textDiv);
	            contentDiv.appendChild(actionDiv);
	            commentDiv.appendChild(userImg);
	            commentDiv.appendChild(contentDiv);
	            
	            // 10. 최종 댓글을 modal_comments에 추가
	            commentList.appendChild(commentDiv);
	        }); //forEach
        }// else
        
       	//수정, 삭제 아이콘 출력
		const postWriter = POST.user_id;
		if (loginUser == postWriter) {
		    document.getElementById("editButtons").style.display = "block";
		    document.getElementById("deleteButtons").style.display = "block";
		}else{
			document.getElementById("editButtons").style.display = "none";
			document.getElementById("deleteButtons").style.display = "none";
		}
		
        const modal = document.getElementById('modal');
        modal.setAttribute('data-post-id', postId); // 모달에 게시물 ID 저장
        document.getElementById("modal").style.display = "flex"; // 모달창 표시
        document.body.classList.add("modal-open"); // 배경스크롤 막기
    } catch (error) {
        console.error("Error fetching post detail:", error);
        alert("게시물을 불러오지 못했습니다.");
    }
}
</script>

</body>
</html>