package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Snapshot_board;
import com.springboot.wearwave.service.SnapService;

import jakarta.servlet.http.HttpSession;

@Controller
@Scope("session")
public class SnapController {
	@Autowired
	private SnapService snapService;
	
	
	
	@GetMapping("/snap/profileContent.html")
	public ModelAndView profile() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "profile_page.jsp");
		return mav;
	}
	@GetMapping("/snap/storedContent.html") //네비클릭
	public ModelAndView stored() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "stored_page.jsp");
		return mav;
	}
	@GetMapping("/snap/postingContent.html")
	public ModelAndView posting(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		List<Snapshot_board> FeedList = this.snapService.getFeedList();
		session.setAttribute("FeedList", FeedList);
		
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "posting_page.jsp");
		return mav;
	}
	
	@GetMapping("/snap/snap.html") //스냅페이지 이동
	public ModelAndView snap(HttpSession session) {
	    ModelAndView mav = new ModelAndView("index"); 
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    return mav;
	}
}
