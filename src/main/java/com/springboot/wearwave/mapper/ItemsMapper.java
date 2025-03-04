package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Item_color;
import com.springboot.wearwave.model.Item_size;
import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.StartEnd;

@Mapper
public interface ItemsMapper {
	void updateItem(Items_tbl item);
	void deleteItem(String code);
	Integer getMaxNum();
	Items_tbl getMyItem(String item_code);
	List<Item_size> getMyItem_size(String item_code);
	List<Item_color> getMyItem_color(String item_code);
	void updateNum(Integer num);
	List<Items_tbl> getItemList();
	List<Items_tbl> getMyItemList(String user_id);
	void putItems(Items_tbl item);
	void putSize(Item_size size);
	void putColor(Item_color color);
	Integer checkDupCode(String item_code);
	void deleteItem_size(String code);
	void deleteItem_color(String code);
	List<Items_tbl> userIdbyItemList(String user_id);
	List<Items_tbl> getItemMenu(StartEnd se);
	List<Items_tbl> getCategory(Items_tbl item);
	List<Items_tbl> getItemByName(String name);
	List<Items_tbl> getItemListPage(Items_tbl item);
	List<Items_tbl> searchItemByName(Items_tbl item);
}
