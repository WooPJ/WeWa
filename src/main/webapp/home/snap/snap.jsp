<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스냅화면</title>
<link rel="stylesheet" type="text/css" href="../css/snap.css">

</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>
<h2>스냅 화면</h2>


<!-- 메인 페이지 -->
<div id="snap_container">
    <div class = "snap_content_box">

              <div class="user_navi">
                  <a class="navi_posting" onclick="show_Posting()">
                      <svg class="navi_img" aria-label=""  fill="currentColor" width="12" height="12" role="img" viewBox="0 0 24 24"><title></title><rect fill="none" height="18" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" width="18" x="3" y="3"></rect><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="9.015" x2="9.015" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="14.985" x2="14.985" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="9.015" y2="9.015"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="14.985" y2="14.985"></line></svg>
                      <span>&nbsp;게시물</span>  
                  </a>

                  <a class="navi_stored" onclick="show_Stored()">
                      <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><polygon fill="none" points="20 21 12 13.44 4 21 4 3 20 3 20 21" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polygon></svg>
                      <span>&nbsp;저장됨</span>
                  </a>

                  <a class="navi_profile" onclick="show_Tag()"><!-- class="tag_post" -->
                      <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><path d="M10.201 3.797 12 1.997l1.799 1.8a1.59 1.59 0 0 0 1.124.465h5.259A1.818 1.818 0 0 1 22 6.08v14.104a1.818 1.818 0 0 1-1.818 1.818H3.818A1.818 1.818 0 0 1 2 20.184V6.08a1.818 1.818 0 0 1 1.818-1.818h5.26a1.59 1.59 0 0 0 1.123-.465Z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><path d="M18.598 22.002V21.4a3.949 3.949 0 0 0-3.948-3.949H9.495A3.949 3.949 0 0 0 5.546 21.4v.603" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><circle cx="12.072" cy="11.075" fill="none" r="3.556" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></circle></svg>
                      <span>&nbsp;프로필</span>
                  </a>
              </div>

			<!-- 피드게시물----------------------- -->
               <div class = "posting_page"> 
                   <div class = "posting_line">
                       <div class = "posting_box" onclick="openModal('img/feed_img1.jpg')">
                           <img class = "posting_img" src = "https://loremflickr.com/400/600">
                       </div>
                       <div class = "posting_box">
                           <img class = "posting_img" src = "img/feed_img1.jpg">
                       </div>
                       <div class = "posting_box">
                           <img class = "posting_img" src = "img/feed_img2.jpg">
                       </div>
                       <div class = "posting_box">
                           <img class = "posting_img" src = "img/feed_img3.jpg">
                       </div>
                       <div class = "posting_box">
                           <img class = "posting_img" src = "img/feed_img3.jpg">
                       </div>
                       
                       <!-- + 버튼 -->
   					<button class="floating_btn">+</button>
                   </div>
               </div> 
               
               <!-- 저장된게시물----------------------- -->
               <div class = "stored_post_page">
                   <div id="store_top">
                       <span>저장한 내용은 회원님만 볼 수 있습니다.</span>
                       <div class="new_store">+새 컬렉션</div>
                   </div>

                   <div id = "store_main">
                       <div id="store_main_box">
                           <div id = "store_img_box">
                               <svg class="store_img" aria-label="" fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><polygon fill="none" points="20 21 12 13.44 4 21 4 3 20 3 20 21" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polygon></svg>
                           </div>
                           <span>저장</span>
                           <span>다시보고 싶은 사진과 동영상을 저장하세요. 콘텐츠를<br> 저장해도 다른 사람에게 알림이 전송되지 않으며, 저장된<br>콘텐츠는 회원님만 볼 수 있습니다.</span>
                       </div>
                   </div>
               </div>
               
 				<!-- 프로필 및 작성게시글----------------------- -->  				                
               <div class = "profile_page">
                <div class="profile">
                    <div class = "user_top">
                        <img class = "user_img" src="/imgs/icon/profile.png" width="100" height="100">
                    </div>

                    <section class="user_section">
                        <div class = user_info_box>
                            <div class ="user_name"><h2>jeonga.cho</h2></div>
                            <div><a class = "profile_modify"href="#">프로필 편집</a></div>
                            <div><a class = "setting"href="#">
                                <svg class="setting_img" aria-label="옵션" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24"><title>옵션</title><circle cx="12" cy="12" fill="none" r="8.635" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></circle><path d="M14.232 3.656a1.269 1.269 0 0 1-.796-.66L12.93 2h-1.86l-.505.996a1.269 1.269 0 0 1-.796.66m-.001 16.688a1.269 1.269 0 0 1 .796.66l.505.996h1.862l.505-.996a1.269 1.269 0 0 1 .796-.66M3.656 9.768a1.269 1.269 0 0 1-.66.796L2 11.07v1.862l.996.505a1.269 1.269 0 0 1 .66.796m16.688-.001a1.269 1.269 0 0 1 .66-.796L22 12.93v-1.86l-.996-.505a1.269 1.269 0 0 1-.66-.796M7.678 4.522a1.269 1.269 0 0 1-1.03.096l-1.06-.348L4.27 5.587l.348 1.062a1.269 1.269 0 0 1-.096 1.03m11.8 11.799a1.269 1.269 0 0 1 1.03-.096l1.06.348 1.318-1.317-.348-1.062a1.269 1.269 0 0 1 .096-1.03m-14.956.001a1.269 1.269 0 0 1 .096 1.03l-.348 1.06 1.317 1.318 1.062-.348a1.269 1.269 0 0 1 1.03.096m11.799-11.8a1.269 1.269 0 0 1-.096-1.03l.348-1.06-1.317-1.318-1.062.348a1.269 1.269 0 0 1-1.03-.096" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="2"></path></svg>
                            </a></div>
                        </div>

                        <ul class="user_follow">
                            <li>게시물 <span>15</span></li>
                            <li>팔로워 <span>123</span></li>
                            <li>팔로우 <span>456</span></li>
                        </ul>

                        <div class="user_detail">
                            <span>조정아</span>
                            <p>KR</p>
                        </div>
                    </section>
                </div>
               
               </div>
               

    
    </div> <!-- snap_content_box -->
</div>


<!-- 📌 모달 팝업-->
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

function show_Posting(){
    document.querySelector(".navi_posting").style.borderTop="solid 1px black";
    document.querySelector(".navi_stored").style.borderTop="none";
    document.querySelector(".navi_profile").style.borderTop="none";

    document.querySelector(".navi_posting").style.color="#000000";
    document.querySelector(".navi_stored").style.color="#737373";
    document.querySelector(".navi_profile").style.color="#737373";

    document.querySelector(".posting_page").style.display="flex";
    document.querySelector(".stored_post_page").style.display="none";
    document.querySelector(".profile_page").style.display="none";
}

function show_Stored(){
    document.querySelector(".navi_posting").style.borderTop="none";
    document.querySelector(".navi_stored").style.borderTop="solid 1px black";
    document.querySelector(".navi_profile").style.borderTop="none";

    document.querySelector(".navi_posting").style.color="#737373";
    document.querySelector(".navi_stored").style.color="#000000";
    document.querySelector(".navi_profile").style.color="#737373";
    
    document.querySelector(".posting_page").style.display="none";
    document.querySelector(".stored_post_page").style.display="flex";
    document.querySelector(".profile_page").style.display="none";
}

function show_Tag(){
    document.querySelector(".navi_posting").style.borderTop="none";
    document.querySelector(".navi_stored").style.borderTop="none";
    document.querySelector(".navi_profile").style.borderTop="solid 1px black";

    document.querySelector(".navi_posting").style.color="#737373";
    document.querySelector(".navi_stored").style.color="#737373";
    document.querySelector(".navi_profile").style.color="#000000";

    document.querySelector(".posting_page").style.display="none";
    document.querySelector(".stored_post_page").style.display="none";
    document.querySelector(".profile_page").style.display="flex";
}

</script>

</body>
</html>