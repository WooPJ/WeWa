package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.ItemsMapper;
import com.springboot.wearwave.model.Item_color;
import com.springboot.wearwave.model.Item_size;
import com.springboot.wearwave.model.Items_tbl;

import jakarta.transaction.Transactional;

@Service
public class ItemsService {
	@Autowired
	private ItemsMapper itemsMapper;
	
	public void updateItem(Items_tbl item) {
		this.itemsMapper.updateItem(item);
	}
	
	public void deleteItem(String code) {
		this.itemsMapper.deleteItem(code);
	}
	
	public Integer getMaxNum() {
		Integer max = itemsMapper.getMaxNum();
		if(max == null) return 0;
		return max;
	}
	
	public Items_tbl getMyItem(String item_code) {
		return this.itemsMapper.getMyItem(item_code);
	}
	
	public List<Item_size> getMyItem_size(String item_code) {
		return this.itemsMapper.getMyItem_size(item_code);
	}
	
	public List<Item_color> getMyItem_color(String item_code) {
		return this.itemsMapper.getMyItem_color(item_code);
	}
	
	public void updateNum(Integer num) {
		 if (num != null) {
		        this.itemsMapper.updateNum(num);
		    }
	}
	
	public List<Items_tbl> getItemList(){
		return this.itemsMapper.getItemList();
	}
	
	public List<Items_tbl> getMyItemList(String user_id){
		return this.itemsMapper.getMyItemList(user_id);
	}
	
	@Transactional
    public void putItems(Items_tbl item) {
        // 1. 상품 등록
        this.itemsMapper.putItems(item);

        // 2. 사이즈 리스트 등록
        if (item.getItem_sizes() != null) {
            for (Item_size size : item.getItem_sizes()) {
                size.setItem_code(item.getItem_code()); // item_code 설정
                this.itemsMapper.putSize(size);
            }
        }

        // 3. 색상 리스트 등록
        if (item.getItem_colors() != null) {
            for (Item_color color : item.getItem_colors()) {
                color.setItem_code(item.getItem_code()); // item_code 설정
                this.itemsMapper.putColor(color);
            }
        }
    }
	
	public void putSize(Item_size size) {
		this.itemsMapper.putSize(size);
	}
	
	public void putColor(Item_color color) {
		this.itemsMapper.putColor(color);
	}
	
	public Integer checkDupCode(String item_code) {
		return this.itemsMapper.checkDupCode(item_code);
	}
	
	public void deleteItem_size(String code) {
		this.itemsMapper.deleteItem_size(code);
	}
	
	public void deleteItem_color(String code) {
		this.itemsMapper.deleteItem_color(code);
	}
	
	public List<Items_tbl> userIdbyItemList(String user_id){
		return this.itemsMapper.userIdbyItemList(user_id);
	}
}
