package com.springboot.wearwave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.wearwave.model.SlideOrders;
import com.springboot.wearwave.model.Slider_images;

@Mapper
public interface SliderMapper {
	List<Slider_images> getSliderImageList();
	void putSliderImage(Slider_images sliderImg);
	Integer getMaxOrder();
	Integer getMaxNum();
	void deleteslider(Integer order);
	void updatedisplayorder(Integer order);
	void updatenum(Integer num);
	void changeOrders(SlideOrders orders);
	void changeItself(SlideOrders orders);
}
