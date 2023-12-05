package com.study.springboot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.ChatRoomDAO;
import com.study.springboot.dao.NoticeDAO;
import com.study.springboot.dao.ProductDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.ChatRoomDTO;
import com.study.springboot.dto.NoticeDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
	
	@Autowired
	UserDAO userDao;
	@Autowired
	NoticeDAO noticeDao;
	@Autowired
	ProductDAO productDao;
	@Autowired
	ChatRoomDAO chatRoomDao;
	
	@RequestMapping("/noticelist")
	public String noticelist(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		Integer user_seqIn = (Integer) request.getSession().getAttribute("user_seq");
		if (user_seqIn == null) {
	        return "redirect:list";
	    }
		
		int user_seq = (int) session.getAttribute("user_seq");
		
		List<NoticeDTO> noticeCRList = noticeDao.noticeviewDao(user_seq);
		noticeCRList.removeIf(Objects::isNull);
		
		for (NoticeDTO notice : noticeCRList) {
			if (notice.getChat_room_seq() != 0) {
				if ("Y".equals(notice.getNotice_use_yn())) {
					Integer chatRoomSeq = notice.getChat_room_seq();
					
					ChatRoomDTO chatRoomlist = chatRoomDao.selectDao3(chatRoomSeq);
					ProductDTO productDto = productDao.selectDao1(chatRoomlist.getProduct_seq());
					if(user_seq == chatRoomlist.getBuy_seq()) {
						String name = userDao.username(chatRoomlist.getSell_seq());
						String prd_title = productDto.getPrd_title();
						
						notice.setNotice_title(prd_title);
						notice.setNotice_name(name);
						notice.setProduct_seq(productDto.getProduct_seq());
					}
					if(user_seq == chatRoomlist.getSell_seq()) {
						String name = userDao.username(chatRoomlist.getBuy_seq());
						String prd_title = productDto.getPrd_title();

						notice.setNotice_title(prd_title);
						notice.setNotice_name(name);
						notice.setProduct_seq(productDto.getProduct_seq());
					}
				}
			}
		}
		model.addAttribute("crlist", noticeCRList);
		
		List<NoticeDTO> noticePRDList = noticeDao.noticeviewDao1(user_seq);
		String prd_name = null;
		noticePRDList.removeIf(Objects::isNull);
		
		for (NoticeDTO notice : noticePRDList) {
			if (notice.getProduct_seq() != 0) {
				Integer productSeq = notice.getProduct_seq();
				
				ProductDTO productDto = productDao.selectDao1(productSeq);
				prd_name = userDao.username(productDto.getUser_seq());
				
				notice.setNotice_name(prd_name);
			}
	    }

		model.addAttribute("pRdlist", noticePRDList);
		
		return "alarm_list";
	}

	@RequestMapping("/noticeintchat")
	@ResponseBody
	public void noticeintchat(@RequestParam("you_seq") int you_seq,
					@RequestParam("chat_room_seq") int chat_room_seq) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("item1", String.valueOf(you_seq));
		map.put("item2", String.valueOf(chat_room_seq));
		
		noticeDao.noticeInsertChat(map);
	}
	
	@RequestMapping("/noticeReview")
	@ResponseBody
	public String noticeReview(@RequestParam("notice_seq") int notice_seq,
							@RequestParam("product_seq") int product_seq,
							Model model) {

		ProductDTO productList = productDao.selectDao1(product_seq);
		String user_name = userDao.username(productList.getUser_seq());
		
		model.addAttribute("user_name", user_name);
		model.addAttribute("productList", productList);
		model.addAttribute("notice_seq", notice_seq);
		
		return "test_review";
	}
	
	@RequestMapping("/noticeudchat")
	@ResponseBody
	public void noticeudchat(@RequestParam("you_seq") int you_seq,
					@RequestParam("chat_room_seq") int chat_room_seq) {
		noticeDao.noticeupdateDao(you_seq, chat_room_seq);
	}
}

