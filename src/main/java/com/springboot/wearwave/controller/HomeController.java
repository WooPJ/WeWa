package com.springboot.wearwave.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Heart;
import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.Slider_images;
import com.springboot.wearwave.service.ItemsService;
import com.springboot.wearwave.service.SliderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	private SliderService sliderService;
	@Autowired
	private ItemsService itemsService;

	@GetMapping(value="/home/index.html") //홈 화면 이동
	public ModelAndView home(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		
		List<Slider_images> sliderlist = this.sliderService.getSliderImageList();
		List<Items_tbl> itemList = this.itemsService.getItemList(); // 모든 상품 리스트를 조회해서 전달
		mav.addObject("sliderList",sliderlist);
        mav.addObject("itemList", itemList);
        
		return mav;
	}
}