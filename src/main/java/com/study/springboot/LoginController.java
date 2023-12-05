package com.study.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.study.springboot.dao.AuthDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.oauth2.SessionUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	@Autowired
	UserDAO userDao;
	@Autowired
	AuthDAO authDao;
	@Autowired
	private HttpSession httpSession;
	
	@RequestMapping(value = "/login", method=RequestMethod.GET)
	public String showLoginForm(HttpServletRequest request, Model model) {
		return "mainhome";
	}

	@RequestMapping("/userList")
	public String userList(Model model) {
		model.addAttribute("users", userDao.userList());
		return "/list";
	}
	
	@RequestMapping("/userView")
	public String Userview(HttpServletRequest request, Model model) {
		String id = request.getParameter("user_id");
		model.addAttribute("userDto", userDao.userView(id));
		
		return "mainhome";
	}

	
	@RequestMapping("/numberuserInsert")
	public String numberUserinsert(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		
		String phoneNum = (String) session.getAttribute("phoneNum");
		String address = (String) session.getAttribute("addressName");
		double latitude = (double) session.getAttribute("latitude");
		double longitude = (double) session.getAttribute("longitude");
		
		UserDTO user = userDao.userSelect1("user_id");

		String uId = phoneNum;
	    String uName = phoneNum;
		String uSns = "S";

		System.out.println(uId);
		System.out.println(uName);
		System.out.println(address);
		System.out.println(latitude);
		System.out.println(longitude);
		System.out.println(uSns);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("param1", uId);
		map.put("param2", uName);
		map.put("param3", address);
		map.put("param4", String.valueOf(latitude));
		map.put("param5", String.valueOf(longitude));
		map.put("param6", uSns);

		int nResult = userDao.userInsert(map);
		
		user = userDao.userSelect1(uId);
		
		session.setAttribute("user_seq", user.getUser_seq());
        session.setAttribute("user_id", uId);
        session.setAttribute("user_name", uName);
		System.out.println("userInsert:" +nResult);

		return "redirect:list";
	}
	
	@RequestMapping("/userInsert")
	public String socialUserinsert(HttpServletRequest request, Model model) {
	
		SessionUser sessionUser = (SessionUser) httpSession.getAttribute("user");
		HttpSession session = request.getSession();
//		String id = String.valueOf(userDao.userSelect(sessionUser.getEmail()));
	    UserDTO user = userDao.userSelect1(sessionUser.getEmail());
		System.out.println(9999999);
		if (user == null) {
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
			
			user = userDao.userSelect1(uId);
			
			session.setAttribute("user_seq", user.getUser_seq());
            session.setAttribute("user_id", uId);
            session.setAttribute("user_name", uName);
            
			System.out.println("userInsert:" + nResult);
		} else {
			
			session.setAttribute("user_seq", user.getUser_seq());
	        session.setAttribute("user_id", user.getUser_id());
	        session.setAttribute("user_name", user.getUser_name());
	        
			return "redirect:list";
		}
		
		return "login_location";
	}
	

	@RequestMapping("/locationUpdate")
	public String locationUpdate(HttpServletRequest request, Model model) {
		System.out.println("여기까지왔나");
		HttpSession session = request.getSession();
		System.out.println("여기까지왔나1");
		SessionUser user = (SessionUser) session.getAttribute("user");
		if(user != null) {
			System.out.println(user.getEmail());
			System.out.println(user.getNickname());
		} else {
			System.out.println("세션없다");
		}
		
		String userId = user.getEmail();
		String address = (String) session.getAttribute("addressName");
		double latitude = (double) session.getAttribute("latitude");
		double longitude = (double) session.getAttribute("longitude");
		
		System.out.println(userId);
		System.out.println(address);
		System.out.println(latitude);
		System.out.println(longitude);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("param1", userId);
		map.put("param2", address);
		map.put("param3", String.valueOf(latitude));
		map.put("param4", String.valueOf(longitude));
		
		int nResult = userDao.locationUpdate(map);
		
		System.out.println("locationUpdate:" +nResult);
		return "redirect:list";
	}
}

