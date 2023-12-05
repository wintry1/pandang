package com.study.springboot.auth;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.oauth2.SessionUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
   
   @Autowired
    private UserDAO userDao;
   
   @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException  {
      
//        request.getRequestDispatcher("/userInsert").forward(request, response);
        
        SessionUser user = (SessionUser)request.getSession().getAttribute("user");
        String sns = user.getSns();
        if ("N".equals(sns) || "K".equals(sns)) {
        	response.sendRedirect("/userInsert");
        } else {
        	response.sendRedirect("/numberuserInsert");
        }   
    }
}