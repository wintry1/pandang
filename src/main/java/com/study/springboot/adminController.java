package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.AdminDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class adminController {	
	
	@Autowired
	AdminDAO addao;
	@Autowired
	UserDAO udao;
	@Autowired
	ProductDAO pdao;
	@Autowired
	UserDAO userDao;

	@RequestMapping("/admin")
    public String adminUser(HttpServletRequest request, HttpServletResponse response, Model model) 
    		throws ServletException, IOException 
    {
    	HttpSession session = request.getSession();
    	Integer user_seq = (Integer) session.getAttribute("user_seq");
	    UserDTO user = userDao.viewUser(user_seq);
    	String admin_name = user.getUser_name();
    	session.setAttribute("admin_name", admin_name);
    	session.setAttribute("admin_address", "관리자");
        
    	List<UserDTO> userList = addao.admin_user_list();
    	for (UserDTO users : userList) {
    		int warning = users.getUser_warning_count();
    		int suspend = users.getUser_criminal_count();
    		String userStatus = "정상"; 
    		if ((warning > 0) && (suspend == 0)){userStatus = "경고";}
    		else if ((suspend > 0)){userStatus = "정지";}
    		users.setUser_status(userStatus);
		}
    	   	
    	model.addAttribute("userList", userList);

    	List<ProductDTO> productList = addao.admin_prd_list();
    	for (ProductDTO products : productList) {
    		String prdStatus = products.getPrd_use();
    		String product_status = "판매중";
			if (prdStatus.equals("R")) {product_status = "예약중";}
			else if (prdStatus.equals("S")) {product_status = "판매완료";}
			products.setPrd_use(product_status);
		}
    	   	
    	model.addAttribute("productList", productList);
    	    	
        return "adminMode";
    }    
    
    @GetMapping("/userWarning")
    public void userWarning(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	int user_seq = 0;
    	String str = request.getParameter("user_SEQ");
    	try{
    		user_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("user_seq at userWarning: " + user_seq);
    	
		UserDTO userDTO = addao.admin_user_view(user_seq);
		int grade = userDTO.getUser_grade();
		System.out.println("grade : " + grade);
		int warning = userDTO.getUser_warning_count();
		System.out.println("warning : " + warning);
		int crime = userDTO.getUser_criminal_count();
		System.out.println("crime : " + crime);		
		
		grade = grade - 5;
		warning = warning + 1;
		int checkNum = addao.admin_user_punish(warning, crime, grade, user_seq);
			
		String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"회원 경고 발송\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"경고 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
    }
    
    @GetMapping("/userPunish")
    public void userPunish(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	int user_seq = 0;
    	String str = request.getParameter("user_SEQ");
    	try{
    		user_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("user_seq at userPunish: " + user_seq);
    	
		UserDTO userDTO = addao.admin_user_view(user_seq);
		int grade = userDTO.getUser_grade();
		System.out.println("grade : " + grade);
		int warning = userDTO.getUser_warning_count();
		System.out.println("warning : " + warning);
		int crime = userDTO.getUser_criminal_count();
		System.out.println("crime : " + crime);		
		
		grade = grade - 10;
		crime = crime + 1;
		int checkNum = addao.admin_user_punish(warning, crime, grade, user_seq);
			
		String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"회원 징계 실행\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"징계 실패\"}";		
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
    }
    
    @GetMapping("/userDelete")
    public void userDelete(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	int user_seq = 0;
    	String str = request.getParameter("user_SEQ");
    	try{
    		user_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("user_seq at userDelete: " + user_seq);
		
		int	checkNum = addao.admin_user_delete(user_seq);		
		System.out.println("checkNum at userDelete: " + checkNum);
		
		String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"회원 삭제 성공\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"삭제 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
    }
    
    @GetMapping("/searchUser")
    public String searchUser(HttpServletRequest request, HttpServletResponse response, Model model) 
    		throws ServletException, IOException 
    {
    	String searchField = request.getParameter("searchField");
    	String searchText = request.getParameter("searchText"); 
    	System.out.println("searchField: " + searchField);
    	System.out.println("searchText: " + searchText);
    	
    	if (searchField.equals("user_id")) {
    		List<UserDTO> userList = addao.admin_user_id_search(searchText);
        	for (UserDTO users : userList) {
        		int warning = users.getUser_warning_count();
        		int suspend = users.getUser_criminal_count();
        		String userStatus = "정상"; 
        		if ((warning > 0) && (suspend == 0)){userStatus = "경고";}
        		else if ((suspend > 0)){userStatus = "정지";}
        		users.setUser_status(userStatus);
    		}        	   	
        	model.addAttribute("userList", userList);
        	
    	} else if (searchField.equals("user_name")) {
        	List<UserDTO> userList = addao.admin_user_name_search(searchText);
        	for (UserDTO users : userList) {
        		int warning = users.getUser_warning_count();
        		int suspend = users.getUser_criminal_count();
        		String userStatus = "정상"; 
        		if ((warning > 0) && (suspend == 0)){userStatus = "경고";}
        		else if ((suspend > 0)){userStatus = "정지";}
        		users.setUser_status(userStatus);
    		}        	   	
        	model.addAttribute("userList", userList);
        }
    	
    	List<ProductDTO> productList = addao.admin_prd_list();
    	System.out.println(productList);
    	for (ProductDTO products : productList) {
    		String prdStatus = products.getPrd_use();
    		String product_status = "판매중";
			if (prdStatus.equals("R")) {product_status = "예약중";}
			else if (prdStatus.equals("S")) {product_status = "판매완료";}
			products.setPrd_use(product_status);
		}
    	   	
    	model.addAttribute("productList", productList);
    	
    	return "adminMode";
	}
        
    @GetMapping("/hideProduct")
    public void hideProduct(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	int product_seq = 0;
    	String str = request.getParameter("product_SEQ");
    	try{
    		product_seq = Integer.parseInt(str);
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("product_seq at hideProduct: " + product_seq);
    	
    	String prd_use_yn = "N";
    	
		int checkNum =  addao.admin_prd_hide(prd_use_yn, product_seq);
        String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"상품 판매 정지\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"판매 정지 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
    }
    
    @GetMapping("/openProduct")
    public void openProduct(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	int product_seq = 0;
    	String str = request.getParameter("product_SEQ");
    	try{
    		product_seq = Integer.parseInt(str);
            System.out.println(product_seq); 
        }
        catch (NumberFormatException ex){
            ex.printStackTrace();
        }
    	System.out.println("product_seq at hideProduct: " + product_seq);
    	
    	String prd_use_yn = "Y";
    	
		int checkNum =  addao.admin_prd_hide(prd_use_yn, product_seq);
        String json_data = "";
        if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"판매 정지 해제\"}";
        } else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"정지 해제 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	   	
    }
    
    @RequestMapping("/adminch")
	public String adminch(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	Integer user_seq = (Integer) session.getAttribute("user_seq");
	    UserDTO user = userDao.viewUser(user_seq);
	    System.out.println(user);
	    if ("admin".equals(user.getUser_type())) {
	    	System.out.println(user.getUser_type());
	    	
	    	return "redirect:admin";
	    }
	    
	    return "redirect:list";
	}
    
    @GetMapping("/searchProduct")
    public String searchProduct(HttpServletRequest request, HttpServletResponse response, Model model) 
    		throws ServletException, IOException 
    {
    	String searchField = request.getParameter("searchField");
    	String searchText = request.getParameter("searchText");    
    	System.out.println("searchField: " + searchField);
    	System.out.println("searchText: " + searchText);
    	
    	List<UserDTO> userList = addao.admin_user_list();
    	for (UserDTO users : userList) {
    		int warning = users.getUser_warning_count();
    		int suspend = users.getUser_criminal_count();
    		String userStatus = "정상"; 
    		if ((warning > 0) && (suspend == 0)){userStatus = "경고";}
    		else if ((suspend > 0)){userStatus = "정지";}
    		users.setUser_status(userStatus);
		}
    	   	
    	model.addAttribute("userList", userList);

    	if (searchField.equals("prd_title")) {
    		List<ProductDTO> productList = addao.admin_prd_title_search(searchText);
			for (ProductDTO products : productList) {
	    		String prdStatus = products.getPrd_use();
	    		String product_status = "판매중";
	    		if (prdStatus.equals("R")) {product_status = "예약중";}
				else if (prdStatus.equals("S")) {product_status = "판매완료";}
				products.setPrd_use(product_status);
			}	    	   	
    			model.addAttribute("productList", productList);  	
    	} else if (searchField.equals("prd_ctnt")) {
    		List<ProductDTO> productList = addao.admin_prd_ctnt_search(searchText);
    		for (ProductDTO products : productList) {
        		String prdStatus = products.getPrd_use();
        		String product_status = "판매중";
        		if (prdStatus.equals("R")) {product_status = "예약중";}
    			else if (prdStatus.equals("S")) {product_status = "판매완료";}
    			products.setPrd_use(product_status);
			}	    	   	
	    		model.addAttribute("productList", productList);
    	}
    	
        return "adminMode";
	}
        
}