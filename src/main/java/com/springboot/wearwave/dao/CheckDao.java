package com.springboot.wearwave.dao;

public interface CheckDao {
	Integer checkDupId(String user_id);//계정 중복검사용 메서드
}
