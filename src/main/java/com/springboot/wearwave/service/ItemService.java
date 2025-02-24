package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.wearwave.mapper.ItemMapper;
import com.springboot.wearwave.model.Item;

@Service
public class ItemService {
    @Autowired
    private ItemMapper itemMapper;

    public Item getItemCodePage(String item_code) {
    	return this.itemMapper.getItemCodePage(item_code);
    }
}