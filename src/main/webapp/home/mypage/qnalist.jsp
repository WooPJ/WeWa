<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 내역</title>
<link rel="stylesheet" type="text/css" href="../css/qnalist.css">
</head>
<body>
    <div class="qna-container">
     <div class="qna-header">
		   <div class="qna-title">문의 사항(Q&A)</div>
		   <c:if test="${sessionScope.loginUser != null}">
		       <button class="write-btn" onclick="location.href='/qna/qnaWrite.html'">글쓰기</button>
		   </c:if>
	</div>   
	<div class="qna-table">
		<table>
			<tr><th>글번호</th><th>제 목</th><th>작성자</th><th>작성일</th></tr>
			
			 <c:forEach var="qna" items="${qnas}">
				<tr>
				    <td class="qna-seqno">${qna.seqno}</td>
				    <td class="qna-title"><a href="/qna/readqna.html?seqno=${qna.seqno}">${qna.title}</a></td>
				    <td class="qna-writer">${qna.writer}</td>
				    <td class="qna-date">${qna.w_date}
				     <div class="qna-user-buttons">
				    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id == qna.writer}">	
				        <button onclick="location.href='/qna/update.html?seqno=${qna.seqno}'">수정</button>
				    </c:if>   
				    <c:if test="${sessionScope.loginUser.grade == 0 || sessionScope.loginUser.id == qna.writer}">	    
				            <button onclick="deleteqna(${qna.seqno})">삭제</button>
				    </c:if>
				   	</div>
				
				    </td>
				</tr>
			</c:forEach>
		</table>
		</div>
    </div>
    <script type="text/javascript">
        document.querySelectorAll('.qna-question').forEach(function(item) {
            item.addEventListener('click', function() {
                var parent = item.parentElement;
                parent.classList.toggle('active');
            });
        });
        function deleteqna(seqno) { 
	        if (confirm("정말 삭제하시겠습니까?")) {
	            alert("삭제가 완료되었습니다"); 
	            window.location.href = "/qna/delete.html?seqno=" + seqno; 
	        }
	    }
    </script>
</body>
</html>
