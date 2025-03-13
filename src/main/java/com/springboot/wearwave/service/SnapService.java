package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SnapMapper;
import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_comment;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.Snapshot_board;

@Service
public class SnapService {
	@Autowired
	private SnapMapper snapMapper;
	
	
	//댓글관련========================
	public Snap_comment getCommentByNo(Integer commNum) {
		return this.snapMapper.getCommentByNo(commNum);
	}
	public void deleteComment(Integer commNum) {
		this.snapMapper.deleteComment(commNum);
	}
	public void putComment(Snap_comment comment) {
		Integer max = getMaxCommentNo(); 
		comment.setComment_no(max + 1); //댓글PK 증가
		this.snapMapper.putComment(comment);
	}
	public Integer getMaxCommentNo() {
		Integer max = this.snapMapper.getMaxCommentNo();
		if(max == null) max = 0;
		return max;
	}
	
	public List<Snap_comment> getCommentList(Integer postId) {
		return this.snapMapper.getCommentList(postId);
	}
	
	
	
	//게시물관련=======================
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
	public Integer getMaxPostId() {
		Integer max = this.snapMapper.getMaxPostId();
		if(max == null) max = 0;
		return max;
	}
	
	
	public List<Post_tpo_tags> getAllTpoById(Integer postId) {
		return this.snapMapper.getAllTpoById(postId);
	}
	public List<Post_style_tags> getAllStyleById(Integer postId) {
		return this.snapMapper.getAllStyleById(postId);
	}
	public Snap_post_detail getPostDetailByPostId(Integer postId) {
		return this.snapMapper.getPostDetailByPostId(postId);
	}
	public List<Snap_post_detail> getFeedAll() {
		return this.snapMapper.getFeedAll();
	}
	
	
	
	public List<Snapshot_board> getFeedList() {
		return this.snapMapper.getFeedList();
	}
}
