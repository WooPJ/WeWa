package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Snap_comment {
	private Integer comment_no;
	private Integer post_id;
	private String writer_id;
	private String content;
	private String w_date;
	
	private String nickname;
	private String profile_img;
//	private Snap_profile profile;
}
