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
	public ModelAndView top() {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		se.setStart(1); se.setEnd(10);
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/top.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/bottom.html")//하의 카테고리 이동
	public ModelAndView bottom() {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		se.setStart(11); se.setEnd(20);
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/bottom.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/outer.html") //아우터 카테고리 이동
	public ModelAndView outer() {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		se.setStart(21); se.setEnd(30);
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/outer.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/shoes.html") //신발 카테고리 이동
	public ModelAndView shoes() {
		ModelAndView mav = new ModelAndView("index");
		StartEnd se = new StartEnd();
		se.setStart(31); se.setEnd(40);
		List<Items_tbl> Items = this.itemsService.getItemMenu(se);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/shoes.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/topcategoryList.html") 
	public ModelAndView topcategory(@RequestParam("item_id") int itemId) {
		ModelAndView mav = new ModelAndView("index");
		List<Items_tbl> Items = this.itemsService.getCategory(itemId);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/top.jsp");
		return mav;
	}
	

	@GetMapping(value="/menu/bottomcategoryList.html") 
	public ModelAndView bottomcategory(@RequestParam("item_id") int itemId) {
		ModelAndView mav = new ModelAndView("index");
		List<Items_tbl> Items = this.itemsService.getCategory(itemId);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/bottom.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/outercategoryList.html") 
	public ModelAndView outercategory(@RequestParam("item_id") int itemId) {
		ModelAndView mav = new ModelAndView("index");
		List<Items_tbl> Items = this.itemsService.getCategory(itemId);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/outer.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/shoescategoryList.html") 
	public ModelAndView shoescategory(@RequestParam("item_id") int itemId) {
		ModelAndView mav = new ModelAndView("index");
		List<Items_tbl> Items = this.itemsService.getCategory(itemId);
		mav.addObject("Items", Items);
		mav.addObject("BODY","item/shoes.jsp");
		return mav;
	}
}