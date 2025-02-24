<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" type="text/css" href="../css/notice.css">
</head>
<body>
    <div class="notice-container">
     <div class="notice-header">
		   <div class="notice-main">공지사항</div>
		
		   <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
		       <button class="write-btn" onclick="location.href='/notice/write.html'">글쓰기</button>
		   </c:if>
		</div>
          <c:forEach var="notice" items="${notices}">
            <div class="notice-item">
                <div class="notice-title">${notice.seqno}. ${notice.title}</div>
                 <div class="notice-date">${notice.w_date}</div>
                <div class="notice-content">${notice.content}</div>
                  <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                    <div class="notice-admin-buttons">
                        <button onclick="location.href='/notice/update.html?seqno=${notice.seqno}'">수정</button>
                        <button onclick="deletenotice(${notice.seqno})">삭제</button>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <script type="text/javascript">
		    document.querySelectorAll('.notice-title').forEach(function(item) {
		        item.addEventListener('click', function() {
		            var parent = item.parentElement;
		            parent.classList.toggle('active');
		        });
		    });
		    function deletenotice(seqno) { 
		        if (confirm("정말 삭제하시겠습니까?")) {
		            alert("삭제가 완료되었습니다"); 
		            window.location.href = "/notice/delete.html?seqno=" + seqno; 
		        }
		    }
    </script>
</body>
</html>
