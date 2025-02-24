package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Heart;

@Mapper
public interface HeartMapper {
	
	List<Heart> getHeartList();
	void insertHeart(Heart heart);
	void deleteHeart(Heart heart);
	
	void updateTrue(Heart heart);
	void updateFalse(Heart heart);
}
