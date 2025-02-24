package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.User_info;

@Mapper
public interface UserMapper {
	User_info getUserInfo(String id);
	void updateUserInfo(User_info user_info);
}
