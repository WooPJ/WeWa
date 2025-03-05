package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.FindMapper;
import com.springboot.wearwave.model.User_info;

@Service
public class FindService {
	@Autowired
	private FindMapper findMapper;
	
	public String findIdbyPhone(User_info user_info) {//ID찾기(비밀번호)
		user_info.setPhoneFromParts();
		return this.findMapper.findIdbyPhone(user_info);
	}

	public String findIdbyEmail(User_info user_info) {
		user_info.setEmailFromParts();
		return this.findMapper.findIdbyEmail(user_info);
	}
	
	public Integer findPwdbyPhone(User_info user_info) {
		user_info.setPhoneFromParts();
		return this.findMapper.findPwdbyPhone(user_info);
	}
	
	public Integer findPwdbyEmail(User_info user_info) {
		user_info.setEmailFromParts();
		return this.findMapper.findPwdbyEmail(user_info);
	}
	
	public boolean updatePwd(User_info user_info) {
	    findMapper.updatePwd(user_info);
	    return true; 
	}
	
}













