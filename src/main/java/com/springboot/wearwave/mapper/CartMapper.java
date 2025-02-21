package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Cart;
import com.springboot.wearwave.model.Item;

@Mapper
/*public interface CartMapper {
	void putCart(Cart cart);
	List<Item> getUserCart(String user_id);
}
*/
public interface CartMapper {
    void putCart(Cart cart);
    void updateCart(Cart cart);
    Integer checkCartExists(Cart cart);
    List<Cart> getUserCart(String user_id);
}

