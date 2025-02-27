package com.springboot.wearwave.model;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Qna_comment {
	private Integer comment_no;
	private Integer qna_seqno;
	private Integer parent_id;
	private String writer;
	private String content;
	private String w_date;
}
