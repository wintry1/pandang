package com.study.springboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.AdminDAO;
import com.study.springboot.dao.BookmarkDAO;
import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.BookmarkDTO;
import com.study.springboot.dto.FilesDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyController {
	
	@Autowired
	ProductDAO productDao;
	@Autowired
	FilesDAO filesDao;
	@Autowired
	BookmarkDAO bookmarkDao;
	@Autowired
	UserDAO userDao;
	
	@RequestMapping("/")
	public String root(Model model) throws Exception{

		return "redirect:list";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/bookmark")
    public ResponseEntity<String> pbookmark(@RequestParam int product_seq, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int user_seq = (int)session.getAttribute("user_seq");
		
        BookmarkDTO bookmark = bookmarkDao.selectDao(user_seq, product_seq);
        System.out.println(bookmark);
        if (bookmark != null) {
        	bookmarkDao.deleteDao(user_seq, product_seq); // 북마크가 있으면 삭제
        	return ResponseEntity.ok("dislike");
        } else {
        	bookmarkDao.insertDao(user_seq, product_seq); // 북마크가 없으면 추가
        	return ResponseEntity.ok("북마크 토글 성공");
        }
    }
	
	@RequestMapping("/modifyProfile")
	public String modifyProfile() {
		
		return "modifyProfile";
	}
	
	@RequestMapping("/message")
	public String message() {
		
		return "message";
	}
	
	@RequestMapping("/alarm_list")
	public String alarm_list() {
		
		return "alarm_list";
	}
	@RequestMapping("/test_chat")
	public String test_chat() {
		
		return "test_chat";
	}
	
	@RequestMapping("/test_review")
	public String test_review() {
		
		return "test_review";
	}

}