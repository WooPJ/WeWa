package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Order {
	private Integer order_no;
	private String user_id;
	private String item_code;
	private Integer quantity;
	private String item_color;
	private String item_size;
	private String order_date;
	private Integer order_status;
}
