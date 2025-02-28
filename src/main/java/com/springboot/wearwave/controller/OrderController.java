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
import com.springboot.wearwave.model.Order;
import com.springboot.wearwave.service.CartService;
import com.springboot.wearwave.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
    
    @Autowired
    private OrderService orderService;  // OrderService를 주입받습니다.
    @Autowired
    private CartService cartService;    // CartService를 주입받습니다.
    
	
	 @GetMapping(value="/mypage/orders.html") //마이페이지 > 주문정보 이동
	    public ModelAndView orders(HttpSession session) {
	        ModelAndView mav = new ModelAndView("index");
	        LoginUser user = (LoginUser) session.getAttribute("loginUser");
	        mav.addObject("BODY", "mypage/mypage.jsp");
			String userId = user.getId();
//			List<Cart> orderList = cartService.getUserCart(userId); // 장바구니 목록 조회
			List<Order> orderList = orderService.getOrderList(userId);
			mav.addObject("orderList", orderList);
	        mav.addObject("CONTENT", "orders.jsp");
	        
	        return mav;
	    }
    
    @PostMapping(value = "/item/order.html")
    public ModelAndView order(HttpSession session,
                               @RequestParam("order_item_code") String[] itemCodes,
                               @RequestParam("order_item_color") String[] itemColors,
                               @RequestParam("order_item_size") String[] itemSizes,
                               @RequestParam("order_quantity") int[] quantities) {
        ModelAndView mav = new ModelAndView("index");

        // 세션에서 로그인된 사용자 정보 가져오기
        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        if (user == null) {
            mav.addObject("error", "User is not logged in");
            return mav;
        }

        String userId = user.getId();  // 세션에서 userId를 가져옴

        // 주문 목록을 처리하는 로직
        for (int i = 0; i < itemCodes.length; i++) {
            Order order = new Order();
            order.setUser_id(userId);
            order.setItem_code(itemCodes[i]);
            order.setQuantity(quantities[i]);
            order.setItem_color(itemColors[i]);
            order.setItem_size(itemSizes[i]);

            // 주문 테이블에 데이터 삽입
            this.orderService.putOrder(order);  // OrderService를 통해 주문을 DB에 삽입
            System.out.println("전달되는 데이터 :"+userId+itemCodes[i] + quantities[i] + 
            		itemColors[i] + itemSizes[i]);
            Cart cart = new Cart();
//            cart.setUser_id(userId);
            cart.setUser_id(userId);
            cart.setItem_code(itemCodes[i]);
            cart.setItem_color(itemColors[i]);
            cart.setItem_size(itemSizes[i]);
            this.cartService.updateCartToOrdered(cart); //주문 후 장바구니 테이블의 상품정보를 주문완료 상태로 변경.
        }

        // 주문이 완료된 후 장바구니 비우기
        mav.addObject("BODY", "order/orderResult.jsp");
        return mav;
    }
}
