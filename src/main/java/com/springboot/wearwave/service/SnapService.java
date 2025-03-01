package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SnapMapper;
import com.springboot.wearwave.model.Snapshot_board;

@Service
public class SnapService {
	@Autowired
	private SnapMapper snapMapper;
	
	public List<Snapshot_board> getFeedList() {
		return this.snapMapper.getFeedList();
	}
}
