package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CheckMapper {
	Integer checkDupId(String user_id);
}
