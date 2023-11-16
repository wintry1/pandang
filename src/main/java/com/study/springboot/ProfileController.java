package com.study.springboot;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.ProfileDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.BookmarkDTO;
import com.study.springboot.dto.FilesDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.ReviewDTO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProfileController {
	
	@Autowired
	ProfileDAO pfdao;
	@Autowired
	ProductDAO pdao;
	@Autowired
	FilesDAO fdao;
	@Autowired
	UserDAO udao;

	@RequestMapping("/Profile")
	public String viewProfile(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		int user_seq = (int)session.getAttribute("user_seq");
		System.out.println("user_seq at ProfileCont : " + user_seq);
		
		UserDTO user1 = udao.viewUser(user_seq);
		int temp = user1.getUser_grade();
		model.addAttribute("temp", temp);
		System.out.println("temp : " + temp);
		
		List<ProductDTO> soldList = pfdao.listSproduct(user_seq);
		for (ProductDTO product : soldList) {
		    int productSeq = product.getProduct_seq();
		    String prdStatus = product.getPrd_use();
			String product_status = "판매중";
			if (prdStatus == "R") {product_status = "예약중";}
			else if (prdStatus == "S") {product_status = "판매완료";}
			product.setPrd_use(product_status);
			System.out.println(product_status);
			
		    FilesDTO filesDTO = fdao.viewDao(productSeq);
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    System.out.println(imageName);
		    product.setPrd_image(imageName);
		}
		model.addAttribute("soldList", soldList);

		List<ProductDTO> myproductList = pfdao.listMyproduct(user_seq);
		for (ProductDTO myproduct : myproductList) {
			int productSeq = myproduct.getProduct_seq();
			ReviewDTO reviewDTO = pfdao.showReview(productSeq);
			int reviewer_seq = reviewDTO.getUser_seq();
			String review_ctnt = reviewDTO.getReview_ctnt();
			myproduct.setRev_content(review_ctnt);
			String review_at = reviewDTO.getReview_at();
			myproduct.setRev_date(review_at);
						
			String reviewer_name = pfdao.getReviewerName(reviewer_seq); 
			myproduct.setRev_name(reviewer_name);
			String reviewer_addr = pfdao.getReviewerAddr(reviewer_seq);
			myproduct.setRev_addr(reviewer_addr);
			
			System.out.println(productSeq);
		    System.out.println(reviewer_name);
		    System.out.println(review_ctnt);
		    System.out.println(review_at);
		    System.out.println(reviewer_addr);
		}
		model.addAttribute("reviewList", myproductList);
		
		List<BookmarkDTO> bookmarkList = pfdao.listBookmark(user_seq);
		for (BookmarkDTO bookmark : bookmarkList) {
			int productSeq = bookmark.getProduct_seq();			
			ProductDTO bmproduct = pfdao.listBMproduct(productSeq);
			String book_title = bmproduct.getPrd_title();
			bookmark.setPrd_title(book_title);
			int book_price = bmproduct.getPrd_price();
			bookmark.setPrd_price(book_price);
			FilesDTO filesDTO = fdao.viewDao(productSeq);
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    bookmark.setPrd_image(imageName);			
		    
			System.out.println("productSeq : " + productSeq);
		    System.out.println("book_title : " + book_title);
		    System.out.println("book_price : " + book_price);
		    System.out.println("imageName : " + imageName);
		}
		model.addAttribute("bookmarkList", bookmarkList);
		return "/viewProfile";
	}	
}
