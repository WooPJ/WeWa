package com.springboot.wearwave.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Post_style_tags;
import com.springboot.wearwave.model.Post_tpo_tags;
import com.springboot.wearwave.model.Qna_bbs;
import com.springboot.wearwave.model.Snap_comment;
import com.springboot.wearwave.model.Snap_post_detail;
import com.springboot.wearwave.model.Snap_profile;
import com.springboot.wearwave.model.User_info;
import com.springboot.wearwave.service.ItemsService;
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
	private ItemsService itemsService;
	
	   // 게시물수정 수행
		@PostMapping("/snap/updatePost.html")
		@Transactional
		public ModelAndView UpdatePost(
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
		            // 업로드한 이미지 경로 저장
				    post.setImagename(String.join(",", savedFilePaths)); // 여러 개의 이미지 경로를 쉼표로 구분하여 저장
			        
		        }
		        else {
			        // 기존 값 유지 (현재 DB에 있는 값으로 설정)
		        	Snap_post_detail existingItem = snapService.getPostDetailByPostId(post.getPost_id());
			        if (existingItem != null) {
			        	post.setImagename(existingItem.getImagename());
			        }
			    }
		    }
		   
	        User_info userInfo = (User_info)session.getAttribute("userInfo");
	        Snap_profile profile = this.snapService.getProfileByUserId(loginUser.getId());
	        
	        //스냅프로필에 해당ID의 프로필정보나 닉네임이 없는경우
	        if(profile == null || profile.getNickname() == null) {
	        	profile = new Snap_profile();
	        	profile.setUser_id(loginUser.getId()); 
	        	profile.setNickname(userInfo.getName()); // user_info의 이름으로 닉네임 초기화
	        	this.snapService.putNickname(profile); // 스냅프로필 테이블에 insert
	        } 
	        post.setPost_id(post.getPost_id());
	        post.setProfile(profile);
	        this.snapService.updateFeedPost(post); //포스팅정보 update
	        
	        this.snapService.deleteStyle(post.getPost_id());
	        this.snapService.deleteTpo(post.getPost_id());
	        
		    // 스타일태그 정보 저장
	        if (styleTags != null) {
	        	for (String styleTag : styleTags) {
	        		if (styleTag != null && !styleTag.trim().isEmpty()) {
	        			Post_style_tags styleData = new Post_style_tags();
	        			styleData.setPost_id(post.getPost_id());
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
	        			tpoData.setPost_id(post.getPost_id());
	        			tpoData.setTpo_tag(tpoTag);
	        			this.snapService.putTpoTag(tpoData); //TPO태그정보 insert
	        		}
	        	}
	        }
	        return new ModelAndView("redirect:/snap/postingContent.html");
		}
		// 게시물수정 페이지로 이동
		@GetMapping("/snap/postUpdate.html")
		public ModelAndView postUpdate(@RequestParam("postId") Integer post_id) {
			ModelAndView mav = new ModelAndView("index");
			Snap_post_detail Posting = snapService.getPostDetailByPostId(post_id);
			List<String> tpo = snapService.getTpoById(post_id);
			List<String> style = snapService.getStyleById(post_id);
			mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
			mav.addObject("CONTENT", "posting_update_page.jsp");
			mav.addObject("style", style);
			mav.addObject("tpo",tpo);
			mav.addObject("Posting", Posting); //폼페이지로 이동전 객체추가

			return mav;
		}

	//게시글 삭제
	@PostMapping("/snap/deletePost.html")
	@ResponseBody
	public Map<String, Object> deletePost(@RequestParam("postId") Integer postId) {
        Map<String, Object> response = new HashMap<>();
        this.snapService.deletePost(postId);
        response.put("success", true);
        return response;
    }

	//닉네임 중복검사 수행
	@GetMapping("/snap/nicknameCheck.html")
	@Transactional
	public ModelAndView nicknameCheck(String nickname) {
		ModelAndView mav = new ModelAndView("snap/nicknameCheckResult");
		Integer nickDuplicate = this.snapService.duplicateNickname(nickname);
		Integer nickLength = this.snapService.lengthNickname(nickname);
		
		if(nickDuplicate > 0) {//이미 계정이 존재하는 경우, 즉 계정 중복
			mav.addObject("DUP","useNo_duplicate");
			
		}else {//계정이 존재하지 않는 경우, 즉 사용 가능
			if(nickLength == null) {
				mav.addObject("DUP","useNo_length_null"); //빈칸
			} else if(nickLength > 20) {
				mav.addObject("DUP","useNo_length_over"); //길이가 범위를 벗어남
			} else {
				mav.addObject("DUP","useYes"); //사용가능
			}
		}
		mav.addObject("NICKNAME", nickname);
		return mav;
	}
	
	
	//프로필편집 수행
	@PostMapping("/snap/editProfile.html")
	public ModelAndView editDoProfile(
			@ModelAttribute("EditProfile") Snap_profile profile, 
	        @RequestParam("files") MultipartFile file,
	        HttpSession session) {
		
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		if(loginUser == null) {
			ModelAndView mav = new ModelAndView("index");
	    	mav.addObject("EditProfile", new Snap_profile());
	        mav.addObject("error", "로그인이 필요합니다."); // 에러 메시지 추가
	        return mav;
		}
		
		try {
			profile.setUser_id(loginUser.getId()); //계정정보 할당
			
			// 📂저장 경로 설정
		    ServletContext ctx = session.getServletContext();
		    String userFolder = ctx.getRealPath("/imgs/snap/" + loginUser.getId() + "/");
		    
		    File dir = new File(userFolder);
		    if (!dir.exists()) {
		    	dir.mkdirs(); // 폴더가 없으면 생성
		    }
		    
		    // 기존 프로필 이미지 삭제 로직 
		    Snap_profile existingProfile = this.snapService.getProfileByUserId(loginUser.getId()); // 기존 데이터 조회
		    String currentProfileImg = existingProfile != null ? existingProfile.getProfile_img() : null;
		    if (currentProfileImg != null && !currentProfileImg.isEmpty()) {
		        File oldFile = new File(ctx.getRealPath(currentProfileImg));
		        if (oldFile.exists()) {
		            oldFile.delete(); // 기존 파일 삭제
		        }
		    }
		    
	        if (!file.isEmpty()) {
	        	String originalFileName = file.getOriginalFilename();
	        	String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자 추출
	           
	            // 중복되지 않는 파일명 생성
	            String newFileName;
	            File newFile;
	            do {
	            	String shortUUID = UUID.randomUUID().toString().substring(0, 8); // UUID 앞 8자리만 사용
	            	newFileName = shortUUID + fileExtension; // UUID + 확장자만 남기고 파일명 제거
	            	newFile = new File(userFolder + newFileName);
	            	
	            } while (newFile.exists()); // 중복체크 (파일명이 존재하면 파일명 새로생성)
//	            String filePath = userFolder + newFileName;
	            
	        	// 📂파일저장
	            try (OutputStream os = new FileOutputStream(newFile);
	                 BufferedInputStream bis = new BufferedInputStream(file.getInputStream())) {
	                
	                byte[] buffer = new byte[8192]; // 8K 크기
	                int read;
	                while ((read = bis.read(buffer)) > 0) {
	                    os.write(buffer, 0, read);
	                }
	                // 이미지 경로 저장
	                profile.setProfile_img("/imgs/snap/" + loginUser.getId() + "/" + newFileName);
	                
	            } catch (Exception e) {
	                System.out.println("파일 업로드 중 문제 발생: " + e.getMessage());
	            }
	        }
			this.snapService.updateProfile(profile);
			return new ModelAndView("redirect:/snap/profileContent.html");
					
		} catch(Exception e) {
			e.printStackTrace(); //에러 상세메세지
			ModelAndView mav = new ModelAndView("index");
			mav.addObject("BODY", "snap/snap.jsp");
			mav.addObject("CONTENT", "edit_profile_page.jsp"); //프로필편집 페이지 유지
			mav.addObject("error", "프로필편집 저장 중 오류가 발생했습니다.");
			return mav;
		}
	}
	
	// 프로필편집 페이지로 이동
	@GetMapping("/snap/editProfile.html")
	public ModelAndView editProfile(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "edit_profile_page.jsp");
		
		// 로그인예외처리:  사용자확인 (세션에서 사용자 정보 확인) 
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    if (loginUser == null) {
	    	mav.addObject("EditProfile", new Snap_profile());
	        mav.addObject("error", "로그인이 필요합니다."); // 에러 메시지 추가
	        return mav;
	    }
		Snap_profile profile = this.snapService.getProfileByUserId(loginUser.getId());
		
		//스냅프로필에 해당ID의 프로필정보가 없는경우
        if(profile == null) {
        	profile = new Snap_profile();
        	profile.setUser_id(loginUser.getId()); 
        }
		mav.addObject("EditProfile", profile); //폼페이지로 이동전 객체추가
		return mav;
	}
	
	// 댓글 삭제
	@PostMapping("/snap/deleteComment")
	@Transactional
	@ResponseBody
	public Map<String, Object> deleteComment(@RequestParam("commentNo") Integer commentNo,
	                                        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    // 로그인예외처리: 사용자확인 (세션에서 사용자 정보 확인)
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        response.put("error", "로그인이 필요합니다.");
	        return response;
	    }
	    try {
	        // 댓글 존재여부 확인
	        Snap_comment comment = this.snapService.getCommentByNo(commentNo);
	        if (comment == null) {
	            response.put("error", "해당 댓글이 존재하지 않습니다.");
	            return response;
	        }
	        this.snapService.deleteComment(commentNo); // 댓글 삭제 실행
	        response.put("success", true);
	        return response;

	    } catch(Exception e) {
	        e.printStackTrace();
	        response.put("error", "댓글 삭제에 실패했습니다.");
	        return response;
	    }
	}
	
	
	// 댓글업로드
	@PostMapping("/snap/addComment")
	@Transactional
	@ResponseBody
	public Map<String, Object> addComment(@RequestParam("postId") Integer postId,
	                                      @RequestParam("commentContent") String commentContent,
	                                      HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    // 로그인예외처리: 사용자확인 (세션에서 사용자 정보 확인)
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        response.put("error", "로그인이 필요합니다.");
	        return response;
	    }

	    try {
		    // 댓글 객체 생성 및 데이터 삽입
		    Snap_comment newComment = new Snap_comment();
		    newComment.setPost_id(postId);
		    newComment.setWriter_id(loginUser.getId()); // 로그인 사용자 ID 추가
		    newComment.setContent(commentContent);
	
	        User_info userInfo = (User_info)session.getAttribute("userInfo");
	        Snap_profile profile = this.snapService.getProfileByUserId(loginUser.getId());
	        
	        //스냅프로필에 해당ID의 프로필정보나 닉네임이 없는경우
	        if(profile == null || profile.getNickname() == null) {
	        	profile = new Snap_profile();
	        	profile.setUser_id(loginUser.getId()); 
	        	profile.setNickname(userInfo.getName()); // user_info의 이름으로 닉네임 초기화
	        	this.snapService.putNickname(profile); // 스냅프로필 테이블에 insert
	        } 
	        this.snapService.putComment(newComment); //댓글정보 insert
	        return response;
	        
	    } catch(Exception e){
	    	e.printStackTrace();
	    	//System.out.println("댓글작성중 문제발생: "+e);
	    	response.put("error", "댓글 작성에 실패했습니다.");
	    	return response;
	    }
	}
	
	
	//📌 게시물 클릭시 게시물 모달창 띄우기
	@GetMapping("/snap/getPostDetail.html")
	@ResponseBody // JSON 데이터를 반환하도록 설정
	public Map<String, Object> getPostDetail(@RequestParam("postId") Integer postId) {
	    Map<String, Object> response = new HashMap<>();

	    Snap_post_detail postInfo = snapService.getPostDetailByPostId(postId);
	    List<Post_style_tags> styleTag = snapService.getAllStyleById(postId);
	    List<Post_tpo_tags> tpoTag = snapService.getAllTpoById(postId);
	    List<Snap_comment> comment = snapService.getCommentList(postId);
	    
	    if (postInfo == null) {
	        response.put("error", "서버응답: 게시물을 찾을 수 없습니다.");
	        return response; // JSON 형태로 에러 반환
	    }
	    String itemCode = postInfo.getItem_code();
	    System.out.println("상품코드: " + itemCode); // 디버깅 로그

	    Items_tbl item = null; // 기본값 설정
	    if (itemCode != null && !itemCode.isEmpty()) { // NULL 체크 추가
	        item = itemsService.getMyItem(itemCode);
	    }
	  
	    		
	    // JSON 데이터 형태로 구성
	    response.put("postInfo", postInfo);
	    // 태그,댓글 배열 추가
	    response.put("style_tags", styleTag);
	    response.put("tpo_tags", tpoTag);
	    response.put("comments", comment);
	    response.put("related_products", (item != null) ? item : null);
	    return response;
	}
	
	
    // 게시물작성 수행
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
        
        User_info userInfo = (User_info)session.getAttribute("userInfo");
        Snap_profile profile = this.snapService.getProfileByUserId(loginUser.getId());
        
        //스냅프로필에 해당ID의 프로필정보나 닉네임이 없는경우
        if(profile == null || profile.getNickname() == null) {
        	profile = new Snap_profile();
        	profile.setUser_id(loginUser.getId()); 
        	profile.setNickname(userInfo.getName()); // user_info의 이름으로 닉네임 초기화
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
	
	
	// ====== 스냅네비 페이지 3가지(포스팅,저장,프로필)페이지 이동 ======
	// 3.프로필페이지
	@GetMapping("/snap/profileContent.html") 
	public ModelAndView profile(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
 
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		//로그인 풀린경우 예외처리
	    if (loginUser == null) { 
	    	mav.addObject("EditProfile", new Snap_profile());
			mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
			mav.addObject("CONTENT", "profile_page.jsp");
	        return mav;
	    }
		User_info userInfo = (User_info)session.getAttribute("userInfo");
        Snap_profile profile = this.snapService.getProfileByUserId(loginUser.getId());
        
		//스냅프로필에 해당ID의 프로필정보나 닉네임이 없는경우
        if(profile == null || profile.getNickname() == null) {
        	profile = new Snap_profile();
        	profile.setUser_id(loginUser.getId()); 
        	profile.setNickname(userInfo.getName()); // user_info의 이름으로 닉네임 초기화
        	this.snapService.putNickname(profile); // 스냅프로필 테이블에 insert
        } 
        //성별정보
        String putGenderName = "";
        if(profile.getGender() != null) {
        	switch (profile.getGender()){
	        	case "male": putGenderName = "남성"; break;
	        	case "female": putGenderName = "여성"; break;
	        	case "private": putGenderName = "비공개"; break;
        	}
        	profile.setGender(putGenderName);
        }
        
        //해당ID가 작성한 게시물수 조회결과 할당
        profile.setCountPostNum(this.snapService.getCountPostByUserId(loginUser.getId())); 
        List<Snap_post_detail> FeedList = this.snapService.getMyFeedAll(loginUser.getId());
       
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "profile_page.jsp");
		mav.addObject("FeedList", FeedList); //게시물정보 객체주입
		mav.addObject("EditProfile", profile); //프로필정보 객체주입
		mav.addObject("CONTENT2", "posting_page.jsp");
		return mav;
	}
	// 2.저장페이지
	@GetMapping("/snap/storedContent.html") 
	public ModelAndView stored() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "snap/snap.jsp"); // snap.jsp 포함 (네비게이션 유지)
		mav.addObject("CONTENT", "stored_page.jsp");
		return mav;
	}
	// 1.포스팅페이지
	@GetMapping("/snap/postingContent.html") 
	public ModelAndView posting(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		List<Snap_post_detail> FeedList = this.snapService.getFeedAll();
		
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

	//작성한 게시글 보기
	@GetMapping("/snap/mysnap.html") 
	public ModelAndView mysnap(HttpSession session) {
	    ModelAndView mav = new ModelAndView("index"); 
	    LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    List<Snap_post_detail> FeedList = this.snapService.getMyFeedAll(loginUser.getId());
	    mav.addObject("FeedList", FeedList);
	    mav.addObject("BODY", "snap/snap.jsp"); 
	    
	    
	    mav.addObject("loginUser", loginUser);
	    return mav;
	}
}
