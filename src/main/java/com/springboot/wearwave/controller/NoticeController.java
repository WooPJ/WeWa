package com.springboot.wearwave.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Notice;
import com.springboot.wearwave.service.NoticeService;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice/write.html")
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "noticewrite.jsp");
        mav.addObject("notice", new Notice());
        return mav;
	}
	
	@PostMapping("/notice/input.html")
	public ModelAndView input(Notice notice, HttpSession session) {
		int num = this.noticeService.getMaxNum() + 1;
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		String id = user.getId();
		notice.setSeqno(num);
		notice.setWriter(id);
		this.noticeService.putNotice(notice);
		return new ModelAndView("redirect:/mypage/notice.html");
	}
	
	@GetMapping("/notice/delete.html")
	public ModelAndView deleteNotice(@RequestParam("seqno") int seqno) {
	    this.noticeService.deleteNotice(seqno);
	    this.noticeService.updateseqno(seqno);
	    return new ModelAndView("redirect:/mypage/notice.html");
	}
	
	@GetMapping("/notice/update.html")
	public ModelAndView showUpdatePage(@RequestParam("seqno") int seqno) {
	    Notice notice = noticeService.getNotice(seqno);
	    ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "updatenotice.jsp");
        mav.addObject("notice", notice);
        return mav;
	}
	
	@PostMapping("/notice/update.html")
	public ModelAndView updateNotice(Notice notice) {	
	   this.noticeService.updateNotice(notice);
	   return new ModelAndView("redirect:/mypage/notice.html");
	}

}
