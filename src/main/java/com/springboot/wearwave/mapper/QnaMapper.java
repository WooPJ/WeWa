package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Qna_bbs;
import com.springboot.wearwave.model.Qna_comment;

@Mapper
public interface QnaMapper {
	List<Qna_bbs> getQnaList();
	List<Qna_bbs> getUserQnaList(String id);
	List<Qna_bbs> getSellerQnaList(String id);
	void putQna(Qna_bbs qna);
	Integer getMaxNum();
	void updateQna(Qna_bbs qna);
	void deleteQna(Integer seqno);
	void updateseqno(Integer seqno);
	Qna_bbs getQnaDetail(Integer seqno);
	String getItemTitleByCode(String item_code);
	List<Qna_comment> getCommentsByQnaSeqno(Integer seqno);
	void addComment(Qna_comment comment);
	void deleteComment(Integer no);
	Integer getMaxSeq();
	Qna_comment getComment(Integer no);
	void updateComment(Qna_comment comment);
	}























