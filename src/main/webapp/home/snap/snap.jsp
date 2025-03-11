<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스냅화면</title>
<link rel="stylesheet" type="text/css" href="../css/snap/snap.css">

</head>
<body>
<br/><br/><br/><br/><br/><br/><br/>
<h2>스냅 화면</h2>


<!-- 메인 페이지 -->
<div id="snap_container">

		<div class="snap_navi">
             <a class="navi_posting" href="/snap/postingContent.html" onclick="show_Posting()">
                 <svg class="navi_img" aria-label=""  fill="currentColor" width="12" height="12" role="img" viewBox="0 0 24 24"><title></title><rect fill="none" height="18" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" width="18" x="3" y="3"></rect><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="9.015" x2="9.015" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="14.985" x2="14.985" y1="3" y2="21"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="9.015" y2="9.015"></line><line fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="21" x2="3" y1="14.985" y2="14.985"></line></svg>
                 <span>&nbsp;게시물</span>  
             </a>

              <a class="navi_stored" href="/snap/storedContent.html" onclick="show_Stored()">
                  <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><polygon fill="none" points="20 21 12 13.44 4 21 4 3 20 3 20 21" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polygon></svg>
                  <span>&nbsp;저장됨</span>
              </a>

              <a class="navi_profile" href="/snap/profileContent.html" onclick="show_Profile()">
                  <svg class="navi_img" aria-label=""  fill="currentColor" height="12" role="img" viewBox="0 0 24 24" width="12"><title></title><path d="M10.201 3.797 12 1.997l1.799 1.8a1.59 1.59 0 0 0 1.124.465h5.259A1.818 1.818 0 0 1 22 6.08v14.104a1.818 1.818 0 0 1-1.818 1.818H3.818A1.818 1.818 0 0 1 2 20.184V6.08a1.818 1.818 0 0 1 1.818-1.818h5.26a1.59 1.59 0 0 0 1.123-.465Z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><path d="M18.598 22.002V21.4a3.949 3.949 0 0 0-3.948-3.949H9.495A3.949 3.949 0 0 0 5.546 21.4v.603" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path><circle cx="12.072" cy="11.075" fill="none" r="3.556" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></circle></svg>
                  <span>&nbsp;프로필</span>
              </a>
		</div>
		
		<!-- 동적으로 페이지 포함 -->
        <div class="snap_content_box">
            <jsp:include page="${not empty CONTENT ? CONTENT : 'posting_page.jsp'}" />
        </div>
		
</div>



<script type="text/javascript">
//현재 선택된 메뉴를 저장하는 함수
function setActiveTab(tabName) {
    localStorage.setItem("activeTab", tabName);
}

// 스타일 적용하는 함수
function applyActiveTab() {
    let activeTab = localStorage.getItem("activeTab") || "posting"; // 기본값: posting

    document.querySelector(".navi_posting").style.borderTop = activeTab === "posting" ? "solid 1px black" : "none";
    document.querySelector(".navi_stored").style.borderTop = activeTab === "stored" ? "solid 1px black" : "none";
    document.querySelector(".navi_profile").style.borderTop = activeTab === "profile" ? "solid 1px black" : "none";

    document.querySelector(".navi_posting").style.color = activeTab === "posting" ? "#000000" : "#737373";
    document.querySelector(".navi_stored").style.color = activeTab === "stored" ? "#000000" : "#737373";
    document.querySelector(".navi_profile").style.color = activeTab === "profile" ? "#000000" : "#737373";
}

// 클릭 이벤트 추가
function show_Posting(){
    setActiveTab("posting");
}
function show_Stored(){
    setActiveTab("stored");
}
function show_Profile(){
    setActiveTab("profile");
}

// 페이지 로드 시 실행
document.addEventListener("DOMContentLoaded", applyActiveTab);

</script>

</body>
</html>