package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.MemberMapper;
import com.springboot.wearwave.model.User_info;

@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	public List<User_info> memberList(){
		return this.memberMapper.memberList();
	}
	
	public List<User_info> gradebymemberList(Integer grade){
		return this.memberMapper.gradebymemberList(grade);
	}
	
}













