package com.study.springboot.oauth2;

import java.io.Serializable;

import lombok.Getter;

@Getter
public class SessionUser implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String email;
	private String nickname;
	private String sns;


	public SessionUser(String email, String nickname, String sns) {

		this.email = email;
		this.nickname = nickname;
		this.sns = sns;

	}
}