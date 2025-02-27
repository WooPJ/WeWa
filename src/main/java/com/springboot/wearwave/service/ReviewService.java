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
}
