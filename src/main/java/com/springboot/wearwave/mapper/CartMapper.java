package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.wearwave.model.Cart;

@Mapper
public interface CartMapper {
    void putCart(Cart cart);
    void updateCart(Cart cart);
    Integer checkCartExists(Cart cart);
    List<Cart> getUserCart(String user_id);
    void deleteCart(Cart cart);    // 삭제 메서드
    void updateCartItemStatusToOrdered(Cart cart);
}

