package com.springboot.wearwave.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Items_tbl {
	private String item_code;
	private String item_title;
	private Integer item_id; //상품 카테고리 아이디 ex) 1: 상의, 2: 하의, 3: 아우터, 4: 신발
	private Integer price;
	private String reg_date;
	private String imagename;
	private String content;
	private String user_id;
	private Integer num; //등록 순서 저장
	private List<Item_size> item_sizes; 
    private List<Item_color> item_colors;  
	private MultipartFile file;
	private String codeChecked;
}
