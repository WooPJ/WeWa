package com.springboot.wearwave.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class User_info {
	@Id
	private String user_id;
	@NotEmpty(message="암호를 입력하세요.")
	private String user_pwd;
	@NotEmpty(message="이름을 입력하세요.")
	private String name;
	@NotEmpty(message="주소를 입력하세요.")
	private String addr;
	@NotEmpty(message="전화번호를 입력하세요.")
	private String phone;
	private Integer grade;
	@NotEmpty(message="이메일을 입력하세요.")
	private String email;
}








