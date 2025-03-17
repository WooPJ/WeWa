package com.springboot.wearwave.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

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
	
	@GetMapping(value="/items/additems.html")  //상품 작성 폼 이동
	public ModelAndView additems() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "additems.jsp");
        mav.addObject("Items", new Items_tbl());
		return mav;
	}
	
	@PostMapping(value="/items/addItems.html") //상품 BD 주입
	@Transactional
	public ModelAndView inputItems(@ModelAttribute("Items") Items_tbl items, 
	                               @RequestParam("color[]") List<String> colors,
	                               @RequestParam("item_id") Integer item_id,
	                               @RequestParam("size[]") List<String> sizes,
	                               @RequestParam("quantity[]") List<Integer> quantities, 
	                               HttpSession session) {
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    List<MultipartFile> files = items.getFiles(); // 여러 개의 이미지 불러오기
	    List<String> savedFilePaths = new ArrayList<>();
	    
	    ServletContext ctx = session.getServletContext();
	    String userFolder = ctx.getRealPath("/imgs/item/" + loginUser.getId() + "/"); 
	    
	    File dir = new File(userFolder);
	    if (!dir.exists()) {
	        dir.mkdirs(); // 폴더가 없으면 생성
	    }

	    for (MultipartFile multipart : files) {
	        if (!multipart.isEmpty()) {
	            String fileName = multipart.getOriginalFilename();
	            String filePath = userFolder + fileName;
	            
	            try (OutputStream os = new FileOutputStream(filePath);
	                 BufferedInputStream bis = new BufferedInputStream(multipart.getInputStream())) {
	                
	                byte[] buffer = new byte[8192]; // 8K 크기
	                int read;
	                while ((read = bis.read(buffer)) > 0) {
	                    os.write(buffer, 0, read);
	                }
	                
	                savedFilePaths.add("/imgs/item/" + loginUser.getId() + "/" + fileName);
	            } catch (Exception e) {
	                System.out.println("파일 업로드 중 문제 발생: " + e.getMessage());
	            }
	        }
	    }
	    
	    // 업로드한 이미지 경로를 저장
	    items.setImagename(String.join(",", savedFilePaths)); // 여러 개의 이미지 경로를 쉼표로 구분하여 저장

	    int maxNum = this.itemsService.getMaxNum() + 1;
	    items.setItem_id(item_id);
	    items.setNum(maxNum);
	    items.setUser_id(loginUser.getId());
	    this.itemsService.putItems(items);

	    // 색상 정보 저장
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
	
	@GetMapping(value = "/items/itemlist.html") //admin의 상품 목록 출력
	public ModelAndView itemlist(@RequestParam(required = false, defaultValue = "all") String user_id) {
	    ModelAndView mav = new ModelAndView("index");

	    // 전체 상품 목록 가져오기
	    List<Items_tbl> Items = this.itemsService.getItemList();

	    // 중복 제거된 user_id 목록 생성
	    Set<String> userSet = Items.stream()
	                               .map(Items_tbl::getUser_id)  // user_id만 추출
	                               .collect(Collectors.toSet()); // 중복 제거된 Set으로 변환

	    // 모델에 데이터 추가
	    mav.addObject("Items", Items);
	    mav.addObject("userArray", userSet);  // 중복 제거된 user_id 목록
	    mav.addObject("selectedUserId", user_id);  // 현재 선택된 user_id 추가
	    mav.addObject("BODY", "mypage/mypage.jsp");
	    mav.addObject("CONTENT", "itemlist.jsp");

	    return mav;
	}

	
	@GetMapping(value="/items/myitemlist.html") //사업자의 상품 등록 목록 출력
	public ModelAndView myltemlist(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		List<Items_tbl> Items = this.itemsService.getMyItemList(loginUser.getId());	
        mav.addObject("Items",Items);
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "myItemList.jsp");
		return mav;
	}
	
	@PostMapping(value = "/items/deleteItem.html") //상품 삭제
	public ModelAndView deleteMyItem(String item_code, Integer num, HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		this.itemsService.deleteItem_size(item_code);
		this.itemsService.deleteItem_color(item_code);
		this.itemsService.deleteItem(item_code);
		this.itemsService.updateNum(num);
		
		 if (loginUser.getGrade() == 0) {     
	            return new ModelAndView("redirect:/items/itemlist.html"); //관리자일 때 상품 전체목록 이동
	        } else {
	            return new ModelAndView("redirect:/items/myitemlist.html"); //사업자일 때 자신의 상품 목록 이동
	        }
	}
	
	@PostMapping(value = "/items/updateItem.html") //상품 수정 폼 이동
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
	
	@PostMapping(value="/items/updateItemDo.html") //상품 수정 DB 적용
	public ModelAndView updateDo(
	        Items_tbl items, 
	        HttpSession session,  
	        @RequestParam(value="color[]", required=false) List<String> colors,
	        @RequestParam(value="size[]", required=false) List<String> sizes,
	        @RequestParam(value="quantity[]", required=false) List<Integer> quantities,
	        @RequestParam(value="file", required=false) List<MultipartFile> files,
	        @RequestParam(value="deleteImages", required=false) List<String> deleteImages) { // 삭제할 이미지 리스트 추가
	    
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    ServletContext ctx = session.getServletContext();
	    String userFolder = ctx.getRealPath("/imgs/item/" + loginUser.getId() + "/");

	    File dir = new File(userFolder);
	    if (!dir.exists()) {
	        dir.mkdirs(); // 폴더가 없으면 생성
	    }

	    // 기존 이미지 불러오기
	    Items_tbl existingItem = itemsService.getMyItem(items.getItem_code());
	    List<String> imagePaths = new ArrayList<>();

	    if (existingItem != null && existingItem.getImagename() != null) {
	        imagePaths.addAll(Arrays.asList(existingItem.getImagename().split(","))); // 기존 이미지 유지
	    }

	    // 🛑 삭제할 이미지 목록이 있으면 제거
	    if (deleteImages != null) {
	        imagePaths.removeAll(deleteImages);

	        // 실제 파일도 삭제
	        for (String deleteImage : deleteImages) {
	            File deleteFile = new File(ctx.getRealPath(deleteImage));
	            if (deleteFile.exists()) {
	                deleteFile.delete();
	            }
	        }
	    }

	    // 새로운 이미지 업로드
	    for (MultipartFile multipart : files) {
	        if (multipart != null && !multipart.isEmpty()) {
	            try {
	                String fileName = multipart.getOriginalFilename();
	                String filePath = userFolder + fileName;
	                multipart.transferTo(new File(filePath));

	                imagePaths.add("/imgs/item/" + loginUser.getId() + "/" + fileName);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    // 쉼표(,)로 구분된 이미지 경로를 저장
	    items.setImagename(String.join(",", imagePaths));

	    // 데이터 업데이트
	    this.itemsService.updateItem(items);

	    // 기존 색상 및 사이즈 삭제 후 재등록
	    itemsService.deleteItem_size(items.getItem_code());
	    itemsService.deleteItem_color(items.getItem_code());

	    for (String color : colors) {
	        if (color != null && !color.trim().isEmpty()) {
	            Item_color colorData = new Item_color();
	            colorData.setItem_code(items.getItem_code());
	            colorData.setItem_color(color);
	            this.itemsService.putColor(colorData);
	        }
	    }

	    for (int i = 0; i < sizes.size(); i++) {
	        if (sizes.get(i) != null && !sizes.get(i).trim().isEmpty() && quantities.get(i) > 0) {
	            Item_size sizeData = new Item_size();
	            sizeData.setItem_code(items.getItem_code());
	            sizeData.setItem_size(sizes.get(i));
	            sizeData.setQuantity(quantities.get(i));
	            this.itemsService.putSize(sizeData);
	        }
	    }

	    // 권한에 따라 리다이렉트
	    if (loginUser.getGrade() == 0) {
	        return new ModelAndView("redirect:/items/itemlist.html");
	    } else {
	        return new ModelAndView("redirect:/items/myitemlist.html");
	    }
	}


	@GetMapping(value = "/items/codecheck.html") //상품 코드 중복 체크
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
	
	@GetMapping(value = "/items/userIdSearch.html") //이름별로 목록 출력
	public ModelAndView userIdSearch(String user_id) {
		ModelAndView mav = new ModelAndView("index");
	    List<Items_tbl> Items = this.itemsService.userIdbyItemList(user_id);
		mav.addObject("BODY", "mypage/mypage.jsp");
		mav.addObject("CONTENT", "itemlist.jsp");
		mav.addObject("Items", Items);
	    return mav;
	}
}
