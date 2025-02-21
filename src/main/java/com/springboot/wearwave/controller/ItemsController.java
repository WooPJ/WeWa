package com.springboot.wearwave.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Item_color;
import com.springboot.wearwave.model.Item_size;
import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.service.ItemsService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class ItemsController {
	@Autowired
	private ItemsService itemsService;
	
	@GetMapping(value="/items/additems.html") 
	public ModelAndView additems() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "additems.jsp");
        mav.addObject("Items", new Items_tbl());
		return mav;
	}
	
	@PostMapping(value="/items/addItems.html") 
	@Transactional
	public ModelAndView inputItems(@ModelAttribute("Items") Items_tbl items, @RequestParam("color[]") List<String> colors,
			 @RequestParam("size[]") List<String> sizes,@RequestParam("quantity[]") List<Integer> quantities, HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		MultipartFile multipart = items.getFile();//선택한 파일을 불러온다.
		String fileName = null; String path = null; OutputStream os = null;
		fileName = multipart.getOriginalFilename();//선택한 파일의 이름을 찾는다.
		ServletContext ctx = session.getServletContext();//ServletContext 생성
		String userFolder = ctx.getRealPath("/imgs/item/"+loginUser.getId()+"/");
		
		File dir = new File(userFolder);
	    if (!dir.exists()) {
	        dir.mkdirs(); // 폴더가 없으면 생성
	    }
	    path = userFolder + fileName;
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
		items.setImagename("/imgs/item/"+ loginUser.getId() + "/"+fileName);
		int maxNum = this.itemsService.getMaxNum() + 1;
	
		items.setNum(maxNum); items.setUser_id(loginUser.getName());
		this.itemsService.putItems(items);
		 for (String color : colors) {
		        if (color != null && !color.trim().isEmpty()) {
		            Item_color colorData = new Item_color();
		            colorData.setItem_code(items.getItem_code());
		            colorData.setItem_color(color);
		            this.itemsService.putColor(colorData);
		        }
		    }

		    // 사이즈 및 갯수 정보 저장
		    for (int i = 0; i < sizes.size(); i++) {
		        if (sizes.get(i) != null && !sizes.get(i).trim().isEmpty() && quantities.get(i) > 0) {
		            Item_size sizeData = new Item_size();
		            sizeData.setItem_code(items.getItem_code());
		            sizeData.setItem_size(sizes.get(i));
		            sizeData.setQuantity(quantities.get(i));
		            this.itemsService.putSize(sizeData);
		        }
		    }
		return new ModelAndView("redirect:/items/myitemlist.html");
	}
	
	@GetMapping(value="/items/itemlist.html") 
	public ModelAndView ltemlist() {
		ModelAndView mav = new ModelAndView("index");
		List<Items_tbl> Items = this.itemsService.getItemList();	
        mav.addObject("Items",Items);
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "itemlist.jsp");
		return mav;
	}
	
	@GetMapping(value="/items/myitemlist.html") 
	public ModelAndView myltemlist(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		List<Items_tbl> Items = this.itemsService.getMyItemList(loginUser.getId());	
        mav.addObject("Items",Items);
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "myItemList.jsp");
		return mav;
	}
	
	@PostMapping(value = "/items/deleteItem.html")
	public ModelAndView deleteMyItem(String item_code, Integer num, HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		this.itemsService.deleteItem_size(item_code);
		this.itemsService.deleteItem_color(item_code);
		this.itemsService.updateNum(num);
		this.itemsService.deleteItem(item_code);
		 if (loginUser.getGrade() == 0) {     
	            return new ModelAndView("redirect:/items/itemlist.html");
	        } else {
	            return new ModelAndView("redirect:/items/myitemlist.html");
	        }
	}
	
	@PostMapping(value = "/items/updateItem.html")
	public ModelAndView updateMyItem(String item_code) {
		Items_tbl items = itemsService.getMyItem(item_code);
		List<Item_size> size = itemsService.getMyItem_size(item_code);
		List<Item_color> color = itemsService.getMyItem_color(item_code);
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "updateitems.jsp");
        mav.addObject("items", items);
        mav.addObject("size", size);
        mav.addObject("color", color);
		return mav;
	}
	
	@PostMapping(value="/items/updateItemDo.html")
	public ModelAndView updateDo(Items_tbl items, HttpSession session, Integer item_id) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		MultipartFile multiFile = items.getFile();
		if(! multiFile.getOriginalFilename().equals("")) {
			String fileName = null; String path = null; OutputStream os = null;
			fileName = multiFile.getOriginalFilename();
			ServletContext ctx = session.getServletContext();
			String userFolder = ctx.getRealPath("/imgs/item/"+loginUser.getId()+"/");
			path = userFolder + fileName;
			try {
				os = new FileOutputStream(path);//upload 폴더에 파일 생성
				BufferedInputStream bis = 
					new BufferedInputStream(multiFile.getInputStream());//선택한 파일을 연다.
				byte[] buffer = new byte[8156];//8K 크기로 배열 생성(한번에 8K씩 복사가 진행)
				int read = 0;//실제로 읽은 바이트 수
				while((read = bis.read(buffer)) > 0) {//원본 파일에서 읽은 바이트 수가 0이상인 동안 반복
					os.write(buffer, 0, read);//원본파일에서 읽은 데이터를 upload폴더의 파일에 출력
				}
			}catch(Exception e) {
				System.out.println("변경된 이미지 업로드 중 문제발생!");
			}finally {
				try {
					if(os != null) os.close();
				}catch(Exception e) {}
			}//업로드 종료
			items.setImagename(fileName);//Imagebbs의 파일이름을 새 파일이름으로 설정
		}
		//this.imageDao.updateImageBBS(imagebbs);//DB에서 이미지 게시글을 수정한다.
		this.itemsService.updateItem(items);
		
		 if (loginUser.getGrade() == 0) {     
	            return new ModelAndView("redirect:/items/itemlist.html");
	        } else {
	            return new ModelAndView("redirect:/items/myitemlist.html");
	        }
	}
	
	@GetMapping(value = "/items/codecheck.html")
	public ModelAndView idcheck(String item_code) {
		ModelAndView mav = new ModelAndView("mypage/codeCheckResult");
		Integer count = this.itemsService.checkDupCode(item_code);
		if(count > 0) {
			mav.addObject("DUP","YES");
		}else {
			mav.addObject("DUP","NO");
		}
		mav.addObject("item_code", item_code);
		return mav;
	}
	
	@GetMapping(value = "/items/userIdSearch.html") //회원 등급 검색
	public ModelAndView gradSearch(String user_id) {
		ModelAndView mav = new ModelAndView("index");
	    List<Items_tbl> Items = this.itemsService.userIdbyItemList(user_id);
		mav.addObject("BODY", "mypage/mypage.jsp");
		mav.addObject("CONTENT", "itemlist.jsp");
		mav.addObject("Items", Items);
	    return mav;
	}
}
