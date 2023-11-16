package com.study.springboot.oauth2;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	@Autowired
	private HttpSession httpSession;

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2UserService delegate = new DefaultOAuth2UserService();
		OAuth2User oAuth2User = delegate.loadUser(userRequest);

		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		String userNameAttributeName = userRequest.getClientRegistration()
				                                  .getProviderDetails()
				                                  .getUserInfoEndpoint()
				                                  .getUserNameAttributeName();

		OAuthAttributes attributes = OAuthAttributes.of(registrationId,
				                                        userNameAttributeName,
				                                        oAuth2User.getAttributes());
		
		System.out.println(attributes.getNickname());
		SessionUser user = new SessionUser(attributes.getEmail(),
				                           attributes.getNickname(),
				                           attributes.getSns());
		httpSession.setAttribute("user", user);

		return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),
				                     attributes.getAttributes(),
				                     attributes.getNameAttributeKey());
	}
}