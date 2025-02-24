package com.springboot.wearwave.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.wearwave.mapper.SizeMapper;

@Service
public class SizeService {
    @Autowired
    private SizeMapper sizeMapper;

    public List<String> sizeList(String item_code) {
        return this.sizeMapper.sizeList(item_code);
    }
}

