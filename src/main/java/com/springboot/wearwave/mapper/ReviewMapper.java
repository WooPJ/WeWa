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
	//리뷰목록 별점 높은순 정렬
	List<Review> sortStarPointDesc(String item_code);
	//별점 낮은 순
	List<Review> sortStarPointAsc(String item_code);
	//최신 리뷰 순
	List<Review> sortByDateDesc(String item_code);
	//오래된 리뷰 순
	List<Review> sortByDateAsc(String item_code);
}
