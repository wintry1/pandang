package com.study.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.ChatRoomDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dto.ChatRoomDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChatRoomController {
	
	@Autowired
	ChatRoomDAO chatRoomDao;
	@Autowired
	ProductDAO productDao;
	
	@RequestMapping("/chroom")
	public String chatroom(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Integer userSeq = (Integer) request.getSession().getAttribute("user_seq");
		
		if (userSeq == null) {
	        return "loginhome";
	    }
		
		ChatRoomDTO chatRoomDTO = new ChatRoomDTO();

		String buy_seq = (String) session.getAttribute("user_seq");
		String sell_seq = (String) session.getAttribute("sell_seq");
		String product_seq = productDao.selectDao2(sell_seq);
        String user_name = request.getParameter("user_name");
        
        int intbuy_seq = Integer.parseInt(request.getParameter("buy_seq"));
        int intsell_seq = Integer.parseInt(request.getParameter("sell_seq"));
        int intproduct_seq = Integer.parseInt(request.getParameter("product_seq"));
        
        chatRoomDTO = chatRoomDao.buyDao(intbuy_seq, intsell_seq, intproduct_seq);
        
        if (chatRoomDTO == null) {
	        Map<String, String> mapp = new HashMap<String, String>();
			mapp.put("item1", buy_seq);
			mapp.put("item2", sell_seq);
			mapp.put("item3", product_seq);
		
			chatRoomDao.cRinsertDao(mapp);
	        
	        chatRoomDTO = chatRoomDao.buyDao(intbuy_seq, intsell_seq, intproduct_seq);
	        
	        int chat_room_seq = chatRoomDTO.getchat_room_seq();
	        
	        session.setAttribute("chat_room_seq", chat_room_seq);
	        session.setAttribute("user_name", user_name);
	        
        } else {
        	int chat_room_seq = chatRoomDTO.getchat_room_seq();
	        
	        session.setAttribute("chat_room_seq", chat_room_seq);
	        session.setAttribute("user_name", user_name);
        }
        
        return "pop/Realtime";
    }
	
}

