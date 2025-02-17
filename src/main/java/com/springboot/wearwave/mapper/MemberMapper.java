package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.User_info;

@Mapper
public interface MemberMapper {
	List<User_info> memberList();
	List<User_info> gradebymemberList(Integer grade);
}
