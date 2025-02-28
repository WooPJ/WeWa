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
	
	private String item_title;
	private Integer price;
	private Integer status;	//0 : 장바구니담기만함 주문미완료 1 : 주문완료
	private Integer serial_num;
}
