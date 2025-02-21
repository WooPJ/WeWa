package com.springboot.wearwave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MenuController {
	
	@GetMapping(value="/menu/top.html") //상의 카테고리 이동
	public ModelAndView top() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","item/top.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/bottom.html")//하의 카테고리 이동
	public ModelAndView bottom() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","item/bottom.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/outer.html") //아우터 카테고리 이동
	public ModelAndView outer() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","item/outer.jsp");
		return mav;
	}
	
	@GetMapping(value="/menu/shoes.html") //신발 카테고리 이동
	public ModelAndView shoes() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","item/shoes.jsp");
		return mav;
	}
	
}
