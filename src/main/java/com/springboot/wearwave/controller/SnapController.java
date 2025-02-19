package com.springboot.wearwave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SnapController {
	
	@GetMapping("/snap/snap.html") //스냅페이지 이동
	public ModelAndView snap() {
	    ModelAndView mav = new ModelAndView("index"); 
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    return mav;
	}
}
