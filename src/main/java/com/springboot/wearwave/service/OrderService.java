package com.springboot.wearwave.service;

import java.util.List;

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
	public List<Order> getOrderList(String user_id){
		return this.orderMapper.getOrderList(user_id);
	}
	public void deleteOrder(Integer order_no) {
		this.orderMapper.deleteOrder(order_no);
	}
	public List<Order> getOrderClearList(Order order){
		return this.orderMapper.getOrderClearList(order);
	}
	public void setStatus(Order order) {
		this.orderMapper.setStatus(order);
	}
	public void setStatusRefunding(Integer order_no) {
		this.orderMapper.setStatusRefunding(order_no);
	}
	public List<Order> getReturnList(String user_id){
		return this.orderMapper.getReturnList(user_id);
	}
}
