package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SnapMapper;
import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_bookmark;
import com.springboot.wearwave.model.Snap_comment;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;

@Service
public class SnapService {
	@Autowired
	private SnapMapper snapMapper;
	
	
	//북마크관련=====================
	public List<Snap_post_detail> getMyBookmarkAll(String userId) {
		return this.snapMapper.getMyBookmarkAll(userId);
	}
	public Integer getIsBookmarked(Snap_bookmark bookmark) {
		return this.snapMapper.getIsBookmarked(bookmark);
	}
	public Integer getMaxBookmarkNo() {
		Integer max = this.snapMapper.getMaxBookmarkNo();
		if(max == null) max = 0;
		return max;
	}
	public void putBookmark(Snap_bookmark bookmark) {
		Integer max = this.getMaxBookmarkNo();
		bookmark.setBookmark_id(max + 1); //북마크PK 증가
		this.snapMapper.putBookmark(bookmark);
	}
	public void deleteBookmark(Snap_bookmark bookmark) {
		this.snapMapper.deleteBookmark(bookmark);
	}
	
	//프로필관련=====================
	public Integer lengthNickname(String nickname) {
		return this.snapMapper.lengthNickname(nickname);
	}
	public Integer duplicateNickname(String nickname) {
		return this.snapMapper.duplicateNickname(nickname);
	}
	public void updateProfile(Snap_profile profile) {
		this.snapMapper.updateProfile(profile);
	}
	public Integer getCountPostByUserId(String userId) {
		return this.snapMapper.getCountPostByUserId(userId);
	}
	
	
	public Snap_profile getProfileByUserId(String userId) {
		return this.snapMapper.getProfileByUserId(userId);
	}
	
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
	public void deletePost(Integer post_id) {
		this.snapMapper.deletePost(post_id);
	}
	
	public List<String> getTpoById(Integer postId) {
		return this.snapMapper.getTpoById(postId);
	}
	public List<String> getStyleById(Integer postId) {
		return this.snapMapper.getStyleById(postId);
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
	
	public List<Snap_post_detail> getMyFeedAll(String id) {
		return this.snapMapper.getMyFeedAll(id);
	}
	public void updateFeedPost(Snap_post_detail snap_post_detail) {
		this.snapMapper.updateFeedPost(snap_post_detail);
	}
	
	public void deleteTpo(Integer postId) {
		this.snapMapper.deleteTpo(postId);
	}
	
	public void deleteStyle(Integer postId) {
		this.snapMapper.deleteStyle(postId);
	}
}
