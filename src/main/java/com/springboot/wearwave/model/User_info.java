package com.springboot.wearwave.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class User_info {//계정 찾기용 User정보
	@Id
	private String user_id;
	@NotEmpty(message="암호를 입력하세요.")
	private String user_pwd;
	@NotEmpty(message="이름을 입력하세요.")
	private String name;
	@NotEmpty(message="주소를 입력하세요.")
	private String addr;
//	@NotEmpty(message="전화번호를 입력하세요.")
	private String phone;
	private String phone1;
	@NotEmpty(message="전화번호를 입력하세요.")
	private String phone2;
	@NotEmpty(message="전화번호를 입력하세요.")
	private String phone3;
	private Integer grade;
	@NotEmpty(message="이메일을 입력하세요.")
	private String email;
    @NotEmpty(message="도메인을 선택하세요.")
    private String emailDomain;
    private String customEmailDomain;
	
    public void setPhoneFromParts() {
        // phone1, phone2, phone3을 합쳐서 phone에 저장
        this.phone = phone1 + phone2 + phone3;  // 예: 01012345678
    }
    // 이메일 도메인과 customEmailDomain을 사용하여 이메일을 설정하는 메서드
    public void setEmailFromParts() {
        if ("etc".equals(emailDomain)) {
            // 이메일 도메인이 'etc'일 경우 customEmailDomain을 사용
            this.email = email + "@" + customEmailDomain;
        } else {
            // 이메일 도메인이 'etc'가 아닐 경우 기본 emailDomain을 사용
            this.email = email + "@" + emailDomain;
        }
    }
}








