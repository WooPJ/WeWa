package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.wearwave.model.Item;

@Mapper
public interface ItemMapper {
	List<Item> getAllItems();
	Item getItemById(String item_code);
    Item getItemMainPage(@Param("item_id") Integer itemId); // item_id를 파라미터로 추가
}