package com.study.springboot.auth;


import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Configuration
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
   
   @Autowired
    private UserDAO userDao;
   
   @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException  {
      
        request.getRequestDispatcher("/main").forward(request, response);
        
    }
}