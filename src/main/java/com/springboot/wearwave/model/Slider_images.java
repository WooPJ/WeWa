package com.springboot.wearwave.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Slider_images {
	private Integer num;
	private String title;
	private String image_url;
	private Integer display_order;
	private MultipartFile file;
}
