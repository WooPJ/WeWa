package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.ColorMapper;

@Service
public class ColorService {
	@Autowired
	private ColorMapper colorMapper;
	
	public List<String> colorList(String item_code){
		return this.colorMapper.colorList(item_code);
	}
}
