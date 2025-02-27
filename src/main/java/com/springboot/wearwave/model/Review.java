package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Review {
	private Integer seqno;
	private String writer;
	private String title;
	private String item_code;
	private String content;
	private String w_date;
	private String order_no;
	private String parent_id;
	private String group_id;
	private String imagename;
	private String pwd;
	private Integer item_rate;
}
