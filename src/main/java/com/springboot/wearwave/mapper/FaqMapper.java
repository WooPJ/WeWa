package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Faq_bbs;

@Mapper
public interface FaqMapper {
	List<Faq_bbs> getFaqList();
	void putFaq(Faq_bbs faq);
	Integer getMaxNum();
	void updatefaq(Faq_bbs faq);
	void deletefaq(Integer seqno);
	void updateseqno(Integer seqno);
	Faq_bbs getfaq(Integer seqno);
}
