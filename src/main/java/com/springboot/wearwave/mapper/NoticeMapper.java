package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Notice;

@Mapper
public interface NoticeMapper {
	void updateNotice(Notice notice);
	void updateseqno(Integer seqno);
	void deleteNotice(Integer seqno);
	Notice getNotice(Integer seqno);
	List<Notice> getNoticeList();
	Integer getMaxNum();
	void putNotice(Notice notice);
}























