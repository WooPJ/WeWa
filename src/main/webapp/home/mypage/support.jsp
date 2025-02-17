<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객센터</title>
    <link rel="stylesheet" type="text/css" href="../css/support.css">
</head>
<body>
    <div class="faq-container">
     <div class="faq-header">
		   <div class="faq-title">자주 묻는 질문(FAQ)</div>
		
		   <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
		       <button class="write-btn" onclick="location.href='/faq/write.html'">글쓰기</button>
		   </c:if>
		</div>
          <c:forEach var="faq" items="${faqs}">
            <div class="faq-item">
                <div class="faq-question">Q${faq.seqno}. ${faq.title}</div>
                <div class="faq-answer">A${faq.seqno}. ${faq.content}</div>
                  <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                    <div class="faq-admin-buttons">
                        <button onclick="location.href='/faq/update.html?seqno=${faq.seqno}'">수정</button>
                        <button onclick="deletefaq(${faq.seqno})">삭제</button>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <script type="text/javascript">
        document.querySelectorAll('.faq-question').forEach(function(item) {
            item.addEventListener('click', function() {
                var parent = item.parentElement;
                parent.classList.toggle('active');
            });
        });
        function deletefaq(seqno) { 
	        if (confirm("정말 삭제하시겠습니까?")) {
	            alert("삭제가 완료되었습니다"); 
	            window.location.href = "/faq/delete.html?seqno=" + seqno; 
	        }
	    }
    </script>
</body>
</html>
