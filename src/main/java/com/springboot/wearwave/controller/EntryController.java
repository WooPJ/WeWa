package com.springboot.wearwave.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.User;
import com.springboot.wearwave.service.CheckService;
import com.springboot.wearwave.service.LoginService;

import jakarta.validation.Valid;

@Controller
public class EntryController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private CheckService checkService;
	
	@PostMapping(value = "/entry/businessprocess.html")
	public ModelAndView businessRegister(@Valid User user, BindingResult br) {
	    ModelAndView mav = new ModelAndView();	    
	    if (br.hasErrors()) {
	        mav.setViewName("login/businessentry"); // 회원가입 페이지 유지
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }
	    try {
	        this.loginService.putBusinessUser(user);//DB 저장 실행
	        mav.setViewName("login/userEntryResult"); // 회원가입 성공 시 이동할 페이지
	    } catch (Exception e) {
	        e.printStackTrace();
	        mav.setViewName("login/businessentry"); // 오류 발생 시 다시 회원가입 페이지로
	        mav.addObject("errorMessage", "회원가입 중 오류가 발생했습니다.");
	    }
	    return mav;
	}//사업자 회원가입
	
	@PostMapping(value = "/entry/customerprocess.html")
	public ModelAndView customerRegister(@Valid User user, BindingResult br,
				String customDomainInput) {
	    ModelAndView mav = new ModelAndView();	    
	    if (br.hasErrors()) {
	        mav.setViewName("login/userentry"); // 회원가입 페이지 유지
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }
	    try {
	        this.loginService.putCustomerUser(user);//DB 저장 실행
	        mav.setViewName("login/userEntryResult"); // 회원가입 성공 시 이동할 페이지
	    } catch (Exception e) {
	        e.printStackTrace();
	        mav.setViewName("login/userentry"); // 오류 발생 시 다시 회원가입 페이지로
	        mav.addObject("errorMessage", "회원가입 중 오류가 발생했습니다.");
	    }
	    return mav;
	}//고객 회원가입
	
	@GetMapping(value = "/entry/idcheck.html")
	public ModelAndView idcheck(String user_id) {
		ModelAndView mav = new ModelAndView("login/idCheckResult");
//		Integer count = this.checkDao.checkDupId(user_id);
		Integer count = this.checkService.checkDupId(user_id);
		if(count > 0) {//이미 계정이 존재하는 경우, 즉 계정 중복
			mav.addObject("DUP","YES");
		}else {//계정이 존재하지 않는 경우, 즉 사용 가능
			mav.addObject("DUP","NO");
		}
		mav.addObject("ID", user_id);
		return mav;
	}//계정 중복 검사 메서드
	
}
