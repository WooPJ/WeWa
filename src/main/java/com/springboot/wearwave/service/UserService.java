package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.UserMapper;
import com.springboot.wearwave.model.User_info;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	
	public User_info getUserInfo(String id) {
		return this.userMapper.getUserInfo(id);
	}
	
	public void updateUserInfo(User_info user_info) {
		this.userMapper.updateUserInfo(user_info);
	}
}












