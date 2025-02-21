package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.CartMapper;
import com.springboot.wearwave.model.Cart;

/*
 * @Service public class CartService {
 * 
 * @Autowired private CartMapper cartMapper;
 * 
 * public void putCart(Cart cart) { this.cartMapper.putCart(cart); } public
 * List<Item> getUserCart(String user_id){ return this.getUserCart(user_id); } }
 */
@Service
public class CartService {
    @Autowired
    private CartMapper cartMapper;

    public void putCart(Cart cart) {
        // 기존 장바구니에 동일한 상품이 있는지 확인
        Integer existingCount = cartMapper.checkCartExists(cart);

        if (existingCount > 0) {
            // 이미 존재하는 상품이면 수량 업데이트
            cartMapper.updateCart(cart);
        } else {
            // 존재하지 않으면 새로 추가
            cartMapper.putCart(cart);
        }
    }

    public List<Cart> getUserCart(String user_id) {
        return this.cartMapper.getUserCart(user_id);
    }
}
