package com.springboot.wearwave.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Snapshot_board {
	private int seqno;
	private String writer;
	private String content;
	private String w_date;
	private int like_count;
	private String imagename;
	private String pwd;
}
