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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springboot.wearwave.model.Items_tbl;
import com.springboot.wearwave.model.LoginUser;
import com.springboot.wearwave.model.Qna_bbs;
import com.springboot.wearwave.model.Qna_comment;
import com.springboot.wearwave.service.ItemsService;
import com.springboot.wearwave.service.QnaService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class QnaController {
	@Autowired
	private QnaService qnaService;
	@Autowired
	private ItemsService itemsService;
	
	@GetMapping(value="/qna/qnaWrite.html")
	public ModelAndView writeform(@RequestParam(value = "item_code", required = false) String itemCode) {
	ModelAndView mav = new ModelAndView("index");
	    if (itemCode != null) {
	        mav.addObject("item_code", itemCode);  // item_code를 ModelAndView에 추가
	    }
	    mav.addObject("qnabbs", new Qna_bbs()); 
	    mav.addObject("BODY", "mypage/mypage.jsp");
	    mav.addObject("CONTENT", "qnaWriteForm.jsp");
	    return mav;
	}
	
	@GetMapping(value = "/qna/finditem_code.html")
	public ModelAndView findCode() {
		ModelAndView mav = new ModelAndView("mypage/findCode");
		List<Items_tbl> itemList = this.itemsService.getItemList();
		mav.addObject("Items", itemList);
		return mav;
	}
	
	@GetMapping(value = "/qna/finditem_codeResult.html")
	public ModelAndView findCodeResult(String NAME) {
		List<Items_tbl> itemList = this.itemsService.getItemByName(NAME);
		ModelAndView mav = new ModelAndView("mypage/findCodeResult");
		mav.addObject("Items", itemList);
		mav.addObject("NAME", NAME);
		return mav;
	}
	
	
	@PostMapping(value="/qna/write.html")
	public ModelAndView write(@Valid @ModelAttribute("qnabbs") Qna_bbs qnabbs,  
			 HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		MultipartFile multipart = qnabbs.getImage();//선택한 파일을 불러온다.
		System.out.println(qnabbs.getImage());
		if (multipart != null && !multipart.isEmpty()) {  // 파일이 업로드된 경우에만 처리
	        String fileName = multipart.getOriginalFilename();  // 선택한 파일의 이름을 찾는다.
	        ServletContext ctx = session.getServletContext();  // ServletContext 생성
	        String userFolder = ctx.getRealPath("/imgs/qna/" + loginUser.getId() + "/");
	        
	        File dir = new File(userFolder);
	        if (!dir.exists()) {
	            dir.mkdirs();  // 폴더가 없으면 생성
	        }
	        String path = userFolder + fileName;
	        try (OutputStream os = new FileOutputStream(path);
	             BufferedInputStream bis = new BufferedInputStream(multipart.getInputStream())) {
	             
	            byte[] buffer = new byte[8156];  // 8K 크기로 배열을 생성한다.
	            int read;
	            while ((read = bis.read(buffer)) > 0) {
	                os.write(buffer, 0, read);  // 생성된 파일에 출력
	            }
	            qnabbs.setImagename("/imgs/qna/"+ loginUser.getId() + "/"+fileName);
	        } catch (Exception e) {
	            // 로그를 사용하여 에러 처리
	            e.printStackTrace(); // 또는 logger.error("파일 업로드 중 오류 발생", e);
	            return new ModelAndView("redirect:/errorPage.html");  // 에러 페이지로 리다이렉트
	        }
	    } else {
	        // 파일이 업로드되지 않은 경우 처리
	        qnabbs.setImagename(""); 
	    }
		if (qnabbs.getItem_code() == null) {
		    qnabbs.setItem_code("");
		}
		int maxNum = this.qnaService.getMaxNum() + 1;
		qnabbs.setSeqno(maxNum);//글번호 설정
		qnabbs.setWriter(loginUser.getId());//작성자에 계정을 설정
		this.qnaService.putQna(qnabbs);
		return new ModelAndView("redirect:/mypage/qnalist.html");
	}
	
	@GetMapping("/qna/update.html")
	public ModelAndView update(@RequestParam("seqno") int seqno) {
	    Qna_bbs qnabbs = qnaService.getQnaDetail(seqno);
	    ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
        mav.addObject("CONTENT", "updateqna.jsp");
        mav.addObject("qnabbs", qnabbs);
        return mav;
	}
	
	@PostMapping("/qna/update.html")
	public ModelAndView updateQna(Qna_bbs qna_bbs, HttpSession session) {	
		 LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		 MultipartFile multiFile = qna_bbs.getImage();
		 if (multiFile != null && !multiFile.getOriginalFilename().equals("")) {
			 String fileName = multiFile.getOriginalFilename();  // 선택한 파일의 이름을 찾는다.
		        ServletContext ctx = session.getServletContext();  // ServletContext 생성
		        String userFolder = ctx.getRealPath("/imgs/qna/" + loginUser.getId() + "/");
		        
		        File dir = new File(userFolder);
		        if (!dir.exists()) {
		            dir.mkdirs();  // 폴더가 없으면 생성
		        }
		        String path = userFolder + fileName;
		        
		        try (OutputStream os = new FileOutputStream(path);
		             BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
		             
		            byte[] buffer = new byte[8156];  // 8K 크기로 배열을 생성한다.
		            int read;
		            while ((read = bis.read(buffer)) > 0) {
		                os.write(buffer, 0, read);  // 생성된 파일에 출력
		            }
		            qna_bbs.setImagename("/imgs/qna/"+ loginUser.getId() + "/"+fileName);
		        } catch (Exception e) {
		            // 로그를 사용하여 에러 처리
		            e.printStackTrace(); // 또는 logger.error("파일 업로드 중 오류 발생", e);
		            return new ModelAndView("redirect:/errorPage.html");  // 에러 페이지로 리다이렉트
		        }
		    } else {
		        // 기존 값 유지 (현재 DB에 있는 값으로 설정)
		    	
		        Qna_bbs existingItem = qnaService.getQnaDetail(qna_bbs.getSeqno());
		        if (existingItem != null) {
		            qna_bbs.setImagename(existingItem.getImagename());
		        }
		    }
		 	if (qna_bbs.getItem_code() == null) {
			    qna_bbs.setItem_code("");
		 	}
		 	if(qna_bbs.getImagename() == null){
	    		qna_bbs.setImagename("");
	    	}
		 this.qnaService.updateQna(qna_bbs);
		 return new ModelAndView("redirect:/mypage/qnalist.html");
	}
	
	@GetMapping("/qna/delete.html")
	public ModelAndView deleteQna(@RequestParam("seqno") int seqno) {
	    this.qnaService.deleteQna(seqno);
	    this.qnaService.updateseqno(seqno);
		return new ModelAndView("redirect:/mypage/qnalist.html");
	}
	
	@GetMapping(value="/qna/readqna.html")
	public ModelAndView readqna(Integer seqno) {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY", "mypage/mypage.jsp");
		Qna_bbs qnabbs = this.qnaService.getQnaDetail(seqno);
		String itemName = qnaService.getItemTitleByCode(qnabbs.getItem_code());
		List<Qna_comment> comList = this.qnaService.getCommentsByQnaSeqno(seqno);
		mav.addObject("comment",comList);
		mav.addObject("qnabbs",qnabbs);
		mav.addObject("itemName", itemName);
		mav.addObject("CONTENT", "qnaDetail.jsp");
		return mav;
	}
	
	@PostMapping(value = "/qna/addComment.html")
	public ModelAndView addComment(@RequestParam int qna_seqno,
            @RequestParam String content, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		Qna_comment com = new Qna_comment();
		int maxNum = this.qnaService.getMaxSeq() + 1;
		com.setComment_no(maxNum);
		com.setQna_seqno(qna_seqno);
		com.setParent_id(0);
		com.setWriter(loginUser.getId());
		com.setContent(content);
		qnaService.addComment(com);
		return new ModelAndView("redirect:/qna/readqna.html?seqno=" + qna_seqno);
	}
	
	@PostMapping("/qna/updateComment.html")
	public ModelAndView updateComment(@RequestParam("comment_no") int comment_no,
	                                  @RequestParam("content") String content, 
	                                  @RequestParam("qna_seqno") int qna_seqno) {
	    // 댓글 정보 가져오기
	    Qna_comment comment = qnaService.getComment(comment_no);   
	    // 댓글 내용 수정
	    comment.setContent(content);
	    // 수정된 댓글 저장
	    qnaService.updateComment(comment);
	    // 수정 후 해당 게시글의 상세 페이지로 리다이렉트
	    return new ModelAndView("redirect:/qna/readqna.html?seqno=" + qna_seqno);
	}

	    // 댓글 삭제 처리
	    @PostMapping("/qna/deleteComment.html")
	    public ModelAndView deleteComment(@RequestParam("comment_no") int comment_no, @RequestParam int qna_seqno) {
	    	this.qnaService.deleteComment(comment_no);
	    	return new ModelAndView("redirect:/qna/readqna.html?seqno=" + qna_seqno);
	    }
	    
}
