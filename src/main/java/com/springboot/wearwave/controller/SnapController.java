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
	
//	@GetMapping("/snap/feedList.html")
	
	@GetMapping("/snap/snap.html") //스냅페이지 이동
	public ModelAndView snap(HttpSession session) {
	    ModelAndView mav = new ModelAndView("index"); 
	    LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
//		if (loginUser == null) {
//			return mav.addObject("BODY", "snap/snap.jsp"); // 로그인 안 했을때
//		}
	    
	    List<Snapshot_board> FeedList = this.snapService.getFeedList();
	    
	    mav.addObject("FeedList", FeedList);
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    return mav;
	}
}
