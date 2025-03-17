package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Snap_profile {
	private String user_id;
	private String nickname;
	private String intro;
	private String profile_img;
	private Integer height;
	private Integer weight;
	private String gender;
	
	private Integer countPostNum;
}
