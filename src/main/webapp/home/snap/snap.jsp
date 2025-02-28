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
                   <a class="posting" onclick="show_Posting()">
                       <svg class="navi_img" aria-label=""  fill="currentColor" width="12" height="12" role="img" viewBox="0 0 24 24"><title></title><rect fill="none" height="18" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" width="18" x="3" y="3"></rect><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="9.015" x2="9.015" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="14.985" x2="14.985" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="9.015" y2="9.015"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="14.985" y2="14.985"></line></svg>
                       <span>&nbsp;게시물</span>  
                   </a>

                   <a class="stored_post" onclick="show_Stored()">
                       <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><polygon fill="none" points="20 21 12 13.44 4 21 4 3 20 3 20 21" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polygon></svg>
                       <span>&nbsp;저장됨</span>
                   </a>

                   <a class="profile" onclick="show_Tag()"><!-- class="tag_post" -->
                       <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><path d="M10.201 3.797 12 1.997l1.799 1.8a1.59 1.59 0 0 0 1.124.465h5.259A1.818 1.818 0 0 1 22 6.08v14.104a1.818 1.818 0 0 1-1.818 1.818H3.818A1.818 1.818 0 0 1 2 20.184V6.08a1.818 1.818 0 0 1 1.818-1.818h5.26a1.59 1.59 0 0 0 1.123-.465Z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><path d="M18.598 22.002V21.4a3.949 3.949 0 0 0-3.948-3.949H9.495A3.949 3.949 0 0 0 5.546 21.4v.603" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><circle cx="12.072" cy="11.075" fill="none" r="3.556" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></circle></svg>
                       <span>&nbsp;프로필</span>
                   </a>
               </div>

<!-- 피드게시물 -->
                <div class = "posting_page"> 
                    <div class = "posting_line">
                        <div class = "posting_box">
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
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                        <div class = "posting_box">
                            <img class = "posting_img" src = "img/feed_img3.jpg">
                        </div>
                    </div>
                </div>
	
	    
	    </div>
	</div>

</body>
</html>