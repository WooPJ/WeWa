package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_comment;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.Snapshot_board;

@Mapper
public interface SnapMapper {
	//댓글관련
	void putComment(Snap_comment comment);
	Integer getMaxCommentNo();
	List<Snap_comment> getCommentList(Integer postId);
	
	
	//게시물관련
	Snap_profile getNicknameByUserId(String userId);
	void putNickname(Snap_profile nickname);
	
	void putTpoTag(Post_tpo_tags tpoTag);
	void putStyleTag(Post_style_tags styleTag);
	void putFeedPost(Snap_post_detail snap_post_detail);
	Integer getMaxPostId();
	
	Snap_post_detail getPostDetailByPostId(Integer postId);
	List<Post_style_tags> getAllStyleById(Integer postId);
	List<Post_tpo_tags> getAllTpoById(Integer postId);
	List<Snap_post_detail> getFeedAll();
	
	
	
	List<Snapshot_board> getFeedList();
}
