package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.User_info;
import com.springboot.wearwave.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@GetMapping(value="/member/memberlist.html") //마이페이지 > 회원관리 이동
	public ModelAndView memberlist() {
	    ModelAndView mav = new ModelAndView("index");
	    List<User_info> memberList = this.memberService.memberList();
		mav.addObject("BODY", "mypage/mypage.jsp");
		mav.addObject("CONTENT", "memberlist.jsp");
		mav.addObject("memberList", memberList);
	    return mav;
	}
	
	@GetMapping(value = "/member/gradeSearch.html") //회원 등급 검색
	public ModelAndView gradSearch(Integer grade) {
		ModelAndView mav = new ModelAndView("index");
	    List<User_info> memberList = this.memberService.gradebymemberList(grade);
		mav.addObject("BODY", "mypage/mypage.jsp");
		mav.addObject("CONTENT", "memberlist.jsp");
		mav.addObject("memberList", memberList);
	    return mav;
	}
}
