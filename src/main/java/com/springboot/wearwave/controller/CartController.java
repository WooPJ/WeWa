package com.springboot.wearwave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartController {
	
	@GetMapping(value="/cart/cart.html") //장바구니 이동
	public ModelAndView cart() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","cart/cart.jsp");
		return mav;
	}
}
