package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.HeartMapper;
import com.springboot.wearwave.mapper.ItemMapper;
import com.springboot.wearwave.model.Heart;
import com.springboot.wearwave.model.Item;

@Service
public class HeartService {
	@Autowired
	private HeartMapper heartMapper;
	@Autowired
	private ItemMapper itemMapper;
	

	
	public Item getItemById(String item_code) {
        return itemMapper.getItemCodePage(item_code);
    }
	public List<Heart> getHeartList() {
		return this.heartMapper.getHeartList();
	}
	public void insertHeart(Heart heart) {
		this.heartMapper.insertHeart(heart);
	}
	public void deleteHeart(Heart heart) {
		this.heartMapper.deleteHeart(heart);
	}
	public void updateTrue(Heart heart) {
		this.heartMapper.updateTrue(heart);
	}
	public void updateFalse(Heart heart) {
		this.heartMapper.updateFalse(heart);
	}
}
