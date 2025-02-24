package com.springboot.wearwave.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.Item;
import com.springboot.wearwave.service.ColorService;
import com.springboot.wearwave.service.ItemService;
import com.springboot.wearwave.service.SizeService;

@Controller
public class ItemController {

    @Autowired
    private ItemService itemService;
    @Autowired
    private SizeService sizeService;
    @Autowired
    private ColorService colorService;

    @GetMapping(value = "/item/itemDetail.html")
    public ModelAndView itemDetail(@RequestParam("item_code") String item_code) {
        Item item = itemService.getItemCodePage(item_code);
        List<String> sizeList = sizeService.sizeList(item_code); // `size` 대신 `sizeList`
        List<String> colorList = colorService.colorList(item_code);
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("BODY", "item/itemDetail.jsp");
        mav.addObject("item", item);
        mav.addObject("sizeList", sizeList); // 변수명 수정
        mav.addObject("colorList", colorList);

        return mav;
    }
}