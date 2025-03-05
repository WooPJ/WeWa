package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.LoginMapper;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.User;

@Service
public class LoginService {
	@Autowired
	private LoginMapper loginMapper;
	
	public LoginUser getUser(LoginUser loginUser) {
		return this.loginMapper.getUser(loginUser);
	}
	
	public void putCustomerUser(User user) {
	    // 전화번호를 합친 후 저장
	    user.setPhoneFromParts();  // phone1, phone2, phone3를 합치는 작업을 진행합니다.
	    // 이메일과 도메인을 합쳐서 저장
	    user.setEmailFromParts();  // email과 domain을 합치는 작업을 진행합니다.
		this.loginMapper.putCustomerUser(user);
	}
	
	public void putBusinessUser(User user) {
	    // 전화번호를 합친 후 저장
	    user.setPhoneFromParts();  // phone1, phone2, phone3를 합치는 작업을 진행합니다.
	    // 이메일과 도메인을 합쳐서 저장
	    user.setEmailFromParts();  // email과 domain을 합치는 작업을 진행합니다.
		this.loginMapper.putBusinessUser(user);
	}
}
















