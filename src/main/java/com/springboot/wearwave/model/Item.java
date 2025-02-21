package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Item {
	private String item_code;
	private String item_title;
	private Integer item_id;
	private Integer price;
	private String reg_date;
	private String size;
	private String color;
	private String imagename;
	private String content;
}