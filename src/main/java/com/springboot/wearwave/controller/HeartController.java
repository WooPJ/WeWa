package com.springboot.wearwave.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Heart;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.service.HeartService;

import jakarta.servlet.http.HttpSession;

@Controller
@Scope("session")
public class HeartController {
	@Autowired
	private HeartService heartService;
	
	
	@GetMapping(value="/heart/heartlist.html") //찜 목록 이동
	public ModelAndView heartList(HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		ModelAndView mav = new ModelAndView("index");
		if (loginUser == null) {
			return mav.addObject("BODY", "heart/heartlist.jsp"); // 로그인 안 했을때
		}
		
		List<Heart> heartList = (ArrayList<Heart>)session.getAttribute("heartList");
		heartList = this.heartService.getHeartListByUser(loginUser.getId());
		
		session.setAttribute("heartList", heartList);
		mav.addObject("BODY","heart/heartlist.jsp");
		return mav;
	}
	
	@GetMapping(value = "/heart/toggle.html") // 좋아요버튼 누른 경우
	public ModelAndView heartToggle(
			@RequestParam("itemCode") String item_code, 
			@RequestParam("status") boolean isFilled, 
			HttpSession session) {
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		Heart heart = new Heart();
		int status = typeCast(isFilled); //isFilled가 true --> 1리턴
		heart.setStatus(status);
		heart.setUser_id(user.getId()); //하트누른 계정설정
		heart.setItem_code(item_code); // 현재 로그인한 사용자 ID
		
		System.out.println("---시작! 하트컨트롤러에 도달함");
		System.out.println(isFilled);
		
		if(isFilled) { //true 찜하기 추가
			int isHearted = heartService.isHearted(heart); //찜상품 유무 DB조회
			if(isHearted == 0) { //0이면 DB에 찜상품 없음			
				this.heartService.insertHeart(heart); //DB삽입
			} 
			
			ArrayList<Heart> heartList = (ArrayList<Heart>)session.getAttribute("heartList");
			if(heartList == null) {
				heartList = new ArrayList<Heart>();
			}
			heartList.add(heart);
			session.setAttribute("heartList", heartList);
			System.out.println("찜 추가의 상품 code : " + item_code);
			
		} else { //false 찜하기 삭제
		    System.out.println("찜 삭제의 상품 code : " + item_code);

		    // 세션에서 heartList 가져오기
		    ArrayList<Heart> heartList = (ArrayList<Heart>) session.getAttribute("heartList");
		    heartList.removeIf(h -> h.getItem_code().equals(item_code));
		    session.setAttribute("heartList", heartList);
		    
		    // DB에서 status를 0으로 변경
		    heart.setUser_id(user.getId()); // 현재 로그인한 사용자 ID
		    heart.setItem_code(item_code);  // 찜 삭제할 상품 코드
		    heart.setStatus(0); // status = 0 설정

		    this.heartService.updateFalse(heart); // DB 업데이트
		    this.heartService.deleteHeart(heart);
		}
        ModelAndView mav = new ModelAndView("index");
        return mav;
	}
	
	public int typeCast(boolean bool) {
		return bool ? 1 : 0;
	}
}
