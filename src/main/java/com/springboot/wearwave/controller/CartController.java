package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Cart;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	//장바구니 목록에서 삭제
	@PostMapping(value = "/cart/modify.html")
	public ModelAndView modify(@RequestParam("item_code") String item_code, 
	                           @RequestParam("BTN") String BTN,
	                           @RequestParam("item_color") String item_color,
	                           @RequestParam("item_size") String item_size,
	                           HttpSession session) {
	    LoginUser user = (LoginUser) session.getAttribute("loginUser");
	    Cart cart = new Cart();
	    if (user == null) {
	        return new ModelAndView("redirect:/login/login.html"); // 로그인 정보가 없으면 로그인 페이지로 리디렉션
	    }

	    // 삭제 버튼을 클릭한 경우
	    if ("삭제".equals(BTN)) {
	        cart.setItem_code(item_code);
	        cart.setUser_id(user.getId());
	        cart.setItem_color(item_color);
	        cart.setItem_size(item_size);
	        cartService.deleteCart(cart);  // 장바구니에서 삭제
	    }

	    // 삭제 후 결과 페이지로 리디렉션
	    ModelAndView mav = new ModelAndView("index"); // 삭제 완료 페이지
	    mav.addObject("BODY","cart/deleteCartResult.jsp");
	    return mav;
	}


	
	// 장바구니에 추가
	@PostMapping(value = "/cart/cart.html")
	public ModelAndView addCart(HttpSession session, String item_code, String selectedSize, String selectedQuantity,
	        String selectedColor, Cart cart) throws java.sql.SQLIntegrityConstraintViolationException {
	    ModelAndView mav = new ModelAndView("index");
	    LoginUser user = (LoginUser) session.getAttribute("loginUser");
	    String userId = user.getId();

	    // Cart 객체 설정
	    cart.setUser_id(userId);
	    cart.setItem_code(item_code);
	    cart.setQuantity(Integer.parseInt(selectedQuantity));
	    cart.setItem_color(selectedColor);
	    cart.setItem_size(selectedSize);

	    try {
	        // 장바구니에 추가 (중복 체크 포함)
	        this.cartService.putCart(cart);
	        System.out.println("장바구니에 담기 성공: " + cart.toString());
	    } catch (org.springframework.dao.DuplicateKeyException e) {
	        System.err.println("장바구니 추가 실패 - 중복된 데이터: " + e.getMessage());
	        mav.addObject("errorMessage", "이미 장바구니에 담긴 상품입니다.");
	    } catch (Exception e) {
	        System.err.println("장바구니 추가 실패 - 기타 오류: " + e.getMessage());
	        mav.addObject("errorMessage", "장바구니 추가 중 오류가 발생했습니다.");
	    }

	    mav.addObject("BODY", "cart/addCartResult.jsp");
	    return mav;
	}

	// 장바구니 조회
	@GetMapping(value = "/cart/cart.html")
	public ModelAndView cartView(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		LoginUser user = (LoginUser) session.getAttribute("loginUser");

		// 로그인 여부 확인
		if (user == null) {
			return new ModelAndView("redirect:../login/login.html");
		}

		String userId = user.getId();
		List<Cart> cartList = cartService.getUserCart(userId); // 장바구니 목록 조회
		mav.addObject("cartList", cartList);
		mav.addObject("BODY", "cart/cart.jsp");
		return mav;
	}

}