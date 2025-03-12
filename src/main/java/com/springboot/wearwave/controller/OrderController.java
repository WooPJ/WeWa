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

    
    @PostMapping(value = "/order/returnRequest.html")
    public ModelAndView updateStatusRefunding(@RequestParam("order_no") Integer orderNo) {
    	// 서비스 계층을 통해 주문 상태를 업데이트
    	orderService.setStatusRefunding(orderNo);
        // 성공적으로 업데이트 후, 주문 목록 페이지로 리다이렉트
    	ModelAndView mav = new ModelAndView("redirect:/order/orders.html");
    	return mav;
    }
    
	 @GetMapping(value="/order/returns.html") //마이페이지 > 환불 이동
	 public ModelAndView returns(HttpSession session) {
       ModelAndView mav = new ModelAndView("index");
       // 세션에서 로그인 사용자 정보 가져오기
       LoginUser user = (LoginUser) session.getAttribute("loginUser");
       mav.addObject("BODY", "mypage/mypage.jsp");
       
       String userId = user.getId();
       List<Order> returnList = orderService.getReturnList(userId);// 해당 사용자의 반품 목록 조회
       mav.addObject("returnList", returnList);  // 반품 목록을 mav에 추가
       mav.addObject("CONTENT", "../order/orderReturns.jsp");  // orderReturns.jsp 화면 설정
	   return mav;
	   }
    
    @PostMapping(value = "/order/statusChange.html")
    public ModelAndView updateOrderStatus(@RequestParam("order_status") Integer orderStatus, 
                                          @RequestParam("order_no") Integer orderNo, Order order) {
        order.setOrder_no(orderNo);
        order.setOrder_status(orderStatus);
    	// 서비스 계층을 통해 주문 상태를 업데이트
        orderService.setStatus(order);
        // 성공적으로 업데이트 후, 주문 목록 페이지로 리다이렉트
        ModelAndView mav = new ModelAndView("redirect:/order/orderClearList.html");
        return mav;
    }
    
    @GetMapping(value = "/order/orderClearList.html") //마이페이지 > 취소/반품 신청 목록
    public ModelAndView getOrderClearList(HttpSession session, String user_id,
    		String item_code, Integer quantity, String item_color, String item_size,
    		String order_date, Integer order_status) {
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	ModelAndView mav = new ModelAndView("index");
    	Order order = new Order();
    	order.setUser_id(loginUser.getId());
    	order.setItem_code(item_code);
    	order.setQuantity(quantity);
    	order.setItem_color(item_color);
    	order.setItem_size(item_size);
    	order.setOrder_status(order_status);
    	List<Order> orderClearList = this.orderService.getOrderClearList(order);
    	mav.addObject("orderClearList",orderClearList);
    	mav.addObject("BODY", "mypage/mypage.jsp");
    	mav.addObject("CONTENT", "../order/orderClearList.jsp");
    	return mav;
    }
    
    // 주문 취소 및 반품 신청 처리
    @PostMapping(value = "/order/modify.html")
    public ModelAndView orderCancel(@RequestParam("orderNo") Integer orderNo, 
                                    @RequestParam("BTN") String BTN, 
                                    HttpSession session) {
        
        // 세션에서 로그인된 사용자 정보 가져오기
        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        // 버튼 클릭에 따라 처리
        if ("주문취소".equals(BTN)) {
            orderService.deleteOrder(orderNo);  // 주문취소 처리
        }
        
        if ("반품신청".equals(BTN)) {
            // 반품 신청 처리 (예: orderService.requestReturn(orderNo))
        }

        // 주문 취소 후 최신 주문 목록을 가져와서 다시 모델에 추가
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("BODY", "mypage/mypage.jsp");
        List<Order> orderList = orderService.getOrderList(user.getId());  // 최신 주문 목록 조회
        mav.addObject("orderList", orderList);  // 주문 목록을 mav에 추가
        mav.addObject("CONTENT", "../order/orders.jsp");  // orders.jsp로 렌더링

        return mav;
    }

    // 마이페이지 > 주문정보 화면
    @GetMapping(value = "/order/orders.html")
    public ModelAndView orders(HttpSession session) {
        ModelAndView mav = new ModelAndView("index");
        
        // 세션에서 로그인 사용자 정보 가져오기
        LoginUser user = (LoginUser) session.getAttribute("loginUser");
        mav.addObject("BODY", "mypage/mypage.jsp");
        
        String userId = user.getId();
        List<Order> orderList = orderService.getOrderList(userId);  // 해당 사용자의 주문 목록 조회
        mav.addObject("orderList", orderList);  // 주문 목록을 mav에 추가
        mav.addObject("CONTENT", "../order/orders.jsp");  // orders.jsp 화면 설정
        
        return mav;
    }

    // 주문 처리 로직
    @PostMapping(value = "/order/order.html")
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