package com.study.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.AdminDAO;
import com.study.springboot.dao.NoticeDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.ReviewDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.oauth2.SessionUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	ReviewDAO reviewDao;
	
	@Autowired
	NoticeDAO noticeDao;
	
	@Autowired
	ProductDAO pDao;
	
	@Autowired
	AdminDAO adDao;

	
	@RequestMapping(value = "/review", method=RequestMethod.POST)
	public String showReviewForm(HttpServletRequest request, Model model) {
		return "Profile";
	}
	
	@RequestMapping("/user_review")
	public String viewReview(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		SessionUser user = (SessionUser) session.getAttribute("user");

		return "redirect:profile";
	}
	
	@RequestMapping("/save_review")
	public String insertReview(HttpServletRequest request,
	                            @RequestParam(name = "score") int score,
	                            @RequestParam(name = "reviewText") String reviewText, 
	        					@RequestParam("product_seq") int product_seq) {
	    System.out.println("score: " + score);
	    System.out.println("reviewText: " + reviewText);

		System.out.println(score);
		System.out.println(reviewText);
		ProductDTO productlist = pDao.selectDao1(product_seq);
		int sell_seq = productlist.getUser_seq();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("param1", product_seq);
		map.put("param2", sell_seq);
		map.put("param3", reviewText);
		
		reviewDao.reviewInsert(map);
		
		//점수 업데이트
		userDao.updateUserScore(score, sell_seq);
	
		//알림리스트에서 삭제
		noticeDao.noticeDeleteDao(product_seq);
		
		return "mainhome";
	}
	
	@RequestMapping("/seller_review")
	public String insertSellerReview(HttpServletRequest request,
	                            @RequestParam(name = "score") int score,
	                            @RequestParam(name = "reviewText") String reviewText, 
	                            @RequestParam("user_seq") int user_seq,
	        					@RequestParam("product_seq") int product_seq) {
		HttpSession session = request.getSession();
	    System.out.println("score: " + score);
	    System.out.println("reviewText: " + reviewText);
		
	    // REVIEW table insert!	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("param1", product_seq);
		map.put("param2", user_seq);
		map.put("param3", reviewText);

		reviewDao.reviewInsert(map);

		// PRODUCT table (prd_use) update!
		String prd_use = "S";

		pDao.updatePrd(prd_use, product_seq);

		// USERS table (user_grade) update!		
		userDao.updateUserScore(score, user_seq);

		// NOTICE table insert!		
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("item1", String.valueOf(user_seq));
		map2.put("item2", String.valueOf(product_seq));
		
		noticeDao.noticeInsert(map2);
		
		session.setAttribute("product_seq", 0);
		
		return "viewProfile";
	}	
}
