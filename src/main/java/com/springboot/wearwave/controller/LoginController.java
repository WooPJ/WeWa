package com.springboot.wearwave.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.User;
import com.springboot.wearwave.model.User_info;
import com.springboot.wearwave.service.FindService;
import com.springboot.wearwave.service.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private FindService findService;
	@GetMapping("/login/selectentry.html") //회원가입 선택 이동
	public ModelAndView selectentry() {
	    ModelAndView mav = new ModelAndView("login/selectentry"); 
	    return mav;
	}
	
	@GetMapping("/login/findid.html") //아이디 찾기 이동
	public ModelAndView findid(Model model) {
	    ModelAndView mav = new ModelAndView("login/findid"); 
	    model.addAttribute("user_info", new User_info());
	    return mav;
	}
	
	@PostMapping("/login/findidbyphone.html")
	public ModelAndView findidbyphone(User_info user_info) {
	    ModelAndView mav = new ModelAndView("login/findidresult"); 
	    String id = findService.findIdbyPhone(user_info);
	    // 회원 정보가 없을 경우
	    if (id == null || id.isEmpty()) {
	        mav.addObject("message", "등록된 회원 정보가 없습니다.");
	    } else {
	        mav.addObject("ID", id);
	    }   
	    return mav;
	}

	
	@PostMapping("/login/findidbyemail.html")
	public ModelAndView findidbyemail(User_info user_info){
		ModelAndView mav = new ModelAndView("login/findidresult"); 
	    String id = findService.findIdbyEmail(user_info);
	    // 회원 정보가 없을 경우
	    if (id == null || id.isEmpty()) {
	        mav.addObject("message", "등록된 회원 정보가 없습니다.");
	    } else {
	        mav.addObject("ID", id);
	    }   
	    return mav;
	}
	
	@GetMapping("/login/findpwd.html") //비밀번호 찾기 이동
	public ModelAndView findpwd(Model model) {
	    ModelAndView mav = new ModelAndView("login/findpwd"); 
	    model.addAttribute("user_info", new User_info());
	    return mav;
	}
	
	@PostMapping("/login/findpwdbyphone.html")
	public ModelAndView findpwdbyphone(User_info user_info){
		ModelAndView mav = new ModelAndView("login/findpwdresult"); 
	    Integer count = findService.findPwdbyPhone(user_info);
	    // 회원 정보가 없을 경우
	    if (count < 1) {
	        mav.addObject("message", "등록된 회원 정보가 없습니다.");
	    } else {
	        mav.addObject("ID", user_info.getUser_id());
	    }   
	    return mav;
	}
	
	@PostMapping("/login/findpwdbyemail.html")
	public ModelAndView findpwdbyemail(User_info user_info){
		ModelAndView mav = new ModelAndView("login/findpwdresult"); 
	    Integer count = findService.findPwdbyEmail(user_info);
	    // 회원 정보가 없을 경우
	    if (count < 1) {
	        mav.addObject("message1", "등록된 회원 정보가 없습니다.");
	    } else {
	        mav.addObject("ID", count);
	    }   
	    return mav;
	}
	
	@PostMapping("/login/updatepwd.html")
	public ModelAndView updatepwd(String user_id, String new_pwd) {
		  ModelAndView mav = new ModelAndView("login/findpwdresult");
		    User_info user_info = new User_info();
		    user_info.setUser_id(user_id);
		    user_info.setUser_pwd(new_pwd);
		    // 비밀번호 변경 수행
		    boolean isUpdated = findService.updatePwd(user_info);

		    if (isUpdated) {
		        mav.addObject("message", "비밀번호가 성공적으로 변경되었습니다.");
		    }
		    return mav;
	}
	
	@GetMapping("/login/userentry.html") //손님  회원가입 이동
	public ModelAndView userentry(Model model) {
	    ModelAndView mav = new ModelAndView("login/userentry"); 
	    model.addAttribute("user", new User());
	    return mav;
	}
	
	@GetMapping("/login/businessentry.html") //사업자 회원가입 이동
	public ModelAndView businessentry(Model model) {
	    ModelAndView mav = new ModelAndView("login/businessentry"); 
	    model.addAttribute("user", new User());
	    return mav;
	}
	
	@GetMapping("/login/login.html") //로그인 화면 이동
	public ModelAndView login(/*HttpServletRequest request*/) {
		System.out.println("로그인 컨트롤러 OK");
	    ModelAndView mav = new ModelAndView("login/login"); 
	    //request.setAttribute("loginUser",new LoginUser());
	    mav.addObject(new LoginUser());
	    return mav;
	}
	
	@PostMapping(value = "/login/loginDo.html") //로그인 클릭
	public ModelAndView loginDo(@Valid LoginUser loginUser, BindingResult br, HttpSession session) {
	    ModelAndView mav = new ModelAndView("login/login");
	    if (br.hasErrors()) {
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }
	    // 로그인 처리
	    LoginUser user = loginService.getUser(loginUser);
	    if (user == null) { // 로그인 실패
	        mav.setViewName("login/login"); // 로그인 화면 유지
	        mav.addObject("errorMessage", "아이디 또는 비밀번호가 올바르지 않습니다.");
	    } else { // 로그인 성공
	        session.setAttribute("loginUser", user);
	        mav.setViewName("redirect:/home/index.html"); // 로그인 성공 시 홈으로 이동
	    }
	    return mav;
	}

	@GetMapping(value="/login/logout.html")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView("index");
		return mav;
	}
	
}
