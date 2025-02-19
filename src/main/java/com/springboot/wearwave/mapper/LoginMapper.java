package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.LoginUser;

@Mapper
public interface LoginMapper {
	LoginUser getUser(LoginUser loginUser);
}
