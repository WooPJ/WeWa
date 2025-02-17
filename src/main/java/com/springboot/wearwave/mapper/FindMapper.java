package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.User_info;

@Mapper
public interface FindMapper {
	String findIdbyPhone(User_info user_info);
	String findIdbyEmail(User_info user_info);
	Integer findPwdbyPhone(User_info user_info);
	Integer findPwdbyEmail(User_info user_info);
	boolean updatePwd(User_info user_info);
}
