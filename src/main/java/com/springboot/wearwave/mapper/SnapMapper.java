package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.Snapshot_board;

@Mapper
public interface SnapMapper {
	
	Integer getMaxPostId();
	
	Snap_profile getNicknameByUserId(String userId);
	void putNickname(Snap_profile nickname);
	
	void putTpoTag(Post_tpo_tags tpoTag);
	void putStyleTag(Post_style_tags styleTag);
	void putFeedPost(Snap_post_detail snap_post_detail);
	List<Snapshot_board> getFeedList();
}
