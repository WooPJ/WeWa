package com.springboot.wearwave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.OrderMapper;
import com.springboot.wearwave.model.Order;

@Service
public class OrderService {
	@Autowired
	private OrderMapper orderMapper;
	
	public void putOrder(Order order) {
		this.orderMapper.putOrder(order);
	}
	
	public Integer countOrdersByUserId(String user_id) {
		return this.orderMapper.countOrdersByUserId(user_id);
	}
}
