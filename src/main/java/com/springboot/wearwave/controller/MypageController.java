package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Faq_bbs;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Notice;
import com.springboot.wearwave.model.Qna_bbs;
import com.springboot.wearwave.model.User_info;
import com.springboot.wearwave.service.FaqService;
import com.springboot.wearwave.service.NoticeService;
import com.springboot.wearwave.service.QnaService;
import com.springboot.wearwave.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MypageController {
	@Autowired
	private UserService userService;
	@Autowired
	private FaqService faqService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private QnaService qnaService;
	
	@GetMapping(value="/mypage/profile.html") //마이페이지 > 내정보 이동
	public ModelAndView mypage(HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		ModelAndView mav = new ModelAndView("index");
		User_info mypage = this.userService.getUserInfo(loginUser.getId());
		mav.addObject("BODY","mypage/mypage.jsp");
		mav.addObject("CONTENT", "profile.jsp");
		mav.addObject(mypage);
		return mav;
	}
	
	@PostMapping(value="/mypage/modify.html") //내 정보 수정
	public ModelAndView modify(@Valid User_info user_info, BindingResult br) {
		ModelAndView mav = new ModelAndView("index");
		
		this.userService.updateUserInfo(user_info);//가입자 정보 수정
		User_info userInfo = this.userService.getUserInfo(user_info.getUser_id());
		//변경된 가입자 정보를 검색한다.
		mav.addObject("BODY","mypage/mypage.jsp");
		mav.addObject("CONTENT", "profile.jsp");
		mav.addObject(userInfo);
		return mav;
	}
	 
	 
	 @GetMapping(value="/mypage/support.html") //마이페이지 > FAQ 이동
	    public ModelAndView support() {
	        ModelAndView mav = new ModelAndView("index");
	        List<Faq_bbs> faqs = this.faqService.getFaqList();
	        mav.addObject("faqs",faqs);
	        mav.addObject("BODY", "mypage/mypage.jsp");
	        mav.addObject("CONTENT", "support.jsp");
	        return mav;
	    }
	 
	 @GetMapping(value="/mypage/qnalist.html") //마이페이지 > 문의사항 이동
	    public ModelAndView productinquiry(HttpSession session) {
		 	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	        ModelAndView mav = new ModelAndView("index");
	        if (loginUser.getGrade() == 0) {
	        	List<Qna_bbs> qnas = this.qnaService.getQnaList();
	        	mav.addObject("qnas", qnas);
	        }
	        if (loginUser.getGrade() == 1) {
	        	List<Qna_bbs> qnas = this.qnaService.getUserQnaList(loginUser.getId());
	        	mav.addObject("qnas", qnas);
	        }
	        if (loginUser.getGrade() == 2) {
	        	List<Qna_bbs> qnas = this.qnaService.getSellerQnaList(loginUser.getId());
	        	mav.addObject("qnas", qnas);
	        }
	        mav.addObject("BODY", "mypage/mypage.jsp");
	        mav.addObject("CONTENT", "qnalist.jsp");
	        return mav;
	    }
	 
	 @GetMapping(value="/mypage/notice.html") //마이페이지 > 공지사항 이동
	    public ModelAndView notice() {
	        ModelAndView mav = new ModelAndView("index");
	        List<Notice> notices = this.noticeService.getNoticeList();
	        mav.addObject("notices",notices);
	        mav.addObject("BODY", "mypage/mypage.jsp");
	        mav.addObject("CONTENT", "notice.jsp");
	        return mav;
	    }
}
