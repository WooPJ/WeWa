<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 사항</title>
<link rel="stylesheet" type="text/css" href="../css/qnaDetailcss.css">
</head>
<body>
    <div class="container">
        <h1>상세 보기</h1>
        
        <!-- QnA 글 상세 보기 -->
        <table class="qna-table">
            <tr>
                <th>작성자</th>
                <td>${qnabbs.writer}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${qnabbs.title}</td>
            </tr>
            <tr>
                <th>상품명</th>
                <td>${itemName}</td>
            </tr>
            <tr>
                <th>이미지</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty qnabbs.imagename}"> 
                            <img src="<c:url value='${qnabbs.imagename}' />" alt="Image" width="300" />
                        </c:when>
                        <c:otherwise>
                            <p>이미지가 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${qnabbs.content}</td>
            </tr>
        </table>

        <!-- 댓글 작성 폼 -->
<h2>댓글 작성</h2>
 <form action="/qna/addComment.html?seqno=${qnabbs.seqno}" method="post">
    <input type="hidden" name="qna_seqno" value="${qnabbs.seqno}" />
    <div class="comment-form">
        <label for="commentContent">댓글 내용:</label>
        <textarea id="commentContent" name="content" rows="4" cols="50" required></textarea>
        <button type="submit">댓글 등록</button>
    </div>
</form>

<!-- 댓글 목록 -->
<h3>댓글 목록</h3>
<c:forEach var="comment" items="${comment}">
   <div class="comment">
          <div class="comment-header">
           <strong>
               <c:choose>
                   <c:when test="${comment.writer == qnabbs.writer}">
                       <span style="color: red;">${comment.writer}</span>  <!-- 글 작성자의 댓글일 경우 이름을 빨간색으로 표시 -->
                   </c:when>
                   <c:otherwise>
                       ${comment.writer}  <!-- 그 외의 댓글 작성자는 일반 색상 -->
                   </c:otherwise>
               </c:choose>
           </strong>
        </div>
        
        <div class="comment-content">
            <span id="commentContent-${comment.comment_no}">${comment.content}</span>
        </div>
        
        <div class="comment-date">
            <span class="w_date">${comment.w_date}</span>
        </div>
        <c:if test="${sessionScope.loginUser.id == comment.writer}">
        <!-- 수정 버튼 -->
        <button type="button" id="editButton-${comment.comment_no}" onclick="editComment(${comment.comment_no})">수정</button>
        <!-- 삭제 버튼 -->
        <form action="/qna/deleteComment.html" method="post" style="display:inline;" onsubmit="return deleteimage(this)">
            <input type="hidden" name="qna_seqno" value="${qnabbs.seqno}" />
            <input type="hidden" name="comment_no" value="${comment.comment_no}" />
            <button type="submit">삭제</button>
        </form>
        </c:if>
    </div>
</c:forEach>

</div>

<script type="text/javascript">
<!-- 댓글 수정 기능 -->
function editComment(comment_no) {
    var commentContent = document.getElementById('commentContent-' + comment_no);
    var content = commentContent.innerText;

    // 수정할 텍스트를 텍스트 영역에 넣음
    var textarea = document.createElement('textarea');
    textarea.value = content;
    commentContent.innerHTML = ''; // 기존 내용을 지우고 텍스트 영역을 삽입
    commentContent.appendChild(textarea);

    // 수정 버튼을 저장 버튼으로 변경
    var editButton = document.getElementById('editButton-' + comment_no);
    editButton.innerText = '저장';
    editButton.setAttribute('onclick', 'saveComment(' + comment_no + ')'); // 클릭 시 저장 호출
}

function saveComment(comment_no) {
    var commentContent = document.getElementById('commentContent-' + comment_no);
    var updatedContent = commentContent.querySelector('textarea').value;  // 수정된 댓글 내용 가져오기

    // Ajax나 폼을 이용하여 서버에 전송하는 코드 추가 필요
    var form = document.createElement('form');
    form.method = 'post';
    form.action = '/qna/updateComment.html'; // 서버에서 처리할 URL

    var inputContent = document.createElement('input');
    inputContent.type = 'hidden';
    inputContent.name = 'content';
    inputContent.value = updatedContent;
    form.appendChild(inputContent);

    var inputCommentNo = document.createElement('input');
    inputCommentNo.type = 'hidden';
    inputCommentNo.name = 'comment_no';
    inputCommentNo.value = comment_no;
    form.appendChild(inputCommentNo);

    // qna_seqno를 숨은 필드로 추가
    var inputQnaSeqno = document.createElement('input');
    inputQnaSeqno.type = 'hidden';
    inputQnaSeqno.name = 'qna_seqno';
    inputQnaSeqno.value = '${qnabbs.seqno}';  // qna_seqno 값을 서버에서 가져오도록 설정
    form.appendChild(inputQnaSeqno);

    document.body.appendChild(form);
    form.submit();
}

// 삭제 확인 함수
function deleteimage(form) {
    if (confirm("정말 삭제하시겠습니까?")) {
        alert("삭제가 완료되었습니다");
        form.submit();  // 폼 제출
    }
    return false;  // 기본 폼 제출 방지
}
</script>

</body>
</html>
