package com.springboot.wearwave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LikeController {
	
	@GetMapping(value="/like/likelist.html") //찜 목록 이동
	public ModelAndView likelist() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","like/likelist.jsp");
		return mav;
	}
}
