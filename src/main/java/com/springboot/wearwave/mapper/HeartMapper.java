package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Heart;

@Mapper
public interface HeartMapper {
	
	int isHearted(Heart heart);
	
	List<Heart> getUserHeartList(String user_id);
	List<Heart> getHeartListByUser(String user_id);
	
	void insertHeart(Heart heart);
	void updateFalse(Heart heart);
	void deleteHeart(Heart heart);
}
