package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.Order;

@Mapper
public interface OrderMapper {
	// 주문을 DB에 저장하는 메서드
	void putOrder(Order order);
	// 사용자의 주문 수를 확인하는 메서드
	Integer countOrdersByUserId(String user_id);
	// 사용자의 주문목록을 불러오는 메서드
	List<Order> getOrderList(String user_id);
}
