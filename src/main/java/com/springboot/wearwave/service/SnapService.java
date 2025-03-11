package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SnapMapper;
import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.Snapshot_board;

@Service
public class SnapService {
	@Autowired
	private SnapMapper snapMapper;
	
	
	public Integer getMaxPostId() {
		return this.snapMapper.getMaxPostId();
	}
	
	public Snap_profile getNicknameByUserId(String userId) {
		return this.snapMapper.getNicknameByUserId(userId);
	}
	public void putNickname(Snap_profile nickname) {
		this.snapMapper.putNickname(nickname);
	}
	
	public void putTpoTag(Post_tpo_tags tpoTag) {
		this.snapMapper.putTpoTag(tpoTag);
	}
	public void putStyleTag(Post_style_tags styleTag) {
		this.snapMapper.putStyleTag(styleTag);
	}
	public void putFeedPost(Snap_post_detail snap_post_detail) {
		this.snapMapper.putFeedPost(snap_post_detail);
	}
	
	
	public Snap_profile getNicknameByPost(Integer postId) {
		return this.snapMapper.getNicknameByPost(postId);
	}
	public List<Post_style_tags> getAllStyleById(Integer postId) {
		return this.snapMapper.getAllStyleById(postId);
	}
	public List<Post_tpo_tags> getAllTpoById(Integer postId) {
		return this.snapMapper.getAllTpoById(postId);
	}
	
	public Snap_post_detail getPostDetailById(Integer postId) {
		return this.snapMapper.getPostDetailById(postId);
	}
	public List<Snap_post_detail> getFeedAll() {
		return this.snapMapper.getFeedAll();
	}
	public List<Snapshot_board> getFeedList() {
		return this.snapMapper.getFeedList();
	}
}
