package com.study.springboot.oauth2;

import java.util.Map;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OAuthAttributes {
	private Map<String, Object> attributes;
	private String nameAttributeKey;
	private String email;
	private String nickname;
	private String sns;

	@Builder
	public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey,
			                String email, String nickname, String sns) 
	{
		this.attributes = attributes;
		this.nameAttributeKey = nameAttributeKey;
		this.email = email;
		this.nickname = nickname;
		this.sns = sns;
	}

	public static OAuthAttributes of(String registrationId, String userNameAttributeName,
			                         Map<String, Object> attributes) 
	{
//		System.out.println(registrationId);
//		System.out.println(userNameAttributeName);
		if  (registrationId.equals("kakao")) {
			return ofKakao(userNameAttributeName, attributes);
		} else if  (registrationId.equals("naver")) {
			return ofNaver(userNameAttributeName, attributes);
		}
		return ofKakao(userNameAttributeName, attributes);
	}

	private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) 
	{
		
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("kakao_account");
		Map<String, Object> obj2 = (Map<String, Object>) obj1.get("profile");
		String sns = "K";
		System.out.println("kakao_account :" + attributes);
		System.out.println("obj1 :" + obj1);
		System.out.println("obj2 :" + obj2);
		System.out.println((String) obj2.get("nickname"));
		return new OAuthAttributes(attributes, 
				userNameAttributeName,
				(String) obj1.get("email"),
				(String) obj2.get("nickname"),
				sns
				);
	}
	private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) 
	{
		//		System.out.println(attributes);
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("response");
		String sns = "N";
		System.out.println("Naver :" + attributes);
				return new OAuthAttributes(attributes,
						userNameAttributeName,
						(String) obj1.get("email"),
						(String) obj1.get("name"),
						sns
						);
	}
}