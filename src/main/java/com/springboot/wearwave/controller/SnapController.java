package com.springboot.wearwave.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.User_info;
import com.springboot.wearwave.service.LoginService;
import com.springboot.wearwave.service.SnapService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
@Scope("session")
public class SnapController {
	@Autowired
	private SnapService snapService;
	@Autowired
	private LoginService loginService;
	
	
	@GetMapping("/snap/getPostDetail.html")
	@ResponseBody // JSON 데이터를 반환하도록 설정
	public Map<String, Object> getPostDetail(@RequestParam("postId") Integer postId) {
	    Map<String, Object> response = new HashMap<>();

	    Snap_post_detail postDetail = snapService.getPostDetailById(postId);
	    Snap_profile profileInfo = snapService.getNicknameByPost(postId);
	    List<Post_style_tags> styleTag = snapService.getAllStyleById(postId);
	    List<Post_tpo_tags> tpoTag = snapService.getAllTpoById(postId);

	    System.out.println("매핑데이터: " + postId);

	    if (postDetail == null) {
	        response.put("error", "게시물을 찾을 수 없습니다.");
	        return response; // JSON 형태로 에러 반환
	    }

	    // JSON 데이터 형태로 구성
	    response.put("imagename", postDetail.getImagename());
	    response.put("content", postDetail.getContent());
	    response.put("profile", profileInfo);

	    // 태그 배열 추가
	    response.put("style_tags", styleTag);
	    response.put("tpo_tags", tpoTag);

	    return response;
	}

/*    @GetMapping("/snap/getPostDetail.html")
    public String getPostDetail(@RequestParam("postId") Integer postId, Model model) {
        Snap_post_detail postDetail = snapService.getPostDetailById(postId);
        Snap_profile profileInfo = snapService.getNicknameByPost(postId);
        
        System.out.println("매핑데이터: "+postId);
        if (postDetail == null) {
            model.addAttribute("error", "게시물을 찾을 수 없습니다.");
            return "errorPage"; // 에러 페이지로 리다이렉트
        }

        model.addAttribute("postDetail", postDetail);
        model.addAttribute("nickname", profileInfo);

        return "snap_modal"; // 모달창 JSP 페이지
    }*/
	
/*    @GetMapping("/snap/getPostDetail.html")
    public ResponseEntity<?> getPostDetail(@RequestParam("postId") Integer postId) {
        Snap_post_detail postDetail = snapService.getPostDetailById(postId);

        System.out.println("매핑완료!" + postId + postDetail);
        if (postDetail == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("error", "게시물을 찾을 수 없습니다."));
        }

        // DTO 데이터를 JSON으로 반환
        Map<String, Object> response = new HashMap<>();
        response.put("postDetail", postDetail);
        response.put("styleTags", snapService.getAllStyleById(postId));
        response.put("tpoTags", snapService.getAllTpoById(postId));

        return ResponseEntity.ok(response);
    }*/
	
	
	
/*    @GetMapping("/snap/getPostDetail.html")
    public ModelAndView getPostDetail(@RequestParam("postId") Integer postId) {
        Snap_post_detail postDetail = snapService.getPostDetailById(postId);
        if (postDetail == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시물을 찾을 수 없습니다.");
        }
        ModelAndView mav = new ModelAndView("index");
	    List<Snap_post_detail> FeedList = this.snapService.getFeedAll();
		Snap_post_detail PostDetail = this.snapService.getPostDetailById(postId);
		Post_style_tags StyleTag = this.snapService.getAllStyleById(postId);
		Post_tpo_tags TpoTag = this.snapService.getAllTpoById(postId);
	    
		
	    mav.addObject("FeedList", FeedList);
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    mav.addObject("PostDetail", PostDetail);
	    mav.addObject("StyleTag", StyleTag);
        mav.addObject("TpoTag" ,TpoTag);
        
        return mav; 
    }*/
	
	
    //게시물작성 수행
	@PostMapping("/snap/addPostWrite.html")
	@Transactional
	public ModelAndView inputPost(
			@ModelAttribute("Posting") Snap_post_detail post,
            @RequestParam(value = "styleTags[]", required = false) List<String> styleTags,
            @RequestParam(value = "tpoTags[]", required = false) List<String> tpoTags,
            HttpSession session) {
		// post 전송 데이터
		//styleTags=casual&styleTags=retro
		//styleTags = ["casual", "retro"]
		
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
        if(loginUser == null) return new ModelAndView("redirect:/login/login.html");
	    List<MultipartFile> files = post.getFiles(); // 여러 개의 이미지 불러오기
	    List<String> savedFilePaths = new ArrayList<>();
	    
	    ServletContext ctx = session.getServletContext();
	    String userFolder = ctx.getRealPath("/imgs/snap/" + loginUser.getId() + "/");
	    
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
	                savedFilePaths.add("/imgs/snap/" + loginUser.getId() + "/" + fileName);
	            } catch (Exception e) {
	                System.out.println("파일 업로드 중 문제 발생: " + e.getMessage());
	            }
	        }
	    }
	    // 업로드한 이미지 경로 저장
	    post.setImagename(String.join(",", savedFilePaths)); // 여러 개의 이미지 경로를 쉼표로 구분하여 저장
        
        // 엔티티 저장
	    int maxId = this.snapService.getMaxPostId() + 1;
	    post.setPost_id(maxId);
        post.setUser_id(loginUser.getId());
        
        User_info name = (User_info)session.getAttribute("name");
        Snap_profile profile = this.snapService.getNicknameByUserId(loginUser.getId());
        
        //스냅프로필 테이블에 닉네임정보가 없는경우
        if(profile == null || profile.getNickname() == null) {
        	profile = new Snap_profile();
        	profile.setUser_id(loginUser.getId()); 
        	profile.setNickname(name.getName()); // user_info의 이름으로 닉네임 초기화
        	this.snapService.putNickname(profile); // 스냅프로필 테이블에 insert
        } 
        post.setProfile(profile);
        this.snapService.putFeedPost(post); //포스팅정보 insert
        
	    // 스타일태그 정보 저장
        if (styleTags != null) {
        	for (String styleTag : styleTags) {
        		if (styleTag != null && !styleTag.trim().isEmpty()) {
        			Post_style_tags styleData = new Post_style_tags();
        			styleData.setPost_id(maxId);
        			styleData.setStyle_tag(styleTag);
        			this.snapService.putStyleTag(styleData); //스타일태그정보 insert
        		}
        	}
        }
	    // TPO태그 정보 저장
        if(tpoTags != null) {
        	for (String tpoTag : tpoTags) {
        		if (tpoTag != null && !tpoTag.trim().isEmpty()) {
        			Post_tpo_tags tpoData = new Post_tpo_tags();
        			tpoData.setPost_id(maxId);
        			tpoData.setTpo_tag(tpoTag);
        			this.snapService.putTpoTag(tpoData); //TPO태그정보 insert
        		}
        	}
        }
        return new ModelAndView("redirect:/snap/postingContent.html");
	}
	
	// 게시물작성 페이지로 이동
	@GetMapping("/snap/addPostWrite.html")
	public ModelAndView postWrite() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "posting_write_page.jsp");
		mav.addObject("Posting", new Snap_post_detail()); //폼페이지로 이동전 객체추가
		return mav;
	}
	
	// 스냅네비 페이지 3가지(포스팅,저장,프로필)페이지
	@GetMapping("/snap/profileContent.html")
	public ModelAndView profile() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "profile_page.jsp");
		return mav;
	}
	@GetMapping("/snap/storedContent.html") //네비클릭
	public ModelAndView stored() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "stored_page.jsp");
		return mav;
	}
	@GetMapping("/snap/postingContent.html")
	public ModelAndView posting(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		List<Snap_post_detail> FeedList = this.snapService.getFeedAll();
//		List<Snapshot_board> FeedList = this.snapService.getFeedList();
//		session.setAttribute("FeedList", FeedList);
		
		mav.addObject("FeedList", FeedList);
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "posting_page.jsp");
		return mav;
	}
	
	//기본 스냅페이지 이동
	@GetMapping("/snap/snap.html") 
	public ModelAndView snap(HttpSession session) {
	    ModelAndView mav = new ModelAndView("index"); 
	    List<Snap_post_detail> FeedList = this.snapService.getFeedAll();
	    mav.addObject("FeedList", FeedList);
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    
	    LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    mav.addObject("loginUser", loginUser);
	    
	    return mav;
	}
}
