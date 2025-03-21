package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView home(HttpSession session,@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		Items_tbl item = new Items_tbl();
		ModelAndView mav = new ModelAndView("index");
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setStart(start); item.setEnd(end);
		List<Slider_images> sliderlist = this.sliderService.getSliderImageList();
		List<Items_tbl> itemList = this.itemsService.getItemListPage(item); // 모든 상품 리스트를 조회해서 전달
		mav.addObject("sliderList",sliderlist);
        mav.addObject("itemList", itemList);
        mav.addObject("currentPage", pageno);
		return mav;
	}
	
	@PostMapping(value="/home/search.html") //검색창
	public ModelAndView search(@RequestParam(required = false, defaultValue = "") String NAME,
				@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		Items_tbl item = new Items_tbl();
		ModelAndView mav = new ModelAndView("index");
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setName(NAME);
		item.setStart(start); item.setEnd(end);
		List<Items_tbl> itemList = this.itemsService.searchItemByName(item);
		mav.addObject("Items", itemList);
		mav.addObject("BODY","item/itemsByNameList.jsp");
		mav.addObject("NAME", NAME);
		mav.addObject("currentPage", pageno);
		return mav;
	}
}