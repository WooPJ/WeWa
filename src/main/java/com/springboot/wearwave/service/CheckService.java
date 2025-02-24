package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.CheckMapper;

@Service
public class CheckService {
	@Autowired
	private CheckMapper checkMapper;
	public Integer checkDupId(String user_id) {
		return this.checkMapper.checkDupId(user_id);
	}
}
