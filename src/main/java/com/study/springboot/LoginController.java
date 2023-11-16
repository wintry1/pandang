package com.study.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.oauth2.SessionUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	@Autowired
	UserDAO userDao;
	@Autowired
	private HttpSession httpSession;
	
	@RequestMapping(value = "/login", method=RequestMethod.GET)
	public String showLoginForm(HttpServletRequest request, Model model) {
		return "loginhome";
	}
//	회원인지 아닌지
	
	@RequestMapping("/userInsert")
	public String Userinsert(HttpServletRequest request, Model model) {
		
		SessionUser sessionUser = (SessionUser) httpSession.getAttribute("user");
		
	    if (sessionUser == null) {
	        // 세션이 없거나 만료되었을 때의 처리
	        // 예를 들어 로그인 페이지로 리다이렉트하거나 다른 적절한 조치를 취할 수 있음
	        return "redirect:/login";
	    }
	    
	    String uId = sessionUser.getEmail();
	    String uName = sessionUser.getNickname();
		String uAddress = "서울특별시 종로구 관철동";
		double uLatitude = 37.5691245;
		double uLongitude = 126.9860044;
		String uSns = sessionUser.getSns();
		
		System.out.println(uId);
		System.out.println(sessionUser.getNickname());

		System.out.println(uAddress);
		System.out.println(uLatitude);
		System.out.println(uLongitude);
		System.out.println(uSns);

//		로그인 후 지도띄우고 설정 업데이트user_address user_latitude user_longitude
		

		
		Map<String, String> map = new HashMap<String, String>();
		map.put("param1", uId);
		map.put("param2", uName);
		map.put("param3", uAddress);
		map.put("param4", String.valueOf(uLatitude));
		map.put("param5", String.valueOf(uLongitude));
		map.put("param6", uSns);

		System.out.println(map);
		
		int nResult = userDao.userInsert(map);
		System.out.println("userInsert:" +nResult);

		return "mainhome";
	}

	

}

