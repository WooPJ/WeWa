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
	
	
	public List<Heart> getUserHeartList(String user_id) {
		return this.heartMapper.getUserHeartList(user_id);
	}
	
	public int isHearted(Heart heart) {
		return this.heartMapper.isHearted(heart);
	}

	public List<Heart> getHeartListByUser(String user_id) {
		return this.heartMapper.getHeartListByUser(user_id);
	}
	
	public Item getItemById(String item_code) {
        return itemMapper.getItemCodePage(item_code);
    }
	
	public void insertHeart(Heart heart) {
		this.heartMapper.insertHeart(heart);
	}
	public void updateFalse(Heart heart) {
		this.heartMapper.updateFalse(heart);
	}
	public void deleteHeart(Heart heart) {
		this.heartMapper.deleteHeart(heart);
	}
}
