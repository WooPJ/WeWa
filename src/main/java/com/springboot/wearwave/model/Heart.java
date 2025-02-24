package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Heart {
	private String user_id; //찜한 계정
	private String item_code; //찜한 상품코드
	private int status; //하트누른 상태값저장

	public Heart() {
		this.item = new Item(); // Item 인스턴스 생성
	}
	private Item item; // 변수를 선언함으로써 Item 객체를 포함시킴
	private String i_item_code;
	private String item_title;
	private Integer price;
	private String imagename;
	private String content;
}
