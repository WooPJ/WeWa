package com.springboot.wearwave.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Qna_bbs {
	private Integer seqno;
	private String writer;
	private String title;
	private String item_code;
	private String content;
	private String w_date;
	private String imagename;
	private MultipartFile image;
}
