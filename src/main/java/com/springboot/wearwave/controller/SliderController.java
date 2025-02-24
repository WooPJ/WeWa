package com.springboot.wearwave.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.SlideOrders;
import com.springboot.wearwave.model.Slider_images;
import com.springboot.wearwave.service.SliderService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
public class SliderController {
	@Autowired
	private SliderService sliderService;
	
	@GetMapping(value = "/slider/sliderimg.html")
	public ModelAndView sliderImg() {
        ModelAndView mav = new ModelAndView("index");
        List<Slider_images> sliderImg = this.sliderService.getSliderImageList();
        mav.addObject("sliderImg",sliderImg);
        mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "sliderimagesetting.jsp");
        return mav;
	}
	
	@GetMapping(value = "/slider/addImagePage.html")
	public ModelAndView addImagePage() {
	    ModelAndView mav = new ModelAndView("index");
        mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "addSlideImage.jsp");
        mav.addObject("sliderImg", new Slider_images());
        return mav;
	}
	
	@PostMapping(value = "/slider/uploadImage.html")
	public ModelAndView write(@ModelAttribute("sliderImg") Slider_images slideImg, 
			 HttpSession session) {
		MultipartFile multipart = slideImg.getFile();//선택한 파일을 불러온다.
		String fileName = null; String path = null; OutputStream os = null;
		fileName = multipart.getOriginalFilename();//선택한 파일의 이름을 찾는다.
		ServletContext ctx = session.getServletContext();//ServletContext 생성
		path = ctx.getRealPath("/imgs/slider/"+fileName);
		try {
			os = new FileOutputStream(path);//OutputStream을 생성한다.즉, 파일 생성
			BufferedInputStream bis = new BufferedInputStream(multipart.getInputStream());
			//InputStream을 생성한다. 즉, 원본파일을 읽을 수 있도록 연다.
			byte[] buffer = new byte[8156];//8K 크기로 배열을 생성한다.
			int read = 0;//원본 파일에서 읽은 바이트 수를 저장할 변수 선언
			while( (read = bis.read(buffer)) > 0) {//원본 파일에서 읽은 바이트 수가 0이상인 경우 반복
				os.write(buffer, 0, read);//생성된 파일에 출력(원본 파일에서 읽은 바이트를 파일에 출력)
			}
		}catch(Exception e) {
			System.out.println("파일 업로드 중 문제 발생!");
		}finally {
			try { if(os != null) os.close(); }catch(Exception e) {}
		}
		slideImg.setImage_url("/imgs/slider/"+fileName);
		int maxNum = this.sliderService.getMaxNum() + 1;
		int maxOrder = this.sliderService.getMaxOrder() + 1;
		slideImg.setNum(maxNum);
		slideImg.setDisplay_order(maxOrder);
		this.sliderService.putSliderImage(slideImg);
		return new ModelAndView("redirect:/slider/sliderimg.html");
	}
	
	@PostMapping(value = "/slider/deleteImage.html")
	public ModelAndView deleteSlideImage(Integer order) {
		this.sliderService.deleteslider(order);
		this.sliderService.updatedisplayorder(order);
		return new ModelAndView("redirect:/slider/sliderimg.html");
	}
	
	@PostMapping(value = "/slider/updateOrder.html")
	public ModelAndView updateOrder(Integer num, Integer old_order, Integer new_order) {
		SlideOrders orders = new SlideOrders();
		orders.setNum(num); orders.setOld_order(old_order); orders.setNew_order(new_order);
		this.sliderService.changeOrders(orders);
		this.sliderService.changeItself(orders);
	    return new ModelAndView("redirect:/slider/sliderimg.html");
	}
}
