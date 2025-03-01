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
	//상품 주문 취소하기
	void deleteOrder(Integer order_no);
	//사업자의 상품 주문고객 리스트 불러오기
	List<Order> getOrderClearList(Order order);
	//배송상태 변경하기
	void setStatus(Order order);
	//고객의 반품신청버튼 (order_staus를 3(반품처리 중)으로 바꾸기
	void setStatusRefunding(Integer order_no);
	//고객의 주문한 상품 취소/반품내역 확인
	List<Order> getReturnList(String user_id);
}
