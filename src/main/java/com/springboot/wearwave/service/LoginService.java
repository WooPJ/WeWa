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
		this.loginMapper.putCustomerUser(user);
	}
	
	public void putBusinessUser(User user) {
		this.loginMapper.putBusinessUser(user);
	}
}
















