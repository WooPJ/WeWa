package com.springboot.wearwave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ItemReviewController {
	@GetMapping(value = "/item/review.html") //상품 리뷰 목록 이동
	public ModelAndView goReview() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "/item/itemReview.jsp");
		return mav;
	}
}
