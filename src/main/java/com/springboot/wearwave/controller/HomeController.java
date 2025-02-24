package com.springboot.wearwave.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Heart;
import com.springboot.wearwave.model.Item;
import com.springboot.wearwave.service.ItemService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	private ItemService itemService;

	@GetMapping(value="/home/index.html") //홈 화면 이동
	public ModelAndView home(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		
        // 모든 상품 리스트를 조회해서 전달
        List<Item> itemList = itemService.getAllItems();
        mav.addObject("itemList", itemList);
        
        // 세션에서 heartList 가져오기 (찜한 목록)
        ArrayList<Heart> heartList = (ArrayList<Heart>) session.getAttribute("heartList");
        if (heartList == null) {
            heartList = new ArrayList<>();
        }
		mav.addObject("heartList",heartList);
		return mav;
	}
}
