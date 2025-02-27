package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.CartMapper;
import com.springboot.wearwave.model.Cart;

@Service
public class CartService {
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private OrderService orderService;

    public void putCart(Cart cart) {
        // 장바구니에 같은 상품이 있는지 확인
        Integer existingCount = cartMapper.checkCartExists(cart);

        if (existingCount > 0) {
            // 이미 존재하는 상품이면 수량을 업데이트
            cartMapper.updateCart(cart);
        } else {
            // 존재하지 않으면 새로 추가
            cartMapper.putCart(cart);
        }
    }

    public List<Cart> getUserCart(String user_id) {
        return this.cartMapper.getUserCart(user_id); // cart리스트 불러오는 메서드
    }

    // 장바구니 삭제
    public void deleteCart(Cart cart) {
        this.cartMapper.deleteCart(cart); 
    }

    
    // 주문 후 장바구니 상태 업데이트
    public void updateCartToOrdered(String userId) {
        this.cartMapper.updateCartItemStatusToOrdered(userId);  // 주문된 항목 상태 변경
    }
}
