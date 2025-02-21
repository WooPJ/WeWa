package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SliderMapper;
import com.springboot.wearwave.model.SlideOrders;
import com.springboot.wearwave.model.Slider_images;

@Service
public class SliderService {
	@Autowired
	private SliderMapper sliderMapper;
	
	public List<Slider_images> getSliderImageList(){
		return this.sliderMapper.getSliderImageList();
	}
	
	public void putSliderImage(Slider_images sliderImg) {
		this.sliderMapper.putSliderImage(sliderImg);
	}
	
	public Integer getMaxOrder() {
		Integer max = this.sliderMapper.getMaxOrder();
		if(max == null) return 0;
		else return max;
	}
	
	public Integer getMaxNum() {
		Integer max = this.sliderMapper.getMaxNum();
		if(max == null) return 0;
		else return max;
	}
	
	public void deleteslider(Integer order) {
		this.sliderMapper.deleteslider(order);
	}
	
	public void updatedisplayorder(Integer order) {
		this.sliderMapper.updatedisplayorder(order);
	}
	
	public void updatenum(Integer num) {
		this.sliderMapper.updatenum(num);
	}
	
	public void changeOrders(SlideOrders orders) {
		this.sliderMapper.changeOrders(orders);
	}
	
	public void changeItself(SlideOrders orders) {
		this.sliderMapper.changeItself(orders);
	}
}













