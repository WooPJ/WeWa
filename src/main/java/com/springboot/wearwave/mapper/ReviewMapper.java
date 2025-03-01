package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Review;

@Mapper
public interface ReviewMapper {
	void insertReview(Review review);
	List<Review> getReviewList(String item_code);
	//리뷰 삭제 메서드
	void deleteReview(Integer seqno);
}
