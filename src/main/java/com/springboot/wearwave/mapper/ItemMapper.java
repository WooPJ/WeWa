package com.springboot.wearwave.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.springboot.wearwave.model.Item;

@Mapper
public interface ItemMapper {
    Item getItemCodePage(String item_code);
}