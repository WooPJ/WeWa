package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.LoginMapper;
import com.springboot.wearwave.model.LoginUser;

@Service
public class LoginService {
	@Autowired
	private LoginMapper loginMapper;
	
	public LoginUser getUser(LoginUser loginUser) {
		return this.loginMapper.getUser(loginUser);
	}
}
















