package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.AuthDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
//import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
//import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
public class SmsController {	
	
	@Autowired
	UserDAO userDao;
	@Autowired
	AuthDAO dao;
	String phoneNum ="";

	final DefaultMessageService messageService;
	
//	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();


    public SmsController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
//        this.messageService = NurigoApp.INSTANCE.initialize("INSERT_API_KEY", "INSERT_API_SECRET_KEY", "https://api.coolsms.co.kr");
        this.messageService = NurigoApp.INSTANCE.initialize("NCSDIVIZDIRQQXR5", "O3HXJKE1F2DA18O3FCOIX6IFQ69POPLY", "https://api.coolsms.co.kr");
    }

    @GetMapping("/sendOne")
//    public SingleMessageSentResponse sendOne(HttpServletRequest request, Model model) {
    public void sendOne(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	
    	phoneNum = request.getParameter("phoneNum");
    	System.out.println("PanDang 회원가입용 전화 번호 => " + phoneNum);
	    
	    Random rand = new Random();
	    String numStr = "";
	    for (int i = 0; i < 6; i++) {
	        String ran = Integer.toString(rand.nextInt(10));
	        numStr += ran;
	    }
	    System.out.println("PanDang 회원가입 인증 번호 => " + numStr);

        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01023108620");	// 박정현
//        message.setTo("01049066464");	// 김민재
//        message.setTo("01025261089");	// 권도해
//        message.setTo("01045235287");	// 강해마루
        message.setTo(phoneNum);

        message.setText("PanDang 회원가입 인증번호: " + numStr);

/* SMS 발신 파트 - 코드 통합 후 코멘트 풀어야 함.         
        SingleMessageSentResponse response1 = this.messageService.sendOne(new SingleMessageSendingRequest(message));
*/
        String time_sent = LocalDateTime.now()
				.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));        
        
        System.out.println("phoneNum : " + phoneNum);
        System.out.println("numStr : " + numStr);
        System.out.println("time_sent : " + time_sent);
        
        int checkNum = dao.writeAuth(phoneNum, "111111", time_sent);
        System.out.println("checkNum : " + checkNum);
        
		HttpSession session = request.getSession();
		String choice = "receive";
		session.setAttribute("choice", choice);
		System.out.println("choice at SmsCont: " + choice);
        
        String json_data = "";
		if (checkNum == 1) {
			json_data = "{\"code\":\"success\", \"desc\":\"인증번호가 전송되었습니다.\"}";
		} else if (checkNum == 0) {	
			json_data = "{\"code\":\"fail\", \"desc\":\"전화번호 입력 실패\"}";			
		}  
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	

//		return "/verifySMS2";
	}
    
    @RequestMapping("/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException, ParseException 
    {
    	HttpSession session = request.getSession();
    	session.setAttribute("phoneNum", phoneNum);
        
    	String codeNum = request.getParameter("codeNum");
    	System.out.println("phoneNum : " + phoneNum);
    	String auth_num = dao.viewAuthNum(phoneNum);
    	System.out.println("auth_num : " + auth_num);
    	String auth_time = dao.viewAuthTime(phoneNum);
    	System.out.println("auth_time : " + auth_time);
    	System.out.println("codeNum : " + codeNum);
    	
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    	LocalDateTime time_sent2 = LocalDateTime.parse(auth_time, formatter);
    	System.out.println(time_sent2);

    	String time_received = LocalDateTime.now()
				.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    	DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    	LocalDateTime time_received2 = LocalDateTime.parse(time_received, formatter2);
    	System.out.println(time_received2);
    	
    	Duration duration = Duration.between(time_sent2, time_received2);
    	long passedSec = duration.getSeconds();
    	System.out.println("소요 시간(초) : " + passedSec);
    	
        String json_data = "";
        
		if ((codeNum.equals(auth_num)) && (passedSec <= 180)) {	

			UserDTO user = userDao.userSelect1(phoneNum);
			System.out.println(phoneNum);
			System.out.println(user);
			if(user == null) {//회원가입
				json_data = "{\"code\":\"sing-in\", \"desc\":\"PanDang 가족이 되신 걸 환영합니다!\"}";
			}else {
				json_data = "{\"code\":\"login\", \"desc\":\"PanDang 로그인 되셨습니다!\"}";
				session.setAttribute("user_seq", user.getUser_seq());
	            session.setAttribute("user_id", user.getUser_id());
	            session.setAttribute("user_name", user.getUser_name());
			}	

		} else {
			json_data = "{\"code\":\"fail\", \"desc\":\"인증번호 오류 또는 시간초과입니다. 다시 시도해 주세요.\"}";
		}
		
		dao.deleteAuth(phoneNum);
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	
    }
    
    @RequestMapping("/deleteCode")
    public void deleteCode(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException, ParseException 
    {
    	System.out.println("**delete***");
    	String phoneNum = request.getParameter("phoneNum");

    	dao.deleteAuth(phoneNum);
    	
    	String json_data = "";
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	
    	
    }
}
