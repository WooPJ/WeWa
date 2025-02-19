package com.springboot.wearwave.model;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Notice {
	private Integer seqno;
	@NotEmpty(message="제목을 작성하세요.")
	private String writer;
	private String title;
	@NotEmpty(message="내용을 작성하세요.")
	private String content;
	private String w_date;
	

}
