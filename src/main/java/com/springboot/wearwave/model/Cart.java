package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Cart {
	private String user_id;
	private String item_code;
	private Integer quantity;
	private String item_color;
	private String item_size;
}
