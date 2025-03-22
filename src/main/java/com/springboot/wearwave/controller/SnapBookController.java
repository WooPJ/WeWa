package com.springboot.wearwave.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.wearwave.model.Snap_bookmark;
import com.springboot.wearwave.service.SnapService;

@RestController
@RequestMapping("/snap")
public class SnapBookController {
	@Autowired
	private SnapService snapService;
	
	
    @GetMapping("/getBookmarkStatus")
    public Map<String, Boolean> getBookmarkStatus(@RequestParam("postId") int postId, 
                                                   @RequestParam("userId") String userId) {
    	Snap_bookmark bookmark = new Snap_bookmark();
    	bookmark.setPost_id(postId);
    	bookmark.setUser_id(userId);
    	
    	boolean isBookmarked = false;
    	Integer count = snapService.getIsBookmarked(bookmark);
    	if(count > 0) isBookmarked = true; //북마크정보 있으면 
    	
        return Map.of("isBookmarked", isBookmarked);
    }
	
    @PostMapping("/toggleBookmark")
    public ResponseEntity<?> toggleBookmark(@RequestParam("postId") Integer postId,
                                             @RequestParam("userId") String userId,
                                             @RequestParam("action") String action) {
    	Snap_bookmark bookmark = new Snap_bookmark();

    	if ("add".equalsIgnoreCase(action)) {
        	bookmark.setPost_id(postId);
        	bookmark.setUser_id(userId);
        	snapService.putBookmark(bookmark);
            return ResponseEntity.ok(Map.of("status", "added"));
            
        } else if ("remove".equalsIgnoreCase(action)) {
        	bookmark.setPost_id(postId);
        	bookmark.setUser_id(userId);
        	snapService.deleteBookmark(bookmark);
            return ResponseEntity.ok(Map.of("status", "removed"));
        }
        return ResponseEntity.badRequest().body("Invalid action");
    }
}
