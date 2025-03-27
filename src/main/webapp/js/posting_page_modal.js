
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


function deleteCheck(commentNo, txt) {
	if(confirm("해당 댓글을 정말로 삭제하시겠습니까? \n\" "+txt+" \"")) {
		deleteDo(commentNo);
	} else return false;
}
function deleteDo(commentNo) {
	//AJAX 비동기 처리
    fetch('/snap/deleteComment', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
          'commentNo': commentNo
        })
      })
      .then(response => response.json())
      .then(data => {
        if(data.error) {
          alert(data.error);
        } else {
        	console.log("▶댓글삭제요청 서버응답: "+ data.success);
        	alert("댓글이 삭제되었습니다.");
        	const postId = document.getElementById("modal").getAttribute("data-post-id");
        	openPostDetail(postId); // 모달창 다시 열기
        }
      })
      .catch(error => console.error('Error:', error));
}

function confirmLogin() {
	event.preventDefault(); // 기본 동작(폼 제출) 방지
    if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
        // '확인' 클릭 시 로그인 페이지로 이동
        window.location.href = "/login/login.html";
    } else {
    	return false; //아무동작도 안함
    }
}

