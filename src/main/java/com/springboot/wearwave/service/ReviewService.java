package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.ReviewMapper;
import com.springboot.wearwave.model.Review;

@Service
public class ReviewService {
	@Autowired
	private ReviewMapper reviewMapper;
	
	public void insertReview(Review review) {
		this.reviewMapper.insertReview(review);
	}
	public List<Review> getReviewList(String item_code){
		return this.reviewMapper.getReviewList(item_code);
	}
	public void deleteReview(Integer seqno) {
		this.reviewMapper.deleteReview(seqno);
	}
	public List<Review> sortStarPointDesc(String item_code){
		return this.reviewMapper.sortStarPointDesc(item_code);
	}
	List<Review> sortStarPointAsc(String item_code){
		return this.reviewMapper.sortStarPointAsc(item_code);
	}
	List<Review> sortByDateDesc(String item_code){
		return this.reviewMapper.sortByDateDesc(item_code);
	}
	List<Review> sortByDateAsc(String item_code){
		return this.reviewMapper.sortByDateAsc(item_code);
	}
	
	public List<Review> getSortedReviews(String itemCode, String sortOption) {
	    List<Review> reviews;
	    
	    // 정렬 옵션에 따른 분기 처리
	    if ("starpoint-desc".equals(sortOption)) {
	        reviews = reviewMapper.sortStarPointDesc(itemCode); // 별점 높은 순
	    } else if ("starpoint-asc".equals(sortOption)) {
	        reviews = reviewMapper.sortStarPointAsc(itemCode); // 별점 낮은 순
	    } else if ("date-desc".equals(sortOption)) {
	        reviews = reviewMapper.sortByDateDesc(itemCode); // 최신 순
	    } else if ("date-asc".equals(sortOption)) {
	        reviews = reviewMapper.sortByDateAsc(itemCode); // 오래된 순
	    } else {
	        reviews = reviewMapper.getReviewList(itemCode); // 기본 정렬
	    }

	    return reviews;
	}
}
