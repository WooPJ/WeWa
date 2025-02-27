package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Item;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Review;
import com.springboot.wearwave.service.ColorService;
import com.springboot.wearwave.service.ItemService;
import com.springboot.wearwave.service.ReviewService;
import com.springboot.wearwave.service.SizeService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ItemReviewController {
	@Autowired
	private ItemService itemService;
    @Autowired
    private SizeService sizeService;
    @Autowired
    private ColorService colorService;
	@Autowired
	private ReviewService reviewService;
    @PostMapping(value = "/review/submit")
    public ModelAndView submitReview(HttpSession session, String writer, String review_title, String item_code, String content
    		,String w_date, Integer item_rate, Review review) {
        ModelAndView mav = new ModelAndView("index");
        LoginUser user = (LoginUser) session.getAttribute("loginUser");
        String userId = user.getId();
        review.setWriter(userId);
        review.setTitle(review_title);
        review.setItem_code(item_code);
        review.setW_date(w_date);
        review.setItem_rate(item_rate);
        this.reviewService.insertReview(review);
        mav.addObject("BODY", "item/itemReviewResult.jsp");
        return mav;
    }
    
    
	@GetMapping(value = "/item/review.html") //상품 리뷰 목록 이동
	public ModelAndView goReview(@RequestParam("item_code") String item_code) {
		Item item = itemService.getItemCodePage(item_code); 
        List<String> sizeList = sizeService.sizeList(item_code); // `size` 대신 `sizeList`
        List<String> colorList = colorService.colorList(item_code);
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "item/itemReview.jsp");
//		mav.addObject("CONTENT", "itemReviewList.jsp");
		mav.addObject("item", item);
        mav.addObject("sizeList", sizeList); // 변수명 수정
        mav.addObject("colorList", colorList);
        List<Review> reviews = this.reviewService.getReviewList(item_code);
        mav.addObject("reviews",reviews);
		return mav;
	}

}
