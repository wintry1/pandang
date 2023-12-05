package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.ChatRoomDAO;
import com.study.springboot.dao.FilesDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.ProfileDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.BookmarkDTO;
import com.study.springboot.dto.ChatRoomDTO;
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
	@Autowired
	ChatRoomDAO crdao;	

	@RequestMapping("/Profile")
	public String viewProfile(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int user_seq = (int)session.getAttribute("user_seq");
		System.out.println("user_seq at Profile1 : " + user_seq);
		
		Integer pSeq = (Integer)session.getAttribute("product_seq");
		if (pSeq == null) pSeq = 0;
		session.setAttribute("product_seq", pSeq);
		model.addAttribute("product_seq", pSeq);
		System.out.println("product_seq at Profile1 : " + pSeq);
		
		String user_name = udao.username(user_seq);
		System.out.println("user_name at Profile1 : " + user_name);
		session.setAttribute("user_name", user_name);	
		
		UserDTO user1 = udao.viewUser(user_seq);
		System.out.println("user1 at Profile1 : " + user1);
		int temp = user1.getUser_grade();
		String address = user1.getUser_address();
		System.out.println("temp at Profile1 : " + temp);
		model.addAttribute("temp", temp);
		model.addAttribute("address", address);
		
		List<ProductDTO> sellList = pfdao.listSproduct(user_seq);
		for (ProductDTO product : sellList) {
		    int productSeq = product.getProduct_seq();
		    String prdStatus = product.getPrd_use();
			String product_status = "판매중";
			if (prdStatus.equals("R")) {product_status = "예약중";}
			else if (prdStatus.equals("S")) {product_status = "판매완료";}
			product.setPrd_use(product_status);
			
		    FilesDTO filesDTO = fdao.viewDao(productSeq);	
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    product.setPrd_image(imageName);
		}
		model.addAttribute("sellList", sellList);

		List<ProductDTO> myproductList = pfdao.listMyproduct(user_seq);
		for (ProductDTO myproduct : myproductList) {
			int productSeq = myproduct.getProduct_seq();
			ReviewDTO reviewDTO = pfdao.showReview(productSeq);
			if (reviewDTO != null) {
				int reviewer_seq = reviewDTO.getUser_seq();
				String review_ctnt = reviewDTO.getReview_ctnt();
				myproduct.setRev_content(review_ctnt);
				String review_at = reviewDTO.getReview_at();
				myproduct.setRev_date(review_at);String reviewer_name = pfdao.getReviewerName(reviewer_seq); 
				myproduct.setRev_name(reviewer_name);
				String reviewer_addr = pfdao.getReviewerAddr(reviewer_seq);
				myproduct.setRev_addr(reviewer_addr);
			} 			
		}
		model.addAttribute("reviewList", myproductList);
		
		List<BookmarkDTO> bookmarkList = pfdao.listBookmark(user_seq);
		for (BookmarkDTO bookmark : bookmarkList) {
			int productSeq = bookmark.getProduct_seq();			
			ProductDTO bmproduct = pfdao.listBMproduct(productSeq);
			if (bmproduct != null) {
				String prdStatus = bmproduct.getPrd_use();
				String product_status = "판매중";
				if (prdStatus.equals("R")) {product_status = "예약중";}
				else if (prdStatus.equals("S")) {product_status = "판매완료";}
				bookmark.setPrd_use(product_status);
				
				String book_title = bmproduct.getPrd_title();
				bookmark.setPrd_title(book_title);
				int book_price = bmproduct.getPrd_price();
				bookmark.setPrd_price(book_price);
				FilesDTO filesDTO = fdao.viewDao(productSeq);
			    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
			    bookmark.setPrd_image(imageName);			
			} 			
		}
		model.addAttribute("bookmarkList", bookmarkList);
		
		return "viewProfile";
	}
	
	@RequestMapping("/Profile2")
	public String viewProfile2(@RequestParam("user_Seq") String user_Seq, HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		
		int user_seq = 0;
		String str = request.getParameter("user_Seq");
    	try{
    		user_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
		System.out.println("user_seq at Profile2 : " + user_seq);
		
		HttpSession session = request.getSession();
		Integer pSeq = (Integer)session.getAttribute("product_seq");
		if (pSeq == null) pSeq = 0;
		session.setAttribute("product_seq", pSeq);
		model.addAttribute("product_seq", pSeq);
		System.out.println("product_seq at Profile2 : " + pSeq);
		
		String user_name = udao.username(user_seq);
		System.out.println("user_name at Profile2 : " + user_name);
		session.setAttribute("user_name", user_name);	
		
		UserDTO user2 = udao.viewUser(user_seq);
		System.out.println("user2 at Profile2 : " + user2);
		int temp = user2.getUser_grade();
		String address = user2.getUser_address();
		System.out.println("temp at Profile2 : " + temp);
		model.addAttribute("temp", temp);
		model.addAttribute("address", address);
		
		List<ProductDTO> sellList = pfdao.listSproduct(user_seq);
		for (ProductDTO product : sellList) {
		    int productSeq = product.getProduct_seq();
		    String prdStatus = product.getPrd_use();
			String product_status = "판매중";
			if (prdStatus.equals("R")) {product_status = "예약중";}
			else if (prdStatus.equals("S")) {product_status = "판매완료";}
			product.setPrd_use(product_status);
			
		    FilesDTO filesDTO = fdao.viewDao(productSeq);	
		    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
		    product.setPrd_image(imageName);
		}
		model.addAttribute("sellList", sellList);

		List<ProductDTO> myproductList = pfdao.listMyproduct(user_seq);
		for (ProductDTO myproduct : myproductList) {
			int productSeq = myproduct.getProduct_seq();
			ReviewDTO reviewDTO = pfdao.showReview(productSeq);
			if (reviewDTO != null) {
				int reviewer_seq = reviewDTO.getUser_seq();
				String review_ctnt = reviewDTO.getReview_ctnt();
				myproduct.setRev_content(review_ctnt);
				String review_at = reviewDTO.getReview_at();
				myproduct.setRev_date(review_at);String reviewer_name = pfdao.getReviewerName(reviewer_seq); 
				myproduct.setRev_name(reviewer_name);
				String reviewer_addr = pfdao.getReviewerAddr(reviewer_seq);
				myproduct.setRev_addr(reviewer_addr);
			} 			
		}
		model.addAttribute("reviewList", myproductList);
		
		List<BookmarkDTO> bookmarkList = pfdao.listBookmark(user_seq);
		for (BookmarkDTO bookmark : bookmarkList) {
			int productSeq = bookmark.getProduct_seq();			
			ProductDTO bmproduct = pfdao.listBMproduct(productSeq);
			if (bmproduct != null) {
				String prdStatus = bmproduct.getPrd_use();
				String product_status = "판매중";
				if (prdStatus.equals("R")) {product_status = "예약중";}
				else if (prdStatus.equals("S")) {product_status = "판매완료";}
				bookmark.setPrd_use(product_status);
				
				String book_title = bmproduct.getPrd_title();
				bookmark.setPrd_title(book_title);
				int book_price = bmproduct.getPrd_price();
				bookmark.setPrd_price(book_price);
				FilesDTO filesDTO = fdao.viewDao(productSeq);
			    String imageName = (filesDTO != null) ? filesDTO.getFilesName() : null;
			    bookmark.setPrd_image(imageName);			
			} 			
		}
		model.addAttribute("bookmarkList", bookmarkList);
		
		return "viewProfile";
	}
	
	@GetMapping("/showBuyer")
	public String getBuyer(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		int product_seq = 0;		
	
    	String str = request.getParameter("product_SEQ");
    	try{
    		product_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	ProductDTO pdto = pdao.viewProduct(product_seq);
    	String product_title = pdto.getPrd_title();
    	System.out.println("product_title at showBuyer: " + product_title);

    	HttpSession session = null;
		session = request.getSession();
		session.setAttribute("product_title", product_title);
		session.setAttribute("product_seq", product_seq);
		System.out.println("product_seq at showBuyer: " + product_seq);
    	
//		model.addAttribute("product_seq", product_seq);

		List<ChatRoomDTO> chatroomList = crdao.getBuyer(product_seq);
		System.out.println(chatroomList);
		for (ChatRoomDTO mychatroom : chatroomList) {
			int buyer_seq = mychatroom.getBuy_seq();
			System.out.println("buyer_seq at showBuyer: " + buyer_seq);
			UserDTO userDTO = udao.viewUser(buyer_seq);
			String buyer_name = userDTO.getUser_name();
			System.out.println(buyer_name);
			mychatroom.setBuyer_name(buyer_name);
		}
//		model.addAttribute("chatroomList", chatroomList);
		System.out.println(chatroomList);
		
		session.setAttribute("chatroomList", chatroomList);		
		
		int checkNum =  0;
		if (chatroomList != null) checkNum = 1;
		
        String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"구매자 리스트 생성\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"구매자 리스트 생성 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
		
		return "viewProfile";

	}
	
	@GetMapping("/changeStatus")
	public void changeStatus(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
    	String prd_use = request.getParameter("product_STATUS");
    	System.out.println("prd_use at changeStatus: " + prd_use);

		int product_seq = 0;
    	String str = request.getParameter("product_SEQ");
    	try{
    		product_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("product_seq at changeStatus: " + product_seq);

		int checkNum =  pdao.updatePrd(prd_use, product_seq);
        String json_data = "";
        if ((checkNum == 1) && (prd_use.equals("E"))) {
			json_data = "{\"code\":\"success\", \"desc\":\"상품 판매중\"}";
        } else if ((checkNum == 1) && (prd_use.equals("R"))) {
			json_data = "{\"code\":\"success\", \"desc\":\"상품 예약중\"}";
        } else if ((checkNum == 1) && (prd_use.equals("S"))) {
			json_data = "{\"code\":\"success\", \"desc\":\"상품 판매완료\"}";

        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"판매상태 변경 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
	}
}
