package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {	
	
	@Autowired
	UserDAO udao;

    @GetMapping("/changeName")
    public String changeName(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException 
    {
    	HttpSession session = request.getSession();
		int user_seq = (int)session.getAttribute("user_seq");
		System.out.println("user_seq : " + user_seq);
		
    	String newName = request.getParameter("newName");
    	System.out.println("새로운 닉네임 : " + newName);
        
        int checkNum = udao.updateUser(newName, user_seq);
        System.out.println("checkNum : " + checkNum);
        
        if (checkNum == 1) {
            session.setAttribute("user_name", newName);            

//        	response.setContentType("text/html; charset=UTF-8");
//            PrintWriter out = response.getWriter();
//            out.println("<script>alert('닉네임 변경 성공');</script>");
//            out.flush();
//            out.close();        	
        	return "redirect:Profile";
        	
		} else if (checkNum == 0) {	
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('닉네임 변경 실패'); history.go(-1);</script>");
            out.flush();
            out.close();
            return "modifyProfile";
		}
        return "redirect:Profile";
	}
    
    @RequestMapping("/deleteUser")
    public String deleteUser(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException
    {
    	HttpSession session = request.getSession();
		int user_seq = (int)session.getAttribute("user_seq");
		System.out.println("user_seq : " + user_seq);

        int checkNum = udao.deleteUser(user_seq);
        System.out.println("checkNum : " + checkNum);

        if (checkNum == 1) {
        	session.invalidate();
        	return "redirect:list";
//        	window.location.replace("mainhome.jsp");
        	
		} else if (checkNum == 0) {	
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('회원 탈퇴 실패'); history.go(-1);</script>");
            out.flush();
            out.close();	
            return "modifyProfile";
		}  
        return "redirect:list";
    }
}