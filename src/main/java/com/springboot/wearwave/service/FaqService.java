package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.FaqMapper;
import com.springboot.wearwave.model.Faq_bbs;

@Service
public class FaqService {
	@Autowired
	private FaqMapper faqMapper;
	
	public List<Faq_bbs> getFaqList(){
		return this.faqMapper.getFaqList();
	}
	
	public void putFaq(Faq_bbs faq) {
		this.faqMapper.putFaq(faq);
	}
	
	public Integer getMaxNum() {
		Integer max = faqMapper.getMaxNum();
		if(max == null) return 0;
		return max;
	}
	
	public void updatefaq(Faq_bbs faq) {
		this.faqMapper.updatefaq(faq);
	}
	
	public void deletefaq(Integer seqno) {
		this.faqMapper.deletefaq(seqno);
	}
	
	public void updateseqno(Integer seqno) {
		this.faqMapper.updateseqno(seqno);
	}
	
	public Faq_bbs getfaq(Integer seqno) {
		return this.faqMapper.getfaq(seqno);
	}
}
