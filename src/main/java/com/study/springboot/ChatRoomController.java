package com.study.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.ChatRoomDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.ChatRoomDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChatRoomController {
	
	@Autowired
	ChatRoomDAO chatRoomDao;
	@Autowired
	ProductDAO productDao;
	@Autowired
	UserDAO userDao;
	
	// 구매자
	@RequestMapping("/chroom")
	public String chatroom(HttpServletRequest request,  Model model) {
		HttpSession session = request.getSession();
		Integer user_seq = (Integer) request.getSession().getAttribute("user_seq");
		
		if (user_seq == null) {
	        return "redirect:list";
	    }
		
		ChatRoomDTO chatRoomDTO = new ChatRoomDTO();

		int buy_seq = (int) session.getAttribute("user_seq");
		String sell_seq = request.getParameter("sell_seq");
		String product_seq = request.getParameter("product_seq");

        String user_name = userDao.username(buy_seq);
        
        int intSell_seq = Integer.parseInt(request.getParameter("sell_seq"));
        int intProduct_seq = Integer.parseInt(request.getParameter("product_seq"));

        chatRoomDTO = chatRoomDao.selectDao(buy_seq, intSell_seq, intProduct_seq);
        ProductDTO productlist = productDao.selectDao1(intProduct_seq);
        String you_name = userDao.username(intSell_seq);
        
        if (chatRoomDTO == null) {
	        Map<String, String> map = new HashMap<String, String>();
			map.put("item1", String.valueOf(buy_seq));
			map.put("item2", sell_seq);
			map.put("item3", product_seq);
		
			chatRoomDao.cRinsertDao(map);
	        
	        chatRoomDTO = chatRoomDao.selectDao(buy_seq, intSell_seq, intProduct_seq);
	        
	        int chat_room_seq = chatRoomDTO.getchat_room_seq();
	        
	        model.addAttribute("list", productlist);
	        model.addAttribute("you_name", you_name);
	        model.addAttribute("product_seq", product_seq);
	        model.addAttribute("chat_room_seq", chat_room_seq);
	        model.addAttribute("user_name", user_name);
	        model.addAttribute("you_seq", productlist.getUser_seq());
        } else {
        	int chat_room_seq = chatRoomDTO.getchat_room_seq();
        	
        	model.addAttribute("list", productlist);
        	model.addAttribute("you_name", you_name);
        	model.addAttribute("product_seq", product_seq);
        	model.addAttribute("chat_room_seq", chat_room_seq);
        	model.addAttribute("user_name", user_name);
        	model.addAttribute("you_seq", productlist.getUser_seq());
        }
        
        return "message";
    }
	@RequestMapping("/chroom1")
	public String chatroom1(HttpServletRequest request,  Model model) {
		HttpSession session = request.getSession();
		
		String chat_room_seq = request.getParameter("chat_room_seq");

        ChatRoomDTO chatRoomlist = chatRoomDao.selectDao3(Integer.parseInt(chat_room_seq));
        int buy_seq = chatRoomlist.getBuy_seq();
        int sell_seq = chatRoomlist.getSell_seq();
        int product_seq = chatRoomlist.getProduct_seq();

        ProductDTO productlist = productDao.selectDao1(product_seq);
        int user_seq = (int) session.getAttribute("user_seq");
        if (user_seq == buy_seq) {
	        UserDTO userlist = userDao.viewUser(sell_seq);

	        String user_name = userDao.username(buy_seq);
	    	model.addAttribute("list", productlist);
	    	model.addAttribute("you_name", userlist.getUser_name());
	    	model.addAttribute("product_seq", product_seq);
	    	model.addAttribute("chat_room_seq", chat_room_seq);
	    	model.addAttribute("user_name", user_name);
	    	model.addAttribute("you_seq", userlist.getUser_seq());
	    	
	    	return "message";
        }
        if (user_seq == sell_seq) {
        	UserDTO userlist = userDao.viewUser(buy_seq);

	        String user_name = userDao.username(sell_seq);
	    	model.addAttribute("list", productlist);
	    	model.addAttribute("you_name", userlist.getUser_name());
	    	model.addAttribute("product_seq", product_seq);
	    	model.addAttribute("chat_room_seq", chat_room_seq);
	    	model.addAttribute("user_name", user_name);
	    	model.addAttribute("you_seq", userlist.getUser_seq());
	    	
	    	return "message";
        }
        
        return "redirect:list";
    }
}
