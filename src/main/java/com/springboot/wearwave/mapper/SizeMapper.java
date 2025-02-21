package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface SizeMapper {
	List<String> sizeList(String item_code);
}
