package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Snapshot_board;
import com.springboot.wearwave.service.SnapService;

@Controller
public class SnapController {
	@Autowired
	private SnapService snapService;
	
//	@GetMapping("/snap/feedList.html")
	
	@GetMapping("/snap/snap.html") //스냅페이지 이동
	public ModelAndView snap() {
	    ModelAndView mav = new ModelAndView("index"); 
	    
	    List<Snapshot_board> FeedList = this.snapService.getFeedList();
	    
	    mav.addObject("FeedList", FeedList);
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    return mav;
	}
}
