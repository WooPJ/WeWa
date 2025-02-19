package com.springboot.wearwave.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Faq_bbs;
import com.springboot.wearwave.service.FaqService;

@Controller
public class FaqController {
	@Autowired
	private FaqService faqService;
	
	@GetMapping("/faq/write.html")
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "faqwrite.jsp");
        mav.addObject("faq", new Faq_bbs());
        return mav;
	}
	
	@PostMapping("/faq/input.html")
	public ModelAndView input(Faq_bbs faq) {
		int num = this.faqService.getMaxNum() + 1;
		faq.setSeqno(num);
		this.faqService.putFaq(faq);
		return new ModelAndView("redirect:/mypage/support.html");
	}
	
	@GetMapping("/faq/delete.html")
	public ModelAndView deleteFAQ(@RequestParam("seqno") int seqno) {
	    this.faqService.deletefaq(seqno);
	    this.faqService.updateseqno(seqno);
	    return new ModelAndView("redirect:/mypage/support.html");
	}
	
	@GetMapping("/faq/update.html")
	public ModelAndView showUpdatePage(@RequestParam int seqno) {
		Faq_bbs faq = faqService.getfaq(seqno);  
	    ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "updatefaq.jsp");
        mav.addObject("faq", faq);
        return mav;
	}
	
	@PostMapping("/faq/update.html")
	public ModelAndView updateFAQ(Faq_bbs faq) {	
	    this.faqService.updatefaq(faq);
	    return new ModelAndView("redirect:/mypage/support.html");
	}

}
