package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.StartEnd;
import com.springboot.wearwave.service.ItemsService;


@Controller
public class MenuController {
	@Autowired
	private ItemsService itemsService;
	
	@GetMapping(value="/menu/top.html") //상의 카테고리 이동
	public ModelAndView top(@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		se.setStartnum(start); se.setEndnum(end);
		se.setStart(1); se.setEnd(10); //1~10 사이 상의 카테고리
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/top.jsp");
		mav.addObject("currentPage", pageno);
		return mav;
	}
	
	@GetMapping(value="/menu/bottom.html")//하의 카테고리 이동
	public ModelAndView bottom(@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		se.setStartnum(start); se.setEndnum(end);
		se.setStart(11); se.setEnd(20); //11~20 사이 하의 카테고리
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/bottom.jsp");
		mav.addObject("currentPage", pageno);
		return mav;
	}
	
	@GetMapping(value="/menu/outer.html") //아우터 카테고리 이동
	public ModelAndView outer(@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		se.setStartnum(start); se.setEndnum(end);
		se.setStart(21); se.setEnd(30); //21~30 아우터 카테고리
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/outer.jsp");
		mav.addObject("currentPage", pageno);
		return mav;
	}
	
	@GetMapping(value="/menu/shoes.html") //신발 카테고리 이동
	public ModelAndView shoes(@RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		se.setStartnum(start); se.setEndnum(end);
		se.setStart(31); se.setEnd(40); //31~40 신발 카테고리
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/shoes.jsp");
		mav.addObject("currentPage", pageno);
		return mav;
	}
	
	@GetMapping(value="/menu/topcategoryList.html") //상의 세부 카테고리
	public ModelAndView topcategory(@RequestParam("item_id") int itemId, @RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		Items_tbl item = new Items_tbl();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setStart(start); item.setEnd(end);
		item.setItem_id(itemId);
		List<Items_tbl> Items = this.itemsService.getCategory(item);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/top.jsp");
		mav.addObject("item_id", itemId);
		return mav;
	}
	

	@GetMapping(value="/menu/bottomcategoryList.html") //하의 세부 카테고리
	public ModelAndView bottomcategory(@RequestParam("item_id") int itemId, @RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		Items_tbl item = new Items_tbl();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setStart(start); item.setEnd(end);
		item.setItem_id(itemId);
		List<Items_tbl> Items = this.itemsService.getCategory(item);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/bottom.jsp");
		mav.addObject("item_id", itemId);
		return mav;
	}
	
	@GetMapping(value="/menu/outercategoryList.html") //아우터 세부 카테고리
	public ModelAndView outercategory(@RequestParam("item_id") int itemId, @RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		Items_tbl item = new Items_tbl();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setStart(start); item.setEnd(end);
		item.setItem_id(itemId);
		List<Items_tbl> Items = this.itemsService.getCategory(item);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/outer.jsp");
		mav.addObject("item_id", itemId);
		return mav;
	}
	
	@GetMapping(value="/menu/shoescategoryList.html") //신발 세부 카테고리
	public ModelAndView shoescategory(@RequestParam("item_id") int itemId, @RequestParam(required = false, defaultValue = "1") Integer pageno) {
		ModelAndView mav = new ModelAndView("index");
		Items_tbl item = new Items_tbl();
		int pageSize = 12;
		int start = (pageno - 1) * pageSize; // 시작 인덱스
		int end = pageno * pageSize + 1; // 끝 인덱스
		item.setStart(start); item.setEnd(end);
		item.setItem_id(itemId);
		List<Items_tbl> Items = this.itemsService.getCategory(item);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/shoes.jsp");
		mav.addObject("item_id", itemId);
		return mav;
	}
}