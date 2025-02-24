package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.ItemMapper;
import com.springboot.wearwave.model.Item;

@Service
public class ItemService {
    @Autowired
    private ItemMapper itemMapper;
    
    public List<Item> getAllItems() {
        return itemMapper.getAllItems();
    }
    public Item getItemMainPage(Integer itemId) {
        return this.itemMapper.getItemMainPage(itemId); // itemId를 사용하여 아이템을 조회
    }
}