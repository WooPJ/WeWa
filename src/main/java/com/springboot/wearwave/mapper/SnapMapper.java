package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Snapshot_board;

@Mapper
public interface SnapMapper {
	List<Snapshot_board> getFeedList();
}
