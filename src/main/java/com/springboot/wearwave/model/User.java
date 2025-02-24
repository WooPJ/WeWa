package com.springboot.wearwave.model;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class User {
	@NotEmpty(message="계정 중복검사를 해야합니다.")
	private String idChecked;
	
	private String user_id;
	@NotEmpty(message="암호를 입력하세요.")
	private String user_pwd;
	private String user_pwd_confirm;
	
	@NotEmpty(message="이름을 입력하세요.")
	private String name;
	@NotEmpty(message="주소을 입력하세요.")
	private String addr;
	@NotEmpty(message="연락처를 입력하세요.")
	private String phone;
	private Integer grade;
	@NotEmpty(message="이메일을 입력하세요.")
	private String email;

	private int start;
	private int end;
	
}
