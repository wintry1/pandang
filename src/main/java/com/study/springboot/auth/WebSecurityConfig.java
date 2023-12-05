package com.study.springboot.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.study.springboot.oauth2.CustomOAuth2UserService;
//import com.study.springboot.user.Role;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {
	
	@Autowired
	private CustomOAuth2UserService customOAuth2UserService;
	@Autowired
	private CustomAuthenticationSuccessHandler authenticationSuccessHandler;
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf((csrf) -> csrf.disable())
			.authorizeHttpRequests(request -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
					.requestMatchers("/").permitAll()
					.requestMatchers("/css/**", "/js/**", "/img/**").permitAll()
					.requestMatchers("/1/**").permitAll()
					.requestMatchers("/popup/**").permitAll()
					.requestMatchers("/main2").permitAll()
					.requestMatchers("/verifySMS").permitAll()
					.requestMatchers("/admin/**").permitAll()
					.requestMatchers("/**").permitAll()
					.anyRequest().authenticated()	//어떠한 요청이로도 인증 필요
				);
		

		http.formLogin((formLogin) -> formLogin
				.loginPage("/login")
				.loginProcessingUrl("/j_spring_security_check")
				.successHandler(authenticationSuccessHandler)
				.failureUrl("/loginForm?error")
				//.failureHandler(authenticationFailureHandler)
				.usernameParameter("j_username")
				.passwordParameter("j_password")
				.permitAll());
		
		http.logout((logout) -> logout
				.logoutUrl("/logout")
				.logoutSuccessUrl("/logout")
				.deleteCookies("JSESSIONID")
				.invalidateHttpSession(true)
				.permitAll());
		
		http.headers((headers) -> headers
				.frameOptions(frameOptions -> frameOptions.disable())
			);
		
		http.oauth2Login((oauth) -> oauth
				.loginPage("/login")
				.userInfoEndpoint(endPoint -> endPoint
						.userService(customOAuth2UserService)
				)
				.successHandler((request, response, authentication) -> {
			     response.sendRedirect("/userInsert"); // 이동할 URL 지정
			   })
			);
		
		return http.build();
	}
	
}
