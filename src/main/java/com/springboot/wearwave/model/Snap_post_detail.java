package com.springboot.wearwave.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Snap_post_detail {
	private Integer post_id;
	private String user_id;
	private String reg_date;
	private String imagename;
	private Integer height;
	private Integer weight;
	private String gender_style;
	private String content;
	
	private String nickname;
	private String profile_img;
	
	
	private Snap_profile profile;
	private List<Post_style_tags> post_style_tags;
	private List<Post_tpo_tags> post_tpo_tags;
	private List<MultipartFile> files;
	
	private String item_code;
//	private Integer start;
//	private Integer end;
}
