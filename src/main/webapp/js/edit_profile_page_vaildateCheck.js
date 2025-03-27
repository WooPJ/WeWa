function nicknameCheck() {
	const userNickname = document.getElementById("nickname");
    if (userNickname.value.trim() === '') {
        alert("닉네임을 입력하세요.");
        userNickname.focus();
        return false;
    } else {
        if (userNickname.value.length < 1 || userNickname.value.length > 20) {
            alert("닉네임은 1자 이상, 20자 이하로 입력하세요.");
            userNickname.focus();
            return false;
        }
    }
   	const url = "/snap/nicknameCheck.html?nickname=" + userNickname.value;
    window.open(url, "_blank_", "width=500,height=300");
}

function frmCheck() {
	if(document.postFrm.nicknameChecked.value == ""){
		alert("닉네임 중복검사를 해야합니다.");
		return false;
	}
    const isValid = validateForm(); // 성별 체크 검증
    if (!isValid) return false; // 성별 미선택 시 제출 방지
    
	const userIntro = document.getElementById("intro");
	if(userIntro.value.length < 1 || userIntro.value.length > 100) {
            alert("자기소개 내용은 1자 이상, 100자 이하로 입력하세요.");
            userIntro.focus();
            return false;
	}
	return confirmForm(); // 성별 선택 완료 후, 저장 확인창
}

function confirmForm() {
    return confirm("프로필을 저장하시겠습니까?"); 
}

function validateForm() {
    const maleChecked = document.getElementById("gender_male").checked;
    const femaleChecked = document.getElementById("gender_female").checked;
    const genderLessChecked = document.getElementById("gender_less").checked;

    if (!maleChecked && !femaleChecked && !genderLessChecked) {
        alert("성별을 선택해주세요.");
        return false; // 폼 제출 방지
    } 
    return true; // 정상 제출
}