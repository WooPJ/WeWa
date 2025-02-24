package com.springboot.wearwave.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Item;
import com.springboot.wearwave.service.ItemService;

@Controller
public class ItemController {

    @Autowired
    private ItemService itemService;

    @GetMapping(value = "/item/itemDetail.html")
    public ModelAndView itemDetail(@RequestParam("item_id") Integer itemId) {
        Item item = itemService.getItemMainPage(itemId); // item_id를 사용하여 아이템 조회

        ModelAndView mav = new ModelAndView("index"); // 메인 뷰 이름
        mav.addObject("BODY", "item/itemDetail.jsp"); // JSP 파일 경로
        mav.addObject("item", item); // 아이템 객체를 모델에 추가
        return mav;
    }
}
