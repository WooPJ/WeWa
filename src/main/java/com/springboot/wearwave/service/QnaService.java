package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.QnaMapper;
import com.springboot.wearwave.model.Qna_bbs;
import com.springboot.wearwave.model.Qna_comment;

@Service
public class QnaService {
   @Autowired
   private QnaMapper qnaMapper;
   
	public List<Qna_bbs> getQnaList(){
		return this.qnaMapper.getQnaList();
	}
	public List<Qna_bbs> getUserQnaList(String id){
		return this.qnaMapper.getUserQnaList(id);
	}
	public List<Qna_bbs> getSellerQnaList(String id){
		return this.qnaMapper.getSellerQnaList(id);
	}
	public void putQna(Qna_bbs qna) {
		this.qnaMapper.putQna(qna);
	}
	public Integer getMaxNum(){
		Integer max = this.qnaMapper.getMaxNum();
		if(max == null) return 0;
		else return max;
	}
	public void updateQna(Qna_bbs qna) {
		this.qnaMapper.updateQna(qna);
	}
	public void deleteQna(Integer seqno) {
		this.qnaMapper.deleteQna(seqno);
	}
	public void updateseqno(Integer seqno) {
		this.qnaMapper.updateseqno(seqno);
	}
	public Qna_bbs getQnaDetail(Integer seqno) {
		return this.qnaMapper.getQnaDetail(seqno);
	}
	public String getItemTitleByCode(String item_code) {
		if (item_code == null || item_code.isEmpty()) {
	        return "상품 정보가 없습니다."; // 또는 빈 문자열 반환
	    }
	    return qnaMapper.getItemTitleByCode(item_code);
	}
	public List<Qna_comment> getCommentsByQnaSeqno(Integer seqno) {
		  List<Qna_comment> comments = this.qnaMapper.getCommentsByQnaSeqno(seqno);
		    return comments;
	}
	public void addComment(Qna_comment comment) {
		this.qnaMapper.addComment(comment);
	}
	public void deleteComment(Integer no) {
		this.qnaMapper.deleteComment(no);
	}
	public Integer getMaxSeq() {
		Integer max = this.qnaMapper.getMaxSeq();
		if(max == null) return 0;
		else return max;
	}
	public Qna_comment getComment(Integer no) {
		return this.qnaMapper.getComment(no);
	}
	public void updateComment(Qna_comment comment) {
		this.qnaMapper.updateComment(comment);
	}
	
}
