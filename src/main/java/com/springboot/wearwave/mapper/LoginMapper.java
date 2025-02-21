package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.User;

@Mapper
public interface LoginMapper {
	LoginUser getUser(LoginUser loginUser);
	void putCustomerUser(User user);
	void putBusinessUser(User user);
}
