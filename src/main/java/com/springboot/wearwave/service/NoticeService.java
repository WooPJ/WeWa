package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.NoticeMapper;
import com.springboot.wearwave.model.Notice;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper noticeMapper;
	
	public void updateNotice(Notice notice) {
		this.noticeMapper.updateNotice(notice);
	}

	public void updateseqno(Integer seqno) {
		this.noticeMapper.updateseqno(seqno);
	}
	
	public void deleteNotice(Integer seqno) {
		this.noticeMapper.deleteNotice(seqno);
	}
	
	public Notice getNotice(Integer seqno) {
		return this.noticeMapper.getNotice(seqno);
	}
	
	public List<Notice> getNoticeList(){
		return this.noticeMapper.getNoticeList();
	}
	
	public Integer getMaxNum() {
		return this.noticeMapper.getMaxNum();
	}
	
	public void putNotice(Notice notice) {
		this.noticeMapper.putNotice(notice);
	}
}
